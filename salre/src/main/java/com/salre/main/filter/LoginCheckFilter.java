package com.salre.main.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.salre.main.login.UserDTO;

import lombok.extern.slf4j.Slf4j;

@WebFilter("*.do")
@Slf4j
public class LoginCheckFilter implements Filter {
	
    public LoginCheckFilter() {
    	
    }
    
	public void destroy() {
		
	}
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// 요청 수행하기 전
		HttpServletRequest req = (HttpServletRequest) request;
		
		// 요청의 주소 얻어보기
		String contextPath = req.getServletContext().getContextPath();
		String uri = req.getRequestURI();
		uri = uri.substring(contextPath.length());
		log.info("요청 주소 : " + uri);
		
		// 요청 주소가 로그인이면 요청대로 수행하고 로그인이 아니면 로그인 했는지 체크
		if (!uri.equals("/login")) {
			HttpSession session = req.getSession();
			UserDTO userDTO = (UserDTO) session.getAttribute("loggedInUser");
			
			if (userDTO == null) {
				log.info("로그인 안함");
				
				// 로그인 화면으로 이동
				HttpServletResponse res = (HttpServletResponse) response;
				res.sendRedirect(contextPath + "/login");
				return;
			}
		}
		
		chain.doFilter(request, response);
	}
	
	public void init(FilterConfig fConfig) throws ServletException {
		
	}

}
