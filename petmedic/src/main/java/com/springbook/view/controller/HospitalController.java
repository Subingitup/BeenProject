package com.springbook.view.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.pet.commons.PageInfo;
import com.spring.pet.doctor.DoctorService;
import com.spring.pet.doctor.DoctorVO;
import com.spring.pet.hospital.HospitalService;
import com.spring.pet.hospital.HospitalVO;
import com.spring.pet.reserve.ReserveService;
import com.spring.pet.reserve.ReserveVO;
import com.spring.pet.review.ReviewService;
import com.spring.pet.review.ReviewVO;
import com.spring.pet.users.MailSendService;
import com.spring.pet.users.PhoneService;
import com.spring.pet.users.UsersService;
import com.spring.pet.users.UsersVO;

@Controller
@SessionAttributes("hos")
public class HospitalController {

	@Autowired
	private UsersService userService;

	@Autowired
	private ReviewService revService;

	@Autowired
	private HospitalService hospitalService;

	@Autowired
	private DoctorService doctorService;
	
	@Autowired
	private ReserveService reserveService;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private PhoneService phoneService;

	@Autowired
	private MailSendService mailService;
	
	int pageSize = 10; // 한 페이지에 가져올 리스트 수
	int total = 0; // 가져올 리스트 초기값
	int totalPage = 1; // 페이지 기본 값

	@ModelAttribute("conditionMap") // 컨트롤러를 탈 때마다 계속 생성되는 객체이다. request객체인데 밑에 url 타기전에 실행되어 객체생성
	public Map<String, String> searchConditionMap() {
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("카테고리명", "CATEGORY");
		conditionMap.put("지역명", "LOCATION");
		conditionMap.put("의사명", "DOCTOR");
		conditionMap.put("병원명", "HOSPITAL");
		return conditionMap;
	}
	
	
	
   @ModelAttribute("confirmSearchMap") // 검색창 관련 맵
   public Map<String, String> ConfirmSearchMap() {
      Map<String, String> confirmSearchMap = new HashMap<String, String>();
      confirmSearchMap.put("아이디", "ID");
      confirmSearchMap.put("병원명", "HOSNAME");
      return confirmSearchMap;
   }
   

//병원 검색 페이지로 이동
	@RequestMapping("/searchHospitalList")
	public String searchHospitalList(HospitalVO vo, Model model) {
		return "/search/getSearchHosList";
	}
//병원 검색 페이지로 이동
	@RequestMapping("/ListHosUser")
	public String ListHosUser(HospitalVO vo, Model model) {
		model.addAttribute("hospital", hospitalService.ListHosUser(vo));
		return "/hospital/getHosListUser";
	}

	//병원들 검색으로이동
	   @RequestMapping("/getHosList")
	   @ResponseBody
	   public List<HospitalVO> getHosList(@RequestParam("keyword") String keyword, HospitalVO vo, Model model) {
	      vo.setSearchKeyword(keyword);
	      return hospitalService.getHosList(vo);
	   }

	// 병원 상세페이지 메인
   @RequestMapping("/getHos")
   public String getHos(@RequestParam("hos_id") String hosId, Model model) {
       HospitalVO vo = new HospitalVO();
       vo.setHos_id(hosId);
       model.addAttribute("hos", hospitalService.getHos(vo));

       return "/hospital/hosDetail";
   }

	// 검색에서 병원상세로
	@RequestMapping("/getHosInfo")
	public String getHosInfo(@RequestParam("hos_addr2") String hosAddr2, @RequestParam("hos_addr3") String hosAddr3,
			@RequestParam("hos_name") String hosName, @RequestParam("hos_tel") String hosTel, Model model,
			UsersVO uvo,HttpSession session) {
		HospitalVO vo = new HospitalVO();
		vo.setHos_addr2(hosAddr2);
		vo.setHos_addr3(hosAddr3);
		vo.setHos_name(hosName);
		vo.setHos_tel(hosTel);
		uvo.setUsers_id((String)session.getAttribute("users_id"));
		model.addAttribute("hos", hospitalService.getHosInfo(vo));
		model.addAttribute("users",userService.getUserInfo(uvo));
		return "/hospital/hosDetail";
	}

//병원 상세정보
	@RequestMapping("/toHosInfo")
	public String toHosInfo() {

		return "/hospital/hosInfo";
	}


