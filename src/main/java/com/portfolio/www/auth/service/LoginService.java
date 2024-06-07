package com.portfolio.www.auth.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.mail.MailException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import com.portfolio.www.auth.dto.EmailDto;
import com.portfolio.www.auth.dto.EmailUtil;
import com.portfolio.www.auth.dto.MemberDto;
import com.portfolio.www.auth.dto.PasswdResetDto;
import com.portfolio.www.auth.dto.ResetPasswdAuthDto;
import com.portfolio.www.auth.repository.MemberAuthRepository;
import com.portfolio.www.auth.repository.MemberRepository;

import at.favre.lib.crypto.bcrypt.BCrypt;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class LoginService extends AuthCommonService {
//	protected final MemberRepository memberRepository;
//	protected final MemberAuthRepository memberAuthRepository;
//	protected final EmailUtil emailUtil;
	
	@Autowired
	public LoginService(MemberRepository memberRepository, 
					   MemberAuthRepository memberAuthRepository,
					                          EmailUtil emailUtil) {
		
		super(memberRepository, memberAuthRepository, emailUtil);
	}
	
	
	/**
	 * 사용자 입력 정보로 로그인 검사
	 * 1. 해당 아이디로 가입된(조회되는) 회원 없음 : code = -9
	 * 2. 비밀번호 불일치 : code = -1
	 * 3. 아이디, 비밀번호 일치 : code = memberSeq 
	 * @param memberId
	 * @param passwd
	 * @return
	 */
	public int login(String memberId, String passwd){
		int code = -9;
		MemberDto memberDto = memberRepository.findById(memberId);
		MemberDto memberDto2 = memberRepository.findByIdNoAuth(memberId);
		
		//해당 아이디로 조회되는 회원이 없는 경우
		if(ObjectUtils.isEmpty(memberDto)) {
			if(!ObjectUtils.isEmpty(memberDto2)) {
				return -8;
			}
			return code; 
		}
		//아이디로 조회되는 회원이 있으면 
		//비밀번호 일치 검사 (일치 : memberSeq 반환, 불일치 -1)
		code = passwdOrEmailMatch(passwd, memberDto.getPasswd()) ? memberDto.getMemberSeq() : -1;
		return code;
	}
	
	public int sendMailForPasswdReset(String memberId, String userEmail, String contextPath) {
		int code = -9;
		MemberDto memberDto = memberRepository.findById(memberId);
		
		//해당 아이디로 가입된 회원이 없다.
		if(ObjectUtils.isEmpty(memberDto)) {
			code = -1; 
		}
		
		//사용자 입력 이메일과 DB에 저장된 이메일이 다르다.
		if(!passwdOrEmailMatch(userEmail, memberDto.getEmail())){
			code = -2;
		}
		
		//조회되는 아이디가 있고, 입력한 이메일이 일치하면 메일을 보낸다.
		//왜 이메일을 보내야할까? 이메일에는 무슨 내용을 적어야 할까?
		//사용자가 비밀번호를 변경할 수 있는 뷰를 보여주어야 한다고 생각한다.
		//근데, 이 비밀번호 변경 페이지에 대한 접근은 보안적으로 중요하다. (타인이 이 매핑 주소를 유추해서는 안된다.)
		//즉UUID가 또 필요하다. 그리고 그 UUID를 통해 회원을 식별할 수 있어야함. 
		//-> 그래서 테이블을 또 만들었는데.. 뭔가 중복인 느낌
		ResetPasswdAuthDto authDto = ResetPasswdAuthDto.createResetPasswdAuthDto(memberDto.getMemberSeq());
		try {
			code = memberAuthRepository.addResetPasswdAuthInfo(authDto);
			//메일 보내기
			Map<String, String> mailComponent = makeMailComponent(contextPath);
			EmailDto emailDto = EmailDto.createEmailDto(
					userEmail, createMailContent(mailComponent, authDto.getAuthUri()), true);
			log.info("EmailDto={}", emailDto);
			emailUtil.sendMail(emailDto);
		} catch (DataAccessException e) {
			code = -3;
		} catch (MailException e) {
			code = -4;
		} catch (Exception e) {
			code = -5;
		}
		return code;
	}
	
	public PasswdResetDto checkAuthUriForPasswdReset(String uri) {
		return memberAuthRepository.getPasswdResetDto(uri);
	}
	
	@Transactional
	public int resetPasswd(PasswdResetDto resetDto) {
		int code = -1;
		try {
			//새 비밀번호 역시 암호화해서 저장해야 함.
			code = memberRepository.updatePasswd(encrypt(resetDto));
			memberAuthRepository.updateResetPasswdAuthYn(resetDto);
			log.info("resetDto={}", resetDto);
		} catch (DataAccessException e) {
			log.info(e.getMessage());
		}
		return code;
	}
	
	
	private Map<String, String> makeMailComponent(String contextPath) {
		Map<String, String> mailComponent = new HashMap<>();
		mailComponent.put("subject", "새로운 비밀번호를 설정해주세요");
		mailComponent.put("contextPath", contextPath);
		mailComponent.put("domain", "http://localhost:8080");
		mailComponent.put("path", "/auth/resetPasswd.do?uri=");
		mailComponent.put("content", "비밀번호 재설정하기");
		return mailComponent;
	}
	
	
	private PasswdResetDto encrypt(PasswdResetDto resetDto) {
		String passwd = resetDto.getPasswd();
		
		//비밀번호와 이메일 정보를 암호화
		String encPasswd = BCrypt.withDefaults().hashToString(12, passwd.toCharArray());
		resetDto.setPasswd(encPasswd);
		
		return resetDto;
	}
}
