package com.binh.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.Data;

import java.util.List;


@Data
@Entity
@Table(name="Categories")
public class Category implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false, length=10)
	private String categoryID;

	@Column(nullable=false)
	private String name;

	//bi-directional many-to-one association to Product
	@OneToMany(mappedBy="category")
	private List<Product> products;

	public Category() {
	}

	public Category(String categoryID, String name) {
		this.categoryID = categoryID;
		this.name = name;
	}
	
	
}