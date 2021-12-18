package com.binh.service;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Service;

@Service
public class XDateService {
    private SimpleDateFormat formater = new SimpleDateFormat();

	public Date toDate(String date, String pattern) {
		if(date == null || date.equals("")) {
			return null;
		}
		try {
			formater.applyPattern(pattern);
			return new java.util.Date(formater.parse(date).getTime());
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public String toString(Date date, String pattern) {
		formater.applyPattern(pattern);
		return formater.format(date);
	}
}
