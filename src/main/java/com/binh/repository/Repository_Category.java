package com.binh.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.binh.model.Category;

@Repository
public interface Repository_Category extends JpaRepository<Category, String> {
	Category findByName(String name);
	
	@Query(value = "Select c.name as categoryName, "
			+ "case when sum(dtp.quantity) is null then 0 else sum(dtp.quantity) end as quantity "
			+ "from Categories c left join "
			+ "Product p on p.categoryID = c.categoryID inner join DetailedProduct dtp on p.productID = dtp.productID "
			+ "Group by c.name",nativeQuery = true)
	List<Object[]> findNumberOfProductsByCategoryName();
	
	
	//Statistics
	@Query(value = "Select c.name, ISNULL(sum(di.quantity),0) as quantity from  "
			+ "Categories c inner join Product p on c.categoryID = p.categoryID inner join   "
			+ "DetailedProduct dtp on dtp.productID = p.productID inner join "
			+ "DetailedInvoice di on dtp.detailedProductID = di.detailedProductID inner join "
			+ "Invoice i on di.invoiceID = i.invoiceID "
			+ "where cast(i.date as date) >= DateAdd(Day,-7,CAST( GETDATE() AS Date)) "
			+ "Group by c.name",nativeQuery = true)
	List<Object[]> numberOfProductSoldByType();
	
	Category findByNameLike(String cateName);
	
	@Transactional
	@Modifying
	@Query(value="Delete from Category where categoryID = ?1")
	void deleteByCategoryID(String cateID);
	
	@Query(value="Select c.name , count(fc.productID) as quantity "
			+ "from Categories c left join product p "
			+ "on p.categoryID = c.categoryID left join FavoriteCount fc on p.productID = fc.productID "
			+ "group by c.name order by count(fc.productID) desc", nativeQuery = true)
	List<Object[]>findLikedProductByCategory();
}
