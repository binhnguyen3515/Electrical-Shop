package com.binh.service.interceptor;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.binh.model.Info;
import com.binh.model.User;
import com.binh.repository.Repository_Info;
import com.binh.service.SessionService;

@Service
public class VistorCounter implements HandlerInterceptor{
	@Autowired SessionService session;
	@Autowired Repository_Info repoInfo;
	private static int numberOfVisitors = 0;
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		Info info = repoInfo.getByDate(new Date());
		if(info == null) {
			info = new Info(new Date(), numberOfVisitors);
			repoInfo.save(info);
		}else {
			numberOfVisitors = info.getNumberofvisitors();
//			System.out.println("number Visitors pre:"+numberOfVisitors);
		}
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		String uri = request.getServletPath();
		String method = request.getMethod();

		if(method.equalsIgnoreCase("POST")) {
			if(uri.contains("/login")) {
				User user = session.getAttribute("loginInfo");
				if(user != null) {
					numberOfVisitors++;
					repoInfo.saveAndFlush(new Info(new Date(),numberOfVisitors));
//					System.out.println("number Visitors:"+numberOfVisitors);
				}
			}	
		}
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}
//	@Bean
//	public HttpSessionListener httpSessionListener() {
//	 return new HttpSessionListener() {
//	     @Override
//	     public void sessionCreated(HttpSessionEvent se) {
//	         System.out.println("Session Created with session id+" + se.getSession().getId());
//	     }
//	     @Override
//	     public void sessionDestroyed(HttpSessionEvent se) {
//	         System.out.println("Session Destroyed, Session id:" + se.getSession().getId());
//	     }
//	     
//	 };
//	}
}
