package com.portfolio.www.forum.notice.dto;

import javax.validation.constraints.NotBlank;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class BoardSaveDto {
	//제목, 내용, 파일
	private Integer boardSeq;
	@NotBlank(message = "제목을 입력해주세요.")
	private String title;
	@NotBlank(message = "본문 내용을 입력해주세요.")
	private String content;
//	@NotEmpty
	private Integer boardTypeSeq;
//	@NotEmpty
	private Integer regMemberSeq;
}
