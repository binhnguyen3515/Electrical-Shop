package com.binh.controller;

import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.internal.build.AllowSysOut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.binh.model.DetailedInvoice;
import com.binh.model.DetailedInvoicePK;
import com.binh.model.DetailedProduct;
import com.binh.model.FavoriteCount;
import com.binh.model.Invoice;
import com.binh.model.User;
import com.binh.repository.Repository_DetailedInvoice;
import com.binh.repository.Repository_FavoriteCount;
import com.binh.repository.Repository_Invoice;
import com.binh.repository.Repository_Product;
import com.binh.repository.Repository_StoredProcedureCall;
import com.binh.service.SessionService;
import com.binh.service.cart.ShoppingCartService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("detail")
public class Controller_Cart {
	@Autowired ShoppingCartService<DetailedProduct, String, Integer> cart;
	@Autowired SessionService session;
	@Autowired HttpServletRequest request;
	@Autowired Repository_DetailedInvoice repoDetailedInvoice;
	@Autowired Repository_Invoice repoInvoice;
	@Autowired Repository_StoredProcedureCall repoOthers;
	@Autowired Repository_FavoriteCount repoFavor;
	@Autowired Repository_Product repoProduct;
	
	@ResponseBody
	@PostMapping("Cart/AddToCart/**")
	public int addToCart(DetailedProduct detailedProduct, @RequestParam("productID")String productID) {
		cart.add(detailedProduct.getDetailedproductid(), detailedProduct.getQuantity());
		return cart.getCount();
	}
	
	@GetMapping("Cart/AddToFavorite/{id}")
	public String addToFavorite(@PathVariable("id") String productID) {
		User user = session.getAttribute("loginInfo");
		
		if(user == null) {
			session.setAttribute("message", "You need to login to add this product to your favorite!");
		}else {
			try {
				FavoriteCount fav = repoFavor.findByUserIDAndProductID(user.getUserID(), productID);
				if(fav == null) {
					String favoriteID = repoOthers.getKey("FV", "favoriteID", "FavoriteCount").getObject1();
					System.out.println("favID: "+favoriteID);
					FavoriteCount newFav = new FavoriteCount(favoriteID, repoProduct.getById(productID), user);
					repoFavor.save(newFav);
					session.setAttribute("message", "Thank you for adding this product to your favorite list");
				}
				if(fav != null){
					session.setAttribute("message", "This product has already been in your favorite list");
				}
			} catch (Exception e) {
				
				
			}
		}
		String referrer = request.getHeader("referer");
		return "redirect:"+referrer;
	}
	
	@GetMapping("Cart/removeFromFavorite/{id}")
	public String removeFromFavorite(@PathVariable("id") String productID) {
		User user = session.getAttribute("loginInfo");
		
		if(user == null) {
			session.setAttribute("message", "You need to login to remove this product from your favorite list!");
		}else {
			try {
				FavoriteCount fav = repoFavor.findByUserIDAndProductID(user.getUserID(), productID);
				if(fav == null) {
					String favoriteID = repoOthers.getKey("FV", "favoriteID", "FavoriteCount").getObject1();
					System.out.println("favID: "+favoriteID);
//					FavoriteCount newFav = new FavoriteCount(favoriteID, repoProduct.getById(productID), user);
//					repoFavor.save(newFav);
					session.setAttribute("message", "This product has never been in your favorite list");
				}
				if(fav != null){
					repoFavor.delete(fav);
					session.setAttribute("message", "The product has been removed from your favorite list");
				}
			} catch (Exception e) {
				
				
			}
		}
		String referrer = request.getHeader("referer");
		return "redirect:"+referrer;
	}
	
	@ResponseBody
	@GetMapping("Cart/removeFromFavList/{id}")
	public String removeFromFavoriteList(@PathVariable("id") String productID) {
		System.out.println("id"+productID);
		User user = session.getAttribute("loginInfo");
		if(user == null) {
//			session.setAttribute("message", "You need to login to remove this product from your favorite list!");
		}else {
			try {
				FavoriteCount fav = repoFavor.findByUserIDAndProductID(user.getUserID(), productID);
				if(fav == null) {
					String favoriteID = repoOthers.getKey("FV", "favoriteID", "FavoriteCount").getObject1();
					System.out.println("favID: "+favoriteID);
				}
				if(fav != null){
					repoFavor.delete(fav);
				}
			} catch (Exception e) {
				
				
			}
		}
		String referrer = request.getHeader("referer");
		return "redirect:"+referrer;
	}
	
	@GetMapping("Cart/CartInfo")
	public String showCart(@ModelAttribute("profile")User user) {
		return "cart";
	}
	
	@ResponseBody
	@PostMapping("Cart/UpdateCart/**")
	public String updateCart(DetailedProduct detailedProduct) throws JsonProcessingException {
		cart.update(detailedProduct.getDetailedproductid(), detailedProduct.getQuantity());
		ObjectMapper mapper = new ObjectMapper();
		return mapper.writeValueAsString(new Object[]{cart.getCount(),cart.getTotal(),cart.getTotalDiscount()});
	}
	
