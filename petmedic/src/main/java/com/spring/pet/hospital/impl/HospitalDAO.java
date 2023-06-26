package com.spring.pet.hospital.impl;

import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.pet.date.DateVO;
import com.spring.pet.hospital.CategoryVO;
import com.spring.pet.hospital.HospitalVO;

@Repository
public class HospitalDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	// 병원목록조회
	public List<HospitalVO> getHospitalList(HospitalVO vo) {
		return mybatis.selectList("hospitalDAO.getHospitalList", vo);
	}

	// 병원검색
	public List<HospitalVO> searchHospitalList(HospitalVO vo) {
		return mybatis.selectList("hospitalDAO.searchHospitalList", vo);
	}

	public HospitalVO getHos(HospitalVO vo) {
		HospitalVO asdf = (HospitalVO) mybatis.selectOne("hospitalDAO.getHos", vo);
		return asdf;
	}

	public HospitalVO getHosInfo(HospitalVO vo) {
		HospitalVO hos = (HospitalVO) mybatis.selectOne("hospitalDAO.getHosInfo", vo);
		return hos;
	}

	public List<HospitalVO> getHosList(HospitalVO vo) {
		return mybatis.selectList("hospitalDAO.getHosList", vo);

	}

	// 병원추가등록
	public void insertHospital(HospitalVO hosvo) {
		mybatis.insert("hospitalDAO.insertHospital", hosvo);

	}

	// 승인요청한 병원목록
	public List<HospitalVO> requestHospitalList(HospitalVO hosvo) {
		return mybatis.selectList("hospitalDAO.requestHospitalList", hosvo);
	}

	// 승인요청한 병원상세
	public HospitalVO requestHospital(HospitalVO hosvo) {
		return mybatis.selectOne("hospitalDAO.requestHospital", hosvo);
	}

	// 병원승인하기
	public void checkHospital(HospitalVO hosvo) {
		mybatis.update("hospitalDAO.checkHospital", hosvo);
	}

	// 병원수정
	public void updateHospital(HospitalVO hosvo) {
		mybatis.update("hospitalDAO.updateHospital", hosvo);

	}

	// 병원정보 1차삭제
	public void deletewaitingHospital(HospitalVO hosvo) {
		mybatis.update("hospitalDAO.deletewaitingHospital", hosvo);

	}

	// 병원정보 완전삭제
	public void deleteHospital(HospitalVO hosvo) {
		mybatis.delete("hospitalDAO.deleteHospital", hosvo);

	}

	// 병원 보기
	public HospitalVO getHospital(HospitalVO hosvo) {
		return (HospitalVO) mybatis.selectOne("hospitalDAO.getHospital", hosvo);

	}
	
	//병원로그인
   public HospitalVO gethosInfo1(HospitalVO vo) {
      return mybatis.selectOne("hospitalDAO.getHosInfo1", vo);
   }

   boolean pwMatchChk(String chkPassword, String password) {
      boolean chkMatch = false;

      if (chkPassword != null && password != null) {
         chkMatch = BCrypt.checkpw(chkPassword, password);
      }
      return chkMatch;
   }

   //비밀번호 암호화
   String hashedChk(String password) {

      String passwordHashed = BCrypt.hashpw(password, BCrypt.gensalt());
      boolean isValidPassword = BCrypt.checkpw(password, passwordHashed);

      if (isValidPassword) {
         return passwordHashed;
      } else {
         return null;
      }

   }

// [유저] 병원목록조회
	public List<HospitalVO> getHosListUser(HospitalVO vo) {
		return mybatis.selectList("hospitalDAO.getHosListUser", vo);
	}
	// [메인] 별점순
	public List<HospitalVO> revHighStar(HospitalVO vo) {
		return mybatis.selectList("hospitalDAO.revHighStar", vo);
	}
	// [메인] 리뷰순
	public List<HospitalVO> getManyRevHos(HospitalVO vo) {
		return mybatis.selectList("hospitalDAO.getManyRevHos", vo);
	}
	// 전체목록 가져오기		
	public List<HospitalVO> ListHosUser(HospitalVO vo) {
		return mybatis.selectList("hospitalDAO.ListHosUser", vo);
	}

	public HospitalVO checkDupPhone(HospitalVO vo) {
		return mybatis.selectOne("hospitalDAO.checkPhone", vo);
	}
   
   
   //맵검색
   public List<HospitalVO> getAllLocations(HospitalVO vo) {
        return mybatis.selectList("hospitalDAO.getAllLocations", vo);
    }

   
