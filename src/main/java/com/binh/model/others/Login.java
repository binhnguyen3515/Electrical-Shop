package com.binh.model.others;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Login {
	private String userID;
	private String password;
	private Boolean rememberMe = false;
}
