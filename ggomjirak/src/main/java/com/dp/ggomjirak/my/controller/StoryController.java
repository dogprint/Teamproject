package com.dp.ggomjirak.my.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dp.ggomjirak.my.service.StoryCommentService;
import com.dp.ggomjirak.my.service.StoryService;
import com.dp.ggomjirak.vo.MemberVo;
import com.dp.ggomjirak.vo.StoryCommentVo;
import com.dp.ggomjirak.vo.StoryPagingDto;
import com.dp.ggomjirak.vo.StoryVo;

@Controller
@RequestMapping(value="/story")
public class StoryController {
	
	@Inject
	private StoryService storyService;
	
	@Inject
	private StoryCommentService storyCommentService;
	
	@Inject
	private WorkroomController wrController = new WorkroomController();
	
	// 스토리
	@RequestMapping(value="/list/{user_id}", method=RequestMethod.GET)
	public String wrStoryList(@PathVariable("user_id") String page_id, Model model, StoryPagingDto storyPagingDto, HttpSession session) throws Exception {
		storyPagingDto.setUser_id(page_id);
		int count = storyService.storyCount(storyPagingDto);
		storyPagingDto.setCount(count);
		List<StoryVo> list = storyService.StoryList(storyPagingDto);
//		int likeCheck = 0;
//		for (int i = 0; i < list.size(); i++) {
//			StoryVo vo = list.get(i);
//			int st_no = vo.getSt_no();
//			likeCheck = storyService.likeCheck(st_no, user_id);
//			System.out.println(likeCheck);
//			System.out.println(st_no);
//			model.addAttribute("likeCheck", likeCheck);
//		}
		// 카드프로필 공통 메서드
		wrController.profileCommon(page_id, model, session);
		wrController.category(model);
		model.addAttribute("list", list);
		model.addAttribute("storyPagingDto", storyPagingDto);
		return "workroom/wr_story";
	}
	
	// 스토리 상세
	@RequestMapping(value="/detail/{user_id}", method=RequestMethod.GET)
	public String wrStoryDetail(@PathVariable("user_id") String page_id, int st_no, Model model, HttpSession session) throws Exception {
		MemberVo memberVo = (MemberVo)session.getAttribute("loginVo");
		String user_id = memberVo.getUser_id();
		StoryVo storyVo = storyService.StorySelect(st_no);
		List<StoryCommentVo> list = storyCommentService.listComment(st_no);
		wrController.profileCommon(page_id, model, session);
		int likeCheck = storyService.likeCheck(st_no, user_id);
		
		wrController.category(model);
		model.addAttribute("likeCheck", likeCheck);
		model.addAttribute("storyVo", storyVo);
		model.addAttribute("list", list);
		return "workroom/wr_story_detail";
	}
	
	// 작성, 수정 -> page_id받을 필요 없이  session값 받아서 실행
	// 스토리 작성 폼
	@RequestMapping(value="/write", method=RequestMethod.GET)
	public String wrStoryWrite(Model model, HttpSession session) throws Exception {
		MemberVo memberVo = (MemberVo)session.getAttribute("loginVo");
		String user_id = memberVo.getUser_id();
		wrController.profileCommon(user_id, model, session);
		wrController.category(model);
		return "workroom/wr_story_write";
	}
	
	// 스토리 작성
	@RequestMapping(value="/write_run", method=RequestMethod.POST)
	public String wrStoryWriteRun(StoryVo storyVo, Model model, HttpSession session) throws Exception {
		// 세션 아이디값 받기
		MemberVo memberVo = (MemberVo)session.getAttribute("loginVo");
		String user_id = memberVo.getUser_id();
		storyVo.setUser_id(user_id);
		storyService.StoryWrite(storyVo);
		System.out.println("storyVo:" + storyVo);
		wrController.profileCommon(user_id, model, session);
		wrController.category(model);
		return "redirect:/workroom/main/" + user_id;
	}
	
