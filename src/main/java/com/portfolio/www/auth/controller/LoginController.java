package com.portfolio.www.auth.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.portfolio.www.auth.dto.PasswdResetDto;
import com.portfolio.www.auth.message.LoginMessageEnum;
import com.portfolio.www.auth.message.ResetPasswdAuthMessageEnum;
import com.portfolio.www.auth.service.LoginService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/auth")
@Slf4j
public class LoginController {
	private final LoginService loginService;
	
	@GetMapping("/loginPage.do")
	public String loginPage(String url, Model model) {
		log.info("url={}",url);
		
		model.addAttribute("url", url);
		return "auth/login";
	}
	
	/**
	 * 유저 입력값으로 로그인 처리
	 * 성공시 - 세션에 저장 및 아이디 기억 기능 여부에 따른 쿠키 처리
	 * 실패시 - 입력값과 메시지를 가지고 로그인 페이지로 이동
	 * @param memberId
	 * @param passwd
	 * @param model
	 * @param request
	 * @return
	 */
	@PostMapping("/loginPage.do")
	public String login(String memberId, String passwd, Model model, 
			boolean rememberMe, HttpServletRequest request, 
			String url, HttpServletResponse response, RedirectAttributes rattr) {
		
		int code = loginService.login(memberId, passwd);
		
		if(code > 0) {
			//로그인 성공 : 로그인 성공시, memberSeq를 반환하도록 만들어 둠 
			int memberSeq = code;
			//1. 세션 처리(세션에 memberId보다는 seq를 저장하는 편이 더 유용한듯)
			HttpSession session = request.getSession();
			session.setAttribute("memberSeq", memberSeq);
			
			//2.rememberMe 설정에 따른 쿠키 처리
			log.info("rememberMe={}", rememberMe);
			Cookie cookie = makeCookie(memberId, rememberMe);
			response.addCookie(cookie);
			
			rattr.addFlashAttribute("msgObject", LoginMessageEnum.LOGIN_SUCCESS);

			return "redirect:"+(url==""? "/index.do" : url); 
			//로그인 성공시 원래 요청페이지로 이동(없으면 홈)
			//(로그인 필터를 통해 이 컨트롤러 메서드에 온 경우가 아닌,
			//직접적으로 로그인을 한 경우에는 name이 url인 input의 value가 빈 문자열로 넘어온다(null이 아님) 
			
		} else if (code == -8) {
			rattr.addFlashAttribute("msgObject", LoginMessageEnum.USER_NOT_AUTHORIZED);
			return "redirect:/index.do";
			
		} else if (code == -1) {
			//비밀번호 불일치
			model.addAttribute("msgObject", LoginMessageEnum.WRONG_PASSWD);
		
		} else {
			//해당 아이디로 가입된 회원 없음 code = -9
			model.addAttribute("msgObject", LoginMessageEnum.USER_NOT_REGISTERED);
		}
		//로그인 실패한 경우, 유저의 입력값을 가지고 다시 로그인 페이지로 돌아감
		model.addAttribute("memberId", memberId);
//		model.addAttribute("passwd", passwd); 비밀번호는 굳이 안 넘겨도 될 것 같다.
		return "auth/login";
	}
	
	//뷰에서, 로그인 상태에서만 로그아웃 버튼이 보이도록 지정한 상태이지만, 
	//사실 주소창에 직접 치고 들어올 수도 있다(get) 
	//-> 비정상적인 접근. 어떻게 대응을 해야할까? 404를 보여줘야 하나 아니면 그냥 조치없이 홈으로 가야하나..
	@GetMapping("/logout.do")
	public String logout(HttpServletRequest request, RedirectAttributes rattr) {
		HttpSession session = request.getSession(false);
		if(!ObjectUtils.isEmpty(session)) {
			session.invalidate();
			rattr.addFlashAttribute("msgObject", LoginMessageEnum.LOGOUT_SUCCESS);
		}
		return "redirect:/index.do";
	}

	private Cookie makeCookie(String memberId, boolean rememberMe) {
		Cookie cookie;
		if(rememberMe) { //아이디 저장 체크박스 선택시
			cookie = new Cookie("memberId", memberId);
			cookie.setMaxAge(60*60*24*7);
		} else { //아이디 저장 체크박스 해제시 - 기존 쿠키 덮어버리기
			cookie = new Cookie("memberId","");
			cookie.setMaxAge(0);
		}
		return cookie;
	}
	
