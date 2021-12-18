package com.binh.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.binh.model.Invoice;
import com.binh.repository.Repository_Invoice;
import com.binh.service.SessionService;
import com.binh.service.XDateService;

@RequestMapping("admin")
@Controller
public class Controller_Admin_Invoice {
	@Autowired Repository_Invoice repoInvoice;
	@Autowired SessionService session;
	@Autowired XDateService dateService;
	//Invoice Section
	
	@RequestMapping("invoice")
	public String showInvoice(Model model,
			@RequestParam(value="status",defaultValue = "")Optional<String>status,
			@RequestParam(value="customerName",defaultValue = "")Optional<String>customerName,
			@RequestParam(value="dateA",required = false)Optional<String> dateA,
			@RequestParam(value="dateB",required = false)Optional<String> dateB,
			@RequestParam(value="condition",defaultValue = "")Optional<String> condition) {
		session.setAttribute("onSelected", "invoice");
		List<Invoice> listInvoice = new ArrayList<Invoice>();
			
//		System.out.println("status: "+status.get());
		
		String getStatus = status.orElse("");
		Date getDateA = dateService.toDate(dateA.orElse(null),"yyyy-MM-dd");
		Date getDateB = dateService.toDate(dateB.orElse(null),"yyyy-MM-dd");
		String getName = customerName.orElse("");
		System.out.println("condition: "+condition.get());
		if(condition.get().equals("")) {
			listInvoice = repoInvoice.findAll();
		}
		if(condition.get().equals("status")) {
			listInvoice = repoInvoice.findAllByStatusLike(getStatus);
		}
		if(condition.get().equals("name")) {
			listInvoice = repoInvoice.findAllByName("%"+getName.trim()+"%");
		}
		if(condition.get().equals("date")) {
			System.out.println("dateA: "+getDateA+" - dateB: "+getDateB);
			listInvoice = repoInvoice.findByDateBetween(getDateA,getDateB);
		}
		
		model.addAttribute("dateA",dateA.orElse(null));
		model.addAttribute("dateB",dateB.orElse(null));
		model.addAttribute("customerName",customerName.get());
		model.addAttribute("status",status.get());
		model.addAttribute("listInvoice", listInvoice);
		return "admin/invoice";
	}
	
//	@RequestMapping("invoice/searchByDate")
//	public String searchByDate(Model model,
//			@RequestParam(value="dateA", defaultValue = "")Optional<Date>dateA,
//			@RequestParam(value="dateB", defaultValue = "")Optional<Date>dateB) {
//		
//		return "admin/invoice";
//	}
	
	@ResponseBody
	@PostMapping("invoice/{id}")
	public String setPaidInvoice(@PathVariable("id")String invoiceID) {
		System.out.println("id: "+invoiceID);
		Invoice invoice = repoInvoice.findByInvoiceID(invoiceID);
		System.out.println("status: "+invoice.getStatus());
		invoice.setStatus("Paid");
		repoInvoice.saveAndFlush(invoice);
		return invoiceID;
	}
}
