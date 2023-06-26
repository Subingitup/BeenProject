package com.springbook.view.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.pet.faq.FaqVO;
import com.spring.pet.notice.NoticeService;
import com.spring.pet.notice.NoticeVO;

@Controller
@SessionAttributes("noticeSession")
public class NoticeController {

   // CRUD CREATE READ UPDATE DELETE

   @Autowired
   @Qualifier("noticeServiceImpl")
   private NoticeService noticeService;

   // css
   @RequestMapping("/resources/css/noticeCSS.css")
   public void homecss(HttpServletRequest req) {
      System.out.println("css_path" + req.getServletPath());
   }

   // js
   @RequestMapping("/resurces/js/noticejs.js")
   public void homejs(HttpServletRequest req) {
      System.out.println("js_path: " + req.getServletPath());
   }

   // [관리자] 공지사항 등록
   @RequestMapping("/insertNotice")
   public String InsertNotice(NoticeVO vo, MultipartHttpServletRequest request)
         throws IllegalStateException, IOException {

      System.out.println("고정여부값은? 0:일반, 1:고정 >> " + vo.getNotice_pin());

      String notice_cont = vo.getNotice_cont();
      notice_cont = notice_cont.replace("\r\n", "<br>");
      vo.setNotice_cont(notice_cont);
      System.out.println(notice_cont);

      MultipartFile uploadFile = vo.getNotice_file();

      SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
      Date time = new Date();
      String result = dateFormat.format(time);
//      String realPath = "c:/vet/petmedic/src/main/webapp/resources/imgs/";
      String realPath = request.getSession().getServletContext().getRealPath("/resources/imgs/");
      // C:\vet\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\petmedic\resources\noticeupload\

      String notice_realfile = uploadFile.getOriginalFilename();
      String filename = result + notice_realfile;

      if (!uploadFile.isEmpty()) {
         vo.setNotice_realfile(filename);
         uploadFile.transferTo(new File(realPath + filename));
      }

      System.out.println("insert 컨트롤러");
      noticeService.insertNotice(vo);
      return "redirect:/toAdmin_NoticeMain";
   }

// [공통] 공지사항 목록조회 > 인덱스페이지용
   @RequestMapping("/getNoticeList4Index")
   @ResponseBody
   public List<NoticeVO> getNoticeList4Index(NoticeVO vo) {
      System.out.println("인덱스용 공지사항 목록가져오기 컨트롤러~~~");
      return noticeService.getNoticeList4Index(vo);
   }

   // [관리자] 공지사항 수정 페이지로 이동
   @RequestMapping("/updateNoticePage")
   public String updateNoticeForm(NoticeVO vo, Model model) {
      System.out.println("modify jsp페이지로 이동해줘...ㅜ0ㅜ");
      vo = noticeService.getNoticeDetail(vo);
      String notice_cont = vo.getNotice_cont();
      notice_cont = notice_cont.replace("<br>", "\r\n");
      vo.setNotice_cont(notice_cont);
      model.addAttribute("noticeList", vo);
      return "notice/updateNotice.jsp?notice_int=" + vo.getNotice_int();
   }

