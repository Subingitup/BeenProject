package com.spring.pet.reserve.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.pet.hospital.HospitalVO;
import com.spring.pet.reserve.ReserveService;
import com.spring.pet.reserve.ReserveVO;
import com.spring.pet.users.AdminUserReserveVO;
import com.spring.pet.users.UsersVO;
import com.spring.pet.users.impl.UsersDAO;

@Service("ReserveService")
public class ReserveServiceImpl implements ReserveService {

	@Autowired
	UsersDAO usersDAO;

	@Autowired
	private ReserveDAOMybatis ReserveDAO;

	@Override
	public List<ReserveVO> adminUserReserve(UsersVO vo) {
		return usersDAO.adminUserReserve(vo);
	}

	@Override
	public List<AdminUserReserveVO> getUserZzim(UsersVO vo) {
		return usersDAO.getUserZzim(vo);
	}

	@Override
	public int adminUserReserveListCount(UsersVO vo) {
		return usersDAO.adminUserReserveListCount(vo);
	}

	// 예약 수정
	@Override
	public void updateReserve(ReserveVO vo) {
		ReserveDAO.updateReserve(vo);
	};

	// 예약 페이지(병원정보 가져오기)
	@Override
	public HospitalVO reservation_page(HospitalVO hvo) {
		return ReserveDAO.reservation_page(hvo);
	};

	// 예약 취소
	@Override
	public void updateReserve_rcc(ReserveVO vo) {
		ReserveDAO.updateReserve_rcc(vo);
	};

	// 예약 상세보기 조회
	@Override
	public ReserveVO getReserve(ReserveVO vo) {
		return ReserveDAO.getReserve(vo);
	};

	// 예약 전체목록 조회
	@Override
	public List<ReserveVO> getReserveList(ReserveVO vo) {
		return ReserveDAO.getReserveList(vo);
	};

	// [회원] 나의 예약목록 가져오기
	@Override
	public List<ReserveVO> myReserveList(ReserveVO vo) {
		return ReserveDAO.myReserveList(vo);
	}

	// [회원] 나의 예약 취소하기
	@Override
	public void cancelReserve(ReserveVO vo) {
		ReserveDAO.cancelReserve(vo);
	};

	// 예약하기
	@Override
	public int insertReserve(ReserveVO vo) {
		return ReserveDAO.insertReserve(vo);
	}
	// [회원] 나의 예약목록 필터
	@Override
	public List<ReserveVO> reserveFilter(ReserveVO vo) {
		return ReserveDAO.reserveFilter(vo);
	}
	
	@Override
	public List<ReserveVO> getResList(ReserveVO vo) {
		// TODO Auto-generated method stub
		return ReserveDAO.getResList(vo);
	}

	// 예약횟수로 베스트 병원 가져오기 (인덱스용)
	   @Override
	   public List<ReserveVO> getBestHospital(ReserveVO vo) {
	      return ReserveDAO.getBestHospital(vo);
	   }
	
	// 20230519 - 관리자 메인페이지 최근 병원 예약 현황
		public List<ReserveVO> adminRecentReserveHospital() {
			return ReserveDAO.adminRecentReserveHospital();
		}
		@Override
		   public List<ReserveVO> myReserveDATE(ReserveVO vo) {
		      return ReserveDAO.myReserveDATE(vo);
		   } 
		@Override
		   public ReserveVO myReserveDOne(ReserveVO vo) {
		      return ReserveDAO.myReserveDOne(vo);
		   }

}
