package com.spring.pet.faq;

import java.util.List;

public interface FaqService {
	
	// 자주묻는질문 등록
	void insertFAQ(FaqVO vo);
	
	// 자주묻는질문 수정
	void updateFAQ(FaqVO vo);
	
	// 자주묻는질문 삭제
	int deleteFAQ(FaqVO vo);
	
	// 자주묻는질문 검색(카테고리) 조회
	
	// 자주묻는질문 리스트 가져오기
	List<FaqVO> getFaqList(FaqVO vo);

	FaqVO getFaq(FaqVO vo);
	
	int getFaqCount(FaqVO vo);
	
	List<FaqVO> getFaqSearchList(FaqVO vo);
}