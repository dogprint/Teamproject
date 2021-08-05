package com.dp.ggomjirak.kty.controller;

import java.io.FileInputStream;
//import java.sql.Timestamp;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
//import org.omg.CORBA.TIMEOUT;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

//import com.dp.ggomjirak.HomeController;
import com.dp.ggomjirak.kty.service.MyPageService;
import com.dp.ggomjirak.kty.util.MyFileUploadUtil;
import com.dp.ggomjirak.vo.CateVo;
import com.dp.ggomjirak.vo.LoginVo;
import com.dp.ggomjirak.vo.MemberVo;
//import com.twelvemonkeys.util.Time;

import net.sf.json.JSONArray;

@Controller
@RequestMapping(value = "/mypage")
public class MyPageController {
	
	@Resource
	private String rootPath;

	@Inject
	private MyPageService myPageService;

	// 팀플 - 마이 페이지
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String mypageForm() throws Exception {
		return "mypage/member_login";
	}

	// 로그인 폼
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginForm() throws Exception {
		return "mypage/member_login";
	}

	// 로그인 폼
	@RequestMapping(value = "/loginRun", method = RequestMethod.POST)
	public String loginRun(Locale locale, String user_id, String user_pw, RedirectAttributes rttr, HttpSession session)
			throws Exception {
		System.out.println("로그인 폼 컨트롤러 들어옴...");

		String msg = null;
		String page = null;

		MemberVo memberVo = myPageService.login(user_id, user_pw);
		if (memberVo != null) {
			msg = "success";
			// page = "redirect:/mypage/infoForm";
			page = "redirect:/main/mainHome";

			session.setAttribute("loginVo", memberVo);
			System.out.println("loginVo 세션 설정함");

//			LoginVo loginVo = new LoginVo(memberVo.getUser_id(), null);
//			System.out.println(loginVo);

			String requestPath = (String) session.getAttribute("requestPath");
			session.removeAttribute("requestPath");
			if (requestPath != null) {
				page = "redirect:" + requestPath;
			}

			// 인터셉터 추가로 수정 (2021-08-04)
			if (session.getAttribute("loginVo") != null) {
				memberVo = (MemberVo) session.getAttribute("loginVo");
			}

		} else {
			msg = "fail";
			page = "redirect:/mypage/login";
		}
		rttr.addFlashAttribute("msg", msg);
		rttr.addFlashAttribute("memberVo", memberVo);
		return page;
	}

	// 마이 페이지 - 회원 가입
	@RequestMapping(value = "/joinForm", method = RequestMethod.GET)
	public String joinForm(Model model) throws Exception {
		System.out.println("마이 페이지 컨트롤러의 회원 가입 폼 들어감");
		// 회원 프로필로 옮겨야 될 내용
		// List<CateVo> list1 = myPageService.listHobbyCate1();
		// model.addAttribute("list1", list1);
		// System.out.println(list1);
		return "mypage/member_join";
	}

	// 마이 페이지 - 회원 가입 처리
	@RequestMapping(value = "/joinRun", method = RequestMethod.POST)
	public String joinRun(MemberVo memberVo, RedirectAttributes rttr) throws Exception {
		System.out.println("마이 페이지 컨트롤러의 회원 가입 처리를 시작합니다.");
		System.out.println("memberVo.toString(): " + memberVo.toString());
		myPageService.insertMember(memberVo);
		rttr.addFlashAttribute("msg", "success");
		// return "redirect:/mypage/infoForm?user_id=" + memberVo.getUser_id();
		// 회원 가입 처리 후 다시 로그인
		return "redirect:/mypage/login";
	}

	// 마이 페이지 - 회원 가입 - 아이디 중복 확인 버튼 클릭시 비동기 방식으로 요청 확인 부분
	@RequestMapping(value = "/checkDupId", method = RequestMethod.GET)
	@ResponseBody
	public String checkDupId(String user_id) throws Exception {
		System.out.println("마이 페이지 컨트롤러의 아이디 중복 확인 들어갑니다.");
		boolean result = myPageService.checkDupId(user_id);
		return String.valueOf(result);
	}

	// 마이 페이지 - 회원 가입 - 닉네임 중복 확인 버튼 클릭시 비동기 방식으로 요청 확인 부분
	@RequestMapping(value = "/checkDupNick", method = RequestMethod.GET)
	@ResponseBody
	public String checkDupNick(String user_nick) throws Exception {
		System.out.println("마이 페이지 컨트롤러의 닉네임 중복 확인 들어갑니다.");
		boolean result = myPageService.checkDupNick(user_nick);
		return String.valueOf(result);
	}

