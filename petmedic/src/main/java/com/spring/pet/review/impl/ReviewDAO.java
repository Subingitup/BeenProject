package com.spring.pet.review.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.pet.review.ReviewVO;

@Repository
public class ReviewDAO {

	@Autowired
	private SqlSessionTemplate mybatis; // dataSource,Mapper 담고 있음

//	CRUD 기능의 메소드 구현
	// 글쓰기
	public void insertReview(ReviewVO vo) {
		mybatis.insert("reviewDAO.insertReview", vo);
		mybatis.update("reviewDAO.updHosStar", vo);

	}

	// 글수정
	public void updateReview(ReviewVO vo) {
		mybatis.update("reviewDAO.updateReview", vo);
	}

	// 글삭제(Delete)
	public void deleteReview(ReviewVO vo) {
		mybatis.delete("reviewDAO.deleteReview", vo);
	}

	// 글삭제(update)
	public void updateDelReview(ReviewVO vo) {
		mybatis.delete("reviewDAO.updateDelReview", vo);
	}

	// 글상세조회
	public ReviewVO getReview(ReviewVO vo) {
		return (ReviewVO) mybatis.selectOne("reviewDAO.getReview", vo); // 한줄 데이터면 selectOne
	}

	// 글목록조회
	public List<ReviewVO> getReviewList(ReviewVO vo) {
		return mybatis.selectList("reviewDAO.getReviewList", vo); // 여러줄 데이터면 selectList
	}

	// 글 등록을 위한 정보불러오기
	public List<ReviewVO> getReserveInfo(ReviewVO vo) {
		return mybatis.selectList("reviewDAO.getReserveInfo", vo);

	}

	// 신고리뷰 반려처리
	public void updateReport_reject(ReviewVO vo) {
		int updao_rj = mybatis.update("reviewDAO.updateReport_reject", vo);
	}

	// 신고리뷰 삭제
	public void updateReport_delete(ReviewVO vo) {
		int updao_del = mybatis.update("reviewDAO.updateReport_delete", vo);
	}

	// 신고리뷰 조회
	public ReviewVO getReportReview1(ReviewVO vo) {
		ReviewVO rr = mybatis.selectOne("reviewDAO.getReportReview1", vo); // 한줄 데이터면 selectOne
		return rr;
	}
	
	// 신고리뷰 상세보기 조회
	public ReviewVO getReport(ReviewVO vo) {
		ReviewVO rp = mybatis.selectOne("reviewDAO.getReport", vo); // 한줄 데이터면 selectOne
		return rp;
	}

	// 신고리뷰 전체목록 조회
	public List<ReviewVO> getReportList(ReviewVO vo) {
		List<ReviewVO> rl = mybatis.selectList("reviewDAO.getReportList", vo); // 여러줄 데이터면 selectList

		return rl;
	}

	public ReviewVO getRev(ReviewVO vo) {
		ReviewVO asdf = (ReviewVO) mybatis.selectOne("reviewDAO.getRev", vo);
		return asdf;
	}

	public List<ReviewVO> getRevList(ReviewVO vo) {
		List<ReviewVO> asdf = mybatis.selectList("reviewDAO.getRevList", vo);
		return asdf;
	}
	
	//[전체유저]  리뷰검색
	public List<ReviewVO> getMyRevList(ReviewVO vo) {
		return mybatis.selectList("reviewDAO.getMyRevList", vo); // 여러줄 데이터면 selectList
	}
	// [유저] 마이페이지 리뷰
	public List<ReviewVO> getMyReviewPostList(ReviewVO vo) {
		return mybatis.selectList("reviewDAO.getMyReviewPostList", vo); // 여러줄 데이터면 selectList
	}
	
	// [마이페이지]  리뷰검색
		public List<ReviewVO> searchMyRevList(ReviewVO vo) {
			return mybatis.selectList("reviewDAO.searchMyRevList", vo); // 여러줄 데이터면 selectList
		}
		// [병원]  리뷰검색
		public List<ReviewVO> searchHosRevList(ReviewVO vo) {
			return mybatis.selectList("reviewDAO.searchHosRevList", vo); // 여러줄 데이터면 selectList
		}
		
	//리뷰추천
		public int reviewUp(ReviewVO vo) {
			return mybatis.selectOne("reviewDAO.reviewUp", vo); 
		}
		//리뷰추천 삽입
		public int reviewUpInsert(ReviewVO vo) {
			 mybatis.insert("reviewDAO.reviewUpInsert", vo); 
			 return mybatis.update("reviewDAO.reviewUpUpdate", vo); 
		}
		//리뷰추천 삽입
		public int reviewUpDelete(ReviewVO vo) {
			mybatis.delete("reviewDAO.reviewUpDelete", vo); 
			return mybatis.update("reviewDAO.reviewUpUpdateDel", vo); 
		}

	//리뷰신고
		public int reportReviewHos(ReviewVO vo) {
			return mybatis.update("reviewDAO.reportReviewHos", vo);
		}
	
	//리뷰 상세보기 수빈유지보수
	public ReviewVO hosDetailReviewDetail(ReviewVO vo) {
		return mybatis.selectOne("reviewDAO.hosDetailReviewDetail", vo); // 한줄 데이터면 selectOne
	}
	

	public ReviewVO hosGetReviewDetails(ReviewVO vo) {
		ReviewVO r = mybatis.selectOne("reviewDAO.hosGetReviewDetails", vo);
		return r;
	}
}
