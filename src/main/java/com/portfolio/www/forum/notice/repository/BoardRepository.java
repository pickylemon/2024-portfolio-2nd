package com.portfolio.www.forum.notice.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.portfolio.www.forum.notice.dto.BoardDto;
import com.portfolio.www.forum.notice.dto.BoardModifyDto;
import com.portfolio.www.forum.notice.dto.BoardSaveDto;
import com.portfolio.www.forum.notice.dto.BoardVoteDto;
import com.portfolio.www.forum.notice.dto.PageHandler;
import com.portfolio.www.forum.notice.dto.SearchCondition;


public interface BoardRepository {
	List<BoardDto> getList(@Param("ph") PageHandler ph, @Param("sc") SearchCondition sc);
	
	int getTotalCnt(@Param("sc") SearchCondition sc);
	
	BoardDto getOne(@Param("boardSeq") Integer boardSeq, @Param("boardTypeSeq") Integer boardTypeSeq);
	
	BoardVoteDto getVote(@Param("boardSeq") int boardSeq, @Param("boardTypeSeq") int boardTypeSeq, @Param("memberSeq") int memberSeq);
	
	int addVote(@Param("boardSeq") int boardSeq, @Param("boardTypeSeq") int boardTypeSeq, 
			@Param("memberSeq") int memberSeq, @Param("isLike") String isLike, @Param("ip") String ip);
	
	int deleteVote(@Param("boardSeq") int boardSeq, @Param("boardTypeSeq") int boardTypeSeq, 
				@Param("memberSeq") int memberSeq, @Param("isLike") String isLike);
	
	int updateVote(@Param("boardSeq") int boardSeq, @Param("boardTypeSeq") int boardTypeSeq, 
			@Param("memberSeq") int memberSeq, @Param("isLike") String isLike, @Param("ip") String ip);
	
	int save(BoardSaveDto dto);
	
	int update(BoardModifyDto dto);
	
	int delete(@Param("boardSeq") Integer boardSeq, @Param("boardTypeSeq") Integer boardTypeSeq);
	
	int getLikeTotal(@Param("boardSeq") int boardSeq, @Param("boardTypeSeq") int boardTypeSeq);
	int getUnlikeTotal(@Param("boardSeq") int boardSeq, @Param("boardTypeSeq") int boardTypeSeq);

	int updateViewCnt(@Param("boardSeq") Integer boardSeq, @Param("boardTypeSeq") Integer boardTypeSeq);

}
