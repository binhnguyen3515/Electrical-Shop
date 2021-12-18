package com.binh.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Collection;
import java.util.List;

///////////////LỚP NÀY SAU SỬ DỤNG NHƯ CART ITEM////////////////
@Data
@Entity
@Table(name="Detailedproduct")
public class DetailedProduct implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false, length=10)
	private String detailedproductid;

	@Column(nullable=false)
	private String color;

	@Column(nullable=false)
	private boolean isdeleted;

	@Column(nullable=false, precision=53)
	private double price;

	@Column(nullable=false)
	private int quantity;

	//bi-directional many-to-one association to DetailedInvoice
	@OneToMany(mappedBy="detailedProduct")
	private List<DetailedInvoice> detailedInvoices;

	//bi-directional many-to-one association to Product
	@ManyToOne
	@JoinColumn(name="productID", nullable=false)
	private Product product;

	public DetailedProduct() {
		
	}
	
	public DetailedProduct(String detailedproductid, String color, boolean isdeleted, double price, int quantity,
			Product product) {
		this.detailedproductid = detailedproductid;
		this.color = color;
		this.isdeleted = isdeleted;
		this.price = price;
		this.quantity = quantity;
		this.product = product;
	}
	
}