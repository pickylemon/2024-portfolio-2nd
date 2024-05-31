package com.portfolio.www.forum.notice.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.portfolio.www.forum.notice.dto.BoardAttachDto;
import com.portfolio.www.forum.notice.dto.BoardDto;
import com.portfolio.www.forum.notice.dto.BoardModifyDto;
import com.portfolio.www.forum.notice.dto.BoardSaveDto;
import com.portfolio.www.forum.notice.dto.PageHandler;
import com.portfolio.www.forum.notice.dto.SearchCondition;
import com.portfolio.www.forum.notice.exception.FileSaveException;
import com.portfolio.www.forum.notice.message.BoardMessageEnum;
import com.portfolio.www.forum.notice.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/forum/notice")
//게시글 목록 페이지, 개별 페이지(읽기), 작성 페이지 요청과 게시글 등록을 다루는 컨트롤러
//ajax통신은 RestNoticeController에서 담당
public class NoticeController {
	private final BoardService boardService;
	
	/**
	 * 게시글 목록 화면
	 * @param page
	 * @param size
	 * @param model
	 * @return
	 */
	@GetMapping("/listPage.do")
	public String listPage(@RequestParam(defaultValue = "1")Integer page, 
							@RequestParam(defaultValue = "10") Integer size,
							Model model) {
		PageHandler ph = new PageHandler(page, size);
		log.info("ph={}", ph);
		SearchCondition sc = new SearchCondition();
		List<BoardDto> list = boardService.getList(ph, sc);
		
		log.info("list={}",list);
		
		model.addAttribute("list", list);
		model.addAttribute("ph", ph);
		model.addAttribute("sc", sc);
		
		return "forum/notice/list";

	}
	/**
	 * 글쓰기 페이지
	 * @return
	 */
	@GetMapping("/writePage.do")
	public String writePage() {
		return "forum/notice/write";

	}
	
	@PostMapping("/writePage.do")
	public String write(@Validated BoardSaveDto boardSaveDto, BindingResult error, 
						MultipartFile[] attFiles, HttpSession session, RedirectAttributes rattr, Model model) {
		log.info("boardSaveDto={}", boardSaveDto);
		log.info("attFiles.length={}", attFiles.length);
		if(error.hasErrors()) { //작성 내용도 유효성 체크 해야함(ex. 공백 x)
			//사용자 작성 내용은 (생략된)@ModelAttribute에 담겨서 같이 전달됨.
			error.getAllErrors().forEach(System.out::println);
			return "forum/notice/write";
		}
		int memberSeq = (int)session.getAttribute("memberSeq");
		boardSaveDto.setRegMemberSeq(memberSeq);
		
		int code = boardService.savePost(boardSaveDto, attFiles);
		if(code == 1) {
			//성공적으로 게시글+첨부파일이 등록된 경우
			rattr.addFlashAttribute("msgObject", BoardMessageEnum.SAVE_SUCCESS);
//			rattr.addFlashAttribute("code", BoardMessageEnum.SAVE_SUCCESS.getCode());
//			rattr.addFlashAttribute("msg", BoardMessageEnum.SAVE_SUCCESS.getMsg());
			return "redirect:/forum/notice/listPage.do"; //목록으로 이동
		} else if (code == -2) { 
			//코드 -2 : 첨부파일을 물리적으로 저장하는데 예외 발생
			model.addAttribute("msgObject", BoardMessageEnum.FILE_UPLOAD_FAIL);
//			model.addAttribute("code", BoardMessageEnum.FILE_UPLOAD_FAIL.getCode());
//			model.addAttribute("msg", BoardMessageEnum.FILE_UPLOAD_FAIL.getMsg());
		} else { //code == -1 게시글 등록에 예외 발생
			model.addAttribute("msgObject", BoardMessageEnum.SAVE_FAIL);
//			model.addAttribute("code", BoardMessageEnum.SAVE_FAIL.getCode());
//			model.addAttribute("msg", BoardMessageEnum.SAVE_FAIL.getMsg());
		}
		//게시글 등록에 실패한 경우에도, 사용자가 입력한 정보가 사라지면 안되고 그대로 다시 뷰에 뿌려주어야함
		//BoardSaveDto앞에 @ModelAttribute가 생략되어 있음. 
		return "forum/notice/write";
	}
	
	/**
	 * 개별 게시글 읽기 페이지
	 * 1. 게시글에 대한 정보
	 *  : 제목, 내용, 작성자, 게시글에 대한 좋아요/싫어요 카운트 및 현재 로그인한 유저가 게시글에 대해 투표한 정보)
	 * 2. (있다면) 게시글의 첨부파일
	 *  : 첨부파일 제목, 용량, 다운로드 링크
	 * 3. (있다면) 게시글에 달린 댓글 목록
	 *  : 계층을 그리고 각 댓글에 대한 좋아요/싫어요 카운트 및 현재 로그인한 유저가 각 댓글에 대해 투표한 정보
	 * @param params
	 * @return
	 */
	@GetMapping("/readPage.do")
	public String readPage(Integer boardSeq, Integer boardTypeSeq, Model model) {
		BoardDto boardDto = boardService.getPost(boardSeq, boardTypeSeq);
		List<BoardAttachDto> attachDtoList = boardService.getAttFileInfoList(boardSeq, boardTypeSeq);
		
		log.info("boardDto={}", boardDto);
		log.info("attachDtoList={}", attachDtoList);
		model.addAttribute("attFileList", attachDtoList);
		model.addAttribute("boardDto", boardDto);
		return "forum/notice/read";
	}
	