	//의사정보1
			@RequestMapping("/toDoc")
			public String toDoctors(DoctorVO vo, Model model, HttpSession session, HttpServletRequest request) {
				if((String) session.getAttribute("hos_id") != null) {
					vo.setDoc_hos_id((String) session.getAttribute("hos_id"));
				} else {
					String doc_hos_id = request.getParameter("hos_id");
					vo.setDoc_hos_id(doc_hos_id);
				}
				

				model.addAttribute("docList", doctorService.getDocList(vo));
				return "hospital/doctors";
			}

	//  병원리뷰로 이동
		@RequestMapping("/toReviewList")
		public String toReviewList(ReviewVO vo, Model model, HttpSession session, HttpServletRequest request) {
			if((String) session.getAttribute("hos_id") != null) {
				vo.setRev_hos_id((String) session.getAttribute("hos_id"));
			} else {
				String rev_hos_id = request.getParameter("hos_id");
				vo.setRev_hos_id(rev_hos_id);
			}
			model.addAttribute("revList", revService.getRevList(vo));
			return "hospital/reviews";
		}
	
		//병원 마이페이지에서 리뷰 조회할때 사용
		@RequestMapping("/toHosReview")
		public String toReview(ReviewVO vo, Model model, HttpSession session) {

			vo.setRev_hos_id((String)session.getAttribute("hos_id"));
//			모델 어트리뷰트 써서 끌고올것
			model.addAttribute("reviewList", revService.getRevList(vo));
			return "hosMyPage/myHosReviews";
		}

		//의사정보2
		@RequestMapping("/toDocUpdate")
		public String toDocUpdate(DoctorVO vo, Model model, HttpSession session) {
			model.addAttribute("doc", doctorService.getDoc(vo));
			return "hosMyPage/docUpdate";
		}

	
		//병원 마이페이지 정보 수정
		@RequestMapping("/toHosUpdate")
		public String toHosUpdate(HospitalVO vo, Model model, HttpSession session) {
			
			vo.setHos_id((String)session.getAttribute("hos_id"));
			
			model.addAttribute("hos", hospitalService.getHos(vo));
			return "hosMyPage/hosUpdate";
		}
	
		//정보수정메소드
				@RequestMapping(value = "/updHos")
				public String updHos(HospitalVO hosvo, HttpServletRequest request)  throws IllegalStateException, IOException { 
					
					  if(hosvo.getHos_s_lunch()=="1") {
						  hosvo.setHos_s_lunch(null);
					  }
					  
					  if(hosvo.getHos_e_lunch()=="1") {
						  hosvo.setHos_e_lunch(null);
					  }
					   
					  MultipartFile uploadFile = hosvo.getUploadFile();
				      String realPath = request.getSession().getServletContext().getRealPath("/resources/imgs/");
				      String fileName = uploadFile.getOriginalFilename();
				      HospitalVO hosPicVO = hospitalService.adminHosPic(hosvo);
				      String hosFileName = null;
				      if(hosPicVO!=null) {//기존 이미지가 있음 
				    	  hosFileName = hosPicVO.getHos_pic();
				      }
				      
				      if (!uploadFile.isEmpty()) {//이미지 올렸을 때
				    	  hosvo.setFilename(fileName);
				    	  String filenm = hosvo.getFilename();
				    	  if (filenm != null) {// true
//								File file = new File("d:/swork/eleven/src/main/webapp/img/" + filenm);
								File file = new File(realPath+ filenm);
								File hosPicFile = new File(realPath+hosFileName);
								if(hosPicFile.exists()) {//기존 이미지파일 있으면 삭제
									hosPicFile.delete();
								}
								boolean exists = file.exists();
								while (exists) {
									SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
									Date time = new Date();
									String result = dateFormat.format(time);
									filenm = result + filenm;
									File filet = new File(realPath+ filenm);
									exists = filet.exists();
								}

								uploadFile.transferTo(new File(realPath+ filenm));
								hosvo.setHos_pic(filenm);
							}

						}else if(hosFileName!=null) {//기존 병원 이미지가 있는데 수정 때 새로 등록 안함
							hosvo.setHos_pic(hosFileName);
						}
					
					hospitalService.updateHospital(hosvo);
					return "redirect:/toHosMyPage";
				}

		//의사삭제
				@RequestMapping("/delDoc")
				public String delDoctor(DoctorVO vo) {
					doctorService.delDoc(vo);
					return "hosMyPage/docList";
				}

		//의사 수정
				@RequestMapping(value = "/updDoc")
				public String updDoctor(DoctorVO vo,HttpServletRequest request)  throws IllegalStateException, IOException  {
					MultipartFile uploadFile = vo.getUploadFile();
					
					String realPath = request.getSession().getServletContext().getRealPath("/resources/imgs/"); 
					String fileName = uploadFile.getOriginalFilename();
					
					if(!uploadFile.isEmpty()) {
						vo.setDoc_filename(fileName);
						uploadFile.transferTo(new File(realPath+fileName)); //transferTo: file을 destination으로 transfer함
					}
					doctorService.updDoc(vo);
					return "redirect:/docList";
				}
				
