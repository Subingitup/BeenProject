package com.spring.pet.notice.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.spring.pet.notice.NoticeService;
import com.spring.pet.notice.NoticeVO;

@Service("noticeServiceImpl")
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	@Qualifier("noticeDao")
	private NoticeDAO noticeDAO;

	// 공지사항등록
	@Override
	public void insertNotice(NoticeVO vo) {
		noticeDAO.insertNotice(vo);
	}

	// 공지사항 수정
	@Override
	public void updateNotice(NoticeVO vo) {
		noticeDAO.updateNotice(vo);
	}

	// 공지사항 삭제
	@Override
	public int deleteNotice(NoticeVO vo) {
		return noticeDAO.deleteNotice(vo);
	}

	// 공지사항 목록조회
	@Override
	public List<NoticeVO> getNoticeList(NoticeVO vo) {
		return noticeDAO.getNoticeList(vo);
	}

	// 공지사항 목록조회 (인덱스용)
	@Override
	public List<NoticeVO> getNoticeList4Index(NoticeVO vo) {
		return noticeDAO.getNoticeList4Index(vo);
	};

	// 공지사항 상세보기
	@Override
	public NoticeVO getNoticeDetail(NoticeVO vo) {
		return noticeDAO.getNoticeDetail(vo);
	}

	// 공지사항 검색
	@Override
	public List<NoticeVO> searchNoticeList(NoticeVO vo) {
		return noticeDAO.searchNoticeList(vo);
	}

	// 공지사항 조회수 카운트
	public void noticeCnt(NoticeVO vo) {
		noticeDAO.noticeCnt(vo);
	}

//	@Override
//	public int getNoticeCount(NoticeVO vo) {
//		return noticeDAO.getNoticeCount(vo);
//	};

}
