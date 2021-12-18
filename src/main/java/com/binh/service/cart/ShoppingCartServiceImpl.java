package com.binh.service.cart;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;
import org.springframework.web.context.annotation.SessionScope;

import com.binh.model.DetailedProduct;
import com.binh.repository.Repository_DetailedProduct;

@SessionScope
@Service("cart")
public class ShoppingCartServiceImpl implements ShoppingCartService<DetailedProduct, String, Integer>{
	
	@Autowired Repository_DetailedProduct repoDetailProd;
	
	//DetailedProduct được dùng như CartItem để giảm thiểu code và tăng tính tái sử dụng, 
	//nơi lưu các sản phẩm được chọn trong giỏ hàng
	Map<String,DetailedProduct> map = new LinkedHashMap<>();
	
	@Override
	public DetailedProduct add(String id, Integer qty) {
		DetailedProduct item = map.get(id);
		if(item == null) {
			item = repoDetailProd.getById(id);
			item.setQuantity(qty);
			map.put(id, item);
		}else {
			item.setQuantity(item.getQuantity()+qty);
		}
		return item;
	}

	@Override
	public void remove(String id) {
		map.remove(id);	
	}
	
	@Override
	public void clear() {
		map.clear();	
	}
	
	@Override
	public DetailedProduct update(String id, Integer qty) {
		DetailedProduct item = map.get(id);
		item.setQuantity(qty);
		return item;
	}

	@Override
	public Collection<DetailedProduct> getCartItems() {
		return map.values();
	}

	@Override
	public int getCount() {
		return map.values().stream().mapToInt(item->item.getQuantity()).sum();
	}

	@Override
	public double getTotal() {
		return map.values().stream().mapToDouble(item->item.getPrice()*item.getQuantity()).sum();
	}
	
	@Override
	public double getTotalDiscount() {
		return map.values().stream().mapToDouble(item->item.getPrice()*item.getQuantity()*item.getProduct().getDiscount()/100).sum();
	}
}
