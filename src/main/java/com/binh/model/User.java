package com.binh.model;

import java.io.Serializable;
import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

import org.hibernate.validator.constraints.Length;

import lombok.Data;

import java.util.List;


@Data
@Entity
@Table(name="Users")
public class User implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false, length=10)

	@Length(min=3,max=8,message = "UserID from 3 to 8 characters")
	private String userID;

	private String address;

	@Column(length=50)
	@NotBlank(message="Email must not be blank")
	@Email(message = "Email invalid")
	private String email;

	@Column(nullable=false)
	@Length(min=6,max=30,message="Name must be 6 - 30 characters")
	private String fullname;

	@javax.validation.constraints.NotNull(message="Choose a gender")
	private boolean gender;

	@Column(nullable=false)
	private boolean isdeleted;

	@Column(nullable=false, length=20)
	@Length(min=3,max=30,message="Password must be 3 - 30 characters")
	private String password;

	@NotBlank(message="Phone is empty")
	@Length(max=15,message = "Phone max length is 15")
	@Column(nullable=false, length=20)
	private String phone;

	private String photo;

	@Column(nullable=false)
	private String role;

	//bi-directional many-to-one association to FavoriteCount
	@OneToMany(mappedBy="user")
	private List<FavoriteCount> favoriteCounts;

	//bi-directional many-to-one association to Invoice
	@OneToMany(mappedBy="user")
	private List<Invoice> invoices;

}