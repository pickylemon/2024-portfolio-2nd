package com.portfolio.www.forum.notice.dto;

import lombok.Data;

@Data
public class CommentDto {
	private Integer commentSeq;
	private Integer lvl;
	private String content;
	private Integer boardSeq;
	private Integer boardTypeSeq;
	
	private Integer regMemberSeq;
	private String regMemberNm;
	private Integer mentionMemberSeq;
	private String mentionMemberNm;
	private Integer parentCommentSeq;
	private String regDtm;
	private String updateDtm;
	private String deleteDtm;
	
	private String isLike;
	private int likeTotal;
	private int unlikeTotal;
}
