package com.dp.ggomjirak.kty.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.dp.ggomjirak.vo.MemberVo;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("세션에서 loginVo 값이 있는지 체크 하는 부분 들어감");
		// 세션에서 loginVo 값이 있는지 체크
		HttpSession session = request.getSession();
				
		// 요청 경로 얻기
		String uri = request.getRequestURI();
		String queryString = request.getQueryString();
		String requestPath = null;

		if (uri == "/manager/**/*") {
			uri = "/main/mainHome";
		}
		if(queryString == null) {
			requestPath = uri;
		} else {
			requestPath = uri + "?" + queryString; 
		}
		System.out.println("requestPath:" + requestPath);
		session.setAttribute("requestPath", requestPath);
		
		MemberVo memberVo = (MemberVo)session.getAttribute("loginVo");
				
		// 로그인 되어 있지 않다면
		if (memberVo == null) {
			//response.sendRedirect("/loginForm");
			response.sendRedirect("/mypage/login");
			return false; // 요청 처리를 중단
		}
		
		return true; // 요청 처리를 계속함
	}	
}