	@GetMapping("/checkIdAndEmail.do")
	public String enterIdPage() {
		return "/auth/checkIdAndEmail";
	}
	
	@PostMapping("/checkIdAndEmail.do")
	public String verifyId(String memberId, String email, HttpServletRequest request, Model model, RedirectAttributes rattr) {
		String contextPath = request.getContextPath();
		int code = loginService.sendMailForPasswdReset(memberId, email, contextPath);
		
		log.info("memberId={}, email={}", memberId, email);
		//조회되는 아이디가 없거나, 
		//아이디가 일치해도 입력한 이메일이 가입시 입력한 이메일과 다르다면(가벼운 본인 인증 절차)
		//사용자 입력값을 그대로 뷰에 뿌려주고 메시지를 전달한다.
		
		//비밀번호 리셋 : 비밀번호 리셋 뷰가 필요하다(사용자가 새 비밀번호를 입력해야하니까)
		//근데, 이 뷰와 연결된 컨트롤러 메서드는, 그 주소가 유추가능해서는 안된다. (악용될 수 있으니까)
		//즉, 랜덤값으로 주소를 전달해야하고, 내부적으로는 그 랜덤값을 통해 사용자를 식별할 수 있어야 비밀번호 update도 가능하다.
		//그럼 결국 테이블이 또 필요한걸까?
		
		//해시함수를 이용해 이메일을 암호화했기때문에 복호화가 불가능하다.
		//즉 가입된 이메일을 직접 DB에서 꺼내서 사용자에게 확인시키거나, 이메일 전송에 사용할 수가 없음
		//사용자 입력 이메일이 저장된 이메일이 같은지 검증하고, 같다면 사용자 입력 이메일로 비밀번호 변경 메일을 보낸다.
		if(code == 1) {
			rattr.addFlashAttribute("msgObject",ResetPasswdAuthMessageEnum.MAIL_SEND_SUCCESS);
			return "redirect:/index.do";
		} else if (code == -1) {
			//조회되는 아이디가 없으면
			model.addAttribute("msgObject", ResetPasswdAuthMessageEnum.NO_SUCH_MEMBER);
		} else if (code == -3) {
			//이메일 발송 오류
			model.addAttribute("msgObject", ResetPasswdAuthMessageEnum.AUTH_MAIL_FAIL);
		} else {
			//기타 오류
			model.addAttribute("msgObject", ResetPasswdAuthMessageEnum.FAIL);
		}
		//유저 입력값을 다시 form으로 전달하며 메시지도 같이 전달
		model.addAttribute("memberId", memberId);
		model.addAttribute("email",email);
		return "/auth/checkIdAndEmail";
	}
	
	@GetMapping("/resetPasswd.do")
	public String resetPasswordPage(String uri, Model model) {
		log.info("authUri={}",uri);
		//authUri로 조회되는 
		PasswdResetDto dto = loginService.checkAuthUriForPasswdReset(uri);
		log.info("authDto={}", dto);
		if(dto != null) {
			model.addAttribute("dto", dto);
			return "/auth/resetPasswd";
		} else {
			return "redirect:/index.do"; //TODO 잘못된 접근 404페이지로 수정하기
		}
	}
	
	@PostMapping("/resetPasswd.do")
	public String resetPassword(@Valid PasswdResetDto passwdResetDto, BindingResult result, Model model, RedirectAttributes rattr) {
		//log.info("passwdResetDto={}", passwdResetDto);
		int memberSeq = passwdResetDto.getMemberSeq();
		
		if(result.hasErrors()) {
			result.getAllErrors().forEach(System.out::println);
			model.addAttribute("memberSeq", memberSeq);
			return "/auth/resetPasswd";
		}
		
		int code = loginService.resetPasswd(passwdResetDto);
		if(code == 1) {
			rattr.addFlashAttribute("msgObject", ResetPasswdAuthMessageEnum.PASSWD_RESET_SUCCESS);
			return "redirect:/index.do";
			
		} else {
			model.addAttribute("dto", passwdResetDto);
			return "/auth/resetPasswd";
		}
		
	}
}
