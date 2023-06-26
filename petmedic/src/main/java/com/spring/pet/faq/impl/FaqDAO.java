package com.spring.pet.faq.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.pet.faq.FaqVO;

@Repository("faqDao")
public class FaqDAO {
	
	@Autowired
	private SqlSessionTemplate faqBatis;
	
	// 자주묻는질문 등록
	public void insertFAQ(FaqVO vo) {
		faqBatis.insert("faqDAO.insertFaq", vo);
	}

	// 자주묻는질문 수정
	public void updateFAQ(FaqVO vo) {
		faqBatis.update("faqDAO.updateFaq", vo);
	}

		// 자주묻는질문 삭제
	public int deleteFAQ(FaqVO vo) {
		return faqBatis.update("faqDAO.deleteFaq", vo);
	}
		
	// 자주묻는질문 한 개만 가져오기
	public FaqVO getFaq(FaqVO vo) {
		return faqBatis.selectOne("faqDAO.getFaq", vo);
	}

	// 자주묻는질문 목록 가져오기
	public List<FaqVO> getFaqList(FaqVO vo) {
		
		if (vo.getFaq_cate_btn() == null || vo.getFaq_cate_btn().equals("null")) {
			return faqBatis.selectList("faqDAO.getFaqAll", vo);
		} else {
			return faqBatis.selectList("faqDAO.getFaqList", vo);
		}
	}
	
	public List<FaqVO> getFaqSearchList(FaqVO vo){
		
		return faqBatis.selectList("faqDAO.getFaqSearch", vo);
	}
	
	// 자주묻는질문 개수 가져오기
	public int getFaqCount(FaqVO vo) {
		return faqBatis.selectOne("faqDAO.listCount", vo);
	}
}