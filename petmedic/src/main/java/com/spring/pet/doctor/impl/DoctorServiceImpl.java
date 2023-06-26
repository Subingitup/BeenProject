package com.spring.pet.doctor.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.pet.doctor.DoctorService;
import com.spring.pet.doctor.DoctorVO;

@Service("docService")
public class DoctorServiceImpl implements DoctorService{

	@Autowired
	private DoctorDAO doctorDAO;
	
	@Override
	public DoctorVO getDoc(DoctorVO vo) {
		return doctorDAO.getDoc(vo);
	}

	@Override
	public void delDoc(DoctorVO vo) {
		doctorDAO.delDoc(vo);
	}

	@Override
	public void updDoc(DoctorVO vo) {
		doctorDAO.updDoc(vo);		
	}
	
	@Override
	public List<DoctorVO> getDocList(DoctorVO vo) {
		return doctorDAO.getDocList(vo);
	}

	@Override
	public void insertDoc(DoctorVO vo) {
		doctorDAO.insertDoc(vo);
	}

	
}
