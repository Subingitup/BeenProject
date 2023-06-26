package com.springbook.view.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.pet.commons.PageInfo;
import com.spring.pet.date.DateVO;
import com.spring.pet.hospital.CategoryVO;
import com.spring.pet.hospital.HospitalService;
import com.spring.pet.hospital.HospitalVO;
import com.spring.pet.reserve.ReserveService;
import com.spring.pet.reserve.ReserveVO;
import com.spring.pet.review.ReviewService;
import com.spring.pet.users.UsersService;
import com.spring.pet.users.UsersVO;

@Controller
public class AdminUserController {

   @Autowired
   private UsersService userService; // user.impl에 있는 UserServiceImpl
   @Autowired
   private ReserveService reserveService; // reserve.impl에 있는 ReserveImpl
   @Autowired
   private ReviewService reviewService; // review.impl에 있는 ReviewImpl
   @Autowired
   private HospitalService hospitalService;
   
   
   @ModelAttribute("searchMap") // 검색창 관련 맵
   public Map<String, String> searchMap() {
      Map<String, String> searchMap = new HashMap<String, String>();
      searchMap.put("아이디", "ID");
      searchMap.put("이름", "NAME");
      searchMap.put("연락처", "TEL");
      return searchMap;
   }

   @ModelAttribute("search_role_Map") // 회원 등급 검색창 관련 맵 (※2차 통합 후 수정)  
   public Map<String, String> searchRoleMap() {
      Map<String, String> search_role_Map = new HashMap<String, String>();
      search_role_Map.put("SUPERADMIN", "SUPERADMIN");
      search_role_Map.put("ADMIN", "ADMIN");
      search_role_Map.put("USER", "USER");
      return search_role_Map;
   }

   @ModelAttribute("search_reserve_Map") // 회원 등급 검색창 관련 맵
   public Map<String, String> searchReserveMap() {
      Map<String, String> search_reserve_Map = new HashMap<String, String>();
      search_reserve_Map.put("예약일", "RES_DATE");
      search_reserve_Map.put("결제일", "RES_CASHDATE");
      return search_reserve_Map;
   }
   
   @ModelAttribute("email_Domain_Map") // 이메일 도메인 맵
   public Map<String, String> emailDomainMap() {
      Map<String, String> email_Domain_Map = new HashMap<String, String>();
      email_Domain_Map.put("@naver.com", "@naver.com");
      email_Domain_Map.put("@daum.net", "@daum.net");
      email_Domain_Map.put("@gmail.com", "@gmail.com");
      email_Domain_Map.put("@hanmail.net", "@hanmail.net");
      email_Domain_Map.put("@nate.com", "@nate.com");
      email_Domain_Map.put("@kakao.com", "@kakao.com");
      email_Domain_Map.put("@yahoo.com", "@yahoo.com");
      return email_Domain_Map;
   }

   
// [관리자] 회원 리스트 정보가져오기
   @RequestMapping("/getUserList")
   public String getUserList(@ModelAttribute("user") UsersVO vo, Model model,
         @ModelAttribute("paging") PageInfo pageInfo) {
      return "admin_user/admin_UserList";
   }
   
   
   // [관리자] 회원 리스트 정보가져오기
   @RequestMapping("/getUserListInfo")
   public String getUserListInfo(@ModelAttribute("user") UsersVO vo, Model model,
         @ModelAttribute("paging") PageInfo pageInfo) {

      int listCount = userService.userListCount(vo); // 글 목록의 수 가져옴
      pageInfo.setPageListCount(listCount);
      pageInfo = paging(pageInfo);
      vo.setStart(pageInfo.getStart());
      model.addAttribute("userList", userService.getUserList(vo));
      return "admin_user/admin_UserListInfo";
   }

   // [관리자] 회원 상세 페이지 이동(※2차 통합 후 수정) - 기존 메소드 수정이라 이거 복사해서 해당 메소드 덮어써주세요 Mapping 변경)
   @RequestMapping("/getUserPage")
   public String userDtailPage(UsersVO vo, Model model) {
         model.addAttribute("userDtailId", vo.getUsers_id());
         return "admin_user/admin_GetUser";
      }