// 20230519 - 관리자 메인 최신 병원 가입 현황
	public List<HospitalVO> adminMainRecentJoinHospital() {
		return mybatis.selectList("hospitalDAO.adminMainRecentJoinHospital");
	}

	// 20230519 - 관리자 메인 병원 가입 현황(당 월 정보 가져오기)
	public DateVO intoCurrentMonth(String vo) {
		return mybatis.selectOne("dateDAO.intoCurrentMonth", vo);
	}

	// 20230519 - 관리자 메인 병원 가입 현황(당 월 가입 개수 정보 가져오기)
	public DateVO weeksum(DateVO vo) {
		return mybatis.selectOne("dateDAO.weeksum", vo);
	}

	// 20230519 - 관리자 메인 병원 가입 현황(당 월 예약 개수 정보 가져오기)
	public List<DateVO> reserveWeeksum(DateVO vo) {
		List<HospitalVO> cateList = mybatis.selectList("dateDAO.hosCategory");
		List<DateVO> dateList = mybatis.selectList("dateDAO.reserveWeeksum", vo);
		return dateList;
	}   	

	public HospitalVO checkDupPhone1(HospitalVO vo) {
		return mybatis.selectOne("hospitalDAO.checkPhone1", vo);
	}
	
	// 병원 삭제되면 전체유저의 찜목록에서도 값을 null로 변경해준다
	public void delHosZzim(HospitalVO hosvo) {
			mybatis.update("hospitalDAO.delHosZzim", hosvo);
	}
	
	//병원 승인요청 목록 갯수 가져오기 수빈유지보수
	public int requestHospitalListCount(HospitalVO hosvo) {
		return mybatis.selectOne("hospitalDAO.requestHospitalListCount", hosvo);
	}

	//병원 전체&검색목록 갯수 가져오기 수빈유지보수
	public int adminHosListCount(HospitalVO hosvo) {
		return mybatis.selectOne("hospitalDAO.adminHosListCount",hosvo);
	}
	
	//수빈유지보수(병원이미지 이름 가져오기)
	public HospitalVO adminHosPic(HospitalVO hosvo) {
		return mybatis.selectOne("hospitalDAO.adminHosPic",hosvo);
	}
	
	// 관리자 메인 전체병원 카테고리별 등록 현황
	public CategoryVO hosChartCate(CategoryVO vo) {
		return mybatis.selectOne("categoryDAO.hosChartCate", vo);
	}
	

public HospitalVO getId(HospitalVO vo) {
	return mybatis.selectOne("hospitalDAO.checkId", vo);
}

public HospitalVO checkDupEmail(HospitalVO vo) {
		return mybatis.selectOne("hospitalDAO.checkEmail", vo);
}

public int delHos(HospitalVO vo) {
 return mybatis.update("hospitalDAO.delHos", vo);
}

boolean pwMatchChk1(String chkPassword, String savedPassword) {
    boolean chkMatch = false;

    if (chkPassword != null && savedPassword != null) {
       chkMatch = BCrypt.checkpw(chkPassword, savedPassword);
    }
    return chkMatch;
 }

public HospitalVO checkDupEmail1(HospitalVO vo) {
	return mybatis.selectOne("hospitalDAO.checkDupEmail1", vo);
}

//베스트 병원 목록으로 가져오기
	public List<HospitalVO> getBestHosList(HospitalVO vo){
		return mybatis.selectList("hospitalDAO.getBestHosList", vo);
	}

}
