package com.portfolio.www.forum.notice.controller;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.portfolio.www.forum.notice.dto.CommentDto;
import com.portfolio.www.forum.notice.message.CommentMessageEnum;
import com.portfolio.www.forum.notice.service.CommentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@RequestMapping("/forum/notice")
@Slf4j
public class RestCommentController {
	private final CommentService commentService;
	
	/**
	 * 댓글을 저장하고 갱신된 댓글리스트를 반환한다.
	 * msg와 List를 함께 반환하기 위해 한번 객체로 한번 감싸서 반환
	 * 근데 addComment에서 댓글 저장과 댓글리스트 가져오기를 모두 하는게 맞나?
	 * 메서드를 분리해야하나? -> 일단은 댓글 등록 메서드에서는 등록만 담당하기로.
	 * 근데 post메서드이기때문에 get으로 보내는게 맞을것 같다.
	 * 새로고침하면 댓글이 계속 등록되는데 이건 의도하는 동작이 아님.
	 * js에서 성공 콜백함수 내에서 댓글 등록 성공시 다시 해당 page로 get요청보냄
	 * 
	 * 일단은 나눈 버전으로 구현
	 * @param commentDto
	 * @param session
	 * @return
	 */
	@PostMapping("/addComment.do")
	public ResponseEntity<String> addComment(@RequestBody CommentDto commentDto, HttpSession session) {
		int memberSeq = (int)session.getAttribute("memberSeq");
		commentDto.setRegMemberSeq(memberSeq);
		log.info("commentDto={}",commentDto);
		
		int code = commentService.addComment(commentDto);
		
		if(code == 1) {
			return ResponseEntity.ok()
					.header(HttpHeaders.CONTENT_TYPE, "application/json;charset=UTF-8")
					.body(CommentMessageEnum.SAVE_SUCCESS.getMsg());
		} else {
			return ResponseEntity.badRequest()
					.header(HttpHeaders.CONTENT_TYPE, "application/json;charset=UTF-8")
					.body(CommentMessageEnum.SAVE_FAIL.getMsg());
		}

	}
	
	@DeleteMapping("/{commentSeq}/deleteComment.do")
	public ResponseEntity<String> deleteComment(@PathVariable("commentSeq") int commentSeq) {
		int code = commentService.deleteComment(commentSeq);
		
		if(code == 1) {
			return ResponseEntity.ok()
								.header(HttpHeaders.CONTENT_TYPE, "application/json;charset=UTF-8")
								.body(CommentMessageEnum.DEL_SUCCESS.getMsg());
		} else {
			return ResponseEntity.badRequest()
								.header(HttpHeaders.CONTENT_TYPE, "application/json;charset=UTF-8")
								.body(CommentMessageEnum.DEL_FAIL.getMsg());
		}
	}
	
	@PatchMapping("/modifyComment.do")
	public ResponseEntity<String> modifyComment(@RequestBody CommentDto commentDto) {
		int code = commentService.modifyComment(commentDto);
		
		if(code == 1) {
			return ResponseEntity.ok()
								.header(HttpHeaders.CONTENT_TYPE, "application/json;charset=UTF-8")
								.body(CommentMessageEnum.MODIFY_SUCCESS.getMsg());
		} else {
			return ResponseEntity.badRequest()
								.header(HttpHeaders.CONTENT_TYPE, "application/json;charset=UTF-8")
								.body(CommentMessageEnum.MODFY_FAIL.getMsg());
		}
		
	}
//	
//	/**
//	 * 댓글 투표 
//	 * @param commentSeq
//	 * @param thumb
//	 * @param session
//	 * @param request
//	 * @return
//	 */
//	@GetMapping("/{commentSeq}/replyVote.do")
//	public ResponseEntity<ReplyVoteResponse> vote(@PathVariable("commentSeq") int commentSeq,
//									@RequestParam("thumb") boolean thumb, 
//									HttpSession session, HttpServletRequest request) {
//		log.info("commentSeq={}", commentSeq);
//		log.info("thumb={}", thumb);
//		//댓글 등록자
//		int memberSeq = (int)session.getAttribute("memberSeq");
//		//ip 주소
//		String ip = request.getRemoteAddr();
//		//댓글 투표 정보
//		String isLike = thumb? "Y" : "N";
//	
//		BoardCommentVoteDto commentVoteDto = new BoardCommentVoteDto(commentSeq, memberSeq, isLike, ip);
//		int code = commentService.vote(commentVoteDto);
//		ReplyVoteResponse response = new ReplyVoteResponse(code, thumb);
//		if(code == -1) {
//			return ResponseEntity.badRequest().body(response);
//		} else {
//			return ResponseEntity.ok().body(response);
//		}
//	}

}
