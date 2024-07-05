package com.portfolio.www.index;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class IndexController {
	

	@GetMapping("/index.do")
	public String index(Model model, HttpServletRequest request) {
		log.info("\n\n >>>>index.do<<<<");
		log.info("model={}",model);
		
		String referer = request.getHeader("referer");
		log.info("\n\n >>>>index.do referer <<<<");
		log.info("referer={}",referer);
		return "index";
	}
	
	
	@GetMapping("/aboutMe.do")
	public ModelAndView introduce() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("aboutMe");
		return mv;
	}
}
