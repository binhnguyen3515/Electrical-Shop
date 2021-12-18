package com.binh.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.binh.model.DetailedProduct;

@Repository
public interface Repository_DetailedProduct extends JpaRepository<DetailedProduct, String> {
	@Query("Select dtp from DetailedProduct dtp where dtp.product.productID like ?1")
	List<DetailedProduct>findByProductID(String productID);
	
	@Transactional
	@Modifying
	@Query(value="delete from DetailedProduct where productID = :productID")
	void deleteByProductID(@Param("productID")String productID);
}
