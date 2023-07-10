package com.springbook.view.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.pet.pets.PetsService;
import com.spring.pet.pets.PetsVO;
import com.spring.pet.users.KakaoService;
import com.spring.pet.users.KakaoUser;
import com.spring.pet.users.MailSendService;
import com.spring.pet.users.PhoneService;
import com.spring.pet.users.UsersService;
import com.spring.pet.users.UsersVO;

@Controller
public class UsersController {
	@Autowired
	private UsersService usersService;
	@Autowired
	private MailSendService mailService;
	@Autowired
	private PhoneService phoneService;
	@Autowired
	private KakaoService kakaoService;
	@Autowired
	private PetsService petsService;

//	// 로그인(5차통합전)
	@RequestMapping(value = "/login2", method = RequestMethod.POST)
    public String login2(UsersVO vo, Model model, HttpSession session) {
       String user_pw = vo.getUsers_pw();
       UsersVO userInfo = usersService.getUserInfo(vo);
       if (userInfo != null) {
          if (usersService.pwMatchChk(user_pw, userInfo.getUsers_pw())) {
             session.setAttribute("login", userInfo);
             session.setAttribute("users_id", userInfo.getUsers_id());
             session.setAttribute("users_name", userInfo.getUsers_name());
             session.setAttribute("users_role", userInfo.getUsers_role());
             return "redirect:index.jsp";
          }
       }
       model.addAttribute("nologin", true);
       return "forward:/login.jsp";
    }

	// 로그인
	@ResponseBody
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public Object login(UsersVO vo, Model model, HttpSession session) {
	    Map<String, Object> Login = new HashMap<String, Object>();
	    String user_pw = vo.getUsers_pw();
	    UsersVO userInfo = usersService.getUserInfo(vo);
	    if (userInfo != null) {
	        if (usersService.pwMatchChk(user_pw, userInfo.getUsers_pw())) {
	            if (userInfo.getUsers_role().equals("USER")) {
	                session.setAttribute("login", userInfo);
	                session.setAttribute("users_id", userInfo.getUsers_id());
	                session.setAttribute("users_name", userInfo.getUsers_name());
	                session.setAttribute("users_role", userInfo.getUsers_role());
	                session.setAttribute("husers_pick1", userInfo.getUsers_pick1());
	                session.setAttribute("husers_pick2", userInfo.getUsers_pick2());
	                session.setAttribute("husers_pick3", userInfo.getUsers_pick3());
	                session.setAttribute("husers_pick4", userInfo.getUsers_pick4());
	                session.setAttribute("husers_pick5", userInfo.getUsers_pick5());
	                Login.put("loginError", "false");
	            } else {
	                Login.put("loginError", "true");
	            }
	        } else {
	            Login.put("loginError", "true");
	        }
	    } else {
	        Login.put("loginError", "true");
	    }
	    return Login;
	}

 //병원상세보기로 이동
	@RequestMapping("/hos")
	public String hos() {
		return "hospital/hosDetail";
	}

		//이용약관
		    @RequestMapping("/beforeJoin")
		    public String step1() throws Exception {
		        return "/intercept/beforeJoin";
		    }
			
	
	// 아이디 찾기
	@RequestMapping("/forgotId")
	public String forgotId() {
		return "intercept/forgotId";
	}


// 로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:index.jsp";
	}

