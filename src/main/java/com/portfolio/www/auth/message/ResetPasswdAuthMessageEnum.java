package com.portfolio.www.auth.message;

import lombok.Getter;

@Getter
public enum ResetPasswdAuthMessageEnum {
	MAIL_SEND_SUCCESS("000", "메일이 발송되었습니다. 확인해주세요."), 
	NO_SUCH_MEMBER("001", "존재하지 않는 회원입니다."),
	
	INVALID_AUTH_TIME("101", "인증 시간이 초과되었습니다."),
	AUTH_MAIL_FAIL("102", "이메일 발송 중 오류가 발생했습니다."),
	FAIL("103", "오류가 발생했습니다."),
	
	PASSWD_RESET_SUCCESS("200", "비밀번호가 성공적으로 변경되었습니다");
	
	private ResetPasswdAuthMessageEnum(String code, String msg) {
		this.code = code;
		this.msg = msg;
	}
	
	String code;
	String msg;
}