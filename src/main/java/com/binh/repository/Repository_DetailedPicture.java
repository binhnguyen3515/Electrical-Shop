package com.binh.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.binh.model.DetailedPicture;
@Repository
public interface Repository_DetailedPicture extends JpaRepository<DetailedPicture, String> {
	@Query("Select dtpic from DetailedPicture dtpic where dtpic.product.productID like ?1")
	List<DetailedPicture>findByProductID(String productID);
	
	@Transactional
	@Modifying
	@Query(value="delete from DetailedPicture where productID = :productID")
	void deleteByProductID(@Param("productID")String productID);
}
