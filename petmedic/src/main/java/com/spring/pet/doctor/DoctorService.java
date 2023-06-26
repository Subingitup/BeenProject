package com.spring.pet.doctor;

import java.util.List;

public interface DoctorService {

	DoctorVO getDoc(DoctorVO vo);
	void delDoc(DoctorVO vo);
	void updDoc(DoctorVO vo);
	void insertDoc(DoctorVO vo);
	List<DoctorVO> getDocList(DoctorVO vo);
}
