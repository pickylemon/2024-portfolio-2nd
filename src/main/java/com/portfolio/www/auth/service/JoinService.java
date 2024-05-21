package com.portfolio.www.auth.service;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import com.portfolio.www.auth.dto.MemberDto;
import com.portfolio.www.auth.repository.MemberRepository;

import at.favre.lib.crypto.bcrypt.BCrypt;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class JoinService {
	private final MemberRepository memberRepository;
	
	/**
	 * 회원가입.
	 * 비밀번호와 이메일을 암호화한 데이터를 repository계층으로 넘겨야 한다.
	 * @param memberDto
	 * @return
	 */
	public int join(MemberDto memberDto) {
		int code = -1;
		try {
			//사용자 정보를 암호화 후 repository계층으로 넘김
			code = memberRepository.save(encrypt(memberDto));
		} catch (DuplicateKeyException e) {
			//memberId는 Unique키 제약조건이 있어서, 
			//같은 id로 가입시도 하면 exception 발생
			code = 0;
			e.printStackTrace();
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		return code;
	}
	
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
