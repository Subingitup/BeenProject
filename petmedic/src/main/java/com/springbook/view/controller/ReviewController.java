package com.springbook.view.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.spring.pet.hospital.HospitalService;
import com.spring.pet.hospital.HospitalVO;
import com.spring.pet.review.ReviewService;
import com.spring.pet.review.ReviewVO;

@Controller
@SessionAttributes("review")
// session.setAttribute와 동일 => key이름:"board" 만 있잖아?  
// => 객체 생성될 때( model.addAttribute("Review", reviewService.getReview(vo));) 물고있는 값을 알아서 가져온다
public class ReviewController {

	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private HospitalService hospitalService;

	// 상대경로를 절대경로로 변경해주는 로직
	// public String insertBoard(MultipartHttpServletRequest request, BoardVO vo)
	// throws IllegalStateException, IOException {

	@ModelAttribute("searchMap") // 컨트롤러를 탈 때마다 계속 생성되는 객체이다. request객체인데 밑에 url 타기전에 실행되어 객체생성
	public Map<String, String> searchConditionMap() {
		Map<String, String> searchMap = new HashMap<String, String>();
		System.out.println("searchMap: " + searchMap);
		searchMap.put("병원명", "HOS_NAME");
		return searchMap;
	}
	
	
// 글 등록을 위한 정보불러오기	   
	@RequestMapping("/getReserveForReview")
	public String getReserveForReview(ReviewVO vo, HttpSession session, Model model) {
		System.out.println("===ReviewController getReserveForReview 시작===");
		vo.setRev_userid(((String) session.getAttribute("users_id")));
		System.out.println("로그인 아이디" + vo.getRev_userid());
		model.addAttribute("review", reviewService.getReserveInfo(vo));
		System.out.println(model.getAttribute("review"));
		return "/review/insertReview";

	}

	
	// 글 등록
	@RequestMapping(value = "/insertReview")
	public String insertReview(ReviewVO vo, HttpSession session, MultipartHttpServletRequest request) throws IllegalStateException, IOException {
		MultipartFile uploadFile = vo.getUploadFile();

		// 상대경로를 절대경로로 변경해주는 경우 realPath 추가
		// String realPath =
		// request.getSession().getServletContext().getRealPath("/img/");
//		String realPath = "c:/vet/petmedic/src/main/webapp/resources/imgs/";
		String realPath = request.getSession().getServletContext().getRealPath("/resources/imgs/");
		String fileName = vo.getRev_userid() + "_" + uploadFile.getOriginalFilename();

		if (!uploadFile.isEmpty()) {
			vo.setRev_pic(fileName);
			uploadFile.transferTo(new File(realPath + fileName)); // transferTo: file을 destination으로 transfer함
		}
		System.out.println("insertReview 시작: " + vo);
		vo.setRev_userid(((String) session.getAttribute("users_id")));
		reviewService.insertReview(vo);
		return "redirect:getMyReviewPostList";
	}

//   글 수정 
	@RequestMapping("/updateReview")
	public String updateReview(ReviewVO vo, HttpSession session) throws IllegalStateException, IOException {
		MultipartFile uploadFile = vo.getUploadFile();

		// 상대경로를 절대경로로 변경해주는 경우 realPath 추가
		// String realPath =
		// request.getSession().getServletContext().getRealPath("/img/");
		String realPath = "c:/vet/petmedic/src/main/webapp/resources/imgs/";
		String fileName = uploadFile.getOriginalFilename();

		if (!uploadFile.isEmpty()) {
			vo.setRev_pic(fileName);
			uploadFile.transferTo(new File(realPath + fileName)); // transferTo: file을 destination으로 transfer함
		}
		System.out.println("와라");
		reviewService.updateReview(vo);
		System.out.println("updateReview 끝");
		return "redirect:getMyReviewPostList";

	}

//  [관리자] 리뷰 상세 조회
	@RequestMapping("/getAdminReview")
	public String getAdminReview(ReviewVO vo, Model model) {
		// Model model 인터페이스 객체를 자동으로 만듬.
		System.out.println("===ReviewController getReview 시작===");
		System.out.println(vo.getRev_hos_seq());
		model.addAttribute("review", reviewService.getReview(vo));
//				=> 데이터를 담기만해도 어차피 포워드로 전송이 되기때문에 MAV 객체를 쓸 필요가 없다
		return "/review/getAdminReviewDetails";
	}
//  [전체유저] 리뷰 상세 조회
	@RequestMapping("/getReview")
	public String getReview(ReviewVO vo, Model model) {
		// Model model 인터페이스 객체를 자동으로 만듬.
		System.out.println("===ReviewController getReview 시작===");
		System.out.println(vo.getRev_hos_seq());
		model.addAttribute("review", reviewService.getReview(vo));
//				=> 데이터를 담기만해도 어차피 포워드로 전송이 되기때문에 MAV 객체를 쓸 필요가 없다
		return "/review/getReviewDetails";
	}
//  [병원회원] 리뷰 상세 조회
	@RequestMapping("/hosGetReviewDetails")
	public String hosGetReviewDetails(ReviewVO vo, Model model, HttpSession session) {
		HospitalVO hvo = new HospitalVO();
        hvo.setHos_id((String) session.getAttribute("hos_id"));
        model.addAttribute("hos", hospitalService.getHos(hvo));
		model.addAttribute("review", reviewService.hosGetReviewDetails(vo));
//				=> 데이터를 담기만해도 어차피 포워드로 전송이 되기때문에 MAV 객체를 쓸 필요가 없다
		return "/hosMyPage/hosGetReviewDetails";
	}
//  [마이페이지] 리뷰 상세 조회
	@RequestMapping("/getMyReview")
	public String getMyReview(ReviewVO vo, Model model) {
		// Model model 인터페이스 객체를 자동으로 만듬.
		System.out.println("===ReviewController getReview 시작===");
		System.out.println(vo.getRev_hos_seq());
		model.addAttribute("review", reviewService.getReview(vo));
//				=> 데이터를 담기만해도 어차피 포워드로 전송이 되기때문에 MAV 객체를 쓸 필요가 없다
		return "/review/getReview";
	}

//   병원페이지 리뷰 상세 조회
	@RequestMapping("/getReviewDetail")
	public String getReviewDetail(ReviewVO vo, Model model) {
		// Model model 인터페이스 객체를 자동으로 만듬.
		System.out.println("===ReviewController getReviewDetail 시작===");
		System.out.println(vo.getRev_hos_seq());
		model.addAttribute("review", reviewService.getReview(vo));
//				=> 데이터를 담기만해도 어차피 포워드로 전송이 되기때문에 MAV 객체를 쓸 필요가 없다
		return "/review/getReviewDetail";
	}

