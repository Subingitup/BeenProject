package com.spring.pet.pets.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.pet.pets.PetsService;
import com.spring.pet.pets.PetsVO;

@Service("petsService")
public class PetsServiceImpl implements PetsService{
	
	@Autowired
	private PetsDAOMybatis petsDAO;

	//펫 등록
	public void insertPets(PetsVO vo) {
		petsDAO.insertPets(vo);
	}
	
	//펫 조회
	public PetsVO getPetsInfo(PetsVO vo) {
		return petsDAO.getPetsInfo(vo);
	}

	//펫 목록 조회
	public List<PetsVO> getPetsList(PetsVO vo) {
		return petsDAO.getPetsList(vo);
	}
	
	//펫 수정
	public void updatePetsInfo(PetsVO vo) {
		petsDAO.updatePetsInfo(vo);
	}
	
	//펫 삭제
	public int deletePetsInfo(PetsVO vo) {
		return petsDAO.deletePetsInfo(vo);
	}
}

