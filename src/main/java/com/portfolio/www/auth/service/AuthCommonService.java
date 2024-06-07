package com.portfolio.www.auth.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import com.portfolio.www.auth.dto.EmailDto;
import com.portfolio.www.auth.dto.EmailUtil;
import com.portfolio.www.auth.dto.MemberAuthDto;
import com.portfolio.www.auth.dto.MemberDto;
import com.portfolio.www.auth.repository.MemberAuthRepository;
import com.portfolio.www.auth.repository.MemberRepository;

import at.favre.lib.crypto.bcrypt.BCrypt;
//import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
//회원 가입시 인증메일, 유효기간이 지난 인증 메일 재전송, 비밀번호 reset 등에 필요한
//아이디, 이메일 검증 및 메일 발송을 담당하는 service
public class AuthCommonService {
	protected final MemberRepository memberRepository;
	protected final MemberAuthRepository memberAuthRepository;
	protected final EmailUtil emailUtil;
	
	
	//사용자 입력 비밀번호와 저장된 비밀번호 
	//또는 사용자 입력 이메일과 저장된 이메일을 비교하는 메서드
	protected boolean passwdOrEmailMatch(String givenString, String savedString) {
		return BCrypt.verifyer().verify(givenString.toCharArray(), savedString).verified;
	}
	
	protected HashMap<String, String> createMailContent(Map<String, String> mailComponent, String authUri) {
		
		HashMap<String, String> mailContent = new HashMap<>();
		
//		String subject = "새로운 비밀번호를 설정해주세요";
		String aTagHead = "<a href='";
		String aTagBody = "'>";
		String aTagTail = "</a>";
		
		String html = aTagHead + mailComponent.get("domain")
							   + mailComponent.get("contextPath")
							   + mailComponent.get("path")
							   + authUri
							   + aTagBody
							   + mailComponent.get("content")
							   + aTagTail;

		
		mailContent.put("subject", mailComponent.get("subject"));
		mailContent.put("text", html);
		return mailContent;
	}
	

	protected int sendAuthMail(Map<String, String> mailComponent, String receiver, int memberSeq) {
		int code;
		MemberAuthDto authDto = MemberAuthDto.createMemberAuthDto(memberSeq);
		code = memberAuthRepository.addAuthInfo(authDto);
		
		//3. 인증메일 보내기
		String authUri = authDto.getAuthUri();
		//관련있는 메일 정보(제목, 내용)을 hashmap 객체에 묶어서 다루고자 함
		HashMap<String, String> mailContent = createMailContent(mailComponent, authUri);
		//sender에 대한 정보는 bean으로 등록한 mailSender에서 가져온다.
		EmailDto emailDto = EmailDto.createEmailDto(receiver, mailContent, true);
		emailUtil.sendMail(emailDto);
		return code;
	}
}
