package com.binh.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.binh.model.Category;
import com.binh.model.Product;
import com.binh.model.User;
import com.binh.repository.Repository_Category;
import com.binh.repository.Repository_DetailedProduct;
import com.binh.repository.Repository_Product;
import com.binh.service.SessionService;

@Controller
@RequestMapping("")
public class Controller_Home {
	
	@Autowired Repository_Product repoProduct;
	@Autowired Repository_DetailedProduct repoDetailedProd;
	@Autowired Repository_Category repoCategory;
	@Autowired HttpServletRequest request;
	@Autowired SessionService session;
	
	@RequestMapping("")
	public String index(Model model,
			@RequestParam("page")Optional<Integer>p,
			@RequestParam(value="closeBanner",defaultValue = "starting")Optional<String> closeBanner,
			@RequestParam(value="sortBy",defaultValue = "all")String sortBy,
			@RequestParam(value="showByNumber",defaultValue = "10")Integer number,
			@RequestParam(value="keywords",defaultValue = "")Optional<String>kw,
			@RequestParam(value="min",defaultValue = "123696978966989")Optional<Double>min,
			@RequestParam(value="max",defaultValue = "123696978966989")Optional<Double>max,
			@RequestParam(value="sortByA_Z",defaultValue = "A_Z")Optional<String>sortByA_Z,
			@ModelAttribute("profile")User user){
		//trở về trạng thái bthuong
		session.removeAttribute("keywords");
		//Mặc định sort theo discount
		Sort sort = Sort.by(Direction.DESC,"discount");
		//bật tắt banner
		if(closeBanner.orElse("").equals("false") ) {
			session.setAttribute("closeBanner", false);
		}else if(closeBanner.orElse("").equals("true")) {
			session.setAttribute("closeBanner", true);
		}
		//phân trang
		Pageable pageable =  null;
		Page<Product> items = null;
		
		
		//Search Price Range
		double minPrice = min.get();
		double maxPrice = max.get();
		try {
			System.out.println("min: "+minPrice);
			System.out.println("max: "+maxPrice);
			if(minPrice != 123696978966989d && maxPrice != 123696978966989d && sortByA_Z.get().equals("A_Z")) {
				pageable = PageRequest.of(p.orElse(0), number);
				Page<Product> listPriceRange = repoProduct.findByPriceMinAndMax(minPrice, maxPrice,pageable);
				if(listPriceRange.isEmpty()) {
					session.setAttribute("message", "No items found!");
					String referrer = request.getHeader("referer");
					return "redirect:"+referrer;
				}else {
					items = listPriceRange;
				}
				model.addAttribute("min", minPrice);
				model.addAttribute("max", maxPrice);
			}		
		} catch (Exception e) {
			System.out.println("no item found");
		}
		
		//sort by category
		if(minPrice == 123696978966989d && maxPrice == 123696978966989d && sortByA_Z.get().equals("A_Z")&& kw.get().equals("")) {
			if(sortBy.equals("all")) {
				System.out.println("run0");
				pageable = PageRequest.of(p.orElse(0), number,sort);
				items = repoProduct.findByIsdeletedFalse(pageable);
			}else {
				System.out.println("run1");
				pageable = PageRequest.of(p.orElse(0), number);
				items = repoProduct.findAllByCategoryID(sortBy, pageable);
				if(items.isEmpty()) {
					session.setAttribute("message", "No items found for this category!");
					String referrer = request.getHeader("referer");
					return "redirect:"+referrer;
				}
			}
		}
		
		//Search Product
		String kwords = kw.get();
		if(!kwords.equals("")) {
			System.out.println("running search");
			try {
				Page<Product> searchList = repoProduct.findByIsdeletedFalseAndNameContaining(kwords, pageable);
				if(searchList.isEmpty()) {
					session.setAttribute("message", "No items found!");
					String referrer = request.getHeader("referer");
					return "redirect:"+referrer;
				}else {
					items = searchList;
					System.out.println("have item");
				}
			} catch (Exception e) {
			}
		}
		//Sort By A_Z
		if(minPrice == 123696978966989d && maxPrice == 123696978966989d && kw.get().equals("") && !sortByA_Z.get().equals("A_Z") && kwords.equals("")) {
			System.out.println("running a-z");
			if(sortByA_Z.get().equals("nameDESC")) {
				pageable = PageRequest.of(p.orElse(0), number,sort);
				items = repoProduct.findByNameDesc(pageable);
			}
			if(sortByA_Z.get().equals("nameASC")) {
				pageable = PageRequest.of(p.orElse(0), number,sort);
				items = repoProduct.findByNameAsc(pageable);
			}
			if(sortByA_Z.get().equals("discountDESC")) {
				sort = Sort.by(Direction.DESC,"discount");
				pageable = PageRequest.of(p.orElse(0), number,sort);
				items = repoProduct.findByIsdeletedFalse(pageable);;
			}
			if(sortByA_Z.get().equals("discountASC")) {
				sort = Sort.by(Direction.ASC,"discount");
				pageable = PageRequest.of(p.orElse(0), number,sort);
				items = repoProduct.findByIsdeletedFalse(pageable);;
			}
			model.addAttribute("sortByA_Z", sortByA_Z.get());
		}
		
		
		model.addAttribute("keywords", kwords);
		//Fill select box sort By and shows
		List<Category> cate = repoCategory.findAll();
		//Sort By Category
		model.addAttribute("cateGoryList",cate);
		//Message Sort and Show
		model.addAttribute("sortMessage", sortBy);
		model.addAttribute("showMessage", number);

		model.addAttribute("productList",items);
		return "index";
	}
	
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
	
	
	@ModelAttribute("listGender")
	public Map<Boolean,String> getGenders(){
		Map<Boolean, String> map = new HashMap<>();
		map.put(true, "Male");
		map.put(false, "Female");
		return map;
	}
}
