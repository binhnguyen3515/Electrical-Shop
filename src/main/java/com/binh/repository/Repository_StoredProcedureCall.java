package com.binh.repository;

import javax.persistence.EntityManager;
import javax.persistence.ParameterMode;
import javax.persistence.PersistenceContext;
import javax.persistence.StoredProcedureQuery;

import org.springframework.stereotype.Repository;
import com.binh.model.others.Object1;


@Repository
public class Repository_StoredProcedureCall{
	@PersistenceContext EntityManager em;

	public Object1 getKey(String expectingID, String primaryKey, String entity) {
		StoredProcedureQuery query = em.createStoredProcedureQuery("sp_AutoKeyInAnyCases","AutoKey");
		query.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);
		query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);
		query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN);
		
		query.setParameter(1, expectingID);
		query.setParameter(2, primaryKey);
		query.setParameter(3, entity);

		return (Object1) query.getSingleResult();
	}
}
