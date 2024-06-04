package com.portfolio.www.forum.notice.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.portfolio.www.forum.notice.dto.CommentDto;



public interface CommentRepository {
	int save(CommentDto commentDto);
	int modify(CommentDto commentDto);
	int delete(int commentSeq);
	List<CommentDto> getAllCommentList(@Param("boardSeq") int boardSeq, @Param("boardTypeSeq") int boardTypeSeq);
	int count(@Param("boardSeq") int boardSeq, @Param("boardTypeSeq") int boardTypeSeq);
//	BoardCommentVoteDto getVote(@Param("commentSeq") int commentSeq, @Param("memberSeq") int memberSeq);
//	int addVote(BoardCommentVoteDto dto);
//	int deleteVote(int commentSeq);
//	int updateVote(BoardCommentVoteDto dto);
//	int getLikeTotal(int commentSeq);
//	int getUnlikeTotal(int commentSeq);


}
