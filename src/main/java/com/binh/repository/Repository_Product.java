package com.binh.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.binh.model.Product;

@Repository
public interface Repository_Product extends JpaRepository<Product, String>,JpaSpecificationExecutor<Product> {

	Page<Product> findByIsdeletedFalse(Pageable pageable);
	
	List<Product>findByIsdeletedFalse();
	List<Product>findByIsdeletedTrue();
	
	@Query("Select p from Product p where p.category.categoryID LIKE ?1 and p.isdeleted = false Order by p.category.categoryID DESC")
	Page<Product> findAllByCategoryID(String categoryID,Pageable pageable);
	
	Page<Product>findByIsdeletedFalseAndNameContaining(String keywords,Pageable pageable);

	@Query("Select p from Product p inner join p.detailedProducts dtp "
			+ "where dtp.price between ?1 and ?2 and p.isdeleted = false "
			+ "group by p.productID,p.brand,p.description,p.discount,p.isdeleted,p.name,p.picture,p.category.categoryID")
	Page<Product>findByPriceMinAndMax(double min,double max,Pageable pageable);

	@Query("Select distinct p from Product p inner join p.detailedProducts dtp "
			+ "where p.isdeleted = false "
			+ "order by p.name desc")
	Page<Product>findByNameDesc(Pageable pageable);
	@Query("Select distinct p from Product p inner join p.detailedProducts dtp "
			+ "where p.isdeleted = false  "
			+ "order by p.name asc")
	Page<Product>findByNameAsc(Pageable pageable);
	

}