		//내 병원 	
		@RequestMapping("/myHos")
		public String myHos(HospitalVO vo, Model model) {
			model.addAttribute("hos", hospitalService.getHos(vo));
			return "hosMyPage/myHos";
		}

	//병원리스트
		@RequestMapping("/docList")
	      public String docList(DoctorVO vo, Model model, HttpSession session) {
	         vo.setDoc_hos_id((String) session.getAttribute("hos_id"));

	         model.addAttribute("docList", doctorService.getDocList(vo));
	         return "hosMyPage/docList";
	      }

		//병원회원 탈퇴
	@RequestMapping("/toDelHos")
	public String delHos(HospitalVO vo, Model model, HttpSession session) {
		vo.setHos_id((String)session.getAttribute("hos_id"));
		model.addAttribute("hos", hospitalService.getHos(vo));
		return "hosMyPage/deleteHos";
	}

		@RequestMapping("/toHosMyPage")
		public String toHosMyPage(HospitalVO hvo, DoctorVO dvo, ReviewVO revvo, ReserveVO resvo, Model model, HttpSession session) {
			hvo.setHos_id((String)session.getAttribute("hos_id"));
			dvo.setDoc_hos_id((String)session.getAttribute("hos_id"));
			resvo.setRes_hos_id((String)session.getAttribute("hos_id"));
			revvo.setRev_hos_id((String)session.getAttribute("hos_id"));
			model.addAttribute("hos", hospitalService.getHos(hvo));
			model.addAttribute("docList", doctorService.getDocList(dvo));
			model.addAttribute("revList", reviewService.getRevList(revvo));
			model.addAttribute("resList", reserveService.getResList(resvo));

			return "hosMyPage/hosMyPage";
		}

		@RequestMapping("/toInsertDoc")
		public String toInsertDoc(HospitalVO vo, Model model, HttpSession session) {

			vo.setHos_id((String)session.getAttribute("hos_id"));
			//이건 김태희가 세션 없어서 임의로 만든거임
			
			model.addAttribute("hos", hospitalService.getHos(vo));
			return "hosMyPage/insertDoc";
		}
		
		
		//수빈유지보수
	@RequestMapping("/insertDoc")
	public String insertDoc(DoctorVO vo, HttpSession session,HttpServletRequest request) throws IllegalStateException, IOException {
		
		//개행 줄바꿈
		String docInfo = vo.getDoc_info();
		docInfo = docInfo.replace("\r\n", "<br>");
        vo.setDoc_info(docInfo);
		
		
		MultipartFile uploadFile = vo.getUploadFile();
	    String realPath = request.getSession().getServletContext().getRealPath("/resources/imgs/");
	    String fileName = uploadFile.getOriginalFilename();
	     
	      if (!uploadFile.isEmpty()) {//이미지 올렸을 때
	    	  vo.setDoc_filename(fileName);
	    	  String filenm = vo.getDoc_filename();
	    	  if (filenm != null) {// true
					File file = new File(realPath+ filenm);
					boolean exists = file.exists();
					while (exists) {
						SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
						Date time = new Date();
						String result = dateFormat.format(time);
						filenm = result + filenm;
						File filet = new File(realPath+ filenm);
						exists = filet.exists();
					}
	
					uploadFile.transferTo(new File(realPath+ filenm));
					vo.setDoc_filename(filenm);
				}
	      }
			
			doctorService.insertDoc(vo);
			
			return "redirect:/docList";
		}
	

//		 [관리자]병원등록1
		@RequestMapping(value = "/insertHospital", method = RequestMethod.GET)
		public String insertHospital() {

			return "/hospital/insertHospital";
		}

