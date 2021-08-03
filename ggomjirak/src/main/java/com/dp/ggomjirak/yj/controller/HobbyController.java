package com.dp.ggomjirak.yj.controller;

import java.util.List;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dp.ggomjirak.vo.CateVo;
import com.dp.ggomjirak.vo.CostVo;
import com.dp.ggomjirak.vo.HobbyVo;
import com.dp.ggomjirak.vo.LevelVo;
import com.dp.ggomjirak.vo.TimeVo;
import com.dp.ggomjirak.yj.service.CateService;
import com.dp.ggomjirak.yj.service.HobbyService;

import net.sf.json.JSONArray;

//수정
@Controller
@RequestMapping("/hobby")
public class HobbyController {
	
	@Inject
	private HobbyService hobbyService;
	
	private String swalIcon = null;
	private String swalTitle = null;
	
	@Inject
	private CateService cateService;
	
	private static final Logger logger = LoggerFactory.getLogger(HobbyController.class);
	
	@RequestMapping(value="/content/{hobby_no}", method=RequestMethod.GET)
	public String content(Model model, @PathVariable("hobby_no") int hobby_no,
			HttpServletRequest request) throws Exception {
		HobbyVo hobbyVo = hobbyService.selectHobbyArticle(hobby_no, false);
		List<CateVo> cates = cateService.getCateList();
		model.addAttribute("cates", JSONArray.fromObject(cates));
		model.addAttribute("hobbyVo", hobbyVo);
		model.addAttribute("url", request.getRequestURL());
		return "hobby/content";
	}
	
	@RequestMapping(value="/update/{hobby_no}", method=RequestMethod.GET)
	public String update(Model model, @PathVariable("hobby_no") int hobby_no) throws Exception {
		
		HobbyVo hobbyVo = hobbyService.selectHobbyArticle(hobby_no, true);
		model.addAttribute("hobbyVo", hobbyVo);
		
		List<CateVo> cates = cateService.getCateList();
		List<TimeVo> times = cateService.getTimeList();
		List<LevelVo> levels = cateService.getLevelList();
		List<CostVo> costs = cateService.getCostList();
		model.addAttribute("cates", JSONArray.fromObject(cates));
		model.addAttribute("times", JSONArray.fromObject(times));
		model.addAttribute("levels", JSONArray.fromObject(levels));
		model.addAttribute("costs", JSONArray.fromObject(costs));
		return "hobby/modify_form";
	}
	
	@RequestMapping(value="/updateRun", method=RequestMethod.POST)
	public String updateRun(@ModelAttribute HobbyVo hobbyVo, 
			HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		System.out.println(hobbyVo);
		boolean result = hobbyService.updateHobbyArticle(hobbyVo);
		String url = null;
		
		if(result == true) {
			swalIcon = "success";
			swalTitle = "수정 성공";
			url = "redirect:/hobby/content/" + hobbyVo.getHobby_no();
		} else {
			swalIcon = "error";
			swalTitle = "수정 실패";
			// 이전페이지의 URL 
			url = "redirect:" + request.getHeader("referer");
		}
		
		rttr.addFlashAttribute("swalIcon",swalIcon);
		rttr.addFlashAttribute("swalTitle", swalTitle);
		
		return url;
	}
	
	@RequestMapping(value="/insert", method=RequestMethod.GET)
	public String insert(Model model) throws Exception {
		List<CateVo> cates = cateService.getCateList();
		List<TimeVo> times = cateService.getTimeList();
		List<LevelVo> levels = cateService.getLevelList();
		List<CostVo> costs = cateService.getCostList();
		model.addAttribute("cates", JSONArray.fromObject(cates));
		model.addAttribute("times", JSONArray.fromObject(times));
		model.addAttribute("levels", JSONArray.fromObject(levels));
		model.addAttribute("costs", JSONArray.fromObject(costs));
		return "hobby/write_form";
	}
	
	@RequestMapping(value="/insertRun", method=RequestMethod.POST)
	public String insertRun(HobbyVo hobbyVo, RedirectAttributes rttr) throws Exception {
		System.out.println(hobbyVo);
		
		boolean result = hobbyService.insertHobbyArticle(hobbyVo);

		String url = null;
		String msgInsert = null;
		
		if(result == true) {
			msgInsert = "success";
			url = "redirect:/hobby/listAll";
		} else {
			msgInsert = "fail";
			url = "redirect:/hobby/insert";
		}
		
		
		rttr.addFlashAttribute("msgInsert", msgInsert);
		return url;
	}
	
	// 게시글 삭제
	@RequestMapping("delete/{hobby_no}")
	public String deleteMarket(@PathVariable("hobby_no") int hobby_no,
							 HttpServletRequest request, RedirectAttributes rttr) {
		
		int result = hobbyService.deleteHobbyArticle(hobby_no);
		
		String url = null;
		String msgDelete = null;
		if(result > 0) {
			msgDelete = "success";
			url = "redirect:/hobby/listAll";
		} else {
			msgDelete = "fail";
			// 이전페이지의 URL 
			url = "redirect:" + request.getHeader("referer");
		}
		
		rttr.addFlashAttribute("msgDelete",msgDelete);
		return url;
	}
	
	
	@RequestMapping(value="/listAll", method=RequestMethod.GET)
	public String hobbyList() throws Exception {
		return "hobby/hobby_list";
	}
	

	
	@RequestMapping(value="/test", method=RequestMethod.GET)
	public String test() throws Exception {
		return "hobby/test";
	}
	
	
}