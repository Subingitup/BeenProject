package com.spring.pet.review.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.pet.review.ReviewService;
import com.spring.pet.review.ReviewVO;
import com.spring.pet.users.UsersVO;
import com.spring.pet.users.impl.UsersDAO;

@Service("reviewService")
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewDAO reviewDAO;

	@Autowired
	private UsersDAO usersDAO;

	@Override
	public void insertReview(ReviewVO vo) {
		reviewDAO.insertReview(vo);
	}

	@Override
	public void updateReview(ReviewVO vo) {
		reviewDAO.updateReview(vo);
	}

	@Override
	public void deleteReview(ReviewVO vo) {
		reviewDAO.deleteReview(vo);
	}

	@Override
	public ReviewVO getReview(ReviewVO vo) {
		return reviewDAO.getReview(vo);
	}

	@Override
	public List<ReviewVO> getReviewList(ReviewVO vo) {
		return reviewDAO.getReviewList(vo);
	}

	@Override
	public List<ReviewVO> getReserveInfo(ReviewVO vo) {
		return reviewDAO.getReserveInfo(vo);
	}

	@Override
	public List<ReviewVO> adminUserReview(UsersVO vo) {
		return usersDAO.adminUserReview(vo);
	}

	@Override
	public int adminUserReviewListCount(UsersVO vo) {
		return usersDAO.adminUserReviewListCount(vo);
	}

	@Override
	public void updateDelReview(ReviewVO vo) {
		reviewDAO.updateDelReview(vo);
	}

	// 신고리뷰 반려처리
	@Override
	public void updateReport_reject(ReviewVO vo) {
		reviewDAO.updateReport_reject(vo);
	};

	// 신고리뷰 삭제
	@Override
	public void updateReport_delete(ReviewVO vo) {
		reviewDAO.updateReport_delete(vo);
	};

	// 신고리뷰 조회
	@Override
	public ReviewVO getReportReview1(ReviewVO vo) {
		return reviewDAO.getReportReview1(vo);
	};

	// 신고리뷰 상세보기 조회
	@Override
	public ReviewVO getReport(ReviewVO vo) {
		return reviewDAO.getReport(vo);
	};

	// 신고리뷰 전체목록 조회
	@Override
	public List<ReviewVO> getReportList(ReviewVO vo) {
		return reviewDAO.getReportList(vo);
	};

	@Override
	public ReviewVO getRev(ReviewVO vo) {
		return reviewDAO.getRev(vo);
	}

	@Override
	public List<ReviewVO> getRevList(ReviewVO vo) {
		return reviewDAO.getRevList(vo);
	}

	@Override
	public List<ReviewVO> getMyRevList(ReviewVO vo) {
		return reviewDAO.getMyRevList(vo);
	}

	@Override
	public List<ReviewVO> getMyReviewPostList(ReviewVO vo) {
		return reviewDAO.getMyReviewPostList(vo);
	}

	@Override
	public List<ReviewVO> searchMyRevList(ReviewVO vo) {
		return reviewDAO.searchMyRevList(vo);
	}

	@Override
	public int reviewUp(ReviewVO vo) {
		return reviewDAO.reviewUp(vo);
	}

	@Override
	public int reviewUpInsert(ReviewVO vo) {
		return reviewDAO.reviewUpInsert(vo);
	}

	@Override
	public int reviewUpDelete(ReviewVO vo) {
		return reviewDAO.reviewUpDelete(vo);
	}

	@Override
	public List<ReviewVO> searchHosRevList(ReviewVO vo) {
		return  reviewDAO.searchHosRevList(vo);
	}

	//리뷰신고
	@Override
	public int reportReviewHos(ReviewVO vo) {
		return reviewDAO.reportReviewHos(vo);
	}

	//병원상세에서 리뷰상세보기 수빈유지보수
	public ReviewVO hosDetailReviewDetail(ReviewVO vo) {
		return reviewDAO.hosDetailReviewDetail(vo);
	}	

	//병원회원 리뷰상세보기
		@Override
	public ReviewVO hosGetReviewDetails(ReviewVO vo) {
		return reviewDAO.hosGetReviewDetails(vo);
	}
}
