package com.binh.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.Data;

@Data
@Embeddable
public class DetailedInvoicePK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(insertable=false, updatable=false, unique=true, nullable=false, length=10)
	private String invoiceID;

	@Column(insertable=false, updatable=false, unique=true, nullable=false, length=10)
	private String detailedproductid;

	public DetailedInvoicePK() {
		
	}
	
	public DetailedInvoicePK(String invoiceID, String detailedproductid) {
		this.invoiceID = invoiceID;
		this.detailedproductid = detailedproductid;
	}
	
	
}