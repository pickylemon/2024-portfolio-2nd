package com.portfolio.www.forum.notice.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.portfolio.www.forum.notice.dto.CommentDto;
import com.portfolio.www.forum.notice.dto.CommentVoteDto;



public interface CommentRepository {
	//댓글에 대한 CRUD
	int save(CommentDto commentDto);
	int modify(CommentDto commentDto);
	int delete(int commentSeq);
	List<CommentDto> getAllCommentList(@Param("boardSeq") int boardSeq, @Param("boardTypeSeq") int boardTypeSeq);
	int count(@Param("boardSeq") int boardSeq, @Param("boardTypeSeq") int boardTypeSeq);
	CommentVoteDto getVote(@Param("commentSeq") int commentSeq, @Param("memberSeq") int memberSeq);
	
	//댓글 투표 CRUD
	int addVote(CommentVoteDto dto);
	int deleteVote(int commentSeq);
	int updateVote(CommentVoteDto dto);
	int getLikeTotal(int commentSeq);
	int getUnlikeTotal(int commentSeq);


}
