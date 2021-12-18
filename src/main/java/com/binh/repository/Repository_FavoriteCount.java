package com.binh.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.binh.model.FavoriteCount;

@Repository
public interface Repository_FavoriteCount extends JpaRepository<FavoriteCount, String> {
	@Query("Select f from FavoriteCount f where f.user.userID = ?1 and f.product.productID = ?2")
	FavoriteCount findByUserIDAndProductID(String userID,String productID);
	
	@Query("Select f from FavoriteCount f where f.user.userID = ?1")
	List<FavoriteCount> findAllByUserID(String userID);
	
	//Statistics SecondRow Top Favorite
	@Query(value="Select picture , p.name as item2,p.brand,c.name , "
			+ "	(case when fc.productID is null then 0 else count(*) end ) as item "
			+ "	from FavoriteCount fc "
			+ "	right join Product p on fc.productID = p.productID "
			+ "	inner join Categories c on p.categoryID = c.categoryID "
			+ "	Group by picture ,p.name,c.name,p.brand,fc.productID "
			+ "	order by item desc" ,nativeQuery = true)
	List<Object[]> topFavoriteProducts();
	
}
