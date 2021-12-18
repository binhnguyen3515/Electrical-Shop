package com.binh.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.Data;


@Data
@Entity
@Table(name="Favoritecount")
public class FavoriteCount implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false, length=10)
	private String favoriteID;

	//bi-directional many-to-one association to Product
	@ManyToOne
	@JoinColumn(name="productID", nullable=false)
	private Product product;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="userID", nullable=false)
	private User user;

	public FavoriteCount() {
		
	}

	public FavoriteCount(String favoriteID, Product product, User user) {
		this.favoriteID = favoriteID;
		this.product = product;
		this.user = user;
	}
	
	
	
}