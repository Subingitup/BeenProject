package com.spring.pet.hospital.impl;

import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.pet.date.DateVO;
import com.spring.pet.hospital.CategoryVO;
import com.spring.pet.hospital.HospitalService;
import com.spring.pet.hospital.HospitalVO;

@Service
public class HospitalServiceImpl implements HospitalService {

	@Autowired
	private HospitalDAO hospitalDAO;

	@Override
	public List<HospitalVO> getHospitalList(HospitalVO vo) {
		return hospitalDAO.getHospitalList(vo);
	}

	@Override
	public HospitalVO getHos(HospitalVO vo) {
		return hospitalDAO.getHos(vo);
	}


	// 병원등록
	@Override
	public void insertHospital(HospitalVO hosvo) {
		hospitalDAO.insertHospital(hosvo);
	}

	// 병원수정
	@Override
	public void updateHospital(HospitalVO hosvo) {
		hospitalDAO.updateHospital(hosvo);
	}

	// 병원 정보 1차삭제
	@Override
	public void deletewaitingHospital(HospitalVO hosvo) {
		hospitalDAO.deletewaitingHospital(hosvo);
	}

	// 병원 정보완전삭제
	@Override
	public void deleteHospital(HospitalVO hosvo) {
		hospitalDAO.deleteHospital(hosvo);
	}

	// 병원 보기
	@Override
	public HospitalVO getHospital(HospitalVO hosvo) {
		return hospitalDAO.getHospital(hosvo);
	}

	@Override
	public List<HospitalVO> searchHospitalList(HospitalVO vo) {
		return hospitalDAO.searchHospitalList(vo);

	}

	@Override
	public List<HospitalVO> getHosList(HospitalVO vo) {
		// TODO Auto-generated method stub
		return hospitalDAO.getHosList(vo);
	}


	// 관리자의 요청된 병원승인
	@Override
	public void checkHospital(HospitalVO hosvo) {
		hospitalDAO.checkHospital(hosvo);
	}

	@Override
	public HospitalVO getHosInfo(HospitalVO vo) {
		return hospitalDAO.getHosInfo(vo);
	}

	// 승인요청한 병원목록
	@Override
	public List<HospitalVO> requestHospitalList(HospitalVO hosvo) {
		return hospitalDAO.requestHospitalList(hosvo);
	}

	// 승인요청한 병원 상세
	@Override
	public HospitalVO requestHospital(HospitalVO hosvo) {
		return hospitalDAO.requestHospital(hosvo);
	}


	//병원로그인
	// 암호화
    public String hashedChk(String password) {
       return hospitalDAO.hashedChk(password);
    }

    // 암호화
    public boolean pwMatchChk(String chkPassword, String password) {
       return hospitalDAO.pwMatchChk(chkPassword, password);
    }
    @Override
    public HospitalVO gethosInfo1(HospitalVO vo) {
       return hospitalDAO.gethosInfo1(vo);
    }

	@Override
	public List<HospitalVO> getHosListUser(HospitalVO vo) {
		return hospitalDAO.getHosListUser(vo);
	}
	 // 별점높은 병원 가져오기
	@Override
	public List<HospitalVO> revHighStar(HospitalVO vo) {
		return hospitalDAO.revHighStar(vo);
	}
	 // 승인된 병원 전체목록 가져오기			 
	@Override
	public List<HospitalVO> ListHosUser(HospitalVO vo) {
		// TODO Auto-generated method stub
		return  hospitalDAO.ListHosUser(vo);
	}
	 // 리뷰많은 병원 가져오기
	@Override
	public List<HospitalVO> getManyRevHos(HospitalVO vo) {
		return hospitalDAO.getManyRevHos(vo);
	}
	
	@Override
	public HospitalVO checkDupPhone(HospitalVO vo) {
		return hospitalDAO.checkDupPhone(vo);
	}
	
	
	@Override
	public List<HospitalVO> getAllLocations(HospitalVO vo) {
		// TODO Auto-generated method stub
		return hospitalDAO.getAllLocations(vo);
	}
	
	// 20230519 - 관리자 메인 최신 병원 가입 현황
		public List<HospitalVO> adminMainRecentJoinHospital() {
			return hospitalDAO.adminMainRecentJoinHospital();
		}

		// 20230519 - 관리자 메인 병원 가입 현황(당 월 정보 가져오기)
		public DateVO intoCurrentMonth(String vo) {
			return hospitalDAO.intoCurrentMonth(vo);
		}

		// 20230519 - 관리자 메인 병원 가입 현황(당 월 가입 개수 정보 가져오기)
		public DateVO weeksum(DateVO vo) {
			return hospitalDAO.weeksum(vo);
		}

		// 20230519 - 관리자 메인 병원 가입 현황(당 월 예약 개수 정보 가져오기)
		public List<DateVO> reserveWeeksum(DateVO vo) {
			return hospitalDAO.reserveWeeksum(vo);
		}
		@Override
		public HospitalVO checkDupPhone1(HospitalVO vo) {
			return hospitalDAO.checkDupPhone1(vo);
		}

		// 병원 삭제되면 전체유저의 찜목록에서도 값을 null로 변경해준다
		@Override
		public void delHosZzim(HospitalVO hosvo) {
			hospitalDAO.delHosZzim(hosvo);
		}	

//병원 승인요청목록 리스트 갯수 가져오기 수빈유지보수
public int requestHospitalListCount(HospitalVO hosvo) {
	return hospitalDAO.requestHospitalListCount(hosvo);
}

//병원 전체&검색목록 갯수 가져오기 수빈유지보수
public int adminHosListCount(HospitalVO hosvo) {
	return hospitalDAO.adminHosListCount(hosvo);
}

//수빈유지보수(병원이미지 이름 가져오기)
public HospitalVO adminHosPic(HospitalVO hosvo) {
	return hospitalDAO.adminHosPic(hosvo);
}
//관리자 메인 전체병원 카테고리별 등록 현황
public CategoryVO hosChartCate(CategoryVO vo) {
	return hospitalDAO.hosChartCate(vo);
};

@Override
public HospitalVO getId(HospitalVO vo) {
	return hospitalDAO.getId(vo);
}

@Override
	public HospitalVO checkDupEmail(HospitalVO vo) {
		return hospitalDAO.checkDupEmail(vo);
}


@Override
public int delHos(HospitalVO vo) {
	return hospitalDAO.delHos(vo);
}

@Override
public boolean pwMatchChk1(String chkPassword, String savedPassword) {
    return hospitalDAO.pwMatchChk1(chkPassword, savedPassword);
}


@Override
public HospitalVO checkDupEmail1(HospitalVO vo) {
	return hospitalDAO.checkDupEmail1(vo);
}

//베스트 병원 목록으로 가져오기
	public List<HospitalVO> getBestHosList(HospitalVO vo){
		return hospitalDAO.getBestHosList(vo);
	}
}