		// 병원등록
        @RequestMapping(value = "/insertHospital", method = RequestMethod.POST)
        public String insertHospital(HospitalVO hosvo, HttpServletRequest request) throws IllegalStateException, IOException {
           MultipartFile uploadFile = hosvo.getUploadFile();

           // 상대경로를 절대경로로 변경해주는 경우 realPath 추가
            String realPath =
            request.getSession().getServletContext().getRealPath("/resources/pdf/");

           String fileName = uploadFile.getOriginalFilename();

           if (!uploadFile.isEmpty()) {
              String fileExtension = FilenameUtils.getExtension(fileName);
              if ("pdf".equalsIgnoreCase(fileExtension)) {
                 hosvo.setHos_file(fileName);
                 uploadFile.transferTo(new File(realPath + fileName));
              }
           }
           
           MultipartFile uploadFile1 = hosvo.getUploadFile1();
           // 파일 이미지경로 설정              
           String realPath2 =  request.getSession().getServletContext().getRealPath("/resources/imgs/"); 
            String pictureFileName = uploadFile1.getOriginalFilename();
            
            // 이미지 파일이 존재할 경우에만 처리 
            if (!uploadFile.isEmpty()) { 
               String pictureFileExtension = FilenameUtils.getExtension(pictureFileName); 
            if(isImageFileExtension(pictureFileExtension)) {
              hosvo.setHos_pic(pictureFileName);
            uploadFile1.transferTo(new File(realPath2 + pictureFileName)); 
               } 
            }
            
            String hosSLunchStr = request.getParameter("hos_s_lunch");
            String hosELunchStr = request.getParameter("hos_e_lunch");

            if ("".equals(hosSLunchStr)) {
                hosSLunchStr = null;
            }

            if ("".equals(hosELunchStr)) {
                hosELunchStr = null;
            }

            hosvo.setHos_s_lunch(hosSLunchStr);
            hosvo.setHos_e_lunch(hosELunchStr);
            
            String hashedPw = hospitalService.hashedChk(hosvo.getHos_pw());
            hosvo.setHos_pw(hashedPw);
            hospitalService.insertHospital(hosvo);
           return "redirect:/index.jsp";
        }

		   // 이미지파일 다운받게 해주는 메소드
		   private boolean isImageFileExtension(String fileExtension) {
		      String[] imageExtensions = { "jpg", "jpeg", "png", "gif" };
		      String lowerCaseFileExtension = fileExtension.toLowerCase();
		      for (String extension : imageExtensions) {
		         if (lowerCaseFileExtension.equals(extension)) {
		            return true;
		         }
		      }
		      return false;
		   }
	   
	   
	   
	// [관리자]병원 수정 수빈유지보수
	   @RequestMapping("/updateHospital")
	   public String updateHospital(HospitalVO hosvo, HttpServletRequest request) throws IllegalStateException, IOException {
		  if(hosvo.getHos_s_lunch()=="1") {
			  hosvo.setHos_s_lunch(null);
		  }
		  
		  if(hosvo.getHos_e_lunch()=="1") {
			  hosvo.setHos_e_lunch(null);
		  }
		   
		  MultipartFile uploadFile = hosvo.getUploadFile();
	      String realPath = request.getSession().getServletContext().getRealPath("/resources/imgs/");
	      String fileName = uploadFile.getOriginalFilename();
	      HospitalVO hosPicVO = hospitalService.adminHosPic(hosvo);
	      String hosFileName = null;
	      if(hosPicVO!=null) {//기존 이미지가 있음 
	    	  hosFileName = hosPicVO.getHos_pic();
	      }
	      
	      if (!uploadFile.isEmpty()) {//이미지 올렸을 때
	    	  hosvo.setFilename(fileName);
	    	  String filenm = hosvo.getFilename();
	    	  if (filenm != null) {// true
//					File file = new File("d:/swork/eleven/src/main/webapp/img/" + filenm);
					File file = new File(realPath+ filenm);
					File hosPicFile = new File(realPath+hosFileName);
					if(hosPicFile.exists()) {//기존 이미지파일 있으면 삭제
						hosPicFile.delete();
					}
					boolean exists = file.exists();
					while (exists) {
						SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
						Date time = new Date();
						String result = dateFormat.format(time);
						filenm = result + filenm;
						File filet = new File(realPath+ filenm);
						exists = filet.exists();
					}

					uploadFile.transferTo(new File(realPath+ filenm));
					hosvo.setHos_pic(filenm);
				}

			}else if(hosFileName!=null) {//기존 병원 이미지가 있는데 수정 때 새로 등록 안함
				hosvo.setHos_pic(hosFileName);
			}
	         
	         hospitalService.updateHospital(hosvo);
	         
	         return "redirect:getHospitalList?hosUpdate=1";
	      } 
	
	// 관리자가 병원 수정페이지이동
	   @RequestMapping(value = "/updatePageHospital")
	   public String updatePageHospital(HospitalVO hosvo, Model model) {

	      model.addAttribute("hospital", hospitalService.getHospital(hosvo));
	      return "hospital/updateHospital";
	   }

