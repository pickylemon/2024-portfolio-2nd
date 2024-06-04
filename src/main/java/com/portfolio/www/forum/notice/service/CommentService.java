package com.portfolio.www.forum.notice.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.portfolio.www.forum.notice.dto.CommentDto;
import com.portfolio.www.forum.notice.repository.CommentRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommentService {
	private final CommentRepository commentRepository;
	
	public int addComment(CommentDto commentDto) {
		return commentRepository.save(commentDto);
	}
	
	public List<CommentDto> getCommentList(Integer boardSeq, Integer boardTypeSeq) {
		return commentRepository.getAllCommentList(boardSeq, boardTypeSeq);
	}
	
	public int deleteComment(int commentSeq) {
		return commentRepository.delete(commentSeq);
	}
	
	public int modifyComment(CommentDto commentDto) {
		return commentRepository.modify(commentDto);
	}
}