	// 마이 페이지 - 회원 가입 대분류 선택하면 연결되는 중분류만 나타나는 부분 // 회원 프로필로 옮겨야 될 내용
	@RequestMapping(value = "/changeCate", method = RequestMethod.GET)
	public String changeCate(int parent_cate_no, Model model) throws Exception {
		System.out.println("회원 가입 대분류 선택하면 연결되는 중분류만 나타나는 부분 추가 중...");
		System.out.println("parent_cate_no:" + parent_cate_no);
		return "mypage/member_join";
	}

	// 마이 페이지 - 회원 정보 폼 -> 수정하기 버튼이 있고 버튼을 누르면 수정하기 폼으로 들어가도록 구현
	@RequestMapping(value = "/infoForm", method = RequestMethod.GET)
	public String infoForm(String user_id, MemberVo memberVo, Model model, HttpSession session) throws Exception {
		System.out.println("마이 페이지 컨트롤러의 회원 정보 폼 들어감");
		System.out.println("loginVo라는 세션에 저장한 내용 memberVo에 다시 저장");

		if (session.getAttribute("loginVo") != null) {
			memberVo = (MemberVo) session.getAttribute("loginVo");
			memberVo = myPageService.info(memberVo.getUser_id());
		}

		System.out.println(memberVo);
		model.addAttribute("memberVo", memberVo);
		return "mypage/member_info";
	}

	// 마이 페이지 - 회원 정보 수정 폼
	@RequestMapping(value = "/modifyForm", method = RequestMethod.GET)
	public String modifyForm(Model model, HttpSession session) throws Exception {
		System.out.println("마이 페이지 컨트롤러의 회원 정보 수정 폼 들어옴...");

		if (session.getAttribute("loginVo") != null) {
			MemberVo memberVo = (MemberVo) session.getAttribute("loginVo");
			model.addAttribute("memberVo", memberVo);
		}

		return "mypage/member_modify";
	}

	// 마이 페이지 - 회원 정보 수정 실행
	@RequestMapping(value = "/modifyRun", method = RequestMethod.POST)
	public String modifyRun(MemberVo memberVo, RedirectAttributes rttr) throws Exception {
		System.out.println("마이 페이지의 컨트롤러의 회원 정보 수정 실행 처리 중...");
		System.out.println("memberVo: " + memberVo.toString());

		myPageService.modifyRun(memberVo);
		rttr.addFlashAttribute("msg", "success");
		// MemberVo memberVo = (MemberVo)session.getAttribute("loginVo");
		// model.addAttribute("memberVo", memberVo); // ???
		// return "redirect:/mypage/modifyForm?user_id="+ memberVo.getUser_id();
		return "redirect:/mypage/infoForm?user_id=" + memberVo.getUser_id();
	}

	// 마이 페이지 - 나의 프로필 수정 폼
	@RequestMapping(value = "/profileForm", method = RequestMethod.GET)
	public String profileForm(MemberVo memberVo, HttpSession session, Model model) throws Exception {
		System.out.println("마이 페이지 컨트롤러의 프로필 수정 폼 들어감...");

		// 취미 카테고리 선택 추가
		List<CateVo> category = myPageService.selectCate();
		// List<CateVo> bigSort = myPageService.cateBigSort();
		// List<CateVo> smallSort = myPageService.cateSmallSort();
		// 인터셉터 추가로 수정 2021-08-04
		if (session.getAttribute("loginVo") != null) {

			memberVo = (MemberVo) session.getAttribute("loginVo");
			memberVo = myPageService.info(memberVo.getUser_id());
			System.out.println(memberVo);

			model.addAttribute("memberVo", memberVo);
			model.addAttribute("cates", JSONArray.fromObject(category));
			// model.addAttribute("bigSort", bigSort);
			// model.addAttribute("smallSort", smallSort);
		}
		
		return "mypage/member_profile";
	}

	// 마이 페이지 - 회원 프로필 수정 - 닉네임 중복 확인 버튼 클릭시 비동기 방식으로 요청 확인 부분
	@RequestMapping(value = "/checkDupNickProfile", method = RequestMethod.GET)
	@ResponseBody
	public String checkDupNickProfile(String user_id, String user_nick) throws Exception {
		System.out.println("마이 페이지 컨트롤러의 프로필 수정 닉네임 중복 확인 들어갑니다.");
		System.out.println("user_id: " + user_id);
		System.out.println("user_nick: " + user_nick);
		boolean result = myPageService.checkDupNickProfile(user_id, user_nick);
		return String.valueOf(result);
	}
	