	 // [관리자] 병원회원탈퇴 수빈유지보수
	@RequestMapping(value="/deletewaitingHospital")
	public String deletewaitingHospital(HospitalVO hosvo, Model model) {
		hospitalService.deletewaitingHospital(hosvo);
		return "redirect:getHospitalList?hosDel=1";
	}



	// 병원 상세로 이동
	@RequestMapping("/getHospital")
	public String getHospital(HospitalVO hosvo, Model model) {

		model.addAttribute("hospital", hospitalService.getHospital(hosvo));
		return "hospital/getHospital";
	}

	// 병원 목록
	@RequestMapping("/getHospitalList")
	public String getHospitalListPost(@ModelAttribute("adminHosList") HospitalVO hosvo, Model model,@ModelAttribute("paging") PageInfo pageInfo
			,@RequestParam(value="hosUpdate",required = false) String hosUpdate,
			@RequestParam(value="hosDel",required = false) String hosDel) {
		
		int listCount = hospitalService.adminHosListCount(hosvo); // 글 목록의 수 가져옴
		pageInfo.setPageListCount(listCount);
		pageInfo = paging(pageInfo);
		hosvo.setStart(pageInfo.getStart());
		model.addAttribute("hospital", hospitalService.getHospitalList(hosvo));
		if(hosUpdate!=null) {
			model.addAttribute("hosUpdate","1");
			return "hospital/getHospitalList";
		}else if(hosDel!=null) {
			model.addAttribute("hosDel","1");
			return "hospital/getHospitalList";
		}else{
			return "hospital/getHospitalList";
		}
		
	}
	
	
	// [유저]병원 목록
	@RequestMapping("/getHosListUser")
	public String getHosListUser(HospitalVO hosvo, Model model) {
		
		model.addAttribute("hospital", hospitalService.getHosListUser(hosvo));
		return "hospital/getHosListUser";
	}

	// 병원증명자료 다운로드
	   @RequestMapping("/download")
	   public void download(HospitalVO hospital, HttpServletResponse response) throws Exception {
	      try {
	         String fileName = hospital.getHos_file();
	         String extension = FilenameUtils.getExtension(fileName);

	         if (extension.equalsIgnoreCase("pdf") || isImageFileExtension(extension)) {
	            String path = "c:/vet/petmedic/src/main/webapp/resources/imgs/" + fileName;
	            File file = new File(path);

	            response.setHeader("Content-Disposition", "attachment;filename=" + file.getName());
	            FileInputStream fileInputStream = new FileInputStream(file);
	            OutputStream out = response.getOutputStream();

	            int read;
	            byte[] buffer = new byte[1024];
	            while ((read = fileInputStream.read(buffer)) != -1) {
	               out.write(buffer, 0, read);
	            }

	            fileInputStream.close();
	            out.close();
	         } else {
	            throw new Exception();
	         }
	      } catch (Exception e) {
	         throw new Exception("Download error: " + e.getMessage());
	      }
	   }
	
	   

	   
// [관리자] 병원승인하기 수빈유지보수
   @RequestMapping(value="/checkHospital")
   public String checkHospital(HospitalVO hosvo,Model model) {
       hospitalService.checkHospital(hosvo);
       return "redirect:requestHospitalList?checkOK=1";
   } 

	@RequestMapping("/requestHospitalList")
	public String requestHospitalListPost(@ModelAttribute("hospitalSearch")HospitalVO hosvo, Model model, @RequestParam(value="checkOK",required = false)String checkOK,
			@ModelAttribute("paging") PageInfo pageInfo){
		
		int listCount = hospitalService.requestHospitalListCount(hosvo); // 글 목록의 수 가져옴
		pageInfo.setPageListCount(listCount);
		pageInfo = paging(pageInfo);
		hosvo.setStart(pageInfo.getStart());
		model.addAttribute("hospital", hospitalService.requestHospitalList(hosvo));
		
		
		if(checkOK!=null) {
			model.addAttribute("checkOk","1");
			return "admin_user/requestHospitalList";
		}else {
			return "admin_user/requestHospitalList";
		}
	}
	
	 // 관리자가 요청받은 병원 상세
   @RequestMapping(value="/requestHospital")
public String requestHospital(HospitalVO hosvo, Model model) {
	   model.addAttribute("hospital", hospitalService.requestHospital(hosvo));
	   return "admin_user/requestHospital";
	    }
	

