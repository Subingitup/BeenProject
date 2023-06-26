package com.spring.pet.pets;

import org.springframework.web.multipart.MultipartFile;

public class PetsVO {
	private String pet_users_id;
	private String pet_name;
	private int pet_age;
	private double pet_weight;
	private String pet_sex;
	private String pet_cate;
	private String pet_info;
	private String pet_pic;
	private String pet_neuter;

	private MultipartFile uploadFile;

	public String getPet_users_id() {
		return pet_users_id;
	}

	public void setPet_users_id(String pet_users_id) {
		this.pet_users_id = pet_users_id;
	}

	public String getPet_name() {
		return pet_name;
	}

	public void setPet_name(String pet_name) {
		this.pet_name = pet_name;
	}

	public int getPet_age() {
		return pet_age;
	}

	public void setPet_age(int pet_age) {
		this.pet_age = pet_age;
	}

	public double getPet_weight() {
		return pet_weight;
	}

	public void setPet_weight(double pet_weight) {
		this.pet_weight = pet_weight;
	}

	public String getPet_sex() {
		return pet_sex;
	}

	public void setPet_sex(String pet_sex) {
		this.pet_sex = pet_sex;
	}

	public String getPet_cate() {
		return pet_cate;
	}

	public void setPet_cate(String pet_cate) {
		this.pet_cate = pet_cate;
	}

	public String getPet_info() {
		return pet_info;
	}

	public void setPet_info(String pet_info) {
		this.pet_info = pet_info;
	}

	public String getPet_pic() {
		return pet_pic;
	}

	public void setPet_pic(String pet_pic) {
		this.pet_pic = pet_pic;
	}

	public String getPet_neuter() {
		return pet_neuter;
	}

	public void setPet_neuter(String pet_neuter) {
		this.pet_neuter = pet_neuter;
	}

	public MultipartFile getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}

	@Override
	public String toString() {
		return "PetsVO [pet_users_id=" + pet_users_id + ", pet_name=" + pet_name + ", pet_age=" + pet_age
				+ ", pet_weight=" + pet_weight + ", pet_sex=" + pet_sex + ", pet_cate=" + pet_cate + ", pet_info="
				+ pet_info + ", pet_pic=" + pet_pic + ", pet_neuter=" + pet_neuter + ", uploadFile=" + uploadFile + "]";
	}

	
}