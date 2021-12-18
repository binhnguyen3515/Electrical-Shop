package com.binh.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import com.binh.model.Product;
import com.binh.model.User;
import com.binh.repository.Repository_Product;
import com.binh.repository.Repository_User;
import com.binh.service.SessionService;

@RequestMapping("admin")
@Component
public class Controller_Admin_Recover {
	@Autowired Repository_Product repoProduct;
	@Autowired Repository_User repoUser;
	@Autowired SessionService session;
	//Product Section
	@RequestMapping("arhiveProduct")
	public String showArchivedProduct(Model model) {
		//bật tắt banner
		session.setAttribute("onSelected", "archived");
		model.addAttribute("listProduct", repoProduct.findByIsdeletedTrue());
		return "admin/archivedProduct";
	}
	
	@GetMapping("product/recoverProductID/{id}")
	public String recoverProductID(@PathVariable("id")String productID) {
		System.out.println("id: "+productID);
		Product product = repoProduct.getById(productID);
		product.setIsdeleted(false);
		repoProduct.saveAndFlush(product);
		return "redirect:/admin/arhiveProduct";
	}
	
	@GetMapping("product/recoverSelected/{id}")
	public String recoverSelectedProductID(@PathVariable("id")String[] listID) {
		for (String id : listID) {
			Product product = repoProduct.getById(id);
			product.setIsdeleted(false);
			repoProduct.saveAndFlush(product);
		}
		return "redirect:/admin/arhiveProduct";
	}
	
	//Account Section
	@RequestMapping("arhiveAccount")
	public String showArchivedAccount(Model model) {
		//bật tắt banner
		session.setAttribute("onSelected", "archived");
		model.addAttribute("listAccount", repoUser.findByIsdeletedTrue());
		return "admin/archivedAccount";
	}
	
	@GetMapping("account/recoverUserID/{id}")
	public String recoverUserID(@PathVariable("id")String userID) {
		User user = repoUser.getById(userID);
		user.setIsdeleted(false);
		repoUser.saveAndFlush(user);
		return "redirect:/admin/arhiveAccount";
	}
	
	@GetMapping("account/recoverSelectedID/{id}")
	public String recoverSelectedID(@PathVariable("id")String[] listID) {
		for (String id : listID) {
			User user = repoUser.getById(id);
			user.setIsdeleted(false);
			repoUser.saveAndFlush(user);
		}
		return "redirect:/admin/arhiveAccount";
	}
}
