package com.binh.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.binh.model.DetailedInvoice;
import com.binh.model.Invoice;
import com.binh.model.MailInfo;
import com.binh.model.User;
import com.binh.model.others.Login;
import com.binh.repository.Repository_Invoice;
import com.binh.repository.Repository_User;
import com.binh.service.CookieService;
import com.binh.service.MailerServiceImpl;
import com.binh.service.ParamService;
import com.binh.service.SessionService;
import com.binh.service.account.AccountService;
//import com.binh.service.actuator.OnlineUsersCounter;

@RequestMapping("")
@Component
public class Controller_Login {
	
	@Autowired SessionService session;
	@Autowired Repository_User repoUser;
	@Autowired ParamService param;
	@Autowired AccountService accountService;
	@Autowired CookieService cookie;
	@Autowired HttpServletRequest request;
	@Autowired Repository_Invoice repoInvoice;
	@Autowired MailerServiceImpl mailer;
	
//	@Autowired OnlineUsersCounter online;
	
	@GetMapping("login")
	public String showLogin(Model model) {
		//hiện thông tin account lưu trong cookie nếu trước đó tick remember
		
		try {
			Login loginInfo = new Login(cookie.getValue("_userID"), cookie.getValue("_pass"), Boolean.parseBoolean(cookie.getValue("_remember")));
			System.out.println("pass: "+loginInfo.getPassword());
			if(Boolean.parseBoolean(cookie.getValue("_remember"))==true) {
				model.addAttribute("login", loginInfo);
			}
		} catch (Exception e) {
		}
		return "account/login";
	}
	
