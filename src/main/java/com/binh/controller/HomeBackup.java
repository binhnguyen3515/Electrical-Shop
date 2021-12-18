//package com.binh.controller;
//
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//import java.util.Optional;
//
//import javax.servlet.http.HttpServletRequest;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.data.domain.Page;
//import org.springframework.data.domain.PageRequest;
//import org.springframework.data.domain.Pageable;
//import org.springframework.data.domain.Sort;
//import org.springframework.data.domain.Sort.Direction;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//
//import com.binh.model.Category;
//import com.binh.model.Product;
//import com.binh.model.User;
//import com.binh.repository.Repository_Category;
//import com.binh.repository.Repository_DetailedProduct;
//import com.binh.repository.Repository_Product;
//import com.binh.service.SessionService;
//
//@Controller
//@RequestMapping("")
//public class Controller_Home {
//	
//	@Autowired Repository_Product repoProduct;
//	@Autowired Repository_DetailedProduct repoDetailedProd;
//	@Autowired Repository_Category repoCategory;
//	@Autowired HttpServletRequest request;
//	@Autowired SessionService session;
//	
//	@RequestMapping("")
//	public String index(Model model,
//			@RequestParam("page")Optional<Integer>p,
//			@RequestParam(value="closeBanner",defaultValue = "starting")Optional<String> closeBanner,
//			@RequestParam(value="sortBy",defaultValue = "all")String sortBy,
//			@RequestParam(value="showByNumber",defaultValue = "10")Integer number,
//			@RequestParam(value="keywords",defaultValue = "")Optional<String>kw,
//			@ModelAttribute("profile")User user){
//		System.out.println("index running");
//		//trở về trạng thái bthuong
//		session.removeAttribute("keywords");
//		//Mặc định sort theo discount
//		Sort sort = Sort.by(Direction.DESC,"discount");
//		//bật tắt banner
//		if(closeBanner.orElse("").equals("false") ) {
//			session.setAttribute("closeBanner", false);
//		}else if(closeBanner.orElse("").equals("true")) {
//			session.setAttribute("closeBanner", true);
//		}
//		//phân trang
//		Pageable pageable =  null;
//		Page<Product> items = null;
//		if(sortBy.equals("all")) {
//			System.out.println("run0");
//			pageable = PageRequest.of(p.orElse(0), number,sort);
//			items = repoProduct.findByIsdeletedFalse(pageable);
//		}else {
//			System.out.println("run1");
//			pageable = PageRequest.of(p.orElse(0), number);
//			items = repoProduct.findAllByCategoryID(sortBy, pageable);
//		}
//		//Search Product
//		String kwords = kw.orElseGet(()->(String)session.getAttribute("keywords",""));
//		if(!kwords.equals("")) {
//			try {
//				Page<Product> searchList = repoProduct.findByNameContaining(kwords, pageable);
//				if(searchList.isEmpty()) {
//					session.setAttribute("message", "No items found!");
//					String referrer = request.getHeader("referer");
//					return "redirect:"+referrer;
//				}else {
//					items = searchList;
//					System.out.println("have item");
//				}
//			} catch (Exception e) {
//			}
//		}
//		model.addAttribute("keywords", kwords);
//		//Fill select box sort By and shows
//		List<Category> cate = repoCategory.findAll();
//		//Sort By Category
//		model.addAttribute("cateGoryList",cate);
//		//Message Sort and Show
//		model.addAttribute("sortMessage", sortBy);
//		model.addAttribute("showMessage", number);
//
//		model.addAttribute("productList",items);
//		return "index";
//	}
//	
//	@RequestMapping("searchPagination")
//	public String searchAndPagination(Model model,
//			@RequestParam("page")Optional<Integer>p,
//			@RequestParam(value="closeBanner",defaultValue = "starting")Optional<String> closeBanner,
//			@RequestParam(value="keywords",defaultValue = "")Optional<String>kw,
//			@ModelAttribute("profile")User user){
//		System.out.println("search running");
//		//Mặc định sort theo discount
//		Sort sort = Sort.by(Direction.DESC,"discount");
//		//bật tắt banner
//		if(closeBanner.orElse("").equals("false") ) {
//			session.setAttribute("closeBanner", false);
//		}else if(closeBanner.orElse("").equals("true")) {
//			session.setAttribute("closeBanner", true);
//		}
//		//phân trang
//		Pageable pageable =  PageRequest.of(p.orElse(0), 4,sort);
//		Page<Product> items = null;
//		//Search Product
//		String kwords = kw.orElseGet(()->(String)session.getAttribute("keywords",""));
//		if(!kwords.equals("")) {
//			try {
//				Page<Product> searchList = repoProduct.findByNameContaining(kwords, pageable);
//				if(searchList.isEmpty()) {
//					session.setAttribute("message", "No items found!");
//					String referrer = request.getHeader("referer");
//					return "redirect:"+referrer;
//				}else {
//					items = searchList;
//					System.out.println("have item");
//				}
//			} catch (Exception e) {
//			}
//		}
//		//Fill select box sort By and shows
//		List<Category> cate = repoCategory.findAll();
//		//Sort By Category
//		model.addAttribute("cateGoryList",cate);
//		session.setAttribute("keywords", kwords);
//		model.addAttribute("productList",items);
//		String referrer = request.getHeader("referer");
//		return "index";
//	}
//	
//	
//	@ModelAttribute("listGender")
//	public Map<Boolean,String> getGenders(){
//		Map<Boolean, String> map = new HashMap<>();
//		map.put(true, "Male");
//		map.put(false, "Female");
//		return map;
//	}
//}