	// [마이페이지] 글 삭제
	@RequestMapping("/deleteReview")
	public String deleteReview(ReviewVO vo) throws IOException {
	    Path filePath = Paths.get("c:/vet/petmedic/src/main/webapp/resources/imgs/" + vo.getRev_pic());
//	    Path filePath = Paths.get(request.getSession().getServletContext().getRealPath("/resources/imgs/")+ vo.getRev_pic());

	    if (Files.exists(filePath)) {
	        Files.delete(filePath);
	    } else {
	        System.out.println("파일없음. 삭제스킵.");
	    }

	    reviewService.deleteReview(vo);
	    return "/review/getMyReviewList";
	}

// 병원페이지 리뷰 글 삭제처리(hidden) 		  
	@RequestMapping("/updateDelReview")
	public String updateDelReview(ReviewVO vo) {

		reviewService.updateDelReview(vo);
		return "redirect:getReport?rev_hos_req=" + vo.getRes_hos_id();
	}

//  [관리자] 병원 전체 리뷰목록
	@RequestMapping("/getAdminRevList")
	public String getAdminRevList(ReviewVO vo, Model model) {
		System.out.println("관리자 전체리뷰목록이동 처리");
		System.out.println(reviewService.getReviewList(vo));
		model.addAttribute("reviewList", reviewService.getReviewList(vo));
		return "/review/getAdminRevList";
	}

	
//  [전체유저] 병원 전체 리뷰목록
	@RequestMapping("/getReviewList")
	public String getReviewListPost(ReviewVO vo, Model model) {
		System.out.println("유저 전체리뷰목록이동 처리");
		System.out.println(reviewService.getReviewList(vo));
		model.addAttribute("reviewList", reviewService.getReviewList(vo));
		return "/review/getReviewList";
	}
	
//  [관리자]  리뷰검색
	@RequestMapping("/getAdminReviewDetails")
	public String getAdminReviewDetails(ReviewVO vo, Model model, HttpSession session) {
		System.out.println("관리자리뷰 검색 처리");
		System.out.println(vo.getSearchKeyword());
		System.out.println(vo.getSearchCondition());
		model.addAttribute("reviewList", reviewService.getMyRevList(vo)); 
		return "/review/getAdminRevList";
	}

//  [전체유저]  리뷰검색
	@RequestMapping("/getMyRevList")
	public String getMyRevList(ReviewVO vo, Model model, HttpSession session) {
		System.out.println("전체리뷰목록 검색 처리");
		System.out.println(vo.getSearchKeyword());
		System.out.println(vo.getSearchCondition());
		model.addAttribute("reviewList", reviewService.getMyRevList(vo)); 
		return "/review/getReviewList";
	}
//  [마이페이지]  리뷰검색
	@RequestMapping("/searchMyRevList")
	public String searchMyRevList(ReviewVO vo, Model model, HttpSession session) {
		System.out.println("나의리뷰목록 검색 처리");
		vo.setRev_userid((String)session.getAttribute("users_id"));
		System.out.println(vo.getRev_userid());
		System.out.println(vo.getSearchKeyword());
		System.out.println(vo.getSearchCondition());
		model.addAttribute("reviewList", reviewService.searchMyRevList(vo)); 
		return "/review/getMyReviewList";
	}
//  [병원회원]  리뷰검색
	@RequestMapping("/searchHosRevList")
	public String searchHosRevList(ReviewVO vo, Model model, HttpSession session) {
		System.out.println("병원리뷰목록 검색 처리");
		vo.setRev_hos_id((String)session.getAttribute("hos_id"));
		System.out.println(vo.getRev_hos_id());
		System.out.println(vo.getSearchKeyword());
		System.out.println(vo.getSearchCondition());
		model.addAttribute("reviewList", reviewService.searchHosRevList(vo)); 
		return "/hosMyPage/myHosReviews";
	}

//  [마이페이지] 나의 글 전체 목록
	@RequestMapping("/getMyReviewPostList")
	public String getMyReviewPostList(ReviewVO vo, Model model, HttpSession session) {
		System.out.println("[마이페이지] 나의 글 전체 목록");
		vo.setRev_userid((String)session.getAttribute("users_id"));
		model.addAttribute("reviewList", reviewService.getMyReviewPostList(vo));
		return "/review/getMyReviewList";
	}
//  [마이페이지] 나의 글 전체 목록 ajax
	@RequestMapping("/searchHosRevListAjax")
	@ResponseBody
	public List<ReviewVO> searchHosRevListAjax(ReviewVO vo, Model model, HttpSession session) {
		System.out.println("[마이페이지] 나의 글 전체 목록");
		vo.setRev_hos_id((String)session.getAttribute("hos_id"));
		return reviewService.searchHosRevList(vo);
		
	}
//  [병원회원] 나의 글 전체 목록 ajax
	@RequestMapping("/getMyReviewPostListAjax")
	@ResponseBody
	public List<ReviewVO> getMyReviewPostListAjax(ReviewVO vo, Model model, HttpSession session) {
		System.out.println("[병원회원] 나의 글 전체 목록");
		vo.setRev_userid((String)session.getAttribute("users_id"));
		return reviewService.getMyReviewPostList(vo);
		
	}

//  [전체유저]  리뷰검색
	@RequestMapping("/getRevForMe")
	public String getRevForMe(ReviewVO vo, Model model, HttpSession session) {
		System.out.println("마이페이지 리뷰목록 처리");
		System.out.println(vo.getSearchKeyword());
		System.out.println(vo.getSearchCondition());
		model.addAttribute("reviewList", reviewService.getMyRevList(vo)); 
		return "/review/getReviewList";
	}	
	
// 리뷰추천	
	@RequestMapping("/reviewUp")
	@ResponseBody
	public int reviewUp(@RequestParam("rev_hos_seq") int revHosSeq, @RequestParam("rev_userid") String revUserId, ReviewVO vo, HttpSession session) {
	    System.out.println("리뷰추천 reviewUp 처리");
	    // You can use the revHosSeq and revUserId values as needed
	    vo.setRev_hos_seq(revHosSeq);
	    vo.setRev_userid(revUserId);
	    vo.setUsers_id((String)session.getAttribute("users_id"));
	    if(reviewService.reviewUp(vo) == 1) {
	    	reviewService.reviewUpDelete(vo);
	    	 return 0;
	    } else {
	    	reviewService.reviewUpInsert(vo);
	    }
	     return 1;
	}

	
	
//	[관리자] 리뷰신고
	@RequestMapping("/reportReviewHos")
	public String reportReviewHos(ReviewVO vo, Model model, HttpSession session) {
		String hosUser = (String)session.getAttribute("hos_id");
		model.addAttribute("review", reviewService.reportReviewHos(vo));
		return "redirect:toHosReview?hos_id="+hosUser;
	}
	
//	[관리자] 리뷰신고글 상세 조회
	@RequestMapping("/getReport")
	public String getReport(ReviewVO vo, Model model) {
		System.out.println("리뷰신고글 상세조회 처리");

		model.addAttribute("review", reviewService.getReport(vo));
		return "/review/getReport";
	}

//	[관리자] 리뷰신고글 목록
	@RequestMapping("/getReportList")
	public String getReportListPost(ReviewVO vo, Model model) {
		System.out.println("리뷰신고글 목록조회 처리");

		// 리스트 받아오는 것
		model.addAttribute("reportList", reviewService.getReportList(vo));

		// 리스트 페이징 처리
		String rpl = new Gson().toJson(reviewService.getReportList(vo));
		model.addAttribute("rpl", rpl);

		// 검색 받아오는 것
		model.addAttribute("searchCondition", vo.getSearchCondition());

		return "/review/getReportList";
	}