	// 스토리 수정폼
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public String wrStoryUpdate(int st_no, Model model, HttpSession session) throws Exception {
		// 세션 아이디값 받기
		MemberVo memberVo = (MemberVo)session.getAttribute("loginVo");
		String user_id = memberVo.getUser_id();
		StoryVo storyVo = storyService.StorySelect(st_no);
		wrController.profileCommon(user_id, model, session);
		wrController.category(model);
		model.addAttribute("storyVo", storyVo);
		return "workroom/wr_story_update";
	}
	
	// 스토리 수정실행
	@RequestMapping(value="/update_run", method=RequestMethod.POST)
	public String wrStoryUpdateRun(StoryVo storyVo, HttpSession session) throws Exception {
		MemberVo memberVo = (MemberVo)session.getAttribute("loginVo");
		String user_id = memberVo.getUser_id();
		storyVo.setUser_id(user_id);
		storyService.StoryUpdate(storyVo);
		return "redirect:/workroom/main/" + user_id;
	}
	
	// 스토리 삭제 실행
	@RequestMapping(value="/delete_run", method=RequestMethod.GET)
	public String wrStoryDeleteRun(int st_no) throws Exception {
		storyService.StoryDelete(st_no);
		return "redirect:/story/list";
	}
	
	// 스토리 좋아요
	@RequestMapping(value="/like/{st_no}", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> like(@PathVariable("st_no") int st_no, HttpSession session) throws Exception {
		MemberVo memberVo = (MemberVo)session.getAttribute("loginVo");
		String user_id = memberVo.getUser_id();
		Map<String, Object> map = new HashMap<>();
		boolean result = storyService.like(st_no, user_id);
		int likeCount = storyService.likeAll(st_no);
		map.put("likeCount", likeCount);
		if (result == true) {
			map.put("like", "like");
			return map;
		}
		map.put("cancel", "cancel");
		return map;
	}
	
//	//이미지 출력
//	@RequestMapping(value="/displayImage", method=RequestMethod.GET)
//	@ResponseBody
//	public ResponseEntity<byte[]> displayImage(String filePath) throws Exception {
//		System.out.println(filePath);
//		FileInputStream fis = new FileInputStream(filePath);
//		HttpHeaders header = new HttpHeaders();
//        header.setContentType(MediaType.IMAGE_JPEG);
//        ResponseEntity<byte[]> entity = new ResponseEntity<byte[]>(
//        		 IOUtils.toByteArray(fis), 
//        		 header,
//        		 HttpStatus.CREATED);
//        fis.close();
//		return entity;
//	}
//		
//	//이미지 파일 업로드
//	@RequestMapping(value="/uploadImg", method=RequestMethod.POST, produces="application/text;charset=utf-8")
//	@ResponseBody
//	public String uploadImg(MultipartFile file, String sort) throws Exception {
//		System.out.println("file:" + file);
//		System.out.println("sort:" + sort);
//		String orgFileName = file.getOriginalFilename();
//		System.out.println("orgFileName:" + orgFileName);
//		String thumbPath = null;
//		switch (sort) {
//		case "mainImg":
//			thumbPath = MyFileUploadUtil.uploadImage(MAIN_IMG_UPLOAD_PATH, 
//					 orgFileName, file.getBytes(), 300, 260);
//			break;
//		case "stepImg":
//			thumbPath = MyFileUploadUtil.uploadImage(STEP_IMG_UPLOAD_PATH, 
//					 orgFileName, file.getBytes(), 170, 170);
//			break;
//		case "complImg":
//			thumbPath = MyFileUploadUtil.uploadImage(COMPLETE_IMG_UPLOAD_PATH, 
//					 orgFileName, file.getBytes(), 140, 140);
//			break;
//		case "eventImg":
//			thumbPath = MyFileUploadUtil.uploadImage(EVENT_IMG_UPLOAD_PATH, 
//					orgFileName, file.getBytes(), 500, 300);
//			break;
//		
//		}
//		return thumbPath;
//	}
//
//	//첨부파일 서버에서 삭제
//	@RequestMapping(value="/deleteFile", method=RequestMethod.GET)
//	@ResponseBody
//	public String deleteImg(String fileName) throws Exception {
//		if (MyFileUploadUtil.deleteFile(fileName)) {
//			return "success";
//		};
//		return "fail";
//	}

}



