package com.portfolio.www.contact.message;

import lombok.Getter;

@Getter
public enum ContactMessageEnum {
	SUCCESS("000", "감사합니다. 확인 후 이력서를 발송드리겠습니다."),
	FAIL("001", "양식을 채워서 입력해주세요.");
	
	
	private ContactMessageEnum(String code, String msg) {
		this.code = code;
		this.msg = msg;
	}
	String code;
	String msg;
}