	// 페이징 메소드
	public PageInfo paging(PageInfo pageInfo) {
		int listCount = pageInfo.getPageListCount(); // 받아온 리스트 카운트 얻어옴

		int totalPage = listCount / 10; // 임의의 totalPage 변수 생성
		if (listCount % 10 != 0) {
			totalPage++;
		}
		pageInfo.setTotalPage(totalPage); // 정해진 totalPage 수 대입

		int pageNUM = pageInfo.getPageNUM(); // pageNUM값 받아옴
		if (pageNUM == 0) {
			pageNUM = 1;
		}

		pageInfo.setPageNUM(pageNUM);// 이거 해야 처어어어음 로딩 했을 때 페이징 버튼 css 제대로 됨..

		int start = pageNUM - 1;// 임의의 start 변수 생성
		if (start > 0) {
			start = 10 * start;
			pageInfo.setStart(start);
		} else {
			pageInfo.setStart(start); // start 변수 만들어야겠지 ? ?
		}

		if (totalPage <= 10) {
			pageInfo.setStartNUM(1);
			pageInfo.setEndNUM(totalPage);
		} else {
			int p = pageNUM / 10;

			if ((pageNUM % 10) == 0) {
				p = p - 1;
				pageInfo.setStartNUM((p * 10) + 1);
				pageInfo.setEndNUM((p + 1) * 10);
			} else {
				pageInfo.setStartNUM((p * 10) + 1);
				pageInfo.setEndNUM((p + 1) * 10);
			}

			if (pageInfo.getEndNUM() > totalPage) {
				pageInfo.setEndNUM(totalPage);
			}
		}

		return pageInfo;

	}
	
	//병원로그인
	@ResponseBody
	   @RequestMapping(value = "/hoslogin", method = RequestMethod.POST)
	   public Object login(HospitalVO vo, Model model, HttpSession session) {
	       Map<String, Object> Login = new HashMap<String, Object>();
	      String hos_pw = vo.getHos_pw();
	      HospitalVO hosInfo = hospitalService.gethosInfo1(vo);
	      if (hosInfo != null) {
	         if (hospitalService.pwMatchChk(hos_pw, hosInfo.getHos_pw())) {
	            session.setAttribute("login", hosInfo);
	            session.setAttribute("hos_id", hosInfo.getHos_id());
	            session.setAttribute("hos_name", hosInfo.getHos_name());
	            session.setAttribute("hos_role", hosInfo.getHos_role());
	            Login.put("loginError", "false");
	         }else {
	            Login.put("loginError", "true");
	            }
	         }else {
	            Login.put("loginError", "true");
	         }
	      return Login;
	   }
	
	 //병원로그인2 hoslogin.jsp에서 작동되는거
	   @RequestMapping(value = "/hoslogin2", method = RequestMethod.POST)
	   public String login2(HospitalVO vo, Model model, HttpSession session) {
	      String hos_pw = vo.getHos_pw();
	      HospitalVO hosInfo = hospitalService.gethosInfo1(vo);
	      if (hosInfo != null) {
	         if (hospitalService.pwMatchChk(hos_pw, hosInfo.getHos_pw())) {
	            session.setAttribute("login", hosInfo);
	            session.setAttribute("users_id", hosInfo.getHos_id());
	            session.setAttribute("users_name", hosInfo.getHos_name());
	            session.setAttribute("users_role", hosInfo.getHos_role());
	            return "redirect:petmedic_main.jsp";
	         }
	      }
	      model.addAttribute("nologin", true);
	      return "forward:/hoslogin.jsp";
	   }
	   
	   private String randomAuthCode() {
				Random rand = new Random();
				String numStr = "";
				for (int i = 0; i < 6; i++) {
					String ran = Integer.toString(rand.nextInt(10));
					numStr += ran;
				}
				return numStr;
			}
	   
	// 전화번호로 아이디찾기 - 인증번호 전달
	   @RequestMapping("/forgothosIdCheck")
		@ResponseBody
		public HashMap forgotId(HospitalVO vo, HttpSession session) {
			HospitalVO cvo = hospitalService.checkDupEmail(vo);

			HashMap<String, Object> result = new HashMap();
			result.put("flag", cvo != null);
			if (cvo != null) {
				String rndAuthCode = randomAuthCode();
				UUID uuid = UUID.randomUUID();
				session.setAttribute(uuid.toString(), rndAuthCode);
				result.put("key", uuid.toString());
				mailService.joinEmail(vo.getHosFullEmail(), rndAuthCode);
			}
			return result;
		}
			
