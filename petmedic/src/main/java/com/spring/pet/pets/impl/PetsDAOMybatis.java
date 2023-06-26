package com.spring.pet.pets.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.pet.pets.PetsVO;

@Repository
public class PetsDAOMybatis {

	@Autowired
	private SqlSessionTemplate mybatis;

	// 펫 등록
	public void insertPets(PetsVO vo) {
		int pt = mybatis.insert("PetsDAO.insertPets", vo);
	}

	// 펫 목록 조회
	public List<PetsVO> getPetsList(PetsVO vo) {
		return mybatis.selectList("PetsDAO.getPetsList", vo);
	}

	// 펫1마리씩 정보 조회
	public PetsVO getPetsInfo(PetsVO vo) {
		return (PetsVO) mybatis.selectOne("PetsDAO.getPetsInfo", vo);
	}

	// 펫 수정
	public void updatePetsInfo(PetsVO vo) {
		int uppet = mybatis.update("PetsDAO.updatePetsInfo", vo);
	}
	
	//펫 삭제
	public int deletePetsInfo(PetsVO vo) {
		return mybatis.delete("PetsDAO.deletePetsInfo" ,vo);
	}
}