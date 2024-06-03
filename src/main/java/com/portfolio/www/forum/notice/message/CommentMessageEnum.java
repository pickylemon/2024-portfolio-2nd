package com.portfolio.www.forum.notice.message;

import lombok.Getter;

@Getter
public enum CommentMessageEnum {
	SAVE_SUCCESS("000", "댓글이 성공적으로 등록되었습니다"),
	SAVE_FAIL("001", "댓글 작성에 실패했습니다"),
	
	DEL_SUCCESS("100", "댓글이 성공적으로 삭제되었습니다."),
	DEL_FAIL("101", "댓글 삭제에 실패했습니다."),
	
	MODIFY_SUCCESS("200", "댓글이 성공적으로 수정되었습니다"),
	MODFY_FAIL("201", "댓글 수정에 실패했습니다");
	
	
	CommentMessageEnum(String code, String msg) {
		this.code = code;
		this.msg = msg;
	}
	
	private String code;
	private String msg;

}
