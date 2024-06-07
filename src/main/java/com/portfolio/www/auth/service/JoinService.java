package com.portfolio.www.auth.service;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import com.portfolio.www.auth.dto.EmailDto;
import com.portfolio.www.auth.dto.EmailUtil;
import com.portfolio.www.auth.dto.MemberAuthDto;
import com.portfolio.www.auth.dto.MemberDto;
import com.portfolio.www.auth.repository.MemberAuthRepository;
import com.portfolio.www.auth.repository.MemberRepository;

import at.favre.lib.crypto.bcrypt.BCrypt;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
//@RequiredArgsConstructor
public class JoinService extends AuthCommonService{	
//	private final MemberRepository memberRepository;
//	private final MemberAuthRepository memberAuthRepository;
//	private final EmailUtil emailUtil;
	
	@Autowired
	public JoinService(MemberRepository memberRepository, 
					   MemberAuthRepository memberAuthRepository,
					                          EmailUtil emailUtil) {
		
		super(memberRepository, memberAuthRepository, emailUtil);
	}

	
	/**
	 * 회원가입.
	 * 유저 정보를 저장하고, 인증 이메일을 보낸다.
	 * @param memberDto
	 * @return
	 */
	@Transactional
	public int join(MemberDto memberDto, String contextPath) {
		int code = -1;
		try {
			String receiver = memberDto.getEmail();
			//1. Member테이블에 insert
			//(사용자 정보를 암호화 후 repository계층으로 넘김)
			memberRepository.save(encrypt(memberDto)); 
			
			//2. MemberAuth테이블에 insert
			int memberSeq = memberDto.getMemberSeq();
			//log.info("memberSeq={}", memberSeq);
			
			Map<String, String> mailComponent = makeMailComponent(contextPath);
			code = sendAuthMail(mailComponent, receiver, memberDto.getMemberSeq());
//			code = sendAuthMail(contextPath, receiver, memberSeq);
		
		//Tx처리를 위해 try-catch 없애기
		} catch (DuplicateKeyException e) {
			//memberId는 Unique키 제약조건이 있어서, 
			//같은 id로 가입시도 하면 exception 발생
			code = 0;
			log.info(e.getMessage());
		} catch (DataAccessException e) {
			log.info(e.getMessage()); //DataAccessException도 딱히 해줄게 없을 것 같은데 Exception이랑 나눠야 할까?
		} catch (Exception e) {
			log.info(e.getMessage()); 
		}
		//회원가입이 정상적으로 완료되면 code = 1 반환.
		//사용자에게 알려야 할 유의미한 에러인 아이디 중복은 code = 0
		//나머지 에러는 전부 code = -1
		return code;
	}

	public int remail(String memberId, String receiver, String contextPath) {
		int code = -9;
		MemberDto memberDto = memberRepository.findByIdNoAuth(memberId);
		
		//해당 아이디로 가입된 회원이 없다.
		if(ObjectUtils.isEmpty(memberDto)) {
			code = -1; 
		}
		
		//사용자 입력 이메일과 DB에 저장된 이메일이 다르다.
		if(!passwdOrEmailMatch(receiver, memberDto.getEmail())){
			code = -2;
		}
		
		Map<String, String> mailComponent = makeMailComponent(contextPath);
		code = sendAuthMail(mailComponent, receiver, memberDto.getMemberSeq());
		
		return code;
	}