   // [관리자] 회원 상세 데이터 불러오기(※2차 통합 후 수정) - 추가된거라 얘만 복사해서 추가)
   @RequestMapping("/getUser")
   public String userDtail(UsersVO vo, Model model) {
         model.addAttribute("userDtailId", vo.getUsers_id());
         model.addAttribute("userDtail", userService.getUserDetail(vo));
         model.addAttribute("userDetailReserveThree", userService.getAdminUserDetailThree(vo));
         model.addAttribute("userDetailReserveListCount", reserveService.adminUserReserveListCount(vo));
         model.addAttribute("usersDetailReserveCancelCount",userService.adminUserReserveCancelListCount(vo));
         return "admin_user/admin_GetUserInfo";
      }


   // [관리자] 회원 수정 폼으로 이동
   @RequestMapping("/modiFormUser")
   public String userModi(@ModelAttribute("userDtail") UsersVO vo, Model model) {
      model.addAttribute("userDtailId", vo.getUsers_id());
      model.addAttribute("userDtail", userService.getUserDetail(vo));
      return "admin_user/admin_UserModifyForm";
   }

   // [관리자] 회원 수정 적용 update
   @RequestMapping("/updateUser")
   public String userUpdate(@ModelAttribute("userDtail") UsersVO vo) {
      if (userService.userUpdate(vo) > 0) {
         return "redirect:adminUpdateResult?modiresult=1&users_id=" + vo.getUsers_id();
      } else {
         return "redirect:adminUpdateResult?modiresult=0&users_id=" + vo.getUsers_id();
      }

   }

   // [관리자] 수정 성공 시 얼럿띄우는 메소드 (※2차 통합 후 수정)  
   @ResponseBody
   @RequestMapping(value="/adminUpdateResult")
   public void adminUpdateSuccess(HttpServletRequest request,HttpServletResponse response) throws IOException {
      String modiresult = request.getParameter("modiresult");
      String users_id = request.getParameter("users_id");
      
        if(modiresult.equals("1")) {
           init(response);
        PrintWriter out = response.getWriter();
        out.println(String.format("<script>alert('수정을 완료했습니다.');location.href='getUserPage?users_id=" + users_id + "';</script>"));
        out.flush();
        }else{
           init(response);
        PrintWriter out = response.getWriter();
        out.println(String.format("<script>alert('수정에 실패했습니다.');location.href='modiFormUser?users_id=" + users_id + "';</script>"));
        out.flush();
        }

   }
   
   
   public static void init(HttpServletResponse response) {
        response.setContentType("text/html; charset=utf-8");
        response.setCharacterEncoding("utf-8");
    }

   // [관리자] 회원 찜 목록 보기
//   @ResponseBody << 얘 있으면 저거 스트링을 값으로 해야함 ,,,
   @RequestMapping("/userZzim")
   public String userZzim(UsersVO vo, Model model) {

      model.addAttribute("userDtailId", vo.getUsers_id());
      UsersVO zzim_user = userService.getUserDetail(vo);// 해당 회원의 찜목록 포함한 한줄 데이터 받아오기
      model.addAttribute("userZzim", reserveService.getUserZzim(zzim_user));// 받아온 찜목록으로 데이터 받아오기
      return "admin_user/admin_UserZzim";
   }

   // [관리자] 특정 회원 예약 내역 보기
   @RequestMapping("/adminUserReserve")
   public String adminUserReserve(@ModelAttribute("adminUserVO") UsersVO vo, Model model,
         @ModelAttribute("paging") PageInfo pageInfo) {
      
      int adminUserReserveListCount = reserveService.adminUserReserveListCount(vo); // 글 목록의 수 가져옴
      pageInfo.setPageListCount(adminUserReserveListCount);
      pageInfo = pagingMini(pageInfo);//(※2차 통합 후 수정)
      vo.setStart(pageInfo.getStart());
      model.addAttribute("adminUserReserve", reserveService.adminUserReserve(vo));
      model.addAttribute("userDtailId", vo.getUsers_id());
      return "admin_user/admin_UserReserve";
   }

