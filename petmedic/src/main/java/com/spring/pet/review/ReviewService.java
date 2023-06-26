package com.spring.pet.review;

import java.util.List;

import com.spring.pet.users.UsersVO;

public interface ReviewService {

	// CRUD 기능의 메소드 구현
	// 글 등록
	void insertReview(ReviewVO vo);

	// 글 수정
	void updateReview(ReviewVO vo);
//	 void updateReview(ReviewVO vo);

	// 글 삭제
	void deleteReview(ReviewVO vo);

	// 병원페이지 글 삭제처리(hidden)
	void updateDelReview(ReviewVO vo);

	// 글 등록을 위한 정보불러오기
	List<ReviewVO> getReserveInfo(ReviewVO vo);

	// 글 상세보기 조회
	ReviewVO getReview(ReviewVO vo);

	// 글 전체목록 조회
	List<ReviewVO> getReviewList(ReviewVO vo);

	// [관리자]유저리뷰조회
	List<ReviewVO> adminUserReview(UsersVO vo);

	// [관리자]유저리뷰목록
	int adminUserReviewListCount(UsersVO vo);

	// [관리자] 신고리뷰 반려처리
	void updateReport_reject(ReviewVO vo);

	// [관리자] 신고리뷰 삭제
	void updateReport_delete(ReviewVO vo);

	// [관리자] 신고리뷰 조회
	ReviewVO getReportReview1(ReviewVO vo);

	// [관리자] 신고리뷰글 상세보기 조회
	ReviewVO getReport(ReviewVO vo);

	// [관리자] 신고리뷰 전체목록 조회
	List<ReviewVO> getReportList(ReviewVO vo);

	// 해당병원리뷰 가져오기
	ReviewVO getRev(ReviewVO vo);

	// 병원리뷰가져오기
	List<ReviewVO> getRevList(ReviewVO vo);

	//[전체유저]  리뷰검색
	List<ReviewVO> getMyRevList(ReviewVO vo);
	
	// [마이페이지] 마이페이지 리뷰
	List<ReviewVO> getMyReviewPostList(ReviewVO vo);
	
	// [마이페이지]글 전체목록 조회
		List<ReviewVO> searchMyRevList(ReviewVO vo);
		
		// [병원]글 전체목록 조회
		List<ReviewVO> searchHosRevList(ReviewVO vo);

	//리뷰 추천
		int reviewUp(ReviewVO vo);
		
	//리뷰 추천 insert
		int reviewUpInsert(ReviewVO vo);
	//리뷰 추천 delete
		int reviewUpDelete(ReviewVO vo);

		int reportReviewHos(ReviewVO vo);

	//병원상세에서 리뷰상세보기 수빈유지보수
	public ReviewVO hosDetailReviewDetail(ReviewVO vo);
	
	//병원회원 리뷰상세보기	
	ReviewVO hosGetReviewDetails(ReviewVO vo);
}
