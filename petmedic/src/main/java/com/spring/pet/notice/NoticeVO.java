package com.spring.pet.notice;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class NoticeVO {
	private int notice_int;					// 글번호
	private String notice_admin;			// 작성자
	private String notice_title;			// 글제목
	private String notice_cont;				// 내용
	private Date notice_date;				// 작성일
	private int notice_readcount;			// 조회수
	private int notice_pin;					// 상단고정여부
	private MultipartFile notice_file;		// 첨부파일
	private String notice_realfile;			// 실제파일명
	
	private String noticeSearch;			// 셀렉트박스: title_keyword, cont_keyword
	private String noticeSearchKeyword;		// 검색 키워드
	public int getNotice_int() {
		return notice_int;
	}
	public void setNotice_int(int notice_int) {
		this.notice_int = notice_int;
	}
	public String getNotice_admin() {
		return notice_admin;
	}
	public void setNotice_admin(String notice_admin) {
		this.notice_admin = notice_admin;
	}
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_cont() {
		return notice_cont;
	}
	public void setNotice_cont(String notice_cont) {
		this.notice_cont = notice_cont;
	}
	public Date getNotice_date() {
		return notice_date;
	}
	public void setNotice_date(Date notice_date) {
		this.notice_date = notice_date;
	}
	public int getNotice_readcount() {
		return notice_readcount;
	}
	public void setNotice_readcount(int notice_readcount) {
		this.notice_readcount = notice_readcount;
	}
	public int getNotice_pin() {
		return notice_pin;
	}
	public void setNotice_pin(int notice_pin) {
		this.notice_pin = notice_pin;
	}
	public MultipartFile getNotice_file() {
		return notice_file;
	}
	public void setNotice_file(MultipartFile notice_file) {
		this.notice_file = notice_file;
	}
	public String getNotice_realfile() {
		return notice_realfile;
	}
	public void setNotice_realfile(String notice_realfile) {
		this.notice_realfile = notice_realfile;
	}
	public String getNoticeSearch() {
		return noticeSearch;
	}
	public void setNoticeSearch(String noticeSearch) {
		this.noticeSearch = noticeSearch;
	}
	public String getNoticeSearchKeyword() {
		return noticeSearchKeyword;
	}
	public void setNoticeSearchKeyword(String noticeSearchKeyword) {
		this.noticeSearchKeyword = noticeSearchKeyword;
	}
	
	
}