	// 이메일로 아이디 찾기 인증번호 확인
		@RequestMapping("/forgothosIdConfirm")
		@ResponseBody
		public String forgotIdConfirm(String email, String email2, String key, String value, HttpSession session) {
			String keyValue = (String) session.getAttribute(key);
			if (keyValue == null)
				return "expired";
			if (keyValue != null && keyValue.equals(value)) {
				HospitalVO hospitalVO = new HospitalVO();
				hospitalVO.setHos_email(email);
				hospitalVO.setHos_email2(email2);
				HospitalVO cvo = hospitalService.checkDupEmail1(hospitalVO);
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); // yyyy-MM-dd HH:mm:ss
				String format = formatter.format(cvo.getHos_new_date());
				return format+"/" +cvo.getHos_id();
			}
			return "";
		}
			
			// 비밀번호 재설정
			@RequestMapping("/resethosPassword")
			public String resetPassword() {
				return "intercept/resethosPassword";
			}
			
			// 아이디 찾기
			@RequestMapping("/forgothosId")
			public String forgotId() {
				return "intercept/forgothosId";
			}
			
			// 비밀번호 재설정 id와 전화번호 입력했을때 처리
			@RequestMapping("/resethosPasswordCheck")
			@ResponseBody
			public HashMap resetPasswordCheck(HospitalVO vo, HttpSession session) {
				HospitalVO cvo = hospitalService.getId(vo);

				HashMap<String, Object> result = new HashMap();
				result.put("flag", cvo != null);
				// 입력한 id가 없는 경우
				result.put("msg", cvo == null ? "존재하지 않는 ID 입니다." : "");

				if (cvo != null) {
					// 입력한 id는 존재하지만 입력한 전화번호와 일치하지 않는경우
					if (cvo.getHos_tel().equals(vo.getHos_tel()) == false) {
						result.put("flag", false);
						result.put("msg", "전화번호와 일치하는 사용자가 없습니다.");
					} else {
						String rndAuthCode = randomAuthCode();
						UUID uuid = UUID.randomUUID();
						session.setAttribute(uuid.toString(), rndAuthCode);
						result.put("key", uuid.toString());
						phoneService.certifiedPhoneNumber(vo.getHos_tel(), rndAuthCode);
					}
				}
				return result;
			}
			
			@RequestMapping("/hosauthCodeConfirmCheck")
			@ResponseBody
			public Boolean phoneConfirmCheck(String key, String value, HttpSession session) {
				String keyValue = (String) session.getAttribute(key);
				if (keyValue == null)
					return null;
				return keyValue != null && keyValue.equals(value);
			}

	   
		// 별점높은 병원 가져오기	
			@RequestMapping("/revHighStar")
			@ResponseBody
			public List<HospitalVO> revHighStar(HospitalVO vo, HttpSession session) {
			    return hospitalService.revHighStar(vo);
			}
			// 리뷰많은 병원 가져오기	
			@RequestMapping("/getManyRevHos")
			@ResponseBody
			public List<HospitalVO> getManyRevHos(HospitalVO vo, HttpSession session) {
				// You can use the revHosSeq and revUserId values as needed
				return hospitalService.getManyRevHos(vo);
			}
			
	   
			@RequestMapping("/resList")
	         public String resList(ReserveVO vo, HttpSession session, Model model) {
	            vo.setRes_hos_id((String)session.getAttribute("hos_id"));
	            
	            model.addAttribute("resList", reserveService.getResList(vo));
	            return "/hosMyPage/resList";
	         }
			
			
			// 예약횟수로 베스트 병원 가져오기 (인덱스용)
			   @RequestMapping("/getBestHospitals")
			   @ResponseBody
			   public List<ReserveVO> getBestHospitals(ReserveVO vo){
			      reserveService.getBestHospital(vo);
			      return reserveService.getBestHospital(vo);
			   }	
			
			  //맵검색 
			   @RequestMapping("/locations")
			   @ResponseBody
			   public List<HospitalVO> getLocations(@RequestParam String keyword, @RequestParam String searchCondition, HospitalVO vo) {
			     // Retrieve location data from the database (MariaDB in this case)
				   vo.setSearchKeyword(keyword);
				   vo.setSearchCondition(searchCondition);
			     List<HospitalVO> locations = hospitalService.getAllLocations(vo);
			     return locations;
			   }  
			   
			// 병원 상세 [찜목록에서 이동]
			   @RequestMapping("/getHosDetailZzim")
			   public String getHosDetail(HospitalVO vo, Model model, UsersVO uvo,HttpSession session) {
				   uvo.setUsers_id((String)session.getAttribute("users_id"));
			       model.addAttribute("hos", hospitalService.getHos(vo));
			       model.addAttribute("users",userService.getUserInfo(uvo));
			       return "/hospital/hosDetail";
			   }

			   
			// 아이디 중복체크
				@RequestMapping("/idDupCheck1")
				@ResponseBody
				public Boolean idDupCheck(HospitalVO vo) {
					HospitalVO cvo = hospitalService.getId(vo);
					return cvo == null;
				}
				
				// 이메일 중복체크 - 인증번호 전달
				// 전화번호 중복체크
				@RequestMapping("/emailDupCheck1")
				@ResponseBody
				public HashMap mailDupCheck(HospitalVO vo, HttpSession session) {
					HospitalVO cvo = hospitalService.checkDupEmail(vo);

					HashMap<String, Object> result = new HashMap();
					result.put("flag", cvo == null);
					if (cvo == null) {
						String rndAuthCode = randomAuthCode();
						UUID uuid = UUID.randomUUID();
						session.setAttribute(uuid.toString(), rndAuthCode);
						result.put("key", uuid.toString());
						mailService.joinEmail(vo.getHosFullEmail(), rndAuthCode);
					}
					return result;
				}
				
				@RequestMapping("/authCodeConfirmCheck1")
				@ResponseBody
				public Boolean phoneConfirmCheck1(String key, String value, HttpSession session) {
					String keyValue = (String) session.getAttribute(key);
					if (keyValue == null)
						return null;
					return keyValue != null && keyValue.equals(value);
				}

