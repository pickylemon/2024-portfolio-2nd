package com.portfolio.www.forum.notice.message;

import lombok.Getter;

@Getter
public enum BoardMessageEnum {
	SAVE_SUCCESS("000", "게시글이 성공적으로 등록되었습니다"),
	SAVE_FAIL("001", "게시글 작성에 실패했습니다"),
	FILE_UPLOAD_FAIL("002", "첨부파일 업로드에 문제가 발생했습니다");
	
	
	BoardMessageEnum(String code, String msg) {
		this.code = code;
		this.msg = msg;
	}
	
	private String code;
	private String msg;

}
