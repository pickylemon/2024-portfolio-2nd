package com.portfolio.www.forum.notice.dto;

import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class CommentDto {
	private Integer commentSeq;
	private Integer lvl;
	@NotBlank
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
	
	//voteDto로 부터 가져올 값
	private String isLike;
	private int likeTotal;
	private int unlikeTotal;
	
	public void setVoteResult(CommentVoteDto voteDto, int likeTotal, int unlikeTotal) {
		//이전 투표결과(voteDto)가 없으면 isLike는 default가 null이다.
		if(voteDto != null) {
			setIsLike(voteDto.getIsLike());
		}
		setLikeTotal(likeTotal);
		setUnlikeTotal(unlikeTotal);
	}
}
