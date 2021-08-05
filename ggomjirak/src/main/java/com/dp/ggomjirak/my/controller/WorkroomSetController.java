package com.dp.ggomjirak.my.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dp.ggomjirak.my.dao.LikeBookmarkDao;
import com.dp.ggomjirak.my.service.WorkroomSetService;
import com.dp.ggomjirak.vo.FollowVo;
import com.dp.ggomjirak.vo.MemberVo;
import com.dp.ggomjirak.vo.WorkroomVo;

@Controller
@RequestMapping(value="/workroomset")
public class WorkroomSetController {

	@Inject
	private WorkroomSetService workroomSetService;
	
	@Inject
	private WorkroomController wrController = new WorkroomController();
	
	// 작업실 설정 메인
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public String wrSetting(Model model, HttpSession session) throws Exception {
		MemberVo memberVo = (MemberVo)session.getAttribute("loginVo");
		String user_id = memberVo.getUser_id();
		WorkroomVo workroomVo = workroomSetService.getWrSet(user_id);
		List<FollowVo> followingList = workroomSetService.followingList(user_id);
		List<LikeBookmarkDao> likeList = workroomSetService.likeList(user_id);
		wrController.category(model);
		model.addAttribute("page_id", user_id);
		model.addAttribute("followingList", followingList);
		model.addAttribute("likeList", likeList);
		model.addAttribute("workroomVo", workroomVo);
		return "workroom/wr_setting";
	}
	
	// 작업실 이름 수정
	@RequestMapping(value="/nameSet", method=RequestMethod.POST)
	@ResponseBody
	public String wrNameSet(WorkroomVo workroomVo) throws Exception {
		workroomSetService.updateWrName(workroomVo);
		return "nameSuccess";
	}
	
	// 작업실 소개
	@RequestMapping(value="/introSet", method=RequestMethod.POST)
	@ResponseBody
	public String wrIntroSet(String wr_intro, String user_id) throws Exception {
		workroomSetService.updateWrIntro(user_id, wr_intro);
		return "introSuccess";
	}
	
}




