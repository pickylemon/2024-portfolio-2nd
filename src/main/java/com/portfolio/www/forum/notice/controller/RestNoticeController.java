package com.portfolio.www.forum.notice.controller;

import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.portfolio.www.forum.notice.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/forum/notice")
public class RestNoticeController {
	private final BoardService boardService;
	
	
	/**
	 * 게시글 삭제
	 * @param boardTypeSeq
	 * @param boardSeq
	 * @return
	 */
	@DeleteMapping("/{boardTypeSeq}/{boardSeq}/deletePage.do")
	public ResponseEntity<String> deletePage(@PathVariable("boardTypeSeq") Integer boardTypeSeq,
								@PathVariable("boardSeq") Integer boardSeq) {
		
		int code = boardService.delete(boardSeq, boardTypeSeq);
		if(code==1) {
			return ResponseEntity.ok()
					//헤더에 UTF-8 추가 안해주면 ajax 콜백에서 한글 다 깨짐
					.header(HttpHeaders.CONTENT_TYPE, "application/json;charset=UTF-8")
					.body("게시글이 성공적으로 삭제되었습니다");
		} else {
			return ResponseEntity.badRequest()
					.header(HttpHeaders.CONTENT_TYPE, "application/json;charset=UTF-8")
					.body("게시글 삭제에 실패했습니다");
		}
		
	}
	
}
