package com.portfolio.www.auth.message;

import lombok.Getter;

@Getter
public enum AuthMessageEnum {
	SUCCESS("000", "성공"), 
	ALREADY_EXISTS("001", "이미 존재하는 아이디입니다."),
	JOIN_FAIL("002", "회원가입에 실패했습니다");
	
	private AuthMessageEnum(String code, String msg) {
		this.code = code;
		this.msg = msg;
	}
	String code;
	String msg;
}
