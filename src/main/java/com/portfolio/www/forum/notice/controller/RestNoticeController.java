package com.portfolio.www.forum.notice.controller;

import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.portfolio.www.forum.notice.message.BoardMessageEnum;
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
		
		//code = -1; //에러 테스트용
		if(code==1) {
			return ResponseEntity.ok()
					//헤더에 UTF-8 추가 안해주면 ajax 콜백에서 한글 다 깨짐
					.header(HttpHeaders.CONTENT_TYPE, "application/json;charset=UTF-8")
					.body(BoardMessageEnum.DEL_SUCCESS.getMsg());
		} else {
			return ResponseEntity.badRequest()
					.header(HttpHeaders.CONTENT_TYPE, "application/json;charset=UTF-8")
					.body(BoardMessageEnum.DEL_FAIL.getMsg());
		}
		
	}
	

	/**
	 * 수정 페이지에서 파일 개별 삭제 요청
	 * @param boardTypeSeq
	 * @param boardSeq
	 * @return
	 */
	@DeleteMapping("/{attachSeq}/deleteFile.do")
	public ResponseEntity<String> deleteFile(@PathVariable("attachSeq") Integer attachSeq) {
		int code = boardService.deleteFile(attachSeq);
		//code = -1; //에러 테스트용
		if(code==1) {
			return ResponseEntity.ok()
					//헤더에 UTF-8 추가 안해주면 ajax 콜백에서 한글 다 깨짐
					.header(HttpHeaders.CONTENT_TYPE, "application/json;charset=UTF-8")
					.body(BoardMessageEnum.FILE_DELETE_SUCCESS.getMsg());
		} else {
			return ResponseEntity.badRequest()
					.header(HttpHeaders.CONTENT_TYPE, "application/json;charset=UTF-8")
					.body(BoardMessageEnum.FILE_DELETE_FAIL.getMsg());
		}
		
		
	}
	
	
	
}