	// 마이 페이지 - 나의 프로필 수정 실행
	@RequestMapping(value = "/modifyProfileRun", method = RequestMethod.POST)
	public String modifyProfileRun(MemberVo memberVo, HttpSession session, RedirectAttributes rttr, String fileName)
			throws Exception {
		System.out.println("마이 페이지 컨트롤러의 나의 프로필 수정 실행 처리 중...");
		System.out.println("memberVo: " + memberVo);

		// String orgFileName = file.getOriginalFilename();
		// System.out.println("orgFileName: " + orgFileName);
		// String filePath = MyFileUploadUtil.uploadFile("C:/user_img", orgFileName, file.getBytes());

		System.out.println("fileName: " + fileName);
		memberVo.setUser_img(fileName);

		// memberVo.setUser_id((MemberVo)session.getAttribute("loginVo"));
		System.out.println("로그인 아이디 memberVo.getUser_id(): " + memberVo.getUser_id());
		System.out.println("memberVo.getUser_nick(): " + memberVo.getUser_nick());
		System.out.println("memberVo.getCate_no1(): " + memberVo.getCate_no1());
		System.out.println("memberVo.getCate_no2(): " + memberVo.getCate_no2());
		System.out.println("memberVo.getCate_no3(): " + memberVo.getCate_no3());
		System.out.println("memberVo.getCate_etc(): " + memberVo.getCate_etc());
		System.out.println("memberVo.getUser_img(): " + memberVo.getUser_img());

		myPageService.modifyProfileRun(memberVo);
		rttr.addFlashAttribute("msg", "success");

		// model.addAttribute("memberVo", memberVo);
		// return "redirect:/mypage/infoForm?user_id=" + memberVo.getUser_id();
		// return "redirect:/mypage/profileForm?user_id=" + memberVo.getUser_id();
		return "redirect:/mypage/profileForm?user_id=" + memberVo.getUser_id();
	}

//	// 프로필 이미지 첨부파일 추가  - 비동기 방식으로 요청 확인 부분
//	@RequestMapping(value = "/uploadAjax", method = RequestMethod.POST, produces = "application/text;charset=utf-8")
//	@ResponseBody
//	public String uploadAjax(MultipartFile file) throws Exception {
//		System.out.println("마이 페이지 컨트롤러의 프로필 이미지 첨부파일 추가 비동기 요청 처리 중...");
//		System.out.println("file: " + file);
//		String originalFilename = file.getOriginalFilename();
//
//		System.out.println("1 originalFileName: " + originalFilename);
//		// String filePath = MyFileUploadUtil.uploadFile("C:/upload", originalFilename,
//		// file.getBytes());
//		// String filePath = MyFileUploadUtil.uploadFile("//192.168.0.217/git2",
////		String filePath = MyFileUploadUtil.uploadFile(MyFileUploadUtil.rootPath , originalFilename, file.getBytes());
////		String filePath = MyFileUploadUtil.uploadFile(MyFileUploadUtil.rootPath 
////													+ MyFileUploadUtil.serverUploadPath_Profile, 
////				                                      originalFilename, file.getBytes());
//
//		// String filePath =
//		// MyFileUploadUtil.uploadFile(MyFileUploadUtil.serverUploadPath_Profile, originalFilename, file.getBytes());
//		String filePath = MyFileUploadUtil.uploadFile(MyFileUploadUtil.serverUploadPath_Profile, originalFilename, file.getBytes());
//		
//		System.out.println("5 filePath:" + filePath);
//		return filePath;
//	}

	// 프로필 이미지 첨부파일 추가  - 비동기 방식으로 요청 확인 부분
	@RequestMapping(value = "/uploadAjax", method = RequestMethod.POST, produces = "application/text;charset=utf-8")
	@ResponseBody
	public String uploadAjax(MultipartFile file) throws Exception {
		System.out.println("마이 페이지 컨트롤러의 프로필 이미지 첨부파일 추가 비동기 요청 처리 중...");
		System.out.println("file: " + file);
		String originalFilename = file.getOriginalFilename();

		System.out.println("originalFilename:" + originalFilename);
		// String filePath = MyFileUploadUtil.uploadFile("C:/upload", originalFilename,
		// file.getBytes());
		// String filePath = MyFileUploadUtil.uploadFile("//192.168.0.217/git2",
//		String filePath = MyFileUploadUtil.uploadFile(MyFileUploadUtil.serverFilePath , originalFilename, file.getBytes());
//		String filePath = MyFileUploadUtil.uploadFile(MyFileUploadUtil.serverFilePath 
//													+ MyFileUploadUtil.serverUploadPath_Profile, 
//				                                      originalFilename, file.getBytes());

		// String filePath =
		// MyFileUploadUtil.uploadFile(MyFileUploadUtil.serverUploadPath_Profile,
		// originalFilename, file.getBytes());
		String filePath = MyFileUploadUtil.uploadFile(MyFileUploadUtil.serverUploadPath_Profile, originalFilename,
				file.getBytes());

		System.out.println("filePath:" + filePath);
		// originalFilename, file.getBytes());
		return filePath;
	}
	
//	// 썸네일 이미지 요청
//	@RequestMapping(value = "/displayImage", method = RequestMethod.GET)
//	@ResponseBody
//	public byte[] displayImage(String fileName) throws Exception {
//		System.out.println("마이 페이지 컨트롤러의 프로필 썸네일 이미지 요청 처리 중...");
////		FileInputStream fis = new FileInputStream(fileName);
//		FileInputStream fis = new FileInputStream(rootPath + "/" + fileName);
//		System.out.println( rootPath + "/" + fileName);
//		
//		byte[] bytes = IOUtils.toByteArray(fis);
//		fis.close();
//		return bytes;
//	}

