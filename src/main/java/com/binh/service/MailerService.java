package com.binh.service;

import javax.mail.MessagingException;

import com.binh.model.MailInfo;

public interface MailerService {
	//Bài 1--------------------------------//
	/**
	* Gửi email
	* @param mail thông tin email
	* @throws MessagingException lỗi gửi email
	*/
	void send(MailInfo mail) throws MessagingException;
	/**
	* Gửi email đơn giản
	* @param to email người nhận
	* @param subject tiêu đề email
	* @param body nội dung email
	* @throws MessagingException lỗi gửi email
	*/
	void send(String to, String subject, String body) throws MessagingException;
	//Bài 2--------------------------------//
	/**
	* Xếp mail vào hàng đợi
	* @param mail thông tin email
	*/
	void queue(MailInfo mail);
	/**
	* Tạo MailInfo và xếp vào hàng đợi
	* @param to email người nhận
	* @param subject tiêu đề email
	* @param body nội dung email
	*/
	void queue(String to, String subject, String body);
}
