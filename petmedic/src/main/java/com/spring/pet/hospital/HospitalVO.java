package com.spring.pet.hospital;


import java.util.Date;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class HospitalVO {
 
	private String hos_id;      /* 병원 ID */
	private String hos_name;    /* 병원명 */
	private String hos_pw;      /* 비밀번호 */
	private String hos_addr;    /* 우편번호 */
	private String hos_addr2;    /* 도로명주소 */ 
	private String hos_addr3;    /* 지번주소 */
	private String hos_addr4;    /* 상세주소 */
	private String hos_addr5;    /* 참고사항 */
	private String hos_tel;     /* 병원연락처 */
	private String hos_start;   /* 진료시간시작*/
	private String hos_end;     /* 진료시간종료*/
	private String hos_s_lunch; /* 점심시간시작*/
	private String hos_e_lunch; /* 점심시간종료*/
	private String hos_hol;       /* 휴일*/
	private String hos_cate;    /* 진료카테고리 */
	private String hos_role;    /* 승인여부 */
	private Double hos_star;    /* 평균별점 */
	private Date hos_date;      /* 승인일자 */	
	private int hos_price;      /* 진료비 */
	private String hos_del;     /* 삭제상태 */
	private String hos_url;		/* 병원사이트 */
	private Date hos_new_date;  /* 가입일자 */
	
	private String searchKeyword; /*검색키워드*/
	private String searchCondition; /*검색조건*/
	

	private MultipartFile uploadFile; /*파일업로드*/
	private MultipartFile uploadFile1; /*파일업로드*/
	private String filename;    /*파일이름*/
	
	private String hos_file; //증명자료
	private String hos_pic;     /* 병원사진 */
	
	private CommonsMultipartFile multi;
	
	private double latitude;
	private double longitude;
	
	private int start;
	
	private String hos_email;
    private String hos_email2;
	
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public MultipartFile getUploadFile1() {
		return uploadFile1;
	}
	public void setUploadFile1(MultipartFile uploadFile1) {
		this.uploadFile1 = uploadFile1;
	}
	public CommonsMultipartFile getMulti() {
		return multi;
	}
	public void setMulti(CommonsMultipartFile multi) {
		this.multi = multi;
	}
	public String getHos_pic() {
		return hos_pic;
	}
	public void setHos_pic(String hos_pic) {
		this.hos_pic = hos_pic;
	}
	public String getHos_file() {
		return hos_file;
	}
	public void setHos_file(String hos_file) {
		this.hos_file = hos_file;
	}
	public Date getHos_new_date() {
		return hos_new_date;
	}
	public void setHos_new_date(Date hos_new_date) {
		this.hos_new_date = hos_new_date;
	}
	public String getHos_id() {
		return hos_id;
	}
	public void setHos_id(String hos_id) {
		this.hos_id = hos_id;
	}
	public String getHos_name() {
		return hos_name;
	}
	public void setHos_name(String hos_name) {
		this.hos_name = hos_name;
	}
	public String getHos_pw() {
		return hos_pw;
	}
	public void setHos_pw(String hos_pw) {
		this.hos_pw = hos_pw;
	}
	public String getHos_addr() {
		return hos_addr;
	}
	public void setHos_addr(String hos_addr) {
		this.hos_addr = hos_addr;
	}
	public String getHos_addr2() {
		return hos_addr2;
	}
	public void setHos_addr2(String hos_addr2) {
		this.hos_addr2 = hos_addr2;
	}
	public String getHos_addr3() {
		return hos_addr3;
	}
	public void setHos_addr3(String hos_addr3) {
		this.hos_addr3 = hos_addr3;
	}
	public String getHos_addr4() {
		return hos_addr4;
	}
	public void setHos_addr4(String hos_addr4) {
		this.hos_addr4 = hos_addr4;
	}
	public String getHos_addr5() {
		return hos_addr5;
	}
	public void setHos_addr5(String hos_addr5) {
		this.hos_addr5 = hos_addr5;
	}
	public String getHos_tel() {
		return hos_tel;
	}
	public void setHos_tel(String hos_tel) {
		this.hos_tel = hos_tel;
	}
	public String getHos_start() {
		return hos_start;
	}
	public void setHos_start(String hos_start) {
		this.hos_start = hos_start;
	}
	public String getHos_end() {
		return hos_end;
	}
	public void setHos_end(String hos_end) {
		this.hos_end = hos_end;
	}
	public String getHos_s_lunch() {
		return hos_s_lunch;
	}
	public void setHos_s_lunch(String hos_s_lunch) {
		this.hos_s_lunch = hos_s_lunch;
	}
	public String getHos_e_lunch() {
		return hos_e_lunch;
	}
	public void setHos_e_lunch(String hos_e_lunch) {
		this.hos_e_lunch = hos_e_lunch;
	}
	public String getHos_hol() {
		return hos_hol;
	}
	public void setHos_hol(String hos_hol) {
		this.hos_hol = hos_hol;
	}
	public String getHos_cate() {
		return hos_cate;
	}
	public void setHos_cate(String hos_cate) {
		this.hos_cate = hos_cate;
	}
	public String getHos_role() {
		return hos_role;
	}
	public void setHos_role(String hos_role) {
		this.hos_role = hos_role;
	}
	public Double getHos_star() {
		return hos_star;
	}
	public void setHos_star(Double hos_star) {
		this.hos_star = hos_star;
	}
	public Date getHos_date() {
		return hos_date;
	}
	public void setHos_date(Date hos_date) {
		this.hos_date = hos_date;
	}
	public int getHos_price() {
		return hos_price;
	}
	public void setHos_price(int hos_price) {
		this.hos_price = hos_price;
	}
	public String getHos_del() {
		return hos_del;
	}
	public void setHos_del(String hos_del) {
		this.hos_del = hos_del;
	}
	public String getHos_url() {
		return hos_url;
	}
	public void setHos_url(String hos_url) {
		this.hos_url = hos_url;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public MultipartFile getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	
	
	
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	
	
	public String getHos_email() {
        return hos_email;
    }
    public void setHos_email(String hos_email) {
        this.hos_email = hos_email;
    }

    public String getHosFullEmail() {
        return hos_email + hos_email2;
    }

    public String getHos_email2() {
        return hos_email2;
    }
    public void setHos_email2(String hos_email2) {
        this.hos_email2 = hos_email2;
    }
	@Override
	public String toString() {
		return "HospitalVO [hos_id=" + hos_id + ", hos_name=" + hos_name + ", hos_pw=" + hos_pw + ", hos_addr="
				+ hos_addr + ", hos_addr2=" + hos_addr2 + ", hos_addr3=" + hos_addr3 + ", hos_addr4=" + hos_addr4
				+ ", hos_addr5=" + hos_addr5 + ", hos_tel=" + hos_tel + ", hos_start=" + hos_start + ", hos_end="
				+ hos_end + ", hos_s_lunch=" + hos_s_lunch + ", hos_e_lunch=" + hos_e_lunch + ", hos_hol=" + hos_hol
				+ ", hos_cate=" + hos_cate + ", hos_role=" + hos_role + ", hos_star=" + hos_star + ", hos_date="
				+ hos_date + ", hos_price=" + hos_price + ", hos_del=" + hos_del + ", hos_url=" + hos_url
				+ ", hos_new_date=" + hos_new_date + ", searchKeyword=" + searchKeyword + ", searchCondition="
				+ searchCondition + ", uploadFile=" + uploadFile + ", uploadFile1=" + uploadFile1 + ", filename="
				+ filename + ", hos_file=" + hos_file + ", hos_pic=" + hos_pic + ", multi=" + multi + ", latitude="
				+ latitude + ", longitude=" + longitude + "]";
	}
	
		
	
}