	// 썸네일 이미지 요청
	@RequestMapping(value = "/displayImage", method = RequestMethod.GET)
	@ResponseBody
	public byte[] displayImage(String fileName) throws Exception {
		System.out.println("마이 페이지 컨트롤러의 프로필 썸네일 이미지 요청 처리 중...");
//			FileInputStream fis = new FileInputStream(fileName);
		FileInputStream fis = new FileInputStream(MyFileUploadUtil.serverFilePath + "/" + fileName);
		byte[] bytes = IOUtils.toByteArray(fis);
		fis.close();
		return bytes;
	}
		
	// 첨부파일 삭제
	@RequestMapping(value = "/deleteFile", method = RequestMethod.GET)
	@ResponseBody
	public String deleteFile(String fileName) throws Exception {
		System.out.println("마이 페이지 컨트롤러의 프로필 첨부파일 이미지 삭제 처리 중...");
		MyFileUploadUtil.deleteFile(fileName);
		return "success";
	}

	// 마이 페이지 - 알람 설정 폼
	@RequestMapping(value = "/alarmSetUp", method = RequestMethod.GET)
	public String alarmSetup(MemberVo memberVo, HttpSession session, Model model) throws Exception {
		System.out.println("마이 페이지 - 알람 설정 폼에 들어감");
		
		memberVo = (MemberVo) session.getAttribute("loginVo");
		memberVo = myPageService.info(memberVo.getUser_id());
		System.out.println(memberVo);
		
		model.addAttribute("memberVo", memberVo);
		return "mypage/member_setup";
	}
	
	// 마이 페이지 - 알람 설정 수정 - 비동기 방식 처리
	@RequestMapping(value = "/alarmSetUp", method = RequestMethod.POST)
	@ResponseBody
	public String alarmSetUp(MemberVo memberVo) throws Exception {
		System.out.println("마이 페이지의 회원 알림 정보 수정 비동기 방식 처리 중...");
		System.out.println(memberVo);

		myPageService.alarmSetUpRun(memberVo);
		// rttr.addFlashAttribute("msg", "success");
		// return "mypage/member_setup";
		return "success";
	}
		
	// 마이 페이지 - 알람 설정 폼
	@RequestMapping(value = "/alarmSetUpRun", method = RequestMethod.POST)
	public String alarmSetUpRun(String onOff, MemberVo memberVo, LoginVo loginVo, RedirectAttributes rttr)
			throws Exception {
		System.out.println("마이 페이지의 회원 알림 정보 수정 실행 처리 중...");
		System.out.println("onOff: " + onOff);

		// myPageService.alarmSetUpRun(HomeController.userID, onOff);
		// memberVo.setUser_id(HomeController.userID);
		memberVo.setUser_id(loginVo.getUser_id());
		memberVo.setOnOff(onOff);

		myPageService.alarmSetUpRun(memberVo);
		rttr.addFlashAttribute("msg", "success");

		// return "redirect:/mypage/alarmSetUpRun?user_id="+ memberVo.getUser_id();
		return "mypage/member_setup";
	}
	
	// 마이 페이지 - 회원 탈퇴 - 추가 예정
	@RequestMapping(value = "/withdrawalForm", method = RequestMethod.GET)
	public String withdrawalForm() throws Exception {
		System.out.println("마이 페이지 컨트롤러의 회원 탈퇴 폼 들어옴... 추가 예정입니다.");
		return "mypage/member_login";
	}

	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(Locale locale, Model model, HttpSession session) throws Exception {
		System.out.println("마이페이지 - 로그아웃");
		session.invalidate(); // 현재 세션 무효화
								// removeAttribute() 모두
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
		
		// HomeController.userFormattedDate = dateFormat.format(date);
		// System.out.println("종료 시간: " + HomeController.userFormattedDate);
		System.out.println("종료 시간: " + formattedDate);

		return "redirect:/mypage/login";
	}
}