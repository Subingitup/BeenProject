package com.spring.pet.doctor.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.pet.doctor.DoctorVO;

@Repository
public class DoctorDAO {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	public DoctorVO getDoc(DoctorVO vo) {
		DoctorVO asdf = (DoctorVO) mybatis.selectOne("docDAO.getDoc", vo);
		return asdf;
	}

	public void delDoc(DoctorVO vo) {
		mybatis.delete("docDAO.delDoc", vo);
	}
	

	public void updDoc(DoctorVO vo) {
		mybatis.update("docDAO.updDoc", vo);
	}
	
	public List<DoctorVO> getDocList(DoctorVO vo) {
		List<DoctorVO> asdf = mybatis.selectList("docDAO.getDocList", vo);
		return asdf;
	}
	
	public void insertDoc(DoctorVO vo) {
		mybatis.insert("docDAO.insertDoc", vo);
	}
	
}
