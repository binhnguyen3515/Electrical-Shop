package com.binh.model;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

import java.util.List;


@Data
@Entity
@Table(name="Product")
public class Product implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false, length=10)
	private String productID;

	@Column(nullable=false)
	private String brand;

	private String description;

	@Column(nullable=false, precision=53)
	private double discount;

	@Column(nullable=false)
	private boolean isdeleted;

	@Column(nullable=false)
	private String name;

	@Column(nullable=false)
	private String picture;

	//bi-directional many-to-one association to DetailedPicture
	@OneToMany(mappedBy="product")
	private List<DetailedPicture> detailedPictures;

	//bi-directional many-to-one association to DetailedProduct
	@OneToMany(mappedBy="product")
	private List<DetailedProduct> detailedProducts;

	//bi-directional many-to-one association to FavoriteCount
	@OneToMany(mappedBy="product")
	private List<FavoriteCount> favoriteCounts;

	//bi-directional many-to-one association to Category
	@ManyToOne
	@JoinColumn(name="categoryID")
	private Category category;

}