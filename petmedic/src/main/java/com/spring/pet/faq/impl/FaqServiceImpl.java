package com.spring.pet.faq.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.spring.pet.faq.FaqService;
import com.spring.pet.faq.FaqVO;

@Service("faqService")
public class FaqServiceImpl implements FaqService{

	@Autowired @Qualifier("faqDao")
	public FaqDAO faqDao;

	// 자주묻는질문 등록
	@Override
	public void insertFAQ(FaqVO vo) {
		faqDao.insertFAQ(vo);
	}

	// 자주묻는질문 수정
	@Override
	public void updateFAQ(FaqVO vo) {
		faqDao.updateFAQ(vo);
	}

	// 자주묻는질문 삭제
	@Override
	public int deleteFAQ(FaqVO vo) {
		return faqDao.deleteFAQ(vo);
	}

	// 자주묻는질문 목록 가져오기
	@Override
	public List<FaqVO> getFaqList(FaqVO vo) {
		return faqDao.getFaqList(vo);
	}

	// 한개만 가져오기
	@Override
	public FaqVO getFaq(FaqVO vo) {
		return faqDao.getFaq(vo);
	}

	@Override
	public int getFaqCount(FaqVO vo) {
		return faqDao.getFaqCount(vo);
	}
	
	@Override
	public List<FaqVO> getFaqSearchList(FaqVO vo){
		return faqDao.getFaqSearchList(vo);
	}

}