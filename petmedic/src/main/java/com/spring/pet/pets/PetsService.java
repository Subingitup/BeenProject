package com.spring.pet.pets;

import java.util.List;

public interface PetsService {
	//펫 등록
	void insertPets(PetsVO vo);
	
	//펫 정보 조회
	PetsVO getPetsInfo(PetsVO vo);
	
	//펫 목록 조회
	List<PetsVO> getPetsList(PetsVO vo);
	
	//펫 수정
	void updatePetsInfo(PetsVO vo);
	
	//펫 삭제
	int deletePetsInfo(PetsVO vo);

}