package com.portfolio.www.forum.notice.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BoardVoteDto {
	private int boardSeq;
	private int boardTypeSeq;
	private int memberSeq;
	private String ip;
	private String isLike;
	private String regDtm;
	
	
	public BoardVoteDto(int boardSeq, int boardTypeSeq, int memberSeq, String isLike, String ip) {
		this.boardSeq = boardSeq;
		this.boardTypeSeq = boardTypeSeq;
		this.memberSeq = memberSeq;
		this.ip = ip;
		this.isLike = isLike;
	}
	
	
}
