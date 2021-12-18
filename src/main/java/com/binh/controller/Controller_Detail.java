package com.binh.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.binh.model.Category;
import com.binh.model.DetailedPicture;
import com.binh.model.DetailedProduct;
import com.binh.model.User;
import com.binh.repository.Repository_Category;
import com.binh.repository.Repository_DetailedPicture;
import com.binh.repository.Repository_DetailedProduct;

@Component
@RequestMapping("detail")
public class Controller_Detail {

	@Autowired Repository_DetailedProduct repoDetailedProd;
	@Autowired Repository_DetailedPicture repoDetailedPics;
	@Autowired Repository_Category repoCategory;
	
	@RequestMapping("{id}")
	public String showDetail(@PathVariable("id")String productID,Model model,@ModelAttribute("profile")User user) {
		System.out.println("id: "+productID);
		//lấy dữ liệu sản phẩm gồm thông tin chi tiết và thông tin hình ảnh
		List<DetailedProduct> listDetailProduct = repoDetailedProd.findByProductID(productID);
		List<DetailedPicture> listDetailPicture = repoDetailedPics.findByProductID(productID);
//		listDetailProduct.stream().forEach(p->System.out.println("name: "+p.getColor()));
//		listDetailPicture.stream().forEach(p->System.out.println("pic: "+p.getPicturename()));
		//đổ dữ liệu vào form
		model.addAttribute("listDetailProduct", listDetailProduct);
		model.addAttribute("listDetailPics", listDetailPicture);
		//Side bar Category Content
		List<Category> cate = repoCategory.findAll();
		//Sort By Category
		model.addAttribute("cateGoryList",cate);
		return "detail";
	}
	
	@ModelAttribute("listGender")
	public Map<Boolean,String> getGenders(){
		Map<Boolean, String> map = new HashMap<>();
		map.put(true, "Male");
		map.put(false, "Female");
		return map;
	}
}
