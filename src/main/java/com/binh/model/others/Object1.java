package com.binh.model.others;

import java.io.Serializable;

import javax.persistence.ColumnResult;
import javax.persistence.ConstructorResult;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.SqlResultSetMapping;
import javax.persistence.SqlResultSetMappings;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;



@SqlResultSetMappings({
		@SqlResultSetMapping(name = "AutoKey", classes = @ConstructorResult(targetClass = Object1.class, columns = {
				@ColumnResult(name = "getMyKey", type = String.class) })) })
@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Object1 implements Serializable{

	private static final long serialVersionUID = 1L;
	@Id
	private String Object1;

}