	@ResponseBody
	@PostMapping("Cart/RemoveItem/**")
	public String removeItem(DetailedProduct detailedProduct) throws JsonProcessingException {
		cart.remove(detailedProduct.getDetailedproductid());
		ObjectMapper mapper = new ObjectMapper();
		return mapper.writeValueAsString(new Object[]{cart.getCount(),cart.getTotal(),cart.getTotalDiscount()});
	}
	@ResponseBody
	@PostMapping("Cart/RemoveCart")
	public String removeCart() throws JsonProcessingException {
		cart.clear();
		ObjectMapper mapper = new ObjectMapper();
		return mapper.writeValueAsString(new Object[]{cart.getCount(),cart.getTotal(),cart.getTotalDiscount()});
	}
	

	@GetMapping("Cart/CheckLogin")
	public String checkLogin() {
		if(cart.getCount() == 0 || session.getAttribute("scopedTarget.cart") == null) {
			session.setAttribute("message", "Your cart is empty!");
		}
		try {
			User user = session.getAttribute("loginInfo");
			if(user == null && cart.getCount() > 0) {
				session.setAttribute("message", "You need to login to make payment!");
			}
			if(user != null && cart.getCount()>0) {
				session.setAttribute("messageModal", "OK");
			}
			
		} catch (Exception e) {

		}
		return "redirect:/detail/Cart/CartInfo";
	}
	
	@PostMapping("Cart/Payment")
	public String payment(@RequestParam("phone")String phone,
			@RequestParam("address")String address,
			@RequestParam(value="notes",defaultValue = "")String customerNotes) {
		String invoiceID = repoOthers.getKey("IN", "invoiceID", "Invoice").getObject1();
		System.out.println("invoice_id: "+invoiceID);
		User user = session.getAttribute("loginInfo");
		//insert invoice
		Invoice invoice = new Invoice(invoiceID, address, customerNotes, new Date(), phone, "Pending", cart.getTotal()-cart.getTotalDiscount(),user );
		repoInvoice.save(invoice);
		//insert detailed_invoice
		Collection<DetailedProduct> itemInCart = cart.getCartItems();
		for (DetailedProduct detailedProduct : itemInCart) {
			String detailedProductID = detailedProduct.getDetailedproductid();
			DetailedInvoicePK invoicePK = new DetailedInvoicePK(invoiceID, detailedProductID);
//			System.out.println("id: "+detailedProduct.getDetailedproductid()+" - color: "+detailedProduct.getColor()+" - price: "+detailedProduct.getPrice());
			double price = detailedProduct.getPrice()*(1-detailedProduct.getProduct().getDiscount()/100);
			DetailedInvoice dtp = new DetailedInvoice(invoicePK,detailedProduct.getColor(),price,detailedProduct.getQuantity());
			repoDetailedInvoice.save(dtp);
		}
		cart.clear();
		session.setAttribute("message", "Thank you for your purchase!");
		return "redirect:/detail/Cart/CartInfo";
	}
	
//	@ResponseBody
	@GetMapping("Cart/Log")
	public String showLogPayment(Model model) {
		System.out.println("log running");
		session.removeAttribute("listPayment");
		try {
			User user = session.getAttribute("loginInfo");
			System.out.println("id: "+user.getUserID());
			List<Invoice> listPayment = repoInvoice.findAllByUserID(user.getUserID());
			if(!listPayment.isEmpty()) {
				
//				System.out.println("id: "+listPayment.get(0).getDetailedInvoices().get(0).getColor());
				for (Invoice invoice : listPayment) {
//					System.out.println("id: "+invoice.getDetailedInvoices().get(0).getDetailedProduct().getProduct().getProductID());
//					System.out.println("id: "+invoice.getAddress());
					for (DetailedInvoice invoice2 : invoice.getDetailedInvoices()) {
//						System.out.println("quantity: "+invoice2.getQuantity());
//						System.out.println("price: "+invoice2.getPrice());
					}
				}
				session.setAttribute("listPayment", listPayment);
				model.addAttribute("listPayment", listPayment);
				session.setAttribute("logStatus", "hasItem");
			}else {
				session.setAttribute("logStatus", "There is no item in your payment history");
			}
		} catch (Exception e) {

		}

		String referrer = request.getHeader("referer");
		return "redirect:"+referrer;
	}
	
	@GetMapping("Cart/FavoriteList")
	public String showFavoriteProduct() {
		System.out.println("list running");
		User user = session.getAttribute("loginInfo");
		List<FavoriteCount> yourFavoriteList = repoFavor.findAllByUserID(user.getUserID());
		try {
			if(yourFavoriteList.isEmpty()) {
				session.setAttribute("favoriteListLog", "There is no item in your favorite product list");
			}else {
				session.setAttribute("favoriteListLog", "has List");
//				System.out.println("price: "+yourFavoriteList.get(1).getProduct().getDetailedProducts().get(0).getPrice());
				session.setAttribute("favoriteList", yourFavoriteList);
			}	
		} catch (Exception e) {
			// TODO: handle exception
		}
		String referrer = request.getHeader("referer");
		return "redirect:"+referrer;
	}
	
	@ModelAttribute("listGender")
	public Map<Boolean,String> getGenders(){
		Map<Boolean, String> map = new HashMap<>();
		map.put(true, "Male");
		map.put(false, "Female");
		return map;
	}
}
