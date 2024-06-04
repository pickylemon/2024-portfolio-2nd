package com.portfolio.www.forum.notice.dto;

import lombok.Data;

@Data
public class CommentVoteDto {
	private int commentSeq;
	private int memberSeq;
	private String isLike;
	private String regDtm;
	private String ip;
	
	
	public CommentVoteDto(int commentSeq, int memberSeq, String isLike, String ip) {
		this.commentSeq = commentSeq;
		this.memberSeq = memberSeq;
		this.isLike = isLike;
		this.ip = ip;
	}

}
