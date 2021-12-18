package com.binh.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.binh.model.Category;
import com.binh.repository.Repository_Category;
import com.binh.repository.Repository_Info;
import com.binh.repository.Repository_Invoice;
import com.binh.repository.Repository_StoredProcedureCall;
import com.binh.repository.Repository_User;
import com.binh.service.SessionService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@RequestMapping("admin")
@Component
public class Controller_Admin_Dashboard {
	@Autowired private SessionService session;
	@Autowired private Repository_Invoice repoInvoice;
	@Autowired private Repository_Info repoInfo;
	@Autowired private Repository_User repoUser;
	@Autowired private Repository_Category repoCate;
	
	@RequestMapping()
	public String showDashBoard(ModelMap model,
			@RequestParam(value="closeSidebar",defaultValue = "starting")Optional<String> closeSidebar) throws JsonProcessingException {
			
		//bật tắt banner
		if(closeSidebar.orElse("").equals("false") ) {
			session.setAttribute("closeSidebar", false);
		}else if(closeSidebar.orElse("").equals("true")) {
			session.setAttribute("closeSidebar", true);
		}
		session.setAttribute("onSelected", "dashboard");
		//First row content
		//Cart Pending Today + Total Pending// -- Vào invoice lấy thông tin
		Long pendingToday = repoInvoice.findByPendingToday(new Date());
		System.out.println("pending:"+pendingToday);
		Long allPending = repoInvoice.findAllPending();
		System.out.println("allpending:"+allPending);
		
		//Count visitory today and all visitors -- Vào Info lấy thông tin
		int todayVisitor = repoInfo.getTodayVisitors(new Date());
		System.out.println("todayVisitor: "+todayVisitor);
		int totalVisitor = repoInfo.totalVisitors();
		System.out.println("totalVisitor: "+totalVisitor);
		
		//Count today income -- Vào Invoice lấy thông tin
		double todayIncome = repoInvoice.getTodayIncome(new Date());
		System.out.println("todayIncome: "+todayIncome);
		double totalIncome = repoInvoice.getTotalIncome();
		System.out.println("totalIncome: "+totalIncome);
		
		//Get total Account -- vào User lấy thông tin
		int totalAccount = repoUser.totalAccount();
		System.out.println("totalAccount: "+totalAccount);
		int totalAccountBanned = repoUser.totalAccountBanned();
		System.out.println("totalAccountBanned: "+totalAccountBanned);
		
		//Put first row value on dashboard
		Map<String,Object> firstRow = new HashMap<>();
		firstRow.put("pendingToday", pendingToday);
		firstRow.put("allPending", allPending);
		firstRow.put("todayVisitor", todayVisitor);
		firstRow.put("totalVisitor", totalVisitor);
		firstRow.put("todayIncome", todayIncome);
		firstRow.put("totalIncome", totalIncome);
		firstRow.put("totalAccount", totalAccount);
		firstRow.put("totalAccountBanned", totalAccountBanned);
		model.addAttribute("firstRow",firstRow);
		
		//Bar chart content -- Categoryname -- number of item for each category
		List<Object[]> listCate = repoCate.findNumberOfProductsByCategoryName();
		model.addAttribute("secondRowBarchart",listCate);
		
		//Polar area chart -- User -- number of user by role
		List<Object[]>listRole = repoUser.getNumberOfUserByRoles();
		model.addAttribute("secondRowPolarchart",listRole);
		
		//line chart for pending and paid last 7 days --- invoice ---
		List<Object[]>listPendingPaidLast7Days = repoInvoice.pendingAndPaidLast7days();
		model.addAttribute("thirdRowLineChart",listPendingPaidLast7Days);
		return "admin/dashboard";
	}
	
}
