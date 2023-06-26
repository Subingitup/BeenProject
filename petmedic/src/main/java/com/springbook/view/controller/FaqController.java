package com.springbook.view.controller;

import java.util.List;

import javax.mail.Session;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.pet.faq.FaqService;
import com.spring.pet.faq.FaqVO;
import com.spring.pet.notice.NoticeVO;

@Controller
public class FaqController {

	@Autowired @Qualifier("faqService")
	public FaqService faqService;
	
	// [관리자] 자주묻는질문 등록
	@RequestMapping("/insertFAQ")
	public String insertFAQ(FaqVO vo) {
		String faq_cont = vo.getFaq_cont();
		faq_cont = faq_cont.replace("\r\n","<br>");
		vo.setFaq_cont(faq_cont);
		faqService.insertFAQ(vo);
		return "faq/getFaqList_admin";
	}

	// [관리자] 수정페이지로 보내줘
	@RequestMapping("/updateFAQ")
	public String updateFAQForm(FaqVO vo, Model model) {
		
		vo = faqService.getFaq(vo);
	    String faq_cont = vo.getFaq_cont();
	    faq_cont = faq_cont.replace("<br>","\r\n");
	    vo.setFaq_cont(faq_cont);
		model.addAttribute("faqList", vo);
		
		return "faq/updateFAQ";
	}
	
	// [관리자] 자주묻는질문 수정
	@RequestMapping("/modiFAQ")
	public String updateFAQ(FaqVO vo) {
		String faq_cont = vo.getFaq_cont();
		faq_cont = faq_cont.replace("\r\n","<br>");
		vo.setFaq_cont(faq_cont);
		faqService.updateFAQ(vo);
		return "/faq/getFaqList_admin";
	}

	// [관리자] 자주묻는질문 삭제
	@RequestMapping("/deleteFAQ")
	public String deleteFAQ(FaqVO vo) {
		faqService.deleteFAQ(vo);
		return "/faq/getFaqList_admin";
	}
	
	// [공통] 자주묻는질문 리스트 가져오기
	@RequestMapping("/getFaqList")
	@ResponseBody
	public List<FaqVO> getFaqList(FaqVO vo, Model model){
		
		if (vo.getFaqSearch() == null) {
			model.addAttribute("faqList", faqService.getFaqList(vo));
			return faqService.getFaqList(vo);
		} else {
			model.addAttribute("faqList", faqService.getFaqSearchList(vo));
			return faqService.getFaqSearchList(vo);
		}
	}
	
	// [공통] getFaqList으로 이동
	@RequestMapping("/togetFaqList")
	public String toFaq_list_wrap(FaqVO vo) {
		return "/faq/getFaqList";
	}
	
	// [관리자] getFaqList_admin으로 이동
	@RequestMapping("/togetFaqListAdmin")
	public String toFaq_list_wrap_admin(FaqVO vo) {
		return "/faq/getFaqList_admin";
	}
	
	// [관리자] insertFAQ으로 이동
	@RequestMapping("/toInsertFAQ")
	public String toInsertFAQ(FaqVO vo, HttpSession session) {
		return "/faq/insertFAQ";
	}
	
	// [관리자] 공지사항 선택해서 전체삭제되도록
   @RequestMapping("/deleteCheckedFaq")
   public String deleteCheckedFaq(@RequestParam(value="faq_int", required = false) int[] faq_int_list, FaqVO vo) {
	    int delSum = 0;
	    
	    // 배열이 가지고있는 값들을 반복해서 출력해주고 delete문을 반복해서 돌린다
	    for(int faq_intValue : faq_int_list) {
	        vo.setFaq_int(faq_intValue);
	        if (faqService.deleteFAQ(vo) > 0) { delSum++; }
	    }
	    
	    if(delSum > 0) {
	    	return "notice/getFaqList_admin";
	    } else {
	    	return "error";
	    }
   }
	
}