//로그인 및 회원가입(선찬)
	@RequestMapping("resources/js/common.js")
	public void home(HttpServletRequest req) {
	}

	@RequestMapping("resources/css/common.css")
	public void home2(HttpServletRequest req) {
	}

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);
		return "intercept/home";
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "intercept/login";
	}

	@RequestMapping(value = "/login.action", method = RequestMethod.GET)
	public String loginAction(HttpServletRequest req, HttpServletResponse res, HttpSession session) {
		String userId = req.getParameter("userId");
		session.setAttribute("userId", userId);
		return "redirect:/main";
	}

	@RequestMapping(value = "/hospital", method = RequestMethod.GET)
	public String main() {
		return "intercept/hospitaljoin";
	}

	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join() {
		return "intercept/join";
	}

	@RequestMapping("/pathvar/page/{var}") // {var}가 변수자리
	public String page(@PathVariable("var") String v) { // @PathVariable를 꼭 써줘야하고("var")이놈은 위의 변수와 꼭 이름 일치해야함
		String returnUrl = "";

		if (v.equals("one")) {
			returnUrl = "pathvar/page1";
		} else if (v.equals("two")) {
			returnUrl = "pathvar/page2";
		}

		return returnUrl;
	}

	@RequestMapping("/pathvar/byGet") // "/pathvar/byGet?key=1=111&key2=zzz"
	public String resultByGet(@RequestParam(value = "key1") String k1, @RequestParam(value = "key2") String k2,
			Model model) {
		model.addAttribute("key1", k1);
		model.addAttribute("key2", k2);
		return "pathvar/path";
	}

	@RequestMapping("/pathvar/byPath/{key1}/{key2}") // "/pathvar/byPath/qaz/987"
	public String resultByPath(@PathVariable String key1, @PathVariable String key2) {
		return "pathvar/path";
	}

	@RequestMapping("/pathvar/byPath/key1/{key1}/key2/{key2}")
	public String resultByPath2(@PathVariable String key1, @PathVariable String key2) {
		return "pathvar/path";
	}

	/*
	 * - 카카오톡 로그인 카카오톡 로그인후 해당 id로 가입이력이 있으면 로그인처리하고 없으면 신규회원으로 저장하고 로그인처리한다.
	 */
	@GetMapping("/kakaologin")
	public String handleKakaoLoginCallback(@RequestParam("code") String code, @RequestParam(value = "state", required = false) String state, HttpSession session) {
		// 카카오 API를 사용하여 access token을 받아옵니다.
		String accessToken = kakaoService.getAccessToken(code);
		// 카카오 API를 이용하여 사용자 정보 조회
		KakaoUser user = kakaoService.getUserInfo(accessToken);
		// 로그인 처리
		UsersVO usersVO = usersService.loginKakao(user);
		// 로그인 정보 세션에 저장
		if (usersVO != null) {
			session.setAttribute("login", usersVO);
			session.setAttribute("users_id", usersVO.getUsers_id());
			session.setAttribute("users_name", usersVO.getUsers_name());
			session.setAttribute("users_role", usersVO.getUsers_role());
			session.setAttribute("kakao_login", true);
		}

		if (state == null || state.equals("")) {
			state = "/";
		}
		return "redirect:" + state;
	}

	// 회원가입
	@RequestMapping(value = "/joinUser")
	public String insertUser(UsersVO vo) {
		if (usersService.getUsers(vo) != null) {
			return "login.jsp?error=1";
		} else {
			String hashedPw = usersService.hashedChk(vo.getUsers_pw());
			vo.setUsers_pw(hashedPw);
			usersService.insertUser(vo);
			return "redirect:index.jsp";
		}
	}

	// 전화번호 중복체크 - 인증번호 전달
	@RequestMapping("/phoneDupCheck")
	@ResponseBody
	public HashMap phoneDupCheck(UsersVO vo, HttpSession session) {
		UsersVO cvo = usersService.checkDupPhone(vo);
		HashMap<String, Object> result = new HashMap();
		result.put("flag", cvo == null);
		if (cvo == null) {
			// 인증번호를 키값을 uuid로 생성하여 세션에 저장하고 key값만 화면으로 전달
			// 화면에서 key값과 입력값을 받아와서 sessiong에서 값을 확인후 값이 같으면 인증처리하는 방식
			// 실서비스에서는 db 테이블이나 redis를 이용하여 처리해야합니다.
			// 세션정보가 많아지면 oom 발생할수 있음
			String rndAuthCode = randomAuthCode();
			UUID uuid = UUID.randomUUID();
			session.setAttribute(uuid.toString(), rndAuthCode);
			result.put("key", uuid.toString());
			phoneService.certifiedPhoneNumber(vo.getUsers_tel(), rndAuthCode);
		}
		return result;
	}

	// 아이디 중복체크
	@RequestMapping("/idDupCheck")
	@ResponseBody
	public Boolean idDupCheck(UsersVO vo) {
		UsersVO cvo = usersService.getId(vo);
		return cvo == null;
	}

	// 전화번호로 아이디찾기 - 인증번호 전달
	@RequestMapping("/forgotIdCheck")
	@ResponseBody
	public HashMap forgotId(UsersVO vo, HttpSession session) {
		UsersVO cvo = usersService.checkDupPhone(vo);

		HashMap<String, Object> result = new HashMap();
		result.put("flag", cvo != null);
		if (cvo != null) {
			String rndAuthCode = randomAuthCode();
			UUID uuid = UUID.randomUUID();
			session.setAttribute(uuid.toString(), rndAuthCode);
			result.put("key", uuid.toString());
			phoneService.certifiedPhoneNumber(vo.getUsers_tel(), rndAuthCode);
		}
		return result;
	}

	// 이메일 중복체크 - 인증번호 전달
	// 전화번호 중복체크
	@RequestMapping("/emailDupCheck")
	@ResponseBody
	public HashMap mailDupCheck(UsersVO vo, HttpSession session) {
		UsersVO cvo = usersService.checkDupEmail(vo);

		HashMap<String, Object> result = new HashMap();
		result.put("flag", cvo == null);
		if (cvo == null) {
			String rndAuthCode = randomAuthCode();
			UUID uuid = UUID.randomUUID();
			session.setAttribute(uuid.toString(), rndAuthCode);
			result.put("key", uuid.toString());
			mailService.joinEmail(vo.getUsersFullEmail(), rndAuthCode);
		}
		return result;
	}

	@RequestMapping("/authCodeConfirmCheck")
	   @ResponseBody
	   public Boolean phoneConfirmCheck(String key, String value, HttpSession session) {
	      String keyValue = (String) session.getAttribute(key);
	      if (keyValue == null) return null;
	      
	      boolean isEmailVerified = keyValue.equals(value);
	       session.setAttribute("isEmailVerified", isEmailVerified);
	      
	      return keyValue != null && keyValue.equals(value);
	   }

	// 전화번호로 아이디 찾기 인증번호 확인
		@RequestMapping("/forgotIdConfirm")
		@ResponseBody
		public String forgotIdConfirm(String phone, String key, String value, HttpSession session) {
			String keyValue = (String) session.getAttribute(key);
			// 인증번호가 없을경우 재발신 요청하도록 변경
			if (keyValue == null)
				return "expired";
			if (keyValue != null && keyValue.equals(value)) {
				UsersVO usersVO = new UsersVO();
				usersVO.setUsers_tel(phone);
				UsersVO cvo = usersService.checkDupPhone1(usersVO);
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); // yyyy-MM-dd HH:mm:ss
				String format = formatter.format(cvo.getUsers_new_date());
				// 사용자 정보가 있을경우 id와 가입일자 return
				return format+"/" +cvo.getUsers_id();
			}
			return "";
		}

	// 비밀번호 재설정
	@RequestMapping("/resetPassword")
	public String resetPassword() {
		return "intercept/resetPassword";
	}

	// 비밀번호 재설정 id와 전화번호 입력했을때 처리
	@RequestMapping("/resetPasswordCheck")
	@ResponseBody
	public HashMap resetPasswordCheck(UsersVO vo, HttpSession session) {
		UsersVO cvo = usersService.getId(vo);

		HashMap<String, Object> result = new HashMap();
		result.put("flag", cvo != null);
		// 입력한 id가 없는 경우
		result.put("msg", cvo == null ? "존재하지 않는 ID 입니다." : "");

		if (cvo != null) {
			// 입력한 id는 존재하지만 입력한 전화번호와 일치하지 않는경우
			if (cvo.getUsers_tel().equals(vo.getUsers_tel()) == false) {
				result.put("flag", false);
				result.put("msg", "전화번호와 일치하는 사용자가 없습니다.");
			} else {
				String rndAuthCode = randomAuthCode();
				UUID uuid = UUID.randomUUID();
				session.setAttribute(uuid.toString(), rndAuthCode);
				result.put("key", uuid.toString());
				phoneService.certifiedPhoneNumber(vo.getUsers_tel(), rndAuthCode);
			}
		}
		return result;
	}

	// 비밀번호 재설정 인증번호 입력 후 비밀번호 변경 처리
	@RequestMapping("/resetPasswordConfirm")
	@ResponseBody
	public String resetPasswordConfirm(String id, String key, String value, String password, HttpSession session) {
		// 키와 비밀번호를 한번더 받아서 체크
		String keyValue = (String) session.getAttribute(key);
		if (keyValue == null)
			return null;
		if (keyValue.equals(value)) {
			UsersVO user = new UsersVO();
			user.setUsers_id(id);
			String hashedPw = usersService.hashedChk(password);
			user.setUsers_pw(hashedPw);
			usersService.updateInfoPassword(user);
		}
		return "success";
	}

	// 휴대폰, 이메일 인증번호 생성시 사용
	// 나중에 utils쪽이나 서비스로 빼도 무관.
	private String randomAuthCode() {
		Random rand = new Random();
		String numStr = "";
		for (int i = 0; i < 6; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr += ran;
		}
		return numStr;
	}

	// 휴대폰인증
	@RequestMapping("/phoneCheck")
	@ResponseBody
	public String sendSMS(String users_tel) {
		Random rand = new Random();
		String numStr = "";
		for (int i = 0; i < 4; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr += ran;
		}
		phoneService.certifiedPhoneNumber(users_tel, numStr);

		return numStr;
	}

	// 회원정보조회
			@RequestMapping("/getUsers")
			public String getUser(UsersVO vo, Model model, HttpSession session) {
				vo.setUsers_id((String) session.getAttribute("users_id"));
				model.addAttribute("users", usersService.getUserInfo(vo)); // model로 설정했으니까 jsp에 도달하면 끊어지는거임

				if (model.getAttribute("users") != null) { // 로그인을 했을때 세션 설정해야함
					session.setAttribute("users_id", vo.getUsers_id()); // 받아와야하는 아이디값을 넣어야함

					return "userMyPage/update";
				} else {
					return "intercept/login";
				}
			}

			// 마이페이지 정보 수정(api 없음)
			@RequestMapping("/updateInfo")
			public String updateUser(@ModelAttribute("user") UsersVO vo) {
				if (usersService.updateInfo(vo) > 0) {
					return "userMyPage/userMypage";
				} else {
					return "mypage.jsp?error=1";
				}

			}

	//마이페이지 가기전 아이디랑 비밀번호 확인(5차)
			@RequestMapping(value="/update")
			public String updatepage(UsersVO vo, Model model, HttpSession session) {
				
				// parameter로 받은값
				String user_pw = vo.getUsers_pw();
				UsersVO userInfo = usersService.getUserInfo(vo);
				
				if (userInfo != null) {
					if (usersService.pwMatchChk(user_pw, userInfo.getUsers_pw())) {
						model.addAttribute("users",usersService.getUserInfo(vo));
						
						session.setAttribute("login", userInfo);
						session.setAttribute("users_id", userInfo.getUsers_id());
						session.setAttribute("users_name", userInfo.getUsers_name());
						session.setAttribute("users_role", userInfo.getUsers_role());
				
						return "userMyPage/mypage";
//						update라고 성의없이 짓지마라
					}
				}
				model.addAttribute("loginError", true);
				return "userMyPage/userMypage";
			}

	
	
			// 유저 활동페이지 로그인 확인 및 경로 전송
			   @RequestMapping("/myActionPage")
			   public String getMyActionPage(UsersVO vo, HttpSession session, Model model) {
			      // 로그인 아이디가 없으면 index 페이지로 돌아간다
			      if (session.getAttribute("users_id") == null) {
			         return "redirect:/index.jsp";
			      } else {
			         return "/userMyPage/myActionReserve";
			      }
			   }

	// 유저정보 가져오기
	@RequestMapping("/getUsersHos")
	@ResponseBody
	public List<UsersVO> getUserHos(UsersVO vo) {
		return usersService.getUsersHos(vo);

	}

	// 찜목록 아이디를 가져오기 > 병원 이름가져오는걸로 바꾼다이거야
	@RequestMapping("/getZzimHosName")
	@ResponseBody
	public List<UsersVO> getZzimHosName(UsersVO vo, Model model) {
		return usersService.getZzimHosName(vo);
	}

	// 찜 병원 삭제하기 (해당하는 컬럼의 값을 null로 update)
	@RequestMapping("/delUsersZzim")
	public String delUsersZzim(UsersVO vo) {

		usersService.delUsersZzim(vo);
		return "/userMyPage/myActionZzim";
	}

