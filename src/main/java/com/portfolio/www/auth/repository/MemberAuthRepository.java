package com.portfolio.www.auth.repository;

import com.portfolio.www.auth.dto.MemberAuthDto;
import com.portfolio.www.auth.dto.PasswdResetDto;
import com.portfolio.www.auth.dto.ResetPasswdAuthDto;

public interface MemberAuthRepository {

	public int addAuthInfo(MemberAuthDto dto);
	public MemberAuthDto getMemberAuthDto(String uri);
	public int updateAuthValid(String uri);
	
	//비밀번호 찾기시 메일로 보낼 인증주소를 등록
	public int addResetPasswdAuthInfo(ResetPasswdAuthDto dto);
	public PasswdResetDto getPasswdResetDto(String uri);
	public int updateResetPasswdAuthYn(PasswdResetDto dto);
}
