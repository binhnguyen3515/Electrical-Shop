package com.binh.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.binh.model.Category;
import com.binh.model.Colors;
import com.binh.model.DetailedPicture;
import com.binh.model.DetailedProduct;
import com.binh.model.Product;
import com.binh.model.User;
import com.binh.model.others.Object1;
import com.binh.model.others.Roles;
import com.binh.repository.Repository_Category;
import com.binh.repository.Repository_DetailedPicture;
import com.binh.repository.Repository_DetailedProduct;
import com.binh.repository.Repository_Product;
import com.binh.repository.Repository_StoredProcedureCall;
import com.binh.repository.Repository_User;
import com.binh.service.ParamService;
import com.binh.service.SessionService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;


@RequestMapping("admin")
@Component
public class Controller_Admin {
	@Autowired Repository_Product repoProduct;
	@Autowired Repository_DetailedProduct repoDetailedProd;
	@Autowired Repository_Category repoCategory;
	@Autowired Repository_User repoUser;
	@Autowired Repository_DetailedPicture repoDetailedPics;
	
	@Autowired Repository_StoredProcedureCall repoOthers;
	
	@Autowired SessionService session;
	@Autowired ParamService param;
	
	//Product Section
	@RequestMapping("product")
	public String showProduct(Model model) {
		session.setAttribute("onSelected", "product");
		model.addAttribute("listProduct", repoProduct.findByIsdeletedFalse());
		return "admin/product";
	}
	
	@ResponseBody
	@GetMapping(value="product/edit/**")
	public String editProduct(@RequestParam("productID")String productID) throws JsonProcessingException {
//		System.out.println("running");
//		System.out.println("id: "+productID);
		Product product = repoProduct.getById(productID);

		List<DetailedProduct> detailed = repoDetailedProd.findByProductID(productID);
		List<Object[]> colors = new ArrayList<>();
		List<Object[]> quantities = new ArrayList<>();
		List<Object[]> prices = new ArrayList<>();
		for (DetailedProduct detailedProduct : detailed) {
			colors.add(new Object[] {detailedProduct.getColor()});
			quantities.add(new Object[] {detailedProduct.getQuantity()});
			prices.add(new Object[] {detailedProduct.getPrice()});
		}
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("productID", product.getProductID());
		map.put("name", product.getName());
		map.put("picture", product.getPicture());
		map.put("description", product.getDescription());
		map.put("brand", product.getBrand());
		map.put("discount", product.getDiscount());
		map.put("categoryName", product.getCategory().getName());
		map.put("colors", colors);
		map.put("quantities", quantities);
		map.put("prices", prices);
		ObjectMapper mapper = new ObjectMapper();
		
		return mapper.writeValueAsString(map);
	}
	
