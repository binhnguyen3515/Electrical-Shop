package com.binh.service;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ParamService {
	@Autowired
	HttpServletRequest req;
	@Autowired
	ServletContext app;
	/**
	* Đọc chuỗi giá trị của tham số
	* @param name tên tham số
	* @param defaultValue giá trị mặc định
	* @return giá trị tham số hoặc giá trị mặc định nếu không tồn tại
	*/
	public String getString(String name,String defaultValue) {
		String value = req.getParameter(name);
		return value!=null?value:defaultValue;
	}
	
	/**
	* Đọc số nguyên giá trị của tham số
	* @param name tên tham số
	* @param defaultValue giá trị mặc định
	* @return giá trị tham số hoặc giá trị mặc định nếu không tồn tại
	*/
	public int getInt(String name,int defaultValue) {
		String value = req.getParameter(name);
		return value!=null?Integer.parseInt(value):defaultValue;
	}
	
	/**
	* Đọc số thực giá trị của tham số
	* @param name tên tham số
	* @param defaultValue giá trị mặc định
	* @return giá trị tham số hoặc giá trị mặc định nếu không tồn tại
	*/
	
	public double getDouble(String name,double defaultValue) {
		String value = req.getParameter(name);
		return value!=null?Double.parseDouble(value):defaultValue;
	}
	
	/**
	* Đọc giá trị boolean của tham số
	* @param name tên tham số
	* @param defaultValue giá trị mặc định
	* @return giá trị tham số hoặc giá trị mặc định nếu không tồn tại
	*/
	
	public boolean getBoolean(String name,boolean defaultValue) {
		String value = req.getParameter(name);
		return value!=null?Boolean.parseBoolean(value):defaultValue;
	}
	
	/**
	* Đọc giá trị thời gian của tham số
	* @param name tên tham số
	* @param pattern là định dạng thời gian
	* @return giá trị tham số hoặc null nếu không tồn tại
	* @throws RuntimeException lỗi sai định dạng
	*/
	
	public Date getDate(String name,String pattern) {
		String value = req.getParameter(name);
		try {
			return new SimpleDateFormat(pattern).parse(value);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	* Lưu file upload vào thư mục
	* @param file chứa file upload từ client
	* @param path đường dẫn tính từ webroot
	* @return đối tượng chứa file đã lưu hoặc null nếu không có file upload
	* @throws RuntimeException lỗi lưu file
	*/
	
	public File save(MultipartFile file,String path) {
		if(!file.isEmpty()) {
			File dir = new File(app.getRealPath(path));
			if(!dir.exists())dir.mkdirs();
			
			try {
				File saveFile = new File(dir,file.getOriginalFilename());
				file.transferTo(saveFile);
				return saveFile;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
		return null;
	}
	
	/**Lưu nhiều file ảnh**/
	public List<String> saveMultiFiles(MultipartFile[] files,String path) {
		if(files.length>0) {
			File dir = new File(app.getRealPath(path));
			if(!dir.exists())dir.mkdirs();
			try {
				List<String> fileName = new ArrayList<>();
				for(MultipartFile file : files) {
					File saveFile = new File(dir,file.getOriginalFilename());
					file.transferTo(saveFile);
					fileName.add(file.getOriginalFilename());
				}
				return fileName;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
		return null;
	}
	
	public String MoveFile(List<String> fileName, String from, String to) {
		File f1 = new File(app.getRealPath(from));
		File f2 = new File(app.getRealPath(to));
		if(!f1.exists()) {
			f1.mkdirs();
		}
		if(!f2.exists()) {
			f2.mkdirs();
		}
		try {
			for (String filename : fileName) {
				Files.move(Paths.get(f1+"/"+filename), Paths.get(f2+"/"+filename), StandardCopyOption.REPLACE_EXISTING);
			}
			return "ok";
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
}