   // [관리자] 공지사항 수정하기
      @RequestMapping("/updateNotice")
      public void updateNotice(NoticeVO vo, Model model, MultipartHttpServletRequest request, HttpServletResponse response) {

         // 개행 저장되게 하기
         String notice_cont = vo.getNotice_cont();
         notice_cont = notice_cont.replace("\r\n", "<br>");
         vo.setNotice_cont(notice_cont);

         MultipartFile uploadFile = vo.getNotice_file();
         String uprealfile = uploadFile.getOriginalFilename(); // 새로 업로드한 파일이름
         String delrealfile = vo.getNotice_realfile(); // 기존에 등록된 파일이름(삭제되어야함)
         System.out.println("새로 업로드한 파일이름: " + uprealfile);
         System.out.println("새기존에 등록된 파일이름(삭제되어야함): " + delrealfile);
         System.out.println("새로 업로드한 파일이름 수정되니: " + uprealfile);
         
//         String realPath = "c:/vet/petmedic/src/main/webapp/resources/imgs/";
         String realPath = request.getSession().getServletContext().getRealPath("/resources/imgs/");
         
         System.out.println("파일이 저장될 상대경로: " + realPath);

         if (!uprealfile.equals(null)) {
           String filenm = vo.getNotice_realfile(); // 이전에 있던 파일 이름 => 파일을 수정하지 않았을 때도 넘어온다이거야.
           System.out.println("filenm" + filenm);

//           if(filenm.equals("")) {
               if(uprealfile.equals("")) {
                  System.out.println("와라");
                  if(!filenm.equals("")) {
                     vo.setNotice_realfile(filenm);
                     System.out.println("업로드한 파일이 없고 기존파일이 있을때 : " +filenm);
                  } else {
                     filenm = null;
                     System.out.println("업로드한 파일이 없고 기존파일이 없을때 : " + filenm);
                  }
                  System.out.println("와라2+" + filenm);
               } else {
                  SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
                  Date time = new Date();
                  String result = dateFormat.format(time); // 날짜 붙이기
                  uprealfile = result + uprealfile;
                  vo.setNotice_realfile(uprealfile);
               }
//           }
            System.out.println("filenm : " + filenm);
            System.out.println("uprealfile : " + uprealfile);
            
            if (!uprealfile.equals("")) {// 새로 등록했을 때
              System.out.println("새로등록");
              File file = new File(realPath + uprealfile);
              
              if(!filenm.equals("")) {
                 System.out.println("업로드한 파일이 있고 기존파일이 있을때 : " + filenm);
                 boolean exists = file.exists();
                 while (exists) {
                      File filet = new File(realPath + uprealfile);
                      exists = filet.exists();
                   }
                 
                 Path delfilePath = Paths.get(realPath + delrealfile);
                  try {
                     uploadFile.transferTo(new File(realPath + uprealfile));
                     Files.deleteIfExists(delfilePath);
                  } catch (IllegalStateException e) {
                     e.printStackTrace();
                  } catch (IOException e) {
                     e.printStackTrace();
                  }
              } else {
                 System.out.println("업로드한 파일이 있고 기존파일이 없을때 : " + filenm);
                 try {
                  uploadFile.transferTo(new File(realPath + uprealfile));
               } catch (IllegalStateException e) {
                  e.printStackTrace();
               } catch (IOException e) {
                  e.printStackTrace();
               }
              }
            }
         } 
         noticeService.updateNotice(vo);
      }

   // [관리자] 공지사항 삭제
   @RequestMapping("/deleteNotice")
   public String deleteNotice(NoticeVO vo, Model model, MultipartHttpServletRequest request) {
      System.out.println("delete 컨트롤러");
      System.out.println("몇 번 글을 삭제할거니? " + vo.getNotice_int());
      System.out.println("파일이름이 있는가? " + vo.getNotice_realfile());
//      model.addAttribute("noticeList", noticeService.deleteNotice(vo)); //외부에서 쓰기 위한 객체
      String filenm = vo.getNotice_realfile();
//      String realPath = "c:/vet/petmedic/src/main/webapp/resources/imgs/";
      String realPath = request.getSession().getServletContext().getRealPath("/resources/imgs/");
      System.out.println("삭제할 filenm: " + filenm);
//      ♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣ 경로변경 ♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣ 
      Path filePath = Paths.get(realPath + filenm);

      if (noticeService.deleteNotice(vo) > 0) { // 1
         System.out.println("filePath ->>> " + filePath);
         System.out.println("filenm  ->>> " + filenm);
         // 파일 삭제
         try {
            Files.deleteIfExists(filePath);
         } catch (IOException e) {
            e.printStackTrace();
         }
      }
      return "redirect:/toAdmin_NoticeMain";
   }

   // [관리자] insertNotice로 이동
   @RequestMapping("/toInsertNotice")
   public String toInsertFAQ(FaqVO vo, HttpSession session) {
      System.out.println("와라");
      return "/notice/insertNotice";
   }

   // [공통] 공지사항 목록페이지로 이동
   @RequestMapping("/toGetNoticeList")
   public String getNoticePage(NoticeVO vo, HttpSession session) {
      return "notice/getNoticeList";
   }

   // 관리자 Notice로 가자 (완성되면 위의 것에서 관리자부분 없애기)
   @RequestMapping("/toAdmin_NoticeMain")
   public String adminNotice() {
      return "notice/admin_NoticeMain";

   }

