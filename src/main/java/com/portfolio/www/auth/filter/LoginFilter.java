package com.portfolio.www.auth.filter;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.util.ObjectUtils;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

//@WebFilter
//web.xml에 등록해둠
@Slf4j
public class LoginFilter implements Filter {
	private List<String> urlMappings = LoginUrlMapping.getUrlList();

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)req;
		HttpServletResponse response = (HttpServletResponse)resp;
		String contextPath = request.getContextPath();
		String requestURL = request.getRequestURL().toString();
		String requestURI = request.getRequestURI().replaceAll(contextPath, "");
		HttpSession session = request.getSession(false);
		
		//로그인이 필요한 페이지인지 검사
		if(urlMappings.stream().anyMatch(url -> requestURI.startsWith(url))) {
			log.info("로그인 필터 시작");
			//로그인이 필요한 페이지일때 로그인 상태인지 검사
			if(session == null || ObjectUtils.isEmpty(session.getAttribute("memberSeq"))) {
				//세션이 null이면 뒤에 코드는 실행이 안돼서 NullPointerException 발생하지 않지 않을까? 테스트하기
				response.sendRedirect(contextPath+"/auth/loginPage.do?url="+requestURL);
				return;  //return이 매우 중요. return 안 해주면 chain.doFilter까지 실행됨.
			}
		}
		chain.doFilter(request, response);
	}
	
	
	
	@Getter
	private enum LoginUrlMapping {
		BOARD("/forum"),
		SALES("/sales"),
		QA("/qa"),
		SUPPORT("/support");
		
		private final String url;
		
		LoginUrlMapping(String url) {
			this.url = url;
		}
		
		private static List<String> getUrlList() {
			return Stream.of(LoginUrlMapping.values())
					.map(LoginUrlMapping::getUrl)
					.collect(Collectors.toList());
		}
	}
}
