package com.spring.pet.users;

import java.util.List;

import com.spring.pet.reserve.ReserveVO;

public interface UsersService {

//관리자용	
	List<UsersVO> getUserList(UsersVO vo);

	int userListCount(UsersVO vo);

	UsersVO getUserDetail(UsersVO vo);

	int userUpdate(UsersVO vo);
	
	//(※2차 통합 후 수정)
		List<ReserveVO> getAdminUserDetailThree(UsersVO vo);
		int adminUserReserveCancelListCount(UsersVO vo);

//로그인, 회원가입	
	   UsersVO loginKakao(KakaoUser kakaoUser);
	   
	   UsersVO getId(UsersVO vo);

	   UsersVO checkDupPhone(UsersVO vo);

	   UsersVO checkDupEmail(UsersVO vo);

	   void insertUser(UsersVO vo);

	   UsersVO getUsers(UsersVO vo);

	   UsersVO getUserInfo(UsersVO vo);
	   
	   String hashedChk(String password);
	   
	   boolean pwMatchChk(String chkPassword, String password);


//일반회원 이메일 업데이트
	int updateInfo(UsersVO vo);
	
	int updateInfoPassword(UsersVO vo);

//일반회원 탈퇴
	int deleteUser(UsersVO vo);

	// [유저] 나의 활동 페이지용
	List<UsersVO> getUsersHos(UsersVO vo);

	List<UsersVO> getZzimHosName(UsersVO vo);

	void delUsersZzim(UsersVO vo);

	void pickHos1(UsersVO vo);
	void pickHos2(UsersVO vo);
	void pickHos3(UsersVO vo);
	void pickHos4(UsersVO vo);
	void pickHos5(UsersVO vo);

	UsersVO zzimCnt(UsersVO vo);
	
	UsersVO checkDupPhone1(UsersVO vo);
	
	// 회원 이메일 수정
	void updateUsersEmail(UsersVO vo);
	
	// 회원 연락처 수정
	void updateUsersPhone(UsersVO vo);
	
	UsersVO hosZzim(UsersVO vo);
	
	int hosZzimInsert(UsersVO vo);
	
	void delZzim(UsersVO vo);
}