@RequestMapping(value = "/delHos", method = RequestMethod.POST)
   public String delHos(@RequestParam("hos_pw") String hos_pw, HttpSession session, RedirectAttributes redirectAttributes) {
       HospitalVO vo = new HospitalVO();
       vo.setHos_id((String) session.getAttribute("hos_id"));
       vo.setHos_pw(hos_pw);
       HospitalVO hosInfo = hospitalService.gethosInfo1(vo);

       if (hosInfo != null && hospitalService.pwMatchChk1(hos_pw, hosInfo.getHos_pw())) { // 비밀번호 일치 여부 확인
           if (hospitalService.delHos(vo) > 0) {
               session.invalidate();
               return "redirect:index.jsp";
           } else {
               // 회원 탈퇴 실패 처리 로직 추가
               return "redirect:index.jsp";
           }
       } else {
           // 비밀번호가 일치하지 않을 경우 처리 로직 추가
           redirectAttributes.addFlashAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
           return "redirect:toDelHos";
       }
   }


//베스트 병원 목록으로 가져오기
@RequestMapping("/getBestHosList")
public String getBestHosList(HospitalVO hosvo, Model model) {
	   
	   model.addAttribute("hospital", hospitalService.getBestHosList(hosvo));
	   return "hospital/getHosListUser";
}

@RequestMapping("/beforeHosJoin")
public String step1() {
	return "/intercept/beforeHosJoin";
}


@RequestMapping("/hosZzim")
@ResponseBody
public String hosZzim(UsersVO uvo) {
	String hosId = uvo.getHos_id();
	UsersVO tvo = userService.hosZzim(uvo);
	String up1 = tvo.getUsers_pick1(); 
	String up2 = tvo.getUsers_pick2(); 
	String up3 = tvo.getUsers_pick3(); 
	String up4 = tvo.getUsers_pick4(); 
	String up5 = tvo.getUsers_pick5(); 
	
	String[] userPick = {up1, up2, up3, up4, up5};
	
	int index = -1;
	for (String item : userPick) { // 찜목록에 해당 병원이 있는지
	    if (item != null && item.equals(hosId)) {
	    	for (int i = 0; i < userPick.length; i++) {
	    	    if (userPick[i] != null && userPick[i].equals(hosId)) {
	    	        index = i;
	    	        break;
	    	    }
	    	}
	    
    	uvo.SetUp(index+1);
    	userService.delZzim(uvo);
	    	return "1";
	    }
	}
	int userPickNullCnt = 0;
	for(String item : userPick) { //찜 목록이 가득 찼는지
		if(item == null) {
			userPickNullCnt++;
		}
	}
	if(userPickNullCnt == 0) {//찜목록이 가득 참
		return "2";
	}else{
		// 찜목록 추가
		// null이 있는 가장 앞 인덱스 찾기
		int index1 = -1;
		for (int i = 0; i < userPick.length; i++) {
		    if (userPick[i] == null) {
		        index1 = i;
		        break;
		    }
		}
		
		uvo.SetUp(index1+1);
	int zzimResult = userService.hosZzimInsert(uvo);
	
	if(zzimResult>0) {
		return "zzimSuc"; //찜목록에 넣기 성공
	}else {
		return "zzimNo";
	}
	
		
	}
	
	
}
}