   // [관리자] 특정 회원 리뷰 작성 내역
   @RequestMapping("/adminUserReview")
   public String adminUserReview(@ModelAttribute("adminReviewVO") UsersVO vo, Model model,
         @ModelAttribute("paging") PageInfo pageInfo) {

      int adminUserReviewListCount = reviewService.adminUserReviewListCount(vo); // 글 목록의 수 가져옴
      pageInfo.setPageListCount(adminUserReviewListCount);
      pageInfo = pagingMini(pageInfo);//(※2차 통합 후 수정)
      vo.setStart(pageInfo.getStart());

      model.addAttribute("adminUserReview", reviewService.adminUserReview(vo));
      model.addAttribute("userDtailId", vo.getUsers_id());
      return "admin_user/admin_UserReview";
   }

   // 페이징 메소드
   public PageInfo paging(PageInfo pageInfo) {
      int listCount = pageInfo.getPageListCount(); // 받아온 리스트 카운트 얻어옴

      int totalPage = listCount / 10; // 임의의 totalPage 변수 생성
      if (listCount % 10 != 0) {
         totalPage++;
      }
      pageInfo.setTotalPage(totalPage); // 정해진 totalPage 수 대입

      int pageNUM = pageInfo.getPageNUM(); // pageNUM값 받아옴
      if (pageNUM == 0) {
         pageNUM = 1;
      }

      pageInfo.setPageNUM(pageNUM);// 이거 해야 처어어어음 로딩 했을 때 페이징 버튼 css 제대로 됨..

      int start = pageNUM - 1;// 임의의 start 변수 생성
      if (start > 0) {
         start = 10 * start;
         pageInfo.setStart(start);
      } else {
         pageInfo.setStart(start); // start 변수 만들어야겠지 ? ?
      }

      if (totalPage <= 10) {
         pageInfo.setStartNUM(1);
         pageInfo.setEndNUM(totalPage);
      } else {
         int p = pageNUM / 10;

         if ((pageNUM % 10) == 0) {
            p = p - 1;
            pageInfo.setStartNUM((p * 10) + 1);
            pageInfo.setEndNUM((p + 1) * 10);
         } else {
            pageInfo.setStartNUM((p * 10) + 1);
            pageInfo.setEndNUM((p + 1) * 10);
         }

         if (pageInfo.getEndNUM() > totalPage) {
            pageInfo.setEndNUM(totalPage);
         }
      }

      return pageInfo;

   }
   
   // 페이징 메소드 (리뷰, 예약 페이지용 5(페이지에 가져올 글 수), 10 기준)(※2차 통합 후 수정)
      public PageInfo pagingMini(PageInfo pageInfo) {
         int listCount = pageInfo.getPageListCount(); // 받아온 리스트 카운트 얻어옴

         int totalPage = listCount / 5; // 임의의 totalPage 변수 생성
         if (listCount % 5 != 0) {
            totalPage++;
         }
         pageInfo.setTotalPage(totalPage); // 정해진 totalPage 수 대입

         int pageNUM = pageInfo.getPageNUM(); // pageNUM값 받아옴
         if (pageNUM == 0) {
            pageNUM = 1;
         }

         pageInfo.setPageNUM(pageNUM);// 이거 해야 처어어어음 로딩 했을 때 페이징 버튼 css 제대로 됨..

         int start = pageNUM - 1;// 임의의 start 변수 생성
         if (start > 0) {
            start = 5 * start;
            pageInfo.setStart(start);
         } else {
            pageInfo.setStart(start); // start 변수 만들어야겠지 ? ?
         }

         if (totalPage <= 5) {
            pageInfo.setStartNUM(1);
            pageInfo.setEndNUM(totalPage);
         } else {
            int p = pageNUM / 5;

            if ((pageNUM % 5) == 0) {
               p = p - 1;
               pageInfo.setStartNUM((p * 5) + 1);
               pageInfo.setEndNUM((p + 1) * 5);
            } else {
               pageInfo.setStartNUM((p * 5) + 1);
               pageInfo.setEndNUM((p + 1) * 5);
            }

            if (pageInfo.getEndNUM() > totalPage) {
               pageInfo.setEndNUM(totalPage);
            }
         }

         return pageInfo;

      }
      