//	//마이페이지 탈퇴
	@RequestMapping("/deleteInfo")
	public String deleteUser(@ModelAttribute("user") UsersVO vo, Model model, HttpSession session) {
		if (usersService.deleteUser(vo) > 0) {
			model.addAttribute("user", usersService.deleteUser(vo));
			session.invalidate();
			return "redirect:index.jsp";
		} else {

		}
		return "redirect:/getUsers?error=1";
	}
//		모르겠다 머리가 멈춤

	// 탈퇴 페이지로 가기
	@RequestMapping("/GodeleteUser")
	public String GodeleteUser() {
		return "userMyPage/deleteUser";
	}

	// 마이페이지 이메일 인증
	@RequestMapping("/emailDupCheck2")
	@ResponseBody
	public HashMap mailDupCheck2(UsersVO vo, HttpSession session) {
		UsersVO cvo = usersService.checkDupEmail(vo);

		HashMap<String, Object> result = new HashMap();
		result.put("flag", cvo == null);
		if (cvo == null) {
			String rndAuthCode = randomAuthCode();
			UUID uuid = UUID.randomUUID();
			session.setAttribute(uuid.toString(), rndAuthCode);
			result.put("key", uuid.toString());
			mailService.updateEmail(vo.getUsersFullEmail(), rndAuthCode);
		}
		return result;
	}

	// [유저] 찐마이페이지로가기
	//세션 어트리뷰트 써서 유저 아이디 받아오고, 그거 그대로 vo에 넣어서 매퍼로 보내주면 알아서 잘 끌고올거임
		@RequestMapping("/tomypagemain")
		public String goMyPageMain(PetsVO vo,Model model,HttpSession session) {
			String id = (String) session.getAttribute("users_id"); // ID값을 넣은 세션객체를 만들어놔야 여기서 갖고 올 수 있음
			vo.setPet_users_id(id);// id값을 vo에서 세터로 설정한다.
			model.addAttribute("petsList", petsService.getPetsList(vo));
			return "userMyPage/userMypage";
		}

	// [회원] 찜페이지로가기
	@RequestMapping("/myActionZzim")
	public String myActionZzim() {
		return "userMyPage/myActionZzim";
	}

	// [회원] 예약내역 목록보기
	@RequestMapping("/myActionReserve")
	public String myActionReserve() {
		return "userMyPage/myActionReserve";
	}

	// 내정보로가기
	@RequestMapping("/gomypage")
	public String goMyPage() {
		return "userMyPage/mypage";

	}
	
	// 유저의 찜 컬럼의 개수를 가져온다 (null을 제외한)
	   @RequestMapping("/getMyZzimCnt")
	   @ResponseBody
	   public UsersVO getMyZzimCnt(UsersVO vo, Model model) {
	      return usersService.zzimCnt(vo);
	   }
	
	
	// Docat
		@RequestMapping("/getDocat")
		public String getTomcat(HttpSession session) {
			return "/search/Docat";
		}
	
		// 회원이메일수정
        @RequestMapping("/updateUsersEmail")
        public String updateUsersEmail(@ModelAttribute("user") UsersVO vo, Model model, HttpSession session) {
           
           if(session.getAttribute("isEmailVerified")==null) {
              return null;
           } else if((boolean)session.getAttribute("isEmailVerified")) {
              usersService.updateUsersEmail(vo);
              UsersVO userInfo = usersService.getUserInfo(vo);
              model.addAttribute("users", userInfo);
              return "userMyPage/mypageUpdone";
//              return "userMyPage/mypage";
           }
           return null;
        }
        
        // 회원연락처수정
        @RequestMapping("/updateUsersPhone")
        public String updateUsersPhone(@ModelAttribute("user") UsersVO vo, Model model, HttpSession session) {
           
           if(session.getAttribute("isEmailVerified")==null) {
              return null;
           } else if((boolean)session.getAttribute("isEmailVerified")) {
              usersService.updateUsersPhone(vo);
              UsersVO userInfo = usersService.getUserInfo(vo);
              model.addAttribute("users", userInfo);
              return "userMyPage/mypageUpdone";
//              return "userMyPage/mypage";
           }
           return null;
        }
}
