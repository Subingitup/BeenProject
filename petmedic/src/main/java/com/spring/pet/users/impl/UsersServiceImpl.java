package com.spring.pet.users.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.pet.reserve.ReserveVO;
import com.spring.pet.users.KakaoUser;
import com.spring.pet.users.UsersService;
import com.spring.pet.users.UsersVO;

@Service("usersService")
public class UsersServiceImpl implements UsersService {

	@Autowired
	private UsersDAO usersDAO;

	// 로그인
	@Override
	public UsersVO getUsers(UsersVO vo) {
		return usersDAO.getUsers(vo);
	}

	// 아이디 중복체크
	@Override
	public UsersVO getId(UsersVO vo) {
		return usersDAO.getId(vo);
	}

	// 내정보조회
	@Override
	public UsersVO getUserInfo(UsersVO vo) {
		return usersDAO.getUserInfo(vo);
	}

	// 내정보 업데이트
	@Override
	public int updateInfo(UsersVO vo) {
		return usersDAO.updateInfo(vo);
	}

	// 탈퇴
	public int deleteUser(UsersVO vo) {
		return usersDAO.deleteUser(vo);
	}

	@Override
	public List<UsersVO> getUserList(UsersVO vo) {
		return usersDAO.getUserList(vo);
	};

	@Override
	public int userListCount(UsersVO vo) {
		return usersDAO.userListCount(vo);
	}

	@Override
	public UsersVO getUserDetail(UsersVO vo) {
		UsersVO test = usersDAO.getUserDtail(vo);
		return test;
	}

	@Override
	public int userUpdate(UsersVO vo) {
		return usersDAO.userUpdate(vo);
	}

	@Override
	public void insertUser(UsersVO vo) {
		usersDAO.insertUser(vo);
	}

	@Override
	public List<UsersVO> getUsersHos(UsersVO vo) {
		return usersDAO.getUsersHos(vo);
	}

	@Override
	public List<UsersVO> getZzimHosName(UsersVO vo) {
		return usersDAO.getZzimHosName(vo);
	}

	@Override
	public void delUsersZzim(UsersVO vo) {
		usersDAO.delUsersZzim(vo);
	}

	@Override
	public void pickHos1(UsersVO vo) {
		usersDAO.userPick1(vo);
	}
	@Override
	public void pickHos2(UsersVO vo) {
		usersDAO.userPick2(vo);
	}
	@Override
	public void pickHos3(UsersVO vo) {
		usersDAO.userPick3(vo);
	}
	@Override
	public void pickHos4(UsersVO vo) {
		usersDAO.userPick4(vo);
	}
	@Override
	public void pickHos5(UsersVO vo) {
		usersDAO.userPick5(vo);
	}

	@Override
	public UsersVO loginKakao(KakaoUser kakaoUser) {
		// 사용자가 있는지 확인
		String[] email = kakaoUser.getEmail().split("@");
		UsersVO user = new UsersVO();
		user.setUsers_email(email[0]);
		user.setUsers_email2("@" + email[1]);
		UsersVO userInfoByEmail = usersDAO.getUserInfoByEmail(user);
		if (userInfoByEmail == null) {
			// 로그인한 사용자가 DB에 없을경우 DB에 insert - 카카오톡 로그인을 통한 회원가입이라고 테이블에 명시하면 좋을듯합니다.
			// 추가로 패스워드나 주소정보가 없기때문에 db column에 not null 옵션을 빼줘야 정상동작합니다.
			// password, addr 주소등 ..
			// id는 email로 입력
			user.setUsers_id(kakaoUser.getEmail());
			user.setUsers_name(kakaoUser.getNickname());
			user.setUsers_email(email[0]);
			user.setUsers_email2("@" + email[1]);
			user.setUsers_role("user");
			// 연락처 정보는 카카오 api 설정에 추가한후에 KakaoServer.getUserInfo 에서 받아와 저장하게끔 변경하면 됩니다.
			user.setUsers_tel(kakaoUser.getPhone());
			usersDAO.insertUser(user);
			return user;
		}
		return userInfoByEmail;
	}

	@Override
	public int updateInfoPassword(UsersVO vo) {
		return usersDAO.updateInfoPassword(vo);
	}

	@Override
	public UsersVO checkDupPhone(UsersVO vo) {
		return usersDAO.checkDupPhone(vo);
	}

	@Override
	public UsersVO checkDupEmail(UsersVO vo) {
		return usersDAO.checkDupEmail(vo);
	}

	// 암호화
	public String hashedChk(String password) {
		return usersDAO.hashedChk(password);
	}

	// 암호화
	public boolean pwMatchChk(String chkPassword, String password) {
		return usersDAO.pwMatchChk(chkPassword, password);
	}

	// [관리자] 회원상세때 가져올 최근예약 (※2차 통합 후 수정)
	public List<ReserveVO> getAdminUserDetailThree(UsersVO vo) {
		return usersDAO.getAdminUserDetailThree(vo);
	}

	// [관리자] 회원상세때 가져올 취소 예약 수 (※2차 통합 후 수정)
	public int adminUserReserveCancelListCount(UsersVO vo) {
		return usersDAO.adminUserReserveCancelListCount(vo);
	}

	// [회원] 찜 컬럼에서 null이 아닌 컬럼개수가져오기
	@Override
	public UsersVO zzimCnt(UsersVO vo){
		return usersDAO.zzimCnt(vo);
	}
	
	@Override
	public UsersVO checkDupPhone1(UsersVO vo) {
		return usersDAO.checkDupPhone1(vo);
	}
	
	// 회원 이메일 수정
	@Override
	public void updateUsersEmail(UsersVO vo) {
		usersDAO.updateUsersEmail(vo);
	}

	// 회원 연락처 수정
	@Override
	public void updateUsersPhone(UsersVO vo) {
		usersDAO.updateUsersPhone(vo);
	}
	
	@Override
	public UsersVO hosZzim(UsersVO vo) {
		return usersDAO.hosZzim(vo);
	}
	
	@Override
	public int hosZzimInsert(UsersVO vo) {
		return usersDAO.hosZzimInsert(vo);
	}
	
	@Override
	public void delZzim(UsersVO vo) {
		usersDAO.delZzim(vo);
	}
}
