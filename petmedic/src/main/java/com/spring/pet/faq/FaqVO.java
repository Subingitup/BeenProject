package com.spring.pet.faq;

public class FaqVO {
	private int faq_int;		// 글번호
	private String faq_id;		// 작성자아이디
	private String faq_title;	// 글제목
	private String faq_cont;	// 글내용
	private String faq_cate;	// 주제(카테고리선택해서 검색용)
	private String faq_del;		// 삭제여부(N 조회가능)
	
	private String faq_cate_btn; // 카테고리 선택시 셋팅되는 변수
	private int start; 						// 페이징 처리용
	
	private String faqSearch;			// 셀렉트 박스 옵션 선택시 저장되는 값 (title_keyword, cont_keyword)
	private String faqSearchKeyword;	// input에 입력한 검색어
	
	public String getFaqSearch() {
		return faqSearch;
	}

	public void setFaqSearch(String faqSearch) {
		this.faqSearch = faqSearch;
	}

	public String getFaqSearchKeyword() {
		return faqSearchKeyword;
	}

	public void setFaqSearchKeyword(String faqSearchKeyword) {
		this.faqSearchKeyword = faqSearchKeyword;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}
	
	public String getFaq_cate_btn() {
		return faq_cate_btn;
	}

	public void setFaq_cate_btn(String faq_cate_btn) {
		this.faq_cate_btn = faq_cate_btn;
	}

	public String getFaq_del() {
		return faq_del;
	}

	public void setFaq_del(String faq_del) {
		this.faq_del = faq_del;
	}

	public int getFaq_int() {
		return faq_int;
	}
	
	public void setFaq_int(int faq_int) {
		this.faq_int = faq_int;
	}
	
	public String getFaq_id() {
		return faq_id;
	}
	
	public void setFaq_id(String faq_id) {
		this.faq_id = faq_id;
	}
	
	public String getFaq_title() {
		return faq_title;
	}
	
	public void setFaq_title(String faq_title) {
		this.faq_title = faq_title;
	}
	
	public String getFaq_cont() {
		return faq_cont;
	}
	
	public void setFaq_cont(String faq_cont) {
		this.faq_cont = faq_cont;
	}
	
	public String getFaq_cate() {
		return faq_cate;
	}
	
	public void setFaq_cate(String faq_cate) {
		this.faq_cate = faq_cate;
	}
	
}
