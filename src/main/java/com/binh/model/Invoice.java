package com.binh.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.Data;

import java.util.Collection;
import java.util.Date;
import java.util.List;


@Data
@Entity
@Table(name="Invoice")
public class Invoice implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false, length=10)
	private String invoiceID;

	@Column(nullable=false)
	private String address;

	private String customernotes;

	@Column(nullable=false)
	@Temporal(TemporalType.DATE)
	private Date date = new Date();

	@Column(nullable=false, length=20)
	private String phone;

	@Column(nullable=false)
	private String status;

	@Column(nullable=false, precision=53)
	private double totalpayment;

	//bi-directional many-to-one association to DetailedInvoice
	@OneToMany(mappedBy="invoice")
	private List<DetailedInvoice> detailedInvoices;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="userID")
	private User user;

	public Invoice() {
		
	}
	
	public Invoice(String invoiceID, String address, String customernotes, Date date, String phone, String status,
			double totalpayment, User user) {
		this.invoiceID = invoiceID;
		this.address = address;
		this.customernotes = customernotes;
		this.date = date;
		this.phone = phone;
		this.status = status;
		this.totalpayment = totalpayment;
		this.user = user;
	}
	
	

}