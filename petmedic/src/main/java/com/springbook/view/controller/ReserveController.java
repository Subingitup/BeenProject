package com.springbook.view.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

import com.google.gson.Gson;
import com.spring.pet.hospital.HospitalVO;
import com.spring.pet.reserve.ReserveService;
import com.spring.pet.reserve.ReserveVO;

@Controller
@SessionAttributes("reserve")
public class ReserveController {

	@Autowired
	private ReserveService reserveService;

	@ModelAttribute("searchMap") // 컨트롤러를 탈 때마다 계속 생성되는 객체이다. request객체인데 밑에 url 타기전에 실행되어 객체생성
	public Map<String, String> searchConditionMap() {
		Map<String, String> searchMap = new HashMap<String, String>();
		searchMap.put("아이디", "RES_USERS_ID");
		searchMap.put("이름", "USERS_NAME");
		searchMap.put("연락처", "USERS_TEL");
		searchMap.put("병원명", "HOS_NAME");
		return searchMap;
	}

	

	// [관리자] 예약 취소
	@RequestMapping("/updateReserve_rcc")
	public String updateReserve_rcc(@ModelAttribute("reserve") ReserveVO vo, HttpSession session, Model model) {
		reserveService.updateReserve_rcc(vo);
		model.addAttribute("reserve", reserveService.getReserve(vo));
		return "reserve/getReserve";
	}

	// [회원] 나의 예약 취소
	   @RequestMapping("/cancelMyReserve")
	   public String cancelMyReserve(ReserveVO vo, Model model) {
	      reserveService.cancelReserve(vo);
	      model.addAttribute("reserve", reserveService.getReserve(vo));
	      return "userMyPage/myActionReserve";
	   }

	// [관리자] 회원예약 상세 조회
	@RequestMapping("/getReserve")
	public String getReserve(ReserveVO vo, Model model, HospitalVO hvo, HttpSession session) {

		model.addAttribute("reserve", reserveService.getReserve(vo));

		if (session.getAttribute("users_role").equals("ADMIN") || session.getAttribute("users_role").equals("SUPERADMIN")) {
			return "/reserve/getReserve";
		} else {
			hvo.setHos_id(vo.getRes_hos_id());
			HospitalVO rvp1 = reserveService.reservation_page(hvo);
			model.addAttribute("hospital", rvp1);
			model.addAttribute("hos_start", hvo.getHos_start());
			model.addAttribute("hos_end", hvo.getHos_end());
			model.addAttribute("hos_s_lunch", hvo.getHos_s_lunch());
			model.addAttribute("hos_e_lunch", hvo.getHos_e_lunch());
			model.addAttribute("hos_hol", hvo.getHos_hol());
			return "/reserve/getReserve";
		}
//		return "reserve/getReserve";
	}
	
	  // [관리자] 예약 상세 조회
	   @RequestMapping("/getAllReserve")
	   public String getAllReserve(ReserveVO vo, Model model) {

	      model.addAttribute("reserve", reserveService.getReserve(vo));
	      return "/reserve/getReserve";
	   }


	// 예약 목록
	@RequestMapping("/getReserveList")
	public String getReserveListPost(ReserveVO vo, Model model) {

		// 리스트 받아오는 것
		model.addAttribute("reserveList", reserveService.getReserveList(vo));

		// 리스트 페이징 처리
		String rvl = new Gson().toJson(reserveService.getReserveList(vo));
		model.addAttribute("rvl", rvl);

		// 검색 받아오는 것
		model.addAttribute("searchCondition", vo.getSearchCondition());

		return "reserve/getReserveList";
	}

	// [회원] 나의 예약목록을 가져오기
		@RequestMapping("/getMyReserve")
		@ResponseBody
		public List<ReserveVO> getMyReserve(@RequestParam("res_users_id") String userId, @RequestParam(value = "rev_sortKeyword", required = false) String sortKeyword) {
		    
		    ReserveVO vo = new ReserveVO();
		    vo.setRes_users_id(userId);
		    vo.setRev_sortKeyword(sortKeyword);
		    
		    List<ReserveVO> rvo = reserveService.myReserveList(vo);
		    
		    return rvo;
		}
		
	
	// [회원] 나의 예약목록을 필터
	@RequestMapping("/reserveFilter")
	@ResponseBody
	public List<ReserveVO> reserveFilter(ReserveVO vo) {
		
		List<ReserveVO> rvof = reserveService.reserveFilter(vo);
		
		return rvof;
	}
	
	//예약하기
		@RequestMapping("/insertreserve")
		public String insertReserve(ReserveVO vo) throws ParseException {
			 // 문자열
	        String dateStr = vo.getRes_date_temp();
	 
	        // 포맷터
	        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	 
	        // 문자열 -> Date
	        Date date = formatter.parse(dateStr);
			vo.setRes_date(date);
		if(	reserveService.insertReserve(vo) >0) {
			return "redirect:index.jsp";
		}else
			return "hospital/index"; // 일단 해놓은거임
		}
 
		// [회원] 예약상세내역 가져오기
		   @RequestMapping("/myReserveDOne")
		   @ResponseBody
		   public ReserveVO myReserveDOne(ReserveVO vo, Model model) {
		      model.addAttribute("myResrvLst", reserveService.myReserveDOne(vo));
		      return reserveService.myReserveDOne(vo);
		   }	
		   
		// [회원] 나의 예약목록을 가져오기
		   @RequestMapping("/myReserveDATE")
		   @ResponseBody
		   public List<ReserveVO> myReserveDATE(ReserveVO vo, Model model) {
		      
		      List<ReserveVO> rvo = reserveService.myReserveDATE(vo);
		      return rvo;
		   }	   
		   

		// [병원] 병원에서 예약 취소
		   @RequestMapping("/cancelHosReserve")
		   public String cancelHosReserve(ReserveVO vo, Model model) {
		      reserveService.cancelReserve(vo);
		      model.addAttribute("reserve", reserveService.getReserve(vo));
		      return "hosMyPage/hosMyPage";
		   }
}