	// [관리자] 리뷰반려처리
	@RequestMapping("/updateReport_reject")
	public String updateReport_reject(@ModelAttribute("review") ReviewVO vo, HttpSession session, Model model) {
		System.out.println("uprj : " + vo);
		reviewService.updateReport_reject(vo);
		model.addAttribute("review", reviewService.getReport(vo));
		return "/review/getReport";
	}

	// [관리자] 리뷰삭제
	@RequestMapping("/updateReport_delete")
	public String updateReport_delete(@ModelAttribute("review") ReviewVO vo, HttpSession session, Model model) {
		System.out.println("updel : " + vo);
		reviewService.updateReport_delete(vo);
		model.addAttribute("review", reviewService.getReport(vo));
		return "/review/getReport";
	}

	// [관리자] 신고리뷰 조회
	@RequestMapping("/getReportReview1")
	public String getReportReview1(ReviewVO vo, Model model) {
		System.out.println("신고리뷰 상세조회 처리");

		model.addAttribute("review", reviewService.getReportReview1(vo));
		return "/review/getReportReview1";
	}
	
	@RequestMapping("/hosDetailReviewDetail")
	public String hosDetailReviewDetail(ReviewVO vo, Model model) {
		model.addAttribute("review", reviewService.hosDetailReviewDetail(vo));
		return "/hospital/hosDetailReviewDetail";
	}

	
}