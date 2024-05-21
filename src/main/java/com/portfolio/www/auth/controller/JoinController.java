package com.portfolio.www.auth.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.portfolio.www.auth.dto.MemberDto;
import com.portfolio.www.auth.message.AuthMessageEnum;
import com.portfolio.www.auth.service.JoinService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class JoinController {
	private final JoinService joinService;
	

	@GetMapping("/auth/joinPage.do")
	public ModelAndView join() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("auth/join");
		
		return mv;
	}
	
	/**
	 * 사용자 입력을 가지고 회원가입을 처리하는 메서드
	 * @param memberDto
	 * @param model
	 * @param rattr
	 * @return
	 */
	
	//TODO 사용자 입력 validation 추가하기 
	@PostMapping("/auth/joinPage.do")
	public ModelAndView join(@ModelAttribute MemberDto memberDto, Model model, RedirectAttributes rattr ) {
		log.info("memberDto={}", memberDto);
		//에러가 발생해 다시 회원가입 화면 뷰를 보여줄 때, 사용자 입력을 그대로 전달하기 위해
		//memberDto객체를 만들어 둠. 그냥 memberDto를 모델에 담아 전달하면 
		//암호화된 값이 전달되므로 의도에 맞지 않는다.
		MemberDto beforeEncDto = new MemberDto(memberDto);
		ModelAndView mv = new ModelAndView();
		
		int code = joinService.join(memberDto);
		
		if(code == 1) {
			//회원가입 성공시 다시 홈으로 이동
			rattr.addFlashAttribute("msg", AuthMessageEnum.SUCCESS.getMsg());
			mv.setViewName("redirect:/"); 
			return mv;
		} else if (code == 0){
			model.addAttribute("msg", AuthMessageEnum.ALREADY_EXISTS.getMsg());
		} else { //code == -1
			model.addAttribute("msg", AuthMessageEnum.JOIN_FAIL.getMsg());
		}
		//회원가입 실패시 유저의 입력데이터 그대로 들고 다시 form으로
		model.addAttribute("memberDto",beforeEncDto);
		mv.setViewName("auth/join"); 
		return mv;
	}
}
