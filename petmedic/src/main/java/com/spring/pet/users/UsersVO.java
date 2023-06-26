package com.spring.pet.users;

import java.util.Date;

public class UsersVO {
	private String users_id;
	private String users_name;
	private String users_pw;
	private String users_tel;
	private String users_email;
	private String users_email2;
	private String users_addr;
	private String users_addr2;
	private String users_addr3;
	private String users_addr4;
	private String users_addr5;
	private String users_pick1;
	private String users_pick2;
	private String users_pick3;
	private String users_pick4;
	private String users_pick5;
	private String users_role;
	private Date users_new_date;
	private String users_del;
	private Date users_del_date;
	
	private String searchCondition;
	private String searchKeyword;
	
	private String searchInsertDate1;
	private String searchInsertDate2;
	
	private String searchRole;
	
	private int start;
	
	private String hos_id; //찜할때 병원 이름 임시로 넣을때 필요ㄲ
	
	private String res_cancel; // 예약 체크박스로 필요함 .
	
	// 찜 병원 이름
		private String users_hos_name1;	// 찜병원 이름1
		private String users_hos_name2;	// 찜병원 이름2
		private String users_hos_name3;	// 찜병원 이름3
		private String users_hos_name4;	// 찜병원 이름4
		private String users_hos_name5;	// 찜병원 이름5
		  
		private String delZzim;
		private int cnt; 		// 찜컬럼 카운트용	

		private int uP;
	//	gettersetter
		
		public int getUp() {
			return uP;
		}

		public void SetUp(int up) {
			this.uP = up;
		}
		
		
		public String getUsers_id() {
			return users_id;
		}

		public String getHos_id() {
			return hos_id;
		}

		public void setHos_id(String hos_id) {
			this.hos_id = hos_id;
		}

		public int getCnt() {
			return cnt;
		}

		public void setCnt(int cnt) {
			this.cnt = cnt;
		}

		public String getRes_cancel() {
			return res_cancel;
		}

		public void setRes_cancel(String res_cancel) {
			this.res_cancel = res_cancel;
		}

		public void setUsers_id(String users_id) {
			this.users_id = users_id;
		}

		public String getUsers_name() {
			return users_name;
		}

		public void setUsers_name(String users_name) {
			this.users_name = users_name;
		}

		public String getUsers_pw() {
			return users_pw;
		}

		public void setUsers_pw(String users_pw) {
			this.users_pw = users_pw;
		}

		public String getUsers_tel() {
			return users_tel;
		}

		public void setUsers_tel(String users_tel) {
			this.users_tel = users_tel;
		}
		
		public String getUsers_email() {
			return users_email;
		}
		
		public String getUsersFullEmail() {
			return users_email + users_email2;
		}

		public void setUsers_email(String users_email) {
			this.users_email = users_email;
		}

		public String getUsers_email2() {
			return users_email2;
		}

		public void setUsers_email2(String users_email2) {
			this.users_email2 = users_email2;
		}

		public String getUsers_addr() {
			return users_addr;
		}

		public void setUsers_addr(String users_addr) {
			this.users_addr = users_addr;
		}

		public String getUsers_addr2() {
			return users_addr2;
		}

		public void setUsers_addr2(String users_addr2) {
			this.users_addr2 = users_addr2;
		}

		public String getUsers_addr3() {
			return users_addr3;
		}

		public void setUsers_addr3(String users_addr3) {
			this.users_addr3 = users_addr3;
		}

		public String getUsers_addr4() {
			return users_addr4;
		}

		public void setUsers_addr4(String users_addr4) {
			this.users_addr4 = users_addr4;
		}

		public String getUsers_addr5() {
			return users_addr5;
		}

		public void setUsers_addr5(String users_addr5) {
			this.users_addr5 = users_addr5;
		}

		public String getUsers_pick1() {
			return users_pick1;
		}

		public void setUsers_pick1(String users_pick1) {
			this.users_pick1 = users_pick1;
		}

		public String getUsers_pick2() {
			return users_pick2;
		}

		public void setUsers_pick2(String users_pick2) {
			this.users_pick2 = users_pick2;
		}

