package com.spring.pet.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.lang.Nullable;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class Interceptor implements HandlerInterceptor {

	
	static final String[] LOGIN_URL_LIST = {"/tomypagemain","/getMyReviewPostList", "/getMyReview", "/getReserveForReview", 
			"/updateInfo", "/getUsers","/update","/myActionReserve","/myActionZzim",
			"/insertPets","/mypets","/updatePetsInfo","/mypetInfo", "/mypetlist", "/deletePetsInfo",
			}; // 로그인 필요한 URL패턴 
	
	static final String[] HOS_LOGIN_URL_LIST = {"/toHosMyPage","/docList","/toHosUpdate","/toHosReview","/toDelHos"};
	//병원 로그인 필요
	
	
	
	static final String[] ADMIN_ROLE_URL_LIST = {"/getUserList","/getUserPage","/getUser","/modiFormUser","/updateUser",
			"/userZzim","/adminUserReserve","/adminUserReview",
			"/toAdmin_NoticeMain","/getReserveList","/getAllReserve","/updateReserve_rcc","/getReportList","/getReport","/updateReport_delete","/updateReport_reject",
			"/requestHospital","/requestHospitalList"
			}; //관리자 권한 필요한 URL패턴

	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
		
        
		HttpSession session = request.getSession();
		String path = request.getServletPath(); // urI에서 경로(context제외한 나머지)만 가져오기 (Path만 가져옴)
		
//		

		// 아이디, 등급 가져옴
		String userId = (String)session.getAttribute("users_id"); // 세션 아이디값
		String userRole = (String)session.getAttribute("users_role"); //세션 회원등급 
		String hosId = (String)session.getAttribute("hos_id");
		String hosRole = (String)session.getAttribute("hos_role");
		
		for(String target : LOGIN_URL_LIST) {//로그인 필요한거
			if(path.equals(target)) {
				if(userId == null || userId.trim().equals("")) {//로그인 안됐을때
					session.invalidate();
					response.sendRedirect(request.getContextPath() + "login.jsp?loginError=1");
					return false;
				}
			}
		}		
		
		
		for(String target : HOS_LOGIN_URL_LIST) {//병원 로그인 필요
			if(path.equals(target)) {
				if(hosId == null || hosId.trim().equals("") || hosRole.equals("N")) {//로그인 안됐고 병원 회원(승인되어야함)이어야함
					session.invalidate();
					response.sendRedirect(request.getContextPath() + "hoslogin.jsp?loginError=1");//이 페이지 선찬님이 추가할것임
					return false;
				}
			}
		}
		
		
		for(String target : ADMIN_ROLE_URL_LIST) {//관리자 권한 필요함 
			if(path.equals(target)) {
				if(userId == null || userRole == null || userRole.trim().equals("")||userRole.equals("USER")){ //권한이 ADMIN이나 SUPERADMIN이 아닐 때
					response.sendRedirect(request.getContextPath() + "index.jsp?roleError=1"); //메인으로 보냄 
					return false;
				}
			}
		}	
//		
		
		

//		preHandled의 return은 컨트롤러 요청 uri로 가도 되냐 안되냐를 허가하는 의미임
//		따라서 true로 하면 컨트롤러 uri로 가게 됨.
		
		return true; //통과
			
	}
	
//	컨트롤러가 수행되고 화면이 보여지기 직전에 수행되는 메서드
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			@Nullable ModelAndView modelAndView) throws Exception {
	}

	
	
}