      //[관리자] 로그인 페이지로 이동(※0516)(※0517-2)
      @RequestMapping(value="/adminLogin", method = RequestMethod.GET)
      public String adminLoginPage(HttpSession session){
    	  String adminUserId =(String)session.getAttribute("users_id");
    	  String adminRole =(String)session.getAttribute("users_role");
    	  
    	  if((adminUserId!=null)&&!(adminRole.equals("USER"))){
    		  return "redirect:adminMain"; 
    	  }else {
    		  return "admin_user/admin_Login";
    	  }
      }
      
    //[관리자] 로그인하기(※0516)
  	@RequestMapping(value="/adminLogin", method = RequestMethod.POST)
     public String adminLogin(UsersVO vo, HttpSession session) {
  	String user_pw = vo.getUsers_pw();
  	UsersVO userInfo = userService.getUserInfo(vo);
  	if (userInfo != null) {
  		if (userService.pwMatchChk(user_pw, userInfo.getUsers_pw())) {
  			String adminCheckRole =  userInfo.getUsers_role();
  			if(!(adminCheckRole.equals("USER"))) {
  				session.setAttribute("users_role", userInfo.getUsers_role());
  				session.setAttribute("users_id", userInfo.getUsers_id());
  				session.setAttribute("users_name", userInfo.getUsers_name());
  				return "redirect:adminMain";
  			}
  		}
  	}
  	return "admin_user/admin_Login.jsp?adminError=1";
  }
    // 사이드바에 로고이미지 누르면 관리자페이지로 이동
    @RequestMapping(value="/sideLogomove",method = RequestMethod.GET)
    public String sideLogomove() {
   return "admin_user/admin_main";
    } 
    
 // 20230519 - 관리자 메인페이지(추가 시작)
 	@RequestMapping("/adminMain")
 	public String adminMain(Model model) {
 		List<HospitalVO> adminMainRecentJoinHospitalList = hospitalService.adminMainRecentJoinHospital();
 		List<ReserveVO> adminRecentReserveHospitalList = reserveService.adminRecentReserveHospital();
 		model.addAttribute("adminMainRecentJoinHospitalList", adminMainRecentJoinHospitalList);
 		model.addAttribute("adminRecentReserveHospitalList", adminRecentReserveHospitalList);

 		return "/admin_user/admin_main";
 	}
    
    
 // 20230519 - 관리자 메인페이지 (추가 시작)
 	@RequestMapping("/currentDayInfo")
 	@ResponseBody
 	public Object currentDayInfo(DateVO vo) {
 		DateVO intoCurrentMonth = hospitalService.intoCurrentMonth(vo.getToday());
 		DateVO allJoinHosCnt = hospitalService.weeksum(intoCurrentMonth);
 		List<DateVO> reserveWeeksum = hospitalService.reserveWeeksum(intoCurrentMonth);

 		Map<String, Object> map = new HashMap<String, Object>();
 		map.put("allJoinHosCnt", allJoinHosCnt);
 		map.put("dateInfo", intoCurrentMonth);
 		map.put("reserveWeeksum", reserveWeeksum);
 		return map;
 	}
    
  
 // 20230611 - 관리자메인 카테고리로 조회 >> 차트 및 데이타용
  	@RequestMapping("/hosChartCate")
  	@ResponseBody
  	public Object hosChartCate(CategoryVO vo) {
  		// 등록된 병원의 전체 수(삭제되지 않은 병원)와 카테고리 키워드별로 등록된 병원 개수를 가져옴(카테고리 중복선택가능이라 전체수보다 카테고리수가 많음)
  		CategoryVO catevo = hospitalService.hosChartCate(vo);
  		Map<String, Object> map = new HashMap<String, Object>();
  		map.put("catevo", catevo);
  		return map;
  	}
}