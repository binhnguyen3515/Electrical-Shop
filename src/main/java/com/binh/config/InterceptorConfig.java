package com.binh.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.binh.service.SessionService;
import com.binh.service.interceptor.AuthInterceptor;
import com.binh.service.interceptor.VistorCounter;

@Configuration
public class InterceptorConfig implements WebMvcConfigurer{
	@Autowired AuthInterceptor auth;
	@Autowired VistorCounter visitor;
	@Autowired SessionService session;
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(auth)
		.addPathPatterns("/admin/account","/admin/arhiveAccount","/admin/**")
				.excludePathPatterns("");
		registry.addInterceptor(visitor);
		try {
			session.removeAttribute("loginInfo");
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
}
