package com.binh.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.binh.model.Invoice;

@Repository
public interface Repository_Invoice extends JpaRepository<Invoice, String> {

	@Query("select i from Invoice i where i.user.userID = ?1")
	List<Invoice>findAllByUserID(String userID);
	
	List<Invoice>findAllByOrderByDateDesc();
	
	Page<Invoice>findAll(Pageable pageable);
	
	List<Invoice>findAll(Sort sort);
	
	List<Invoice>findAllByStatusLike(String status);
	
	@Query("Select i from Invoice i where i.user.fullname like ?1")
	List<Invoice>findAllByNameLike(String customerName);
	
	@Query("Select i from Invoice i where i.date between ?1 and ?2")
	List<Invoice>findByDateBetween(Date dateA,Date dateB);
	
	Invoice findByInvoiceID(String invoiceID);
	
	@Query("Select i from Invoice i where i.user.fullname like ?1 ")
	List<Invoice> findAllByName(String fullname);
	
	//Dashboard query
	@Query("Select count(*) from Invoice i where i.status = 'Pending' and i.date = ?1")
	Long findByPendingToday(Date today);
	
	@Query("Select count(*) from Invoice i where i.status = 'Pending'")
	Long findAllPending();
	
	@Query("Select COALESCE(sum(i.totalpayment),0) "
			+ "from Invoice i where i.date = ?1 and i.status='Paid'")
	Double getTodayIncome(Date date);
	
	@Query("Select COALESCE(sum(i.totalpayment),0) "
			+ "from Invoice i where i.status='Paid'")
	Double getTotalIncome();
	
	@Query(value = "Select i.last7Days,count(case when i1.status = N'Pending' then 'yes' end) as 'Pending', "
			+ "count(case when i1.status = N'Paid' then 'yes' end) as 'Paid'from  "
			+ "(SELECT CAST( GETDATE() AS Date) last7Days "
			+ "		  UNION ALL  "
			+ "		  SELECT DateAdd(Day,-1,CAST( GETDATE() AS Date)) "
			+ "		  UNION ALL  "
			+ "		  SELECT DateAdd(Day,-2,CAST( GETDATE() AS Date)) "
			+ "		  UNION ALL  "
			+ "		  SELECT DateAdd(Day,-3,CAST( GETDATE() AS Date)) "
			+ "		  UNION ALL  "
			+ "		  SELECT DateAdd(Day,-4,CAST( GETDATE() AS Date)) "
			+ "		  UNION ALL  "
			+ "		  SELECT DateAdd(Day,-5,CAST( GETDATE() AS Date)) "
			+ "		  UNION ALL  "
			+ "		  SELECT DateAdd(Day,-6,CAST( GETDATE() AS Date)) "
			+ "		  UNION ALL  "
			+ "		  SELECT DateAdd(Day,-7,CAST( GETDATE() AS Date)) "
			+ "		  ) i left join Invoice i1  "
			+ "		  ON CAST( i.last7Days AS Date) = CAST( i1.date AS Date) "
			+ "Group by CAST( i.last7Days AS Date)",nativeQuery = true)
	List<Object[]> pendingAndPaidLast7days();
	
	//Statistics query
	@Query(value="SELECT t.last7Days as 'date', ISNULL(sum(totalPayment), 0 ) as 'totalPayment' "
			+ "		FROM  "
			+ "		( "
			+ "		  SELECT CAST( GETDATE() AS Date) last7Days   "
			+ "		  UNION ALL  "
			+ "		  SELECT DateAdd(Day,-1,CAST( GETDATE() AS Date))     "
			+ "		  UNION ALL  "
			+ "		  SELECT DateAdd(Day,-2,CAST( GETDATE() AS Date))     "
			+ "		  UNION ALL  "
			+ "		  SELECT DateAdd(Day,-3,CAST( GETDATE() AS Date))     "
			+ "		  UNION ALL  "
			+ "		  SELECT DateAdd(Day,-4,CAST( GETDATE() AS Date))    "
			+ "		  UNION ALL  "
			+ "		  SELECT DateAdd(Day,-5,CAST( GETDATE() AS Date))     "
			+ "		  UNION ALL  "
			+ "		  SELECT DateAdd(Day,-6,CAST( GETDATE() AS Date))    "
			+ "		  UNION ALL  "
			+ "		  SELECT DateAdd(Day,-7,CAST( GETDATE() AS Date))     "
			+ "		) t LEFT JOIN invoice t1  "
			+ "		ON CAST( t.last7Days AS Date) = CAST( t1.date AS Date) "
			+ "		And t1.status = 'Paid' "
			+ "		group by CAST( t.last7Days AS Date) ",nativeQuery = true)
	List<Object[]> revenueLast7Days();
	
	@Query(value="Select i.date,ISNULL(sum(i.totalPayment),0),i.status from "
			+ "Invoice i where i.status = 'Paid' and i.date between ?1 and ?2 "
			+ "Group by i.date,i.status Order By i.date desc ",nativeQuery = true)
	List<Object[]> findRevenueByDayRange(Date dateA,Date dateB);
}
