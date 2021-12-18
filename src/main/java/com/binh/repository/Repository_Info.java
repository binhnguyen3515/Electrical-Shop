package com.binh.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.binh.model.Info;

@Repository
public interface Repository_Info extends JpaRepository<Info, Date> {
	@Query("Select i from Info i where i.infoID = ?1")
	Info getByDate(Date date);
	
	@Query("Select i.numberofvisitors from Info i where i.infoID = ?1")
	int getTodayVisitors(Date date);
	
	@Query("Select sum(i.numberofvisitors) from Info i")
	int totalVisitors();
	
	@Query(value="SELECT t.last7Days as 'infoID', ISNULL(numberOfVisitors, 0 ) as 'numberOfVisitors' "
			+ "		FROM "
			+ "		( "
			+ "		  SELECT CAST( GETDATE() AS Date) last7Days "
			+ "		  UNION ALL "
			+ "		  SELECT DateAdd(Day,-1,CAST( GETDATE() AS Date)) "
			+ "		  UNION ALL "
			+ "		  SELECT DateAdd(Day,-2,CAST( GETDATE() AS Date)) "
			+ "		  UNION ALL "
			+ "		  SELECT DateAdd(Day,-3,CAST( GETDATE() AS Date)) "
			+ "		  UNION ALL "
			+ "		  SELECT DateAdd(Day,-4,CAST( GETDATE() AS Date)) "
			+ "		  UNION ALL "
			+ "		  SELECT DateAdd(Day,-5,CAST( GETDATE() AS Date)) "
			+ "		  UNION ALL "
			+ "		  SELECT DateAdd(Day,-6,CAST( GETDATE() AS Date)) "
			+ "		  UNION ALL "
			+ "		  SELECT DateAdd(Day,-7,CAST( GETDATE() AS Date)) "
			+ "		) t LEFT JOIN info t1  "
			+ "		ON CAST( t.last7Days AS Date) = CAST( t1.infoID AS Date) "
			+ "		group by CAST( t.last7Days AS Date),numberOfVisitors",nativeQuery = true)
	List<Object[]>visitorsLast7Days();
}
