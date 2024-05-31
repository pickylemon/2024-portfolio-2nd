package com.portfolio.www.forum.notice.dto;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class BoardModifyDto {
	//제목, 내용, 파일
	@NotNull
	private int boardSeq;
	@NotBlank(message = "제목을 입력해주세요")
	private String title;
	@NotBlank(message = "본문 내용을 입력해주세요")
	private String content;
	@NotNull
	private int boardTypeSeq;
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
