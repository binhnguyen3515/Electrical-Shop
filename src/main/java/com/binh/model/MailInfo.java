package com.binh.model;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MailInfo {
	private String from = "FPT Polytechnic <PS14048@fpt.edu.vn>";
	private String to;
//	private List<String> cc = new ArrayList<>();
//	private List<String> bcc = new ArrayList<>();
	private String[] cc;
	private String[] bcc;
	private String subject;
	private String body;
	private List<File> attachments = new ArrayList<>();
	public MailInfo(String to, String subject, String body) {
		this.to = to;
		this.subject = subject;
		this.body = body;
	}
	
	
}
