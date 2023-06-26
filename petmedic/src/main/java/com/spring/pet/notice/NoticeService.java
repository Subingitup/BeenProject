package com.spring.pet.notice;

import java.util.List;

public interface NoticeService {

	// 공지사항 등록
	void insertNotice(NoticeVO vo);

	// 공지사항 수정
	void updateNotice(NoticeVO vo);

	// 공지사항 삭제
	int deleteNotice(NoticeVO vo);

	// 공지사항 목록조회
	List<NoticeVO> getNoticeList(NoticeVO vo);

	// 공지사항 목록조회 (인덱스용)
	List<NoticeVO> getNoticeList4Index(NoticeVO vo);

	// 공지사항 게시글 상세조회
	NoticeVO getNoticeDetail(NoticeVO vo);

	// 공지사항 검색
	List<NoticeVO> searchNoticeList(NoticeVO vo);

	// 공지사항 조회수 카운트
	void noticeCnt(NoticeVO vo);

//	// 글 목록 개수
//	int getNoticeCount(NoticeVO vo);

}
