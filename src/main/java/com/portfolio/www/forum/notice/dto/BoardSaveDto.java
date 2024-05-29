package com.portfolio.www.forum.notice.dto;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class BoardSaveDto implements Serializable {
	//제목, 내용, 파일
	@NotBlank(message = "제목을 입력해주세요.")
	private String title;
	@NotBlank(message = "본문 내용을 입력해주세요.")
	private String content;
//	@NotEmpty
	private Integer boardTypeSeq;
//	@NotEmpty
	private Integer regMemberSeq;
}