   // [공통] 공지사항 목록조회
   @RequestMapping("/getNoticeList1")
   @ResponseBody
   public List<NoticeVO> getNoticeList(NoticeVO vo, Model model) {
      System.out.println("getNoticeList 컨트롤러");
      return noticeService.getNoticeList(vo);
   }

   // [공통] 공지사항 게시글 상세조회
   @RequestMapping(value = { "/getNoticeDetail" })
   public String getNoticeDetail(NoticeVO vo, Model model, HttpSession session,
         @RequestParam(value = "update", required = false) String upcnt) {
      System.out.println("getNoticeDetail 상세정보 가져오기 컨트롤러 시작");
      model.addAttribute("noticeList", noticeService.getNoticeDetail(vo));
      System.out.println("upcnt값  " + upcnt);
      // 공지사항 수정 후에는 게시글로 돌아가지만 조회수 카운트되지않게하기
      if (upcnt == null) {
         noticeService.noticeCnt(vo);
         System.out.println("조회수 +1 완료");
      } 
      
//      System.out.println("getNoticeDetail 상세정보 가져오기 컨트롤러 끗");
//      if (session.getAttribute("users_id") == null) {
//         System.out.println("상세정보의 주소는? 1이다");
//         return "notice/getNoticeDetail";
//      } else if (session.getAttribute("users_role").equals("ADMIN")
//            || session.getAttribute("users_role").equals("SUPERADMIN")) {
//         System.out.println("상세정보의 주소는? 2이다");
//         return "notice/getNoticeDetail_admin";
//      } else {
//         System.out.println("상세정보의 주소는? 3이다");
         return "notice/getNoticeDetail";
//      }
   }

   // [공통] 공지사항 게시글 상세조회 (index에서 보내주기)
   @RequestMapping("/getNoticeDetail_index")
   public String getNoticeDetail_index(NoticeVO vo, Model model, HttpSession session,
         @RequestParam(value = "update", required = false) String upcnt) {
      System.out.println("getNoticeDetail 상세정보 가져오기 컨트롤러 시작");
      model.addAttribute("noticeList", noticeService.getNoticeDetail(vo));
      System.out.println("upcnt값  " + upcnt);
      // 공지사항 수정 후에는 게시글로 돌아가지만 조회수 카운트되지않게하기
      if (upcnt == null) {
         noticeService.noticeCnt(vo);
         System.out.println("조회수 +1 완료");
      } 

      return "notice/getNoticeDetail_index";
   }
   
   // [공통] 공지사항 검색
   @RequestMapping("/searchNotice")
   @ResponseBody
   public List<NoticeVO> searchNoticeList(NoticeVO vo, Model model) {
      System.out.println("notice search 컨트롤러 시작");
      System.out.println("search카테고리: " + vo.getNoticeSearch());
      System.out.println("search키워드: " + vo.getNoticeSearchKeyword());
      return noticeService.searchNoticeList(vo);
   }
   
   // [관리자] 공지사항 목록페이지로 이동
      @RequestMapping("/toGetNoticeListAdmin")
      public String getNoticePageAdmin(NoticeVO vo, HttpSession session) {
         return "notice/getNoticeList_admin";
      }
      
      // [관리자] 공지사항 선택해서 전체삭제되도록
      @RequestMapping("/deleteCheckedNotice")
      public String deleteCheckedNotice(@RequestParam(value="notice_int", required = false) int[] notice_int_list, NoticeVO vo) {
          System.out.println("받아오는 notice_int_list 배열 몇개요? " + notice_int_list.length);
          int delSum = 0;
          
          // 배열이 가지고있는 값들을 반복해서 출력해주고 delete문을 반복해서 돌린다
          for(int notice_intValue : notice_int_list) {
              vo.setNotice_int(notice_intValue);
              System.out.println(notice_intValue + " " + "vo에 설정된 notice_int값 : " + vo.getNotice_int());
              if (noticeService.deleteNotice(vo) > 0) { delSum++; }
          }
          
          if(delSum > 0) {
             System.out.println("delSum 몇개요? " + delSum);
             return "notice/getNoticeList_admin";
          } else {
             return "error";
          }
      }
}