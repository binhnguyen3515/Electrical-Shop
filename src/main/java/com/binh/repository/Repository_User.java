package com.binh.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.binh.model.User;

@Repository
public interface Repository_User extends JpaRepository<User, String> {
	List<User>findByIsdeletedFalse();
	List<User>findByIsdeletedTrue();
	
	User findByEmail(String email);
	
	@Query("Select count(*) from User u")
	int totalAccount();
	
	@Query("Select count(*) from User u where u.isdeleted = true")
	int totalAccountBanned();
	
	@Query(value="Select u.role, count(*) as numberOfUser "
			+ "from Users u "
			+ "Group by u.role",nativeQuery=true)
	List<Object[]>getNumberOfUserByRoles();
	
	//Statistics -- Top Customer --
	@Query(value="Select photo , fullName,gender ,u.phone ,sum(iv.totalPayment) as item  from Invoice iv "
			+ "	inner join Users u on iv.userID = u.userID where iv.status = 'Paid' "
			+ "	Group by u.userID,photo,fullName,u.phone,gender "
			+ "	order by item desc",nativeQuery = true)
	List<Object[]>topCustomers();
}
