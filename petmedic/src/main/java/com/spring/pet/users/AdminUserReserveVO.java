package com.spring.pet.users;

public class AdminUserReserveVO {
	
	// 유저 Zzim 목록 보기위한,,,
	private String res_hos_id;
	private String hos_name;
	private String hos_addr2;
	private String lately_reserve;
	
	
	@Override
	public String toString() {
		return "AdminUserReserveVO [res_hos_id=" + res_hos_id + ", hos_name=" + hos_name + ", hos_addr2=" + hos_addr2
				+ ", lately_reserve=" + lately_reserve + "]";
	}


	public String getRes_hos_id() {
		return res_hos_id;
	}


	public void setRes_hos_id(String res_hos_id) {
		this.res_hos_id = res_hos_id;
	}


	public String getHos_name() {
		return hos_name;
	}


	public void setHos_name(String hos_name) {
		this.hos_name = hos_name;
	}


	public String getHos_addr2() {
		return hos_addr2;
	}


	public void setHos_addr2(String hos_addr2) {
		this.hos_addr2 = hos_addr2;
	}


	public String getLately_reserve() {
		return lately_reserve;
	}


	public void setLately_reserve(String lately_reserve) {
		this.lately_reserve = lately_reserve;
	}
	


}
