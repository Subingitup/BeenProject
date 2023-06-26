package com.spring.pet.reserve;

import java.util.List;

import com.spring.pet.hospital.HospitalVO;
import com.spring.pet.users.AdminUserReserveVO;
import com.spring.pet.users.UsersVO;

public interface ReserveService {

	List<ReserveVO> adminUserReserve(UsersVO vo);

	List<AdminUserReserveVO> getUserZzim(UsersVO vo);

	int adminUserReserveListCount(UsersVO vo);

	// 예약 수정
	void updateReserve(ReserveVO vo);

	// 예약페이지(병원정보 가져오기)
	HospitalVO reservation_page(HospitalVO hvo);

	// 예약 취소
	void updateReserve_rcc(ReserveVO vo);

	// 예약 상세보기 조회
	ReserveVO getReserve(ReserveVO vo);

	// 예약 전체목록 조회
	List<ReserveVO> getReserveList(ReserveVO vo);

	// [회원] 나의 예약목록 가져오기
	List<ReserveVO> myReserveList(ReserveVO vo);

	// [회원] 나의 예약 취소하기
	void cancelReserve(ReserveVO vo);

	// 예약하기
	int insertReserve(ReserveVO vo);
	
	// [회원] 나의 예약목록 필터
		List<ReserveVO> reserveFilter(ReserveVO vo);
	
		//
	List<ReserveVO> getResList(ReserveVO vo);
	
	// 예약횟수로 베스트 병원 가져오기 (인덱스용)
	   List<ReserveVO> getBestHospital(ReserveVO vo); 
	   
	// 20230519 - 관리자 메인페이지 최근 병원 예약 현황
		public List<ReserveVO> adminRecentReserveHospital();
		
		
	List<ReserveVO> myReserveDATE(ReserveVO vo);
	
	ReserveVO myReserveDOne(ReserveVO vo);
}
