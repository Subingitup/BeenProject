package com.spring.pet.reserve;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import com.spring.pet.hospital.HospitalVO;

public class ReserveVO {

	private int res_seq;
	private String res_users_id;
	private String res_name;
	private String users_name;
	private String users_tel;
	private String res_hos_id;
	private String res_time;
	private String res_cancel;

	private Date res_date;
	private String res_date_temp;
	private Date res_cashdate;
	
	private String hos_name; //예약내역 가져올 때 병원 이름,,, 

	private String searchInsertDate1;
	private String searchInsertDate2; //예약기간 검색할 때 필요
	
	private String searchCondition;
	private String searchKeyword;
	
	private List<HospitalVO> hosArray;
	
	
	private int counts;   // 베스트병원 예약개수 세는 용도
	   private String besthosname; // 베스트병원 이름 저장하는 용도(개수 세면서 같이 담는다)
	   
	   private int res_hos_price; // 병원 비용가져오기
	   
	   
	   private String reshosname; // 내가 예약한 병원 이름 저장하는 용도(개수 세면서 같이 담는다)   
	   
	// 예약내역 정렬 키워드 (방문일, 결제일) [6/20 다운 추가]
		private String rev_sortKeyword;
	   
	 
		

		
		
		public String getRev_sortKeyword() {
			return rev_sortKeyword;
		}
		public void setRev_sortKeyword(String rev_sortKeyword) {
			this.rev_sortKeyword = rev_sortKeyword;
		}
	   
	   
	   public String getReshosname() {
		return reshosname;
	}
	public void setReshosname(String reshosname) {
		this.reshosname = reshosname;
	}
	public int getRes_hos_price() {
		      return res_hos_price;
		   }
		   public void setRes_hos_price(int res_hos_price) {
		      this.res_hos_price = res_hos_price;
		   }
	   
	   
	   public String getBesthosname() {
	      return besthosname;
	   }
	   public void setBesthosname(String besthosname) {
	      this.besthosname = besthosname;
	   }
	   public int getCounts() {
	      return counts;
	   }
	   public void setCounts(int counts) {
	      this.counts = counts;
	   }
	public String getRes_date_temp() {
		return res_date_temp;
	}
	public void setRes_date_temp(String res_date_temp) {
		this.res_date_temp = res_date_temp;
	}
	public List<HospitalVO> getHosArray() {
		return hosArray;
	}
	public void setHosArray(List<HospitalVO> hosArray) {
		this.hosArray = hosArray;
	}
	public int getRes_seq() {
		return res_seq;
	}
	public void setRes_seq(int res_seq) {
		this.res_seq = res_seq;
	}
	public String getRes_users_id() {
		return res_users_id;
	}
	public void setRes_users_id(String res_users_id) {
		this.res_users_id = res_users_id;
	}
	public String getUsers_name() {
		return users_name;
	}
	public void setUsers_name(String users_name) {
		this.users_name = users_name;
	}
	public String getUsers_tel() {
		return users_tel;
	}
	public void setUsers_tel(String users_tel) {
		this.users_tel = users_tel;
	}
	public String getRes_hos_id() {
		return res_hos_id;
	}
	public void setRes_hos_id(String res_hos_id) {
		this.res_hos_id = res_hos_id;
	}
	
	
	
	
	public Date getRes_date() {
		return res_date;
	}
	public void setRes_date(Date res_date) {
		this.res_date = res_date;
	}
	public String getRes_time() {
		return res_time;
	}
	public void setRes_time(String res_time) {
		this.res_time = res_time;
	}
	public String getRes_cancel() {
		return res_cancel;
	}
	public void setRes_cancel(String res_cancel) {
		this.res_cancel = res_cancel;
	}
	public Date getRes_cashdate() {
		return res_cashdate;
	}
	public void setRes_cashdate(Date res_cashdate) {
		this.res_cashdate = res_cashdate;
	}
	public String getHos_name() {
		return hos_name;
	}
	public void setHos_name(String hos_name) {
		this.hos_name = hos_name;
	}
	public String getSearchInsertDate1() {
		return searchInsertDate1;
	}
	public void setSearchInsertDate1(String searchInsertDate1) {
		this.searchInsertDate1 = searchInsertDate1;
	}
	public String getSearchInsertDate2() {
		return searchInsertDate2;
	}
	public void setSearchInsertDate2(String searchInsertDate2) {
		this.searchInsertDate2 = searchInsertDate2;
	}
	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getRes_name() {
		return res_name;
	}

	public void setRes_name(String res_name) {
		this.res_name = res_name;
	}
	@Override
	public String toString() {
		return "ReserveVO [res_seq=" + res_seq + ", res_users_id=" + res_users_id + ", res_name=" + res_name
				+ ", users_name=" + users_name + ", users_tel=" + users_tel + ", res_hos_id=" + res_hos_id
				+ ", res_time=" + res_time + ", res_cancel=" + res_cancel + ", res_date=" + res_date
				+ ", res_date_temp=" + res_date_temp + ", res_cashdate=" + res_cashdate + ", hos_name=" + hos_name
				+ ", searchInsertDate1=" + searchInsertDate1 + ", searchInsertDate2=" + searchInsertDate2
				+ ", searchCondition=" + searchCondition + ", searchKeyword=" + searchKeyword + ", hosArray=" + hosArray
				+ ", counts=" + counts + ", besthosname=" + besthosname + ", res_hos_price=" + res_hos_price
				+ ", reshosname=" + reshosname + "]";
	}
	
	
	
	
	
	
	
	
}
