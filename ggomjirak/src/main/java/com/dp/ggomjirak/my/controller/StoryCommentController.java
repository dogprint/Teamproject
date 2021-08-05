package com.dp.ggomjirak.my.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.dp.ggomjirak.my.service.StoryCommentService;
import com.dp.ggomjirak.vo.MemberVo;
import com.dp.ggomjirak.vo.StoryCommentVo;

@RestController
@RequestMapping("/st_comment")
public class StoryCommentController {
	
	@Inject
	private StoryCommentService storyCommentService;
	
	// 댓글쓰기
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public Map<String, Object> stCommentWrite(StoryCommentVo storyCommentVo, HttpSession session) throws Exception {
		MemberVo memberVo = (MemberVo)session.getAttribute("loginVo");
		String user_id = memberVo.getUser_id();
		storyCommentVo.setUser_id(user_id);
		storyCommentService.writeComment(storyCommentVo);
		int commentCount = storyCommentService.commentCount(storyCommentVo.getSt_no());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", "success");
		map.put("commentCount", commentCount);
		return map;
	}
	
	// 댓글 목록
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public List<StoryCommentVo> stCommentList(int st_no) throws Exception {
		List<StoryCommentVo> list = storyCommentService.listComment(st_no);
		return list;
	}
	
	// 수정
	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public String stCommentModify(int st_c_no, String st_c_content) throws Exception {
		storyCommentService.updateComment(st_c_no, st_c_content);
		return "success";
	}
	
	// 댓글 삭제
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public Map<String, Object> stCommentDelete(int st_no, int st_c_no) throws Exception {
		storyCommentService.deleteComment(st_no, st_c_no);
		int commentCount = storyCommentService.commentCount(st_no);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", "success");
		map.put("commentCount", commentCount);
		return map;
	}
	
}








