package com.portfolio.www.index;

import java.util.HashMap;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class IndexController {
	

	@RequestMapping("/index.do")
	public ModelAndView index(@RequestParam HashMap<String, String> params) {
		ModelAndView mv = new ModelAndView();

		mv.setViewName("index");
		return mv;
	}
	
	@RequestMapping("/contactMe.do")
	public ModelAndView contact() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("contactMe");
		return mv;
	}
	
	@RequestMapping("/aboutMe.do")
	public ModelAndView introduce() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("aboutMe");
		return mv;
	}
}