	@PostMapping("login")
	public String login(Login login,Model model) {
		// xếp thứ tự return tuỳ vào tình huống
		// chỉ khi login thành công thì mới xét lưu cookie
		User loginInfo = accountService.login(login.getUserID(), login.getPassword());
		if(loginInfo == null) {
			session.setAttribute("message", "Account not exist");
			return "account/login";
		}
		if(loginInfo.getUserID().equals("wrongpass")) {
			session.setAttribute("message", "Wrong Password");
			return "account/login";
		}
		
		//tài khoản bị khoá
		if(loginInfo.isIsdeleted() == true) {
			session.setAttribute("message", "Account is suspended! Contact Admin to unlock!");
			return "account/login";
		}
			
		if(login.getRememberMe() == true && loginInfo.getUserID().equals(login.getUserID())) {
			cookie.add("_userID", loginInfo.getUserID(), 1);
			cookie.add("_pass", loginInfo.getPassword(), 1);
			cookie.add("_remember", "true", 1);
		}else {
			cookie.remove("_userID");
			cookie.remove("_pass");
			cookie.remove("_remember");
		}
		
		session.setAttribute("loginInfo", loginInfo);
		try {
			String uri = session.getAttribute("security-uri");
			System.out.println("securi-uri: "+uri);
			if(uri != null) {
				loadCartLog(model);
				return "redirect:"+uri;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		//đăng nhập thành công với tài khoản admin|staff
//		if(loginInfo.getRole().equals("Admin") || loginInfo.getRole().equals("Staff")) {
//			session.setAttribute("loginInfo", loginInfo);
//			loadCartLog(model);
//			return "redirect:/admin";
//		}
			
		//trường hợp đăng nhập thành công với tài khoản customer
//		session.setAttribute("loginInfo", loginInfo);
//		loadCartLog(model);
		return "redirect:/";
	}
	
	//Phải có modelAttribute("profile") Bên Controller_Home || Controller_Cart || Controller_Detail và ModelAttribute(listGender)
	@PostMapping("updateProfile")
	public String updateProfile(@ModelAttribute("profile")User user,@RequestParam("input-b6a[]")MultipartFile[] attach) {
		List<String> fileName = new ArrayList<String>();
		try {
			fileName = param.saveMultiFiles(attach, "home/userAvatar");
		} catch (Exception e) {
			
		}
		if(fileName.isEmpty()) {
			user.setPhoto(repoUser.getById(user.getUserID()).getPhoto());
		}else {
			user.setPhoto(fileName.get(0));
		}
		user.setIsdeleted(false);
		session.setAttribute("loginInfo", user);
		repoUser.saveAndFlush(user);
		
		String referrer = request.getHeader("referer");
		return "redirect:"+referrer;
	}
	
	@GetMapping("logout")
	public String logout() {
		session.removeAttribute("loginInfo");
		session.removeAttribute("listPayment");
		System.out.println("url: "+request.getServletPath());
		System.out.println("url: "+request.getContextPath());
		System.out.println("url: "+request.getRequestURL());
		System.out.println("url: "+request.getRequestURI().substring(request.getContextPath().length()+1,request.getRequestURI().lastIndexOf("logout")));
		String referrer = request.getHeader("referer");
		if(referrer.contains("admin")) {
			return "redirect:/login";
		}
		System.out.println("referer: "+referrer);
		return "redirect:"+referrer;
	}
	
	@RequestMapping("sign-up")
	public String showSignUp(@ModelAttribute("User")User user) {
		return "account/sign-up";
	}
	
	@PostMapping("sign-up")
	public String createAccount(@Validated @ModelAttribute("User")User user,BindingResult result,
			@RequestParam("input-b6a[]")MultipartFile[] attach,RedirectAttributes model) {
		if(result.hasErrors()) {
			return "account/sign-up";
		}
		try {
			Optional<User> checkEmpty = repoUser.findById(user.getUserID());
			System.out.println("id: "+checkEmpty.orElse(null).getUserID());
			if(checkEmpty != null) {
				session.setAttribute("message", "ID Existed. Please Choose other ID!");
				return "account/sign-up";
			}
		} catch (Exception e) {
			System.out.println("account empty");
		}
		//nếu ko có lỗi và không bị trùng ID thì thêm dữ liệu
		List<String> fileName = new ArrayList<String>();
		try {
			fileName = param.saveMultiFiles(attach, "home/userAvatar");
		} catch (Exception e) {
			
		}
		user.setPhoto(fileName.get(0));
		user.setIsdeleted(false);
		user.setRole("Customer");
		repoUser.save(user);
		session.setAttribute("message", "Your registration is done!");
		return "redirect:/sign-up";
	}
	
	@ResponseBody
	@PostMapping("forgotPass/{email}")
	public String forgotPassword(@PathVariable("email")String email) {
		System.out.println("email: "+email);
		User userInfo = repoUser.findByEmail(email.trim());
		if(userInfo == null) {
			return "emailNotExist";
		}
		String newPass = RandomStringUtils.randomAlphanumeric(8);
		MailInfo mailInfo = new MailInfo();
		mailInfo.setTo(email.trim());
		mailInfo.setSubject("Reset your password");
		String body = "Hello "+userInfo.getFullname()+". This is your new password: "+newPass;
		mailInfo.setBody(body);
		System.out.println("pass: "+newPass);
		mailer.queue(mailInfo);
		userInfo.setPassword(newPass);
		repoUser.saveAndFlush(userInfo);
		return "ok";
	}
	
	
	
	@ModelAttribute("listGender")
	public Map<Boolean,String> getGenders(){
		Map<Boolean, String> map = new HashMap<>();
		map.put(true, "Male");
		map.put(false, "Female");
		return map;
	}
	
	private void loadCartLog(Model model) {
//		session.removeAttribute("listPayment");
//		try {
//			User user = session.getAttribute("loginInfo");
//			System.out.println("id: "+user.getUserID());
//			List<Invoice> listPayment = repoInvoice.findAllByUserID(user.getUserID());
//			if(!listPayment.isEmpty()) {
//				session.setAttribute("listPayment", listPayment);
//
//				session.setAttribute("logStatus", "hasItem");
//			}else {
//				session.setAttribute("logStatus", "There is no item in your payment history");
//			}
//		} catch (Exception e) {
//			// TODO: handle exception
//		}
	}
}
