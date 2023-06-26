package com.spring.pet.notice.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.pet.notice.NoticeVO;

@Repository("noticeDao")
public class NoticeDAO {

	@Autowired
	private SqlSessionTemplate noticeBatis;

	// 공지사항 등록
	public void insertNotice(NoticeVO vo) {
		noticeBatis.insert("noticeDAO.insertNotice", vo);
	}

	// 공지사항 수정
	public void updateNotice(NoticeVO vo) {
		noticeBatis.update("noticeDAO.updateNotice", vo);
	}

	// 공지사항 삭제
	public int deleteNotice(NoticeVO vo) {
		return noticeBatis.update("noticeDAO.deleteNotice", vo);
	}

	// 공지사항 목록보기
	public List<NoticeVO> getNoticeList(NoticeVO vo) {
		return noticeBatis.selectList("noticeDAO.getNoticeList", vo);
	}

	// 공지사항 목록보기 (인덱스용)
	public List<NoticeVO> getNoticeList4Index(NoticeVO vo) {
		return noticeBatis.selectList("noticeDAO.getNoticeList4Index", vo);
	}

	// 공지사항 상세보기
	public NoticeVO getNoticeDetail(NoticeVO vo) {
		return (NoticeVO) noticeBatis.selectOne("noticeDAO.getNoticeDetail", vo);
	}

	// 공지사항 검색
	public List<NoticeVO> searchNoticeList(NoticeVO vo) {
		return noticeBatis.selectList("noticeDAO.searchNoticeList", vo);

	}

	// 조회수 카운팅
	public void noticeCnt(NoticeVO vo) {
		noticeBatis.update("noticeDAO.noticeCnt", vo);
	}


}
