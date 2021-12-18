package com.binh.service.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.binh.model.User;
import com.binh.service.SessionService;

@Service
public class AuthInterceptor implements HandlerInterceptor {
	@Autowired SessionService session;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String uri = request.getServletPath();
		String error = "";
		System.out.println("uri: "+uri);
		try {
			User user = session.getAttribute("loginInfo");
			//chưa đăng nhập
			if(user == null) {
				System.out.println("user null");
				error = "Please login to enter this field";
//				response.sendRedirect("/login");
			}
			
			if(user.getRole().equals("Customer") && uri.startsWith("/admin")) {
				System.out.println("customer enter admin");
				error = "You don't have permission to enter this page";
			}
			
			if(user.getRole().equals("Staff") && uri.startsWith("/admin/account")) {
//				System.out.println("Staff enter admin/account");
				error = "You don't have permission to enter this page";
			}
			
			if(user.getRole().equals("Staff") && uri.startsWith("/admin/arhiveAccount")) {
//				System.out.println("Staff enter admin/account");
				error = "You don't have permission to enter this page";
			}
			
			if(user.getRole().equals("Admin") && uri.startsWith("/admin/account")) {
//				error = "You don't have permission to enter this page";
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		if(error.length()>0) {
			System.out.println("security-running");
			session.setAttribute("security-uri", uri);
			session.setAttribute("message", error);
			String referrer = request.getHeader("referer");
			response.sendRedirect(request.getContextPath());
			return false;
		}
		return true;
	}
}
