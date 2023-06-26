package com.spring.pet.doctor;

import org.springframework.web.multipart.MultipartFile;

public class DoctorVO {
	private String doc_hos_id;
	private String doc_name;
	private String doc_info;
	private String doc_id;
	
	private String doc_filename;
	private MultipartFile uploadFile;
	public String getDoc_hos_id() {
		return doc_hos_id;
	}
	public void setDoc_hos_id(String doc_hos_id) {
		this.doc_hos_id = doc_hos_id;
	}
	public String getDoc_name() {
		return doc_name;
	}
	public void setDoc_name(String doc_name) {
		this.doc_name = doc_name;
	}
	public String getDoc_info() {
		return doc_info;
	}
	public void setDoc_info(String doc_info) {
		this.doc_info = doc_info;
	}
	public String getDoc_id() {
		return doc_id;
	}
	public void setDoc_id(String doc_id) {
		this.doc_id = doc_id;
	}
	public String getDoc_filename() {
		return doc_filename;
	}
	public void setDoc_filename(String doc_filename) {
		this.doc_filename = doc_filename;
	}
	public MultipartFile getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	@Override
	public String toString() {
		return "DoctorVO [doc_hos_id=" + doc_hos_id + ", doc_name=" + doc_name + ", doc_info=" + doc_info + ", doc_id="
				+ doc_id + ", doc_filename=" + doc_filename + ", uploadFile=" + uploadFile + "]";
	}
	
	
	
	
}