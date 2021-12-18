package com.binh;

import java.io.IOException;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class Ps14048NguyenThaiBinhAsmJava5Application {

	public static void main(String[] args) {
		SpringApplication.run(Ps14048NguyenThaiBinhAsmJava5Application.class, args);
		Runtime rt = Runtime.getRuntime();
	      try {
	    	  rt.exec("cmd /c start chrome.exe http://localhost:8080/PS14048_NguyenThaiBinh_Asm_Java5");
	      } catch (IOException e) {
	          e.printStackTrace();
	      }
	      
	}

}
