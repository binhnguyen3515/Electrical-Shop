package com.binh.controller;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.binh.model.Category;
import com.binh.repository.Repository_Category;
import com.binh.repository.Repository_FavoriteCount;
import com.binh.repository.Repository_Info;
import com.binh.repository.Repository_Invoice;
import com.binh.repository.Repository_StoredProcedureCall;
import com.binh.repository.Repository_User;
import com.binh.service.SessionService;
import com.binh.service.XDateService;

@RequestMapping("admin")
@Component
public class Controller_Admin_Statistics {
	@Autowired private SessionService session;
	@Autowired private Repository_Invoice repoInvoice;
	@Autowired private Repository_Info repoInfo;
	@Autowired private Repository_User repoUser;
	@Autowired private Repository_Category repoCate;
	@Autowired private Repository_FavoriteCount repoFav;
	@Autowired private XDateService dateService;
	@Autowired private Repository_StoredProcedureCall repoOthers;
	
	@GetMapping("statistics")
	public String showStatistics(Model model,
			@RequestParam(value="closeSidebar",defaultValue = "starting")Optional<String> closeSidebar,
			@RequestParam(value="dateARevenue",required = false)Optional<String> dateA,
			@RequestParam(value="dateBRevenue",required = false)Optional<String> dateB) {
		session.setAttribute("onSelected", "statistics");
		//First Row
		//Line Chart Number of Visitors last 7 days
		List<Object[]> visitorsLast7Days = repoInfo.visitorsLast7Days();
		model.addAttribute("visitorsLast7Days", visitorsLast7Days);
		
		//Line Chart Revenue Last 7 days -- invoice;
		List<Object[]> revenueLast7Days = repoInvoice.revenueLast7Days();
		model.addAttribute("revenueLast7Days", revenueLast7Days);
		
		//Line Chart number of product sold by type last 7 days -- category --
		List<Object[]>numberOfProductSoldByType = repoCate.numberOfProductSoldByType();
		model.addAttribute("numberOfProductSoldByType", numberOfProductSoldByType);
		
		//Second row
		//Top Favorite Products -- FavoriteCount -- 
		List<Object[]>topFavoriteProducts = repoFav.topFavoriteProducts();
		model.addAttribute("topFavoriteProducts", topFavoriteProducts);
		
		//Top Customers -- User --
		List<Object[]>topCustomers = repoUser.topCustomers();
		model.addAttribute("topCustomers", topCustomers);
		
		//Third row -- 
		//Revenue by range
		Date getDateA = dateService.toDate(dateA.orElse("2020-10-10"),"yyyy-MM-dd");
		Date getDateB = dateService.toDate(dateB.orElse(dateService.toString(new Date(), "yyyy-MM-dd")),"yyyy-MM-dd");
		List<Object[]> findRevenueByDateRange = repoInvoice.findRevenueByDayRange(getDateA,getDateB);
		model.addAttribute("findRevenueByDateRange", findRevenueByDateRange);
		model.addAttribute("dateARevenue", dateA.orElse(null));
		model.addAttribute("dateBRevenue", dateB.orElse(null));
		
		//CategoryManagement
		List<Category> listCate = repoCate.findAll();
		model.addAttribute("listCate", listCate);
		//PieChart Liked Product by category statistics
		List<Object[]>listProductLikedByType = repoCate.findLikedProductByCategory();
		model.addAttribute("listProductLikedByType", listProductLikedByType);
		
		return "admin/statistics";
	}
	
	@PostMapping("statistics/addCategory")
	public String addCategory(@RequestParam(value ="categoryName",required = false)String cateGoryName) {
		
		System.out.println("cateGoryName: "+cateGoryName);
		Category cateCheck = repoCate.findByNameLike(cateGoryName);
		if(cateCheck!= null) {
			session.setAttribute("message", "Exist Category Name, Please choose other name!");
		}else {
			String cateGoryID = repoOthers.getKey("CG", "categoryID", "Category").getObject1();
			Category newCate = new Category(cateGoryID, cateGoryName);
			repoCate.save(newCate);
			session.setAttribute("message", "New Category Added!");
		}
		return "redirect:/admin/statistics";
	}
	@GetMapping("statistics/removeCategory/{id}")
	public String removeCategory(@PathVariable("id")String cateID) {
		System.out.println("id: "+cateID);
		try {
			repoCate.deleteByCategoryID(cateID);
			session.setAttribute("message", "Category :"+cateID+" has been removed!");
		} catch (Exception e) {
			session.setAttribute("message", "You can not delete Category which has been linked to Product Entity!");
		}
		return "redirect:/admin/statistics";
	}
}
