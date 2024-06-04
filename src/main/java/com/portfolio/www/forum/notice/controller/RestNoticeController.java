package com.portfolio.www.forum.notice.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.portfolio.www.forum.notice.dto.BoardVoteDto;
import com.portfolio.www.forum.notice.dto.VoteResponse;
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
	
	/**
	 * 1. param으로 전달받은 boardSeq, boardTypeSeq, memberSeq(복합 PK)로
	 * 	  DB에서 이전 투표 결과가 있는지 조회한다.
	 * 2. DB에 이전 투표 결과가 없다 -> 테이블에 insert
	 * 3. DB에 이전 투표 결과가 있다.
	 * 	3-1. 이전 투표 결과와 param으로 전달된 isLike가 일치(ex. 좋아요를 두번 누름)
	 *      -> 이전 투표 결과를 삭제(토글처럼 작용)
	 *  3-2. 이전 투표 결과와 param으로 전달된 isLike가 불일치
	 *      -> 이전 투표 결과의 isLike를 param으로 받은 isLike로 update    
	 */
	@GetMapping("/{boardTypeSeq}/{boardSeq}/vote.do")
	public ResponseEntity<VoteResponse> vote(
			@PathVariable("boardSeq") int boardSeq, 
			@PathVariable("boardTypeSeq") int boardTypeSeq,
			@RequestParam("thumb") boolean thumb, //좋아요(true), 싫어요(false)
			HttpServletRequest request) {
		
		//세션으로부터 memberSeq 얻어오기
		HttpSession session = request.getSession(false);
		int memberSeq = (int)session.getAttribute("memberSeq");
	
		//ip 주소 얻기
		String ip = request.getRemoteAddr();
		
		//댓글 투표 정보
		String isLike = thumb? "Y" : "N";
		//좋아요(싫어요) 요청에 대한 코드만 반환받는다.
		//구체적인 처리는 서비스계층에게 위임
		BoardVoteDto boardVoteDto = new BoardVoteDto(boardSeq, boardTypeSeq, memberSeq, isLike, ip);
		int code = boardService.vote(boardVoteDto);
	
		log.info("code={}", code);
		VoteResponse response = new VoteResponse(code, thumb);
		
		//예외가 발생했을 경우 code == -1
		if(code == -1) {
			return ResponseEntity.badRequest().body(response);
		} else {
			return ResponseEntity.ok().body(response);
		}
	}
	
	
}
