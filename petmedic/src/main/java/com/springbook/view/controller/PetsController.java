package com.springbook.view.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.pet.pets.PetsService;
import com.spring.pet.pets.PetsVO;
import com.spring.pet.users.UsersVO;

@Controller
public class PetsController {

	@Autowired
	private PetsService petsService;

	// 펫 등록
	@RequestMapping("/insertPets")
	public String insertPets(@ModelAttribute("pets") PetsVO vo, Model model, HttpSession session,
			@RequestParam("uploadFile") MultipartFile uploadFile, HttpServletRequest request)
			throws IllegalStateException, IOException {
		String id = (String) session.getAttribute("users_id");
		vo.setPet_users_id(id);

		String realPath = request.getSession().getServletContext().getRealPath("/resources/imgs/");
		String fileName = uploadFile.getOriginalFilename();
		System.out.println("펫 등록 파일명: " + fileName);

		if (!uploadFile.isEmpty()) {
			String newFileName = generateUniqueFileName(fileName);
			File file = new File(realPath + newFileName);

			while (file.exists()) {
				newFileName = generateUniqueFileName(fileName);
				file = new File(realPath + newFileName);
			}

			uploadFile.transferTo(file);
			vo.setPet_pic(newFileName);
		}

		petsService.insertPets(vo);
		System.out.println("펫 등록 정보: " + vo);
		model.addAttribute("pets", vo);
		return "redirect:/mypetlist";
	}

	private String generateUniqueFileName(String fileName) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		String timestamp = dateFormat.format(new Date());
		String extension = FilenameUtils.getExtension(fileName);
		return timestamp + "." + extension;
	}

	// 펫 수정 (파일 업데이트 포함)
	@RequestMapping("/updatePetsInfo")
	public String updatePetsInfo(@ModelAttribute("pets") PetsVO vo, Model model, HttpSession session,
			@RequestParam("uploadFile") MultipartFile uploadFile, HttpServletRequest request)
			throws IllegalStateException, IOException {
		vo.setPet_pic((String) session.getAttribute("pet_pic"));
		String id = (String) session.getAttribute("users_id");
		vo.setPet_users_id(id);

		String fileName = uploadFile.getOriginalFilename();
		String delFile = vo.getPet_pic();
		System.out.println("지울 파일명: " + delFile);
		System.out.println("새로 업로드할 파일명: " + fileName);

		if (!uploadFile.isEmpty()) {
			String filenm = vo.getPet_pic(); // 이전에 있던 파일 이름
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
			Date time = new Date();
			String result = dateFormat.format(time); // 날짜 붙이기
			filenm = result + fileName;
			vo.setPet_pic(filenm);

			System.out.println("filenm: " + filenm);

			if (filenm != null) {
				String realPath = request.getSession().getServletContext().getRealPath("/resources/imgs/");
				File file = new File(realPath + filenm);
				boolean exists = file.exists();
				while (exists) {
					File filet = new File(realPath + filenm);
					exists = filet.exists();
				}

				Path delFilePath = Paths.get(realPath + delFile);
				try {
					Files.deleteIfExists(delFilePath);
				} catch (IOException e) {
					e.printStackTrace();
				}

				try {
					uploadFile.transferTo(file);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		petsService.updatePetsInfo(vo);
		return "redirect:/mypetlist?pet_users_id=" + id;
	}

	// 펫 조회
	@RequestMapping("/mypetInfo")
	public String getPetsInfo(@ModelAttribute("pets") PetsVO vo, Model model, HttpSession session) {

		model.addAttribute("pets", petsService.getPetsInfo(vo));

		System.out.println("펫 정보 받아오기 처리");

		if (petsService.getPetsInfo(vo) != null) {
			System.out.println("vo: " + vo);
			session.setAttribute("pet_name", vo.getPet_name());
			session.setAttribute("pet_users_id", vo.getPet_users_id());
			session.setAttribute("pet_pic", vo.getPet_pic());

			System.out.println("id" + vo.getPet_users_id());
			return "userMyPage/mypetinfo";
		} else {
		}

		return "userMyPage/mypetlist";
	}

	// 펫 목록 조회
	@RequestMapping(value = "/mypetlistajax")
	@ResponseBody // 아작스로 데이터 보내려면 반드시 붙여야함
	public List<PetsVO> mypetlistajax(PetsVO vo, Model model, HttpSession session) {
		System.out.println("vo: " + vo.getPet_users_id());
		model.addAttribute("petsList", petsService.getPetsList(vo));

		if (petsService.getPetsList(vo) != null) {
			return petsService.getPetsList(vo);
		} else {
			return null;
		}
	}

	@RequestMapping(value = "/mypetlist")
	public String getPetsList(PetsVO vo, Model model, HttpSession session) {
		System.out.println("vo: " + vo.getPet_users_id());
		String id = (String) session.getAttribute("users_id");
		vo.setPet_users_id(id);
		model.addAttribute("petsList", petsService.getPetsList(vo));

		return "userMyPage/mypetlist"; // string으로 url 보낼때는 return null하면 안 됨

	}

	// 펫 삭제(파일 삭제 o)
	@RequestMapping(value = "/deletePetsInfo")
	public String deletePetsInfo(PetsVO vo, Model model, HttpServletRequest request) {
		System.out.println("delete vo:" + vo);
		int r = petsService.deletePetsInfo(vo);
		String filenm = vo.getPet_pic();
		System.out.println("filenm" + filenm);
		String realPath = request.getSession().getServletContext().getRealPath("/resources/imgs/");
		Path filePath = Paths.get(realPath, filenm);
		if (r > 0) { // delete,update,insert는 행수를 반환하기 때문에 int로 받아 조건을 넣는다.
			// 파일 삭제
			try {
				Files.delete(filePath);
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "redirect:/mypetlist?pet_users_id=" + vo.getPet_users_id();
		} else {
			return "mypetlist?error=1";
		}
	}

	// 펫 등록 페이지
	@RequestMapping("/mypets")
	public String mypets(UsersVO vo) {
		return "userMyPage/mypets";
	}

}