	/**
	 * 게시판 수정 페이지 요청
	 * 해당 boardSeq와 boardTypeSeq로 식별되는 게시물 데이터(게시글, 첨부파일 정보)를 가져와
	 * 수정 페이지에 뿌려준다.
	 * @param boardSeq
	 * @param model
	 * @return
	 */
	@GetMapping("/{boardTypeSeq}/{boardSeq}/modifyPage.do")
	public String modifyPage(@PathVariable("boardSeq") Integer boardSeq, 
							@PathVariable("boardTypeSeq") Integer boardTypeSeq,
							Model model) {
		BoardDto boardDto = boardService.getPost(boardSeq, boardTypeSeq);
		log.info("boardDto.getContent={}", boardDto.getContent());
		List<BoardAttachDto> attFileList = boardService.getAttFileInfoList(boardSeq, boardTypeSeq);
		model.addAttribute("boardDto", boardDto);
		model.addAttribute("attFileList", attFileList);
		
		return "forum/notice/modify";
	}
	
	/**
	 * 게시글 수정
	 * (boardSeq가 미리 정해져있다는 점 빼고는 게시글 등록과 거의 유사)
	 * 
	 * 예외 별로 다른 메시지를 전달하고 싶고 Tx도 적용해야 해서 
	 * 결국 예외를 Controller까지 끌고 왔는데 
	 * 코드가 너무 지저분한 건 아닐까.
	 * Controller에서 DB 예외를 처리하는거 괜찮은걸까. 
	 * Controller까지 DB를 의존해야 할까.
	 * @param boardModifyDto
	 * @param error
	 * @param boardTypeSeq
	 * @param boardSeq
	 * @param attFiles
	 * @param session
	 * @param rattr
	 * @param model
	 * @return
	 */
	@PostMapping("/{boardTypeSeq}/{boardSeq}/modifyPage.do")
	public String modifyPage(@Validated BoardModifyDto boardModifyDto, BindingResult error, 
						@PathVariable("boardTypeSeq") Integer boardTypeSeq, 
						@PathVariable("boardSeq") Integer boardSeq,
						MultipartFile[] attFiles, HttpSession session, RedirectAttributes rattr, Model model) {
		
		log.info("boardSaveDto={}", boardModifyDto);
		if(attFiles!=null) {
			log.info("attFiles.length={}", attFiles.length);
		} 
		
		// QUESTION 작성 내용에 오류가 있으면 사용자 입력을 다시 수정페이지에 뿌려주어야 한다.
		// 단순 텍스트일때는 간단했는데, 
		// 사용자가 파일을 첨부했을 경우 이것도 다시 같이 넘겨야 하는데...? 
		// -> string 파라미터가 아니라 파일을 도대체 어떻게 모델에 담아 전달할 수 있을지 감이 안와서.. 
		// 일단은 그냥 안내메시지로 처리
		// 또 수정이 아닌 등록시에 이미 추가했던 파일에 대한 정보도 또 다시 같이 넘겨야함. (이건 뭐 조회해서 넘기면 되니까..)
		if(error.hasErrors()) { 
			//modify.jsp 뷰에서 EL표현을 통일하기 위해, getMapping에서 모델에 담아 넘겨주는 객체와 이름을 일치시킴.
			model.addAttribute("boardDto", boardModifyDto);
			model.addAttribute("attFileList", boardService.getAttFileInfoList(boardSeq, boardTypeSeq));
			//사실, 수정 페이지에서 사용자가 추가한 첨부파일 정보도 같이 넘겨야 하는데..
			if(attFiles!=null && !attFiles[0].isEmpty()) {
				String uploadMsg = "파일을 다시 업로드 해주세요.";
				model.addAttribute("uploadMsg", uploadMsg);
			}
			error.getAllErrors().forEach(System.out::println);
			return "forum/notice/modify";
		}
		
		try {
			int memberSeq = (int)session.getAttribute("memberSeq");
			boardModifyDto.setUpdateMemberSeq(memberSeq);
			boardService.modify(boardModifyDto, attFiles);
			//성공적으로 게시글+첨부파일이 수정된 경우
			rattr.addFlashAttribute("msgObject", BoardMessageEnum.MODIFY_SUCCESS);
			return "redirect:/forum/notice/listPage.do"; //목록으로 이동
		} catch (DataAccessException e) {
			//게시글 수정에 예외 발생
			model.addAttribute("msgObject", BoardMessageEnum.MODFY_FAIL);
		} catch (FileSaveException e) {
			//첨부파일을 물리적으로 저장하는데 예외 발생
			model.addAttribute("msgObject", BoardMessageEnum.FILE_UPLOAD_FAIL);
		}
		//게시글 수정에 실패한 경우에도, 사용자가 입력한 정보가 사라지면 안되고 그대로 다시 뷰에 뿌려주어야함
		//GetMapping에서 뷰에 뿌려줄때와 일치시키기 위해 model에 담는 객체명 통일
		model.addAttribute("attFileList", boardService.getAttFileInfoList(boardSeq, boardTypeSeq));
		model.addAttribute("boardDto", boardModifyDto);
		if(attFiles!=null && !attFiles[0].isEmpty()) {
			String uploadMsg = "파일을 다시 업로드 해주세요.";
			model.addAttribute("uploadMsg", uploadMsg);
		}
		return "forum/notice/modify";
	}
	
	
}