	@PostMapping("product/update")
	public String updateProduct(Product product,
			@RequestParam(value="input-b6a[]",required = false)MultipartFile[] attach,
			@RequestParam(value="colors",required = true)List<String> colors,
			@RequestParam(value = "prices",required = true)List<Double>prices,
			@RequestParam(value ="quantities",required = true)List<Integer>quantities) {
		System.out.println("category: "+product.getCategory().getName());
		//lấy file ảnh sản phẩm bỏ vào list filename (nếu có)
		List<String> fileName = new ArrayList<String>();
		try {
			fileName = param.saveMultiFiles(attach, "home/ProductImages/"+product.getCategory().getName());
		} catch (Exception e) {
			
		}
		//nếu thay đổi type, sẽ phải thay di chuyển ảnh từ thư mục cũ sang thư mục mới
		String currentCategory = repoProduct.getById(product.getProductID()).getCategory().getName();
		String newCategory = product.getCategory().getName();
		List<String> listImage = new ArrayList<>();
		for (DetailedPicture item : repoDetailedPics.findByProductID(product.getProductID())) {
			listImage.add(item.getPicturename());
			System.out.println(item.getPicturename());
		}
		param.MoveFile(listImage, "home/ProductImages/"+currentCategory, "home/ProductImages/"+newCategory);
		
		//cập nhật lại các giá trị cho Product và DetailedProduct
		product.setCategory(repoCategory.findByName(product.getCategory().getName()));
		product.setPicture(repoProduct.getById(product.getProductID()).getPicture());
		//cập nhật giá, màu và số lượng
		colors.removeAll(Collections.singletonList(null));
		prices.removeAll(Collections.singletonList(null));
		quantities.removeAll(Collections.singletonList(null));
		//cắt bg- ra khỏi chuỗi bg-[color]
		for (int i = 0; i < colors.size(); i++) {
			colors.set(i, colors.get(i).substring(colors.get(i).lastIndexOf("-")+1));
		}
		//xoá bảng detailedProduct theo productID và cập nhật lại thông tin màu, giá số lượng mới
		try {
			repoDetailedProd.deleteByProductID(product.getProductID());
			for (int i = 0; i < colors.size(); i++) {
				Object1 getKey = repoOthers.getKey("DP", "detailedProductID", "DetailedProduct");
				DetailedProduct dtprod = new DetailedProduct(getKey.getObject1(), colors.get(i), false, prices.get(i),quantities.get(i), product);
				repoDetailedProd.saveAndFlush(dtprod);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		//nếu ko có file chọn, tức là ko update file, sẽ giữ nguyên ảnh cũ, ko phải can thiệp entity detailPicutre
		//ngược lại sẽ xoá sạch ảnh trong detailPicutres, và insert ảnh mới,cập nhật lại ảnh đại diện trong entity Product
		if(fileName.isEmpty()) {
			
		}else {
			try {
				product.setPicture(fileName.get(0));
				repoDetailedPics.deleteByProductID(product.getProductID());
				for (String picname : fileName) {
					Object1 getKey = repoOthers.getKey("DP", "detailedPicID", "DetailedPicture");
					System.out.println("ID: "+getKey.getObject1());
					DetailedPicture dtp = new DetailedPicture(getKey.getObject1(),false,picname,product);
					repoDetailedPics.saveAndFlush(dtp);
				}
			} catch (Exception e) {

			}
		}
		repoProduct.saveAndFlush(product);		
		return "redirect:/admin/product";
	}
	
	@PostMapping("product/add")
	public String addProduct(Product product,
			@RequestParam(value="input-b7a[]",required = false)MultipartFile[] attach,
			@RequestParam(value="colors",required = true)List<String> colors,
			@RequestParam(value = "prices",required = true)List<Double>prices,
			@RequestParam(value ="quantities",required = true)List<Integer>quantities) {
		
		//lấy file ảnh sản phẩm bỏ vào list filename (ảnh bắt buộc phải chọn ít nhất 1 trên form)
		List<String> fileName = new ArrayList<String>();
		try {
			fileName = param.saveMultiFiles(attach, "home/ProductImages/"+product.getCategory().getName());
		} catch (Exception e) {
			
		}
		
		System.out.println("category: "+product.getCategory().getName());
		System.out.println("name: "+product.getName());
		System.out.println("brand: "+product.getBrand());
		System.out.println("discount: "+product.getDiscount());
		System.out.println("description: "+product.getDescription());
		//set các thông số còn thiếu cho product
		String productID = repoOthers.getKey("SP", "productID", "Product").getObject1();
		product.setProductID(productID);
		product.setPicture(fileName.get(0));
		product.setCategory(repoCategory.findByName(product.getCategory().getName()));
		product.setIsdeleted(false);
		repoProduct.save(product);	
		//set thông số hình ảnh
		for (String picname : fileName) {
			Object1 getKey = repoOthers.getKey("DP", "detailedPicID", "DetailedPicture");
			DetailedPicture dtp = new DetailedPicture(getKey.getObject1(),false,picname,product);
			repoDetailedPics.save(dtp);
		}
		//set thông số màu, giá, số lượng
		colors.removeAll(Collections.singletonList(null));
		prices.removeAll(Collections.singletonList(null));
		quantities.removeAll(Collections.singletonList(null));
		for (int i = 0; i < colors.size(); i++) {
			Object1 getKey = repoOthers.getKey("DP", "detailedProductID", "DetailedProduct");
			DetailedProduct dtprod = new DetailedProduct(getKey.getObject1(), colors.get(i), false, prices.get(i),quantities.get(i), product);
			repoDetailedProd.save(dtprod);
		}
		return "redirect:/admin/product";
	}
	
	@GetMapping("product/delete/{id}")
	public String deleteByID(@PathVariable("id")String productID,Model model) {
		System.out.println("id: "+productID);
		Product product = repoProduct.getById(productID);
		product.setIsdeleted(true);
		repoProduct.saveAndFlush(product);
		model.addAttribute("listProduct", repoProduct.findByIsdeletedFalse());
		return "redirect:/admin/product";
	}
	
	@GetMapping("product/deleteSelected/{id}")
	public String deleteSelectedID(@PathVariable("id")String[] listProductID,Model model) {
		for (String id : listProductID) {
			Product product = repoProduct.getById(id);
			product.setIsdeleted(true);
			repoProduct.saveAndFlush(product);
		}
		model.addAttribute("listProduct", repoProduct.findByIsdeletedFalse());
		return "redirect:/admin/product";
	}
	
	//Account Section
	@RequestMapping("account")
	public String showUser(@ModelAttribute("User")User user,@ModelAttribute("UserEdit")User userEdit,Model model) {
		session.setAttribute("onSelected", "account");
		model.addAttribute("listAccount", repoUser.findByIsdeletedFalse());
		return "admin/account";
	}
	
	@PostMapping("account/addNewAccount")
	public String addUser(@ModelAttribute("User")User user, @RequestParam("input-b6a[]")MultipartFile[] attach) {
		List<String> fileName = new ArrayList<String>();
		try {
			fileName = param.saveMultiFiles(attach, "home/userAvatar");
		} catch (Exception e) {
			
		}
		user.setPhoto(fileName.get(0));
		user.setIsdeleted(false);
		user.setUserID(repoOthers.getKey("US", "userID", "Users").getObject1());
		repoUser.save(user);
		return "redirect:/admin/account";
	}
	
	@ResponseBody
	@PostMapping("account/edit/{id}")
	public String editUser(@PathVariable("id")String userID,Model model) throws JsonProcessingException {
		System.out.println("id: "+userID);
		User user = repoUser.getById(userID);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userID", user.getUserID());
		map.put("fullname", user.getFullname());
		map.put("email", user.getEmail());
		map.put("gender", user.isGender());
		map.put("address", user.getAddress());
		map.put("password", user.getPassword());
		map.put("phone", user.getPhone());
		map.put("photo", user.getPhoto());
		map.put("role", user.getRole());
		ObjectMapper mapper = new ObjectMapper();
		return mapper.writeValueAsString(map);
	}
	
	@PostMapping("account/updateUser")
	public String updateUser(@ModelAttribute("UserEdit")User user, @RequestParam("input-b7a[]")MultipartFile[] attach) {
		List<String> fileName = new ArrayList<String>();
		try {
			fileName = param.saveMultiFiles(attach, "home/userAvatar");
		} catch (Exception e) {
			
		}
		if(fileName.isEmpty()) {
		
		}else {
			user.setPhoto(fileName.get(0));
		}
		
		user.setIsdeleted(false);
		repoUser.saveAndFlush(user);
		User userLogged = session.getAttribute("loginInfo");
		if(userLogged.getUserID().equals(user.getUserID())) {
			session.setAttribute("loginInfo", user);
		}
		
		return "redirect:/admin/account";
	}
	
	@GetMapping("account/deleteUserID/{id}")
	public String deleteUserID(@PathVariable("id")String userID) {
		System.out.println("id: "+userID);
		User user = repoUser.getById(userID);
		user.setIsdeleted(true);
		repoUser.saveAndFlush(user);
		return "redirect:/admin/account";
	}
	
	@GetMapping("account/deleteSelectedUserID/{id}")
	public String deleteSelectedUserID(@PathVariable("id")String[] userID) {
		for (String id : userID) {
			User user = repoUser.getById(id);
			user.setIsdeleted(true);
			repoUser.saveAndFlush(user);
		}
		return "redirect:/admin/account";
	}
	
	///Modal attribute section///
	@ModelAttribute("listCategory")
	private List<Category> getItems(){
		return repoCategory.findAll();
	}
	
	@ModelAttribute("listRole")
	private List<Roles> getRoles(){
		return Arrays.asList(
				new Roles("Admin","Admin"),
				new Roles("Staff","Staff"),
				new Roles("Customer","Customer"));
	}
	
	@ModelAttribute("listGender")
	public Map<Boolean,String> getGenders(){
		Map<Boolean, String> map = new HashMap<>();
		map.put(true, "Male");
		map.put(false, "Female");
		return map;
	}
	
	@ModelAttribute("listColor")
	private List<Colors> getColors(){
		return Arrays.asList(
				new Colors("black"),
				new Colors("green"),
				new Colors("red"),
				new Colors("yellow"),
				new Colors("blue"),
				new Colors("white"),
				new Colors("orange"),
				new Colors("pink"),
				new Colors("purple"),
				new Colors("gray"),
				new Colors("aqua"));
	}
	
}
