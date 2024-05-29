package com.portfolio.www.forum.notice.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.portfolio.www.forum.notice.dto.BoardDto;
import com.portfolio.www.forum.notice.dto.BoardSaveDto;
import com.portfolio.www.forum.notice.dto.PageHandler;
import com.portfolio.www.forum.notice.dto.SearchCondition;
import com.portfolio.www.forum.notice.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/forum/notice")
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
						MultipartFile[] attFiles, HttpSession session) {
		log.info("boardSaveDto={}", boardSaveDto);
		log.info("attFiles.length={}", attFiles.length);
		if(error.hasErrors()) { //작성 내용도 유효성 체크 해야함(ex. 공백 x)
			//사용자 작성 내용은 (생략된)@ModelAttribute에 담겨서 같이 전달됨.
			error.getAllErrors().forEach(System.out::println);
			return "forum/notice/write";
		}
		int memberSeq = (int)session.getAttribute("memberSeq");
		boardSaveDto.setRegMemberSeq(memberSeq);
		
		boardService.savePost(boardSaveDto, attFiles);
		return "redirect:/forum/notice/listPage.do";
	}
	
	/**
	 * 개별 게시글 읽기 페이지
	 * @param params
	 * @return
	 */
	@GetMapping("/readPage.do")
	public String readPage(@RequestParam HashMap<String, String> params) {
		return "forum/notice/read";
	}

}
