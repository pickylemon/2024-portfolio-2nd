package com.portfolio.www.forum.notice.service;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import com.portfolio.www.forum.notice.dto.CommentDto;
import com.portfolio.www.forum.notice.dto.CommentVoteDto;
import com.portfolio.www.forum.notice.repository.CommentRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class CommentService {
	private final CommentRepository commentRepository;
	
	public int addComment(CommentDto commentDto) {
		return commentRepository.save(commentDto);
	}
	
	//DataAccessException은 RuntimeException이라 rollbackFor 안 적어줘도 됨
	@Transactional 
	public List<CommentDto> getCommentList(Integer boardSeq, Integer boardTypeSeq, int memberSeq) {
		List<CommentDto> comments = commentRepository.getAllCommentList(boardSeq, boardTypeSeq);
		for(CommentDto comment : comments) {
			//현재 로그인 유저의 해당 댓글에 대한 투표결과,
			//해당 댓글의 총 좋아요/싫어요 카운트를 가져와서 commentDto에 반영한다.
			CommentVoteDto voteDto = commentRepository.getVote(comment.getCommentSeq(), memberSeq);
			int likeTotal = commentRepository.getLikeTotal(comment.getCommentSeq());
			int unlikeTotal = commentRepository.getUnlikeTotal(comment.getCommentSeq());
			
			comment.setVoteResult(voteDto, likeTotal, unlikeTotal);
		}
		return comments;
	}
	
	public int deleteComment(int commentSeq) {
		return commentRepository.delete(commentSeq);
	}
	
	public int modifyComment(CommentDto commentDto) {
		return commentRepository.modify(commentDto);
	}
	
	@Transactional
	public int vote(CommentVoteDto voteDto) {
		//이전 투표 결과가 있는지 체크
		int code = -1;
		CommentVoteDto savedCommentVoteDto = getVote(voteDto.getCommentSeq(), voteDto.getMemberSeq());
		try {
			if(ObjectUtils.isEmpty(savedCommentVoteDto)) { 
				//이전의 투표 결과가 없다. -> INSERT
				commentRepository.addVote(voteDto);
				code = 0;
			} else if(savedCommentVoteDto.getIsLike().equals(voteDto.getIsLike())) { 
				//이전 투표결과와 현재 투표 결과가 같다. -> DELETE
				commentRepository.deleteVote(voteDto.getCommentSeq());
				code = 1;
			} else {
				//이전 투표 결과와 다르다 -> UPDATE
				commentRepository.updateVote(voteDto);
				code = 2;
			}
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		return code;
	}
	
	
	/**
	 * 댓글에 대한 이전 투표 결과를 commentVoteDto로 가져온다. 없으면 null 반환
	 * @param commentSeq
	 * @param memberSeq
	 * @return
	 */
	public CommentVoteDto getVote(int commentSeq, int memberSeq) {
		CommentVoteDto commentVoteDto = null;
		try {
			commentVoteDto = commentRepository.getVote(commentSeq, memberSeq);
		} catch(EmptyResultDataAccessException e) {
			log.info(e.getMessage());
		}
		return commentVoteDto;
	}
}
