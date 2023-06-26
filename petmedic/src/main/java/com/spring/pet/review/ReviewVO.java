package com.spring.pet.review;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class ReviewVO {

//review
	private int rev_hos_seq;
	private String rev_title;
	private String rev_userid;
	private String rev_content;
	private Date rev_date;
	private int rev_up;
	private int rev_star;
	private String rev_pic;
	private String rev_req;
	private String rev_info;
	private String rev_res_date;
	private String rev_res_time;
	private int rev_res_seq;
	private String rev_hos_id;

	private String searchCondition;
	private String searchKeyword;

	private MultipartFile uploadFile;

//reserve	
	private int res_seq;
	private String res_users_id;
	private String res_hos_id;
	private String res_date;
	private String res_time;
	private String res_cancel;

//hospital
	private String hos_name;
// 신고
	private String res_req;
//리뷰추천 users
	private String users_id;
	
	
	//getter setter			
	
	public int getRev_hos_seq() {
		return rev_hos_seq;
	}
	public String getUsers_id() {
		return users_id;
	}
	public void setUsers_id(String users_id) {
		this.users_id = users_id;
	}
	public void setRev_hos_seq(int rev_hos_seq) {
		this.rev_hos_seq = rev_hos_seq;
	}
	public String getRev_title() {
		return rev_title;
	}
	public void setRev_title(String rev_title) {
		this.rev_title = rev_title;
	}
	public String getRev_userid() {
		return rev_userid;
	}
	public void setRev_userid(String rev_userid) {
		this.rev_userid = rev_userid;
	}
	public String getRev_content() {
		return rev_content;
	}
	public void setRev_content(String rev_content) {
		this.rev_content = rev_content;
	}
	public Date getRev_date() {
		return rev_date;
	}
	public void setRev_date(Date rev_date) {
		this.rev_date = rev_date;
	}
	public int getRev_up() {
		return rev_up;
	}
	public void setRev_up(int rev_up) {
		this.rev_up = rev_up;
	}
	public int getRev_star() {
		return rev_star;
	}
	public void setRev_star(int rev_star) {
		this.rev_star = rev_star;
	}
	public String getRev_pic() {
		return rev_pic;
	}
	public void setRev_pic(String rev_pic) {
		this.rev_pic = rev_pic;
	}
	public String getRev_req() {
		return rev_req;
	}
	public void setRev_req(String rev_req) {
		this.rev_req = rev_req;
	}
	public String getRev_info() {
		return rev_info;
	}
	public void setRev_info(String rev_info) {
		this.rev_info = rev_info;
	}
	public String getRev_res_date() {
		return rev_res_date;
	}
	public void setRev_res_date(String rev_res_date) {
		this.rev_res_date = rev_res_date;
	}
	public String getRev_res_time() {
		return rev_res_time;
	}
	public void setRev_res_time(String rev_res_time) {
		this.rev_res_time = rev_res_time;
	}
	public int getRev_res_seq() {
		return rev_res_seq;
	}
	public void setRev_res_seq(int rev_res_seq) {
		this.rev_res_seq = rev_res_seq;
	}
	public String getRev_hos_id() {
		return rev_hos_id;
	}
	public void setRev_hos_id(String rev_hos_id) {
		this.rev_hos_id = rev_hos_id;
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
	public MultipartFile getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
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
	public String getRes_hos_id() {
		return res_hos_id;
	}
	public void setRes_hos_id(String res_hos_id) {
		this.res_hos_id = res_hos_id;
	}
	public String getRes_date() {
		return res_date;
	}
	public void setRes_date(String res_date) {
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
	public String getHos_name() {
		return hos_name;
	}
	public void setHos_name(String hos_name) {
		this.hos_name = hos_name;
	}
	public String getRes_req() {
		return res_req;
	}
	public void setRes_req(String res_req) {
		this.res_req = res_req;
	}
	@Override
	public String toString() {
		return "ReviewVO [rev_hos_seq=" + rev_hos_seq + ", rev_title=" + rev_title + ", rev_userid=" + rev_userid
				+ ", rev_content=" + rev_content + ", rev_date=" + rev_date + ", rev_up=" + rev_up + ", rev_star="
				+ rev_star + ", rev_pic=" + rev_pic + ", rev_req=" + rev_req + ", rev_info=" + rev_info
				+ ", rev_res_date=" + rev_res_date + ", rev_res_time=" + rev_res_time + ", rev_res_seq=" + rev_res_seq
				+ ", rev_hos_id=" + rev_hos_id + ", searchCondition=" + searchCondition + ", searchKeyword="
				+ searchKeyword + ", uploadFile=" + uploadFile + ", res_seq=" + res_seq + ", res_users_id="
				+ res_users_id + ", res_hos_id=" + res_hos_id + ", res_date=" + res_date + ", res_time=" + res_time
				+ ", res_cancel=" + res_cancel + ", hos_name=" + hos_name + ", res_req=" + res_req + ", users_id="
				+ users_id + "]";
	}
	

	
	
	

	
	
	
	
	
	
}