	private Map<String, String> makeMailComponent(String contextPath) {
		Map<String, String> mailComponent = new HashMap<>();
		mailComponent.put("subject", "회원가입을 위해 메일 인증을 완료해주세요");
		mailComponent.put("contextPath", contextPath);
		mailComponent.put("domain", "http://localhost:8080");
		mailComponent.put("path", "/auth/emailAuth.do?uri=");
		mailComponent.put("content", "링크를 눌러 인증을 완료해주세요");
		return mailComponent;
	}


//	private int sendAuthMail(String contextPath, String receiver, int memberSeq) {
//		int code;
//		MemberAuthDto authDto = MemberAuthDto.createMemberAuthDto(memberSeq);
//		code = memberAuthRepository.addAuthInfo(authDto);
//		
//		//3. 인증메일 보내기
//		String authUri = authDto.getAuthUri();
//		//관련있는 메일 정보(제목, 내용)을 hashmap 객체에 묶어서 다루고자 함
//		//클래스를 따로 만들까 했지만, 여기서밖에 사용 하지 않을 것 같아서 일단은 map으로만..
//		HashMap<String, String> mailContent = createMailContent(contextPath, authUri);
//		//sender에 대한 정보는 bean으로 등록한 mailSender에서 가져온다.
//		EmailDto emailDto = EmailDto.createEmailDto(receiver, mailContent, true);
//		emailUtil.sendMail(emailDto);
//		return code;
//	}
//	
	
	
	/**
	 * 유저가 발송된 메일의 인증 주소로 접속하면
	 * 인증 여부를 처리하는 메서드
	 * @param uri
	 * @return
	 */
	@Transactional
	public int emailAuth(String uri) {
		int code = -9;
		//QUESTION 못찾으면 null을 반환하는지 아님 Exception 터뜨리는지?
		MemberAuthDto authDto = memberAuthRepository.getMemberAuthDto(uri);
		log.info("authDto={}", authDto);
		//1. 인증 주소가 유효한지
		if(ObjectUtils.isEmpty(authDto)) {
			return code; //해당 uri로 조회되는 authDto가 없다. -> 유효한 인증 주소가 아님
		}
		
		//2. 인증 정보가 유효한지
		int memberSeq = authDto.getMemberSeq();
		MemberDto memberDto = memberRepository.findBySeq(memberSeq);
		if(ObjectUtils.isEmpty(memberDto)) { //해당 auth로 식별되는 회원정보 없음.
			//QUESTION 근데 이걸 체크해야하는 경우가 있을까? 구체적인 예외 상황 상상해보기.
			return code; 
		}
		
		//3. 인증 시간이 유효한지
		if(!isValidTime(authDto.getExpireDtm())) {
//			if(true) { //테스트
			
			//인증시간이 지났다. 
			//메일을 재발송하려면 암호화되지 않은 메일주소가 필요한데..
			//일단 인증 시간이 지났음을 유저에게 알리고
			//아이디랑 메일주소를 재입력받아서 일치하면 다시 그 메일주소로 보낼까? (비번 reset처럼)
			code = -1;
			return code;
		}
		
		//모든 검증이 끝났을 때 비로소 auth_yn을 y로 업데이트치기
		memberAuthRepository.updateAuthValid(uri);
		code = memberRepository.updateAuthValid(memberSeq);

		return code; //default가 -9
	}
	
	
	
	private boolean isValidTime(long time) {
		return Calendar.getInstance().getTimeInMillis() < time;
	}
	

	//QUESTION 여기가 뭔가 신경쓰인다. 
	// 메일의 제목/내용에 변경 시 JoinService자체에 변경 포인트가 생긴다는 점이 뭔가..
	// 메일 컨텐츠 부분만 따로 떼어내서 다룰 수는 없을까. 변경포인트를 분리하고 싶다.
//	private HashMap<String, String> createMailContent(String contextPath, String authUri) {
//		HashMap<String, String> mailContent = new HashMap<>();
//		
//		String subject = "인증을 완료해주세요";
//		String html =  "<a href='http://localhost:8080"
//				+contextPath+"/emailAuth.do?uri="
//				+ authUri + "'>인증하기</a>";
//		
//		mailContent.put("subject", subject);
//		mailContent.put("text", html);
//		return mailContent;
//	}
//	
	
	//사용자 입력 이메일, 비밀번호를 암호화 후 다시 dto를 반환하는 메서드
	private MemberDto encrypt(MemberDto memberDto) {
		String passwd = memberDto.getPasswd();
		String email = memberDto.getEmail();
		
		//비밀번호와 이메일 정보를 암호화
		String encPasswd = BCrypt.withDefaults().hashToString(12, passwd.toCharArray());
		String encEmail = BCrypt.withDefaults().hashToString(12, email.toCharArray());
		
		memberDto.setEmail(encEmail);
		memberDto.setPasswd(encPasswd);
		
		//암호화된 비밀번호와 이메일 확인
		log.info(">>>>>>>>> encPasswd = {}", encPasswd);
		log.info(">>>>>>>>> encEmail = {}", encEmail);
		
		//사용자 입력과 암호화된 데이터가 일치하는지 확인
		BCrypt.Result passwdResult = BCrypt.verifyer().verify(passwd.toCharArray(), encPasswd);
		BCrypt.Result emailResult = BCrypt.verifyer().verify(email.toCharArray(), encEmail);
		log.info(">>>>>>>>> result.verified = {}", passwdResult.verified);
		log.info(">>>>>>>>> result.verified = {}", emailResult.verified);
		
		return memberDto;
	}
	
}