		public String getUsers_pick3() {
			return users_pick3;
		}

		public void setUsers_pick3(String users_pick3) {
			this.users_pick3 = users_pick3;
		}

		public String getUsers_pick4() {
			return users_pick4;
		}

		public void setUsers_pick4(String users_pick4) {
			this.users_pick4 = users_pick4;
		}

		public String getUsers_pick5() {
			return users_pick5;
		}

		public void setUsers_pick5(String users_pick5) {
			this.users_pick5 = users_pick5;
		}

		public String getUsers_role() {
			return users_role;
		}

		public void setUsers_role(String users_role) {
			this.users_role = users_role;
		}
        
		public Date getUsers_new_date() {
			return users_new_date;
		}

		public void setUsers_new_date(Date users_new_date) {
			this.users_new_date = users_new_date;
		}

		public String getUsers_del() {
			return users_del;
		}

		public void setUsers_del(String users_del) {
			this.users_del = users_del;
		}

		public Date getUsers_del_date() {
			return users_del_date;
		}

		public void setUsers_del_date(Date users_del_date) {
			this.users_del_date = users_del_date;
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

		public String getSearchRole() {
			return searchRole;
		}

		public void setSearchRole(String searchRole) {
			this.searchRole = searchRole;
		}

		public int getStart() {
			return start;
		}

		public void setStart(int start) {
			this.start = start;
		}

		public String getUsers_hos_name1() {
			return users_hos_name1;
		}

		public void setUsers_hos_name1(String users_hos_name1) {
			this.users_hos_name1 = users_hos_name1;
		}

		public String getUsers_hos_name2() {
			return users_hos_name2;
		}

		public void setUsers_hos_name2(String users_hos_name2) {
			this.users_hos_name2 = users_hos_name2;
		}

		public String getUsers_hos_name3() {
			return users_hos_name3;
		}

		public void setUsers_hos_name3(String users_hos_name3) {
			this.users_hos_name3 = users_hos_name3;
		}

		public String getUsers_hos_name4() {
			return users_hos_name4;
		}

		public void setUsers_hos_name4(String users_hos_name4) {
			this.users_hos_name4 = users_hos_name4;
		}

		public String getUsers_hos_name5() {
			return users_hos_name5;
		}

		public void setUsers_hos_name5(String users_hos_name5) {
			this.users_hos_name5 = users_hos_name5;
		}

		public String getDelZzim() {
			return delZzim;
		}

		public void setDelZzim(String delZzim) {
			this.delZzim = delZzim;
		}

		@Override
		public String toString() {
			return "UsersVO [users_id=" + users_id + ", users_name=" + users_name + ", users_pw=" + users_pw
					+ ", users_tel=" + users_tel + ", users_email=" + users_email + ", users_email2=" + users_email2
					+ ", users_addr=" + users_addr + ", users_addr2=" + users_addr2 + ", users_addr3=" + users_addr3
					+ ", users_addr4=" + users_addr4 + ", users_addr5=" + users_addr5 + ", users_pick1=" + users_pick1
					+ ", users_pick2=" + users_pick2 + ", users_pick3=" + users_pick3 + ", users_pick4=" + users_pick4
					+ ", users_pick5=" + users_pick5 + ", users_role=" + users_role + ", users_new_date="
					+ users_new_date + ", users_del=" + users_del + ", users_del_date=" + users_del_date
					+ ", searchCondition=" + searchCondition + ", searchKeyword=" + searchKeyword
					+ ", searchInsertDate1=" + searchInsertDate1 + ", searchInsertDate2=" + searchInsertDate2
					+ ", searchRole=" + searchRole + ", start=" + start + ", hos_id=" + hos_id + ", res_cancel="
					+ res_cancel + ", users_hos_name1=" + users_hos_name1 + ", users_hos_name2=" + users_hos_name2
					+ ", users_hos_name3=" + users_hos_name3 + ", users_hos_name4=" + users_hos_name4
					+ ", users_hos_name5=" + users_hos_name5 + ", delZzim=" + delZzim + ", cnt=" + cnt + "]";
		}

		
		
	
	
}
