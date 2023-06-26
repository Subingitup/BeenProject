package com.spring.pet.hospital;

public class CategoryVO {
	private String cateOption;
	private int hos_cate_cnt;
	private int dog_hos;
	private int cat_hos;
	private int bird_hos;
	private int rept_hos;
	private int etc_hos;
	
	public String getCateOption() {
		return cateOption;
	}
	public void setCateOption(String cateOption) {
		this.cateOption = cateOption;
	}
	public int getHos_cate_cnt() {
		return hos_cate_cnt;
	}
	public void setHos_cate_cnt(int hos_cate_cnt) {
		this.hos_cate_cnt = hos_cate_cnt;
	}
	public int getDog_hos() {
		return dog_hos;
	}
	public void setDoc_hos(int dog_hos) {
		this.dog_hos = dog_hos;
	}
	public int getCat_hos() {
		return cat_hos;
	}
	public void setCat_hos(int cat_hos) {
		this.cat_hos = cat_hos;
	}
	public int getBird_hos() {
		return bird_hos;
	}
	public void setBird_hos(int bird_hos) {
		this.bird_hos = bird_hos;
	}
	public int getRept_hos() {
		return rept_hos;
	}
	public void setRept_hos(int rept_hos) {
		this.rept_hos = rept_hos;
	}
	public int getEtc_hos() {
		return etc_hos;
	}
	public void setEtc_hos(int etc_hos) {
		this.etc_hos = etc_hos;
	}
	
}