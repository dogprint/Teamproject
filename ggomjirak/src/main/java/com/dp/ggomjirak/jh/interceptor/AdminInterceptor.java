package com.dp.ggomjirak.jh.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.dp.ggomjirak.vo.ManagerVo;
import com.dp.ggomjirak.vo.MemberVo;

public class AdminInterceptor extends HandlerInterceptorAdapter {

	 @Override
	 public boolean preHandle(HttpServletRequest req,
	    HttpServletResponse res, Object obj) throws Exception {
	  
	  HttpSession session = req.getSession();
	  MemberVo user = (MemberVo)session.getAttribute("user");
	  
	  ManagerVo mUser = (ManagerVo)session.getAttribute("mUser");
	  
	  if(user != null && mUser == null) {
	   res.sendRedirect("/main/mainHome");
	   return false;
	  }
	  
	  return true;
	 }
}
