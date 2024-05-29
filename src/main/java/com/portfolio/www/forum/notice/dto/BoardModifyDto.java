package com.portfolio.www.forum.notice.dto;

import javax.validation.constraints.NotEmpty;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class BoardModifyDto {
	//제목, 내용, 파일
	@NotEmpty
	private int boardSeq;
	@NotEmpty
	private String title;
	@NotEmpty
	private String content;
	@NotEmpty
	private int boardTypeSeq;
	@NotEmpty
	private int updateMemberSeq;
	
	public BoardModifyDto(int boardTypeSeq, int boardSeq, int updateMemberSeq,
			String title, String content) {
		this.boardSeq = boardSeq;
		this.title = title;
		this.content = content;
		this.boardTypeSeq = boardTypeSeq;
		this.updateMemberSeq = updateMemberSeq;
	}
	
	
	

}
