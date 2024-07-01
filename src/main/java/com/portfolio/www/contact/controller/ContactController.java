package com.portfolio.www.contact.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.portfolio.www.contact.dto.ContactDto;
import com.portfolio.www.contact.message.ContactMessageEnum;
import com.portfolio.www.contact.service.ContactService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class ContactController {
	private final ContactService contactService;
	
	@PostMapping("/contactMe.do")
	public String contact(@Validated ContactDto contactDto, BindingResult result, Model model, RedirectAttributes rattr) {
		log.info("contactDto={}", contactDto);
		
		if(result.hasErrors()) {
			model.addAttribute("msgObject", ContactMessageEnum.FAIL);
			model.addAttribute("contactDto", contactDto);
			return "contactMe";
		}
		//성공시
		int code = contactService.save(contactDto);
		rattr.addFlashAttribute("msgObject", ContactMessageEnum.SUCCESS);
		return "redirect:/index.do";
	}
	
	@GetMapping("/contactMe.do")
	public String contactPage() {
		return "contactMe";
	}

}
