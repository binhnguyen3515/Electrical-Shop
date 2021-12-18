package com.binh.service.cart;

import java.util.Collection;
import org.springframework.stereotype.Service;

@Service
public interface ShoppingCartService<E,K,Q> {
	E add(K id,Q qty);
	void remove(K id);
	void clear();
	E update(K id, Q qty);
	Collection<E>getCartItems();
	int getCount();
	double getTotal();
	double getTotalDiscount();
}
