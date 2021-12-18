package com.binh.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.Data;


@Data
@Entity
@Table(name="Detailedinvoice")
public class DetailedInvoice implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private DetailedInvoicePK id;

	@Column(nullable=false)
	private String color;

	@Column(nullable=false, precision=53)
	private double price;

	@Column(nullable=false)
	private int quantity;

	//bi-directional many-to-one association to DetailedProduct
	@ManyToOne
	@JoinColumn(name="detailedproductid", nullable=false, insertable=false, updatable=false)
	private DetailedProduct detailedProduct;

	//bi-directional many-to-one association to Invoice
	@ManyToOne
	@JoinColumn(name="invoiceID", nullable=false, insertable=false, updatable=false)
	private Invoice invoice;

	public DetailedInvoice() {
		
	}
	
	public DetailedInvoice(DetailedInvoicePK id, String color, double price, int quantity) {
		this.id = id;
		this.color = color;
		this.price = price;
		this.quantity = quantity;
	}
	
	
}