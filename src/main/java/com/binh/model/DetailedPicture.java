package com.binh.model;

import java.io.Serializable;
import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name="Detailedpictures")
public class DetailedPicture implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false, length=10)
	private String detailedpicid;

	@Column(nullable=false)
	private boolean isdeleted;

	@Column(nullable=false)
	private String picturename;

	//bi-directional many-to-one association to Product
	@ManyToOne
	@JoinColumn(name="productID", nullable=false)
	private Product product;

}