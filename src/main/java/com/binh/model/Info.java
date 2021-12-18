package com.binh.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import lombok.Data;


@Data
@Entity
@Table(name="Info")
public class Info implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	@Temporal(TemporalType.DATE)
	private Date infoID;

	private int numberofvisitors;

	public Info(Date infoID, int numberofvisitors) {
		this.infoID = infoID;
		this.numberofvisitors = numberofvisitors;
	}

	public Info() {
	}
	
	
}