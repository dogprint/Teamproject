package com.dp.ggomjirak.jh.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dp.ggomjirak.jh.service.EventService;
import com.dp.ggomjirak.jh.service.MainService;
import com.dp.ggomjirak.jh.service.ManagerService;
import com.dp.ggomjirak.vo.CateStrVo;
import com.dp.ggomjirak.vo.CateVo;
import com.dp.ggomjirak.vo.EventVo;
import com.dp.ggomjirak.vo.HobbyVo;
import com.dp.ggomjirak.vo.MemberVo;
import com.dp.ggomjirak.vo.PagingDto;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("main")
public class MainController {
	
	@Inject
	private MainService mainService;
	
	@Inject
	private ManagerService managerService;
	
	@Inject
	private EventService eventService;
	

	@RequestMapping(value="/mainHome", method=RequestMethod.GET)
	public String mainHome(Model model, PagingDto pagingDto, HttpSession session) throws Exception {
//		MemberVo memberVo = (MemberVo)session.getAttribute("loginVo");
//		String user_id = memberVo.getUser_id();
		String user_id = "hong";
		List<CateVo> category = mainService.selectCate();


		int count = eventService.getCountBanner(pagingDto);
		pagingDto.setCount(count);
		
		
		System.out.println("count: " + count);
		System.out.println("pagingDto: " + pagingDto);
		List<EventVo> mainEvent = eventService.getEventBannerList();
		model.addAttribute("mainEvent", mainEvent);
		model.addAttribute("pagingDto", pagingDto);
		
		List<HobbyVo> suggestHobby = mainService.getSuggestHobby(user_id);
		List<HobbyVo> popularHobby = mainService.getPopularHobbyList();
		List<HobbyVo> monthHobby = mainService.getMonthHobbyList();
		List<MemberVo> popularMember1 = mainService.getPopularMemberList1();
		List<MemberVo> popularMember2 = mainService.getPopularMemberList2();
		List<MemberVo> popularMember3 = mainService.getPopularMemberList3();
		List<MemberVo> popularMember4 = mainService.getPopularMemberList4();
		CateStrVo cateStrVo = managerService.selectCateStr(user_id);

		model.addAttribute("cates", JSONArray.fromObject(category));
		model.addAttribute("suggestHobby", suggestHobby);
		model.addAttribute("popularHobby", popularHobby);
		model.addAttribute("monthHobby", monthHobby);
		model.addAttribute("popularMember1", popularMember1);
		model.addAttribute("popularMember2", popularMember2);
		model.addAttribute("popularMember3", popularMember3);
		model.addAttribute("popularMember4", popularMember4);
		model.addAttribute("cateStrVo", cateStrVo);
		model.addAttribute("user_id", user_id);
		return "main/main_home";
	}
	
	@RequestMapping(value="/mainHobby", method=RequestMethod.GET)
	public String mainHobby(Model model, PagingDto pagingDto) throws Exception {
		List<CateVo> category = mainService.selectCate();
		model.addAttribute("cates", JSONArray.fromObject(category));
//		int count = mainService.getCountHobbyList(pagingDto);
		int count = mainService.getCountHobbyCate(pagingDto);
		pagingDto.setPerPage(16);
		pagingDto.setEndRow(16);
		pagingDto.setCount(count);
		
		
		System.out.println("count: " + count);
		System.out.println("pagingDto: " + pagingDto);
		
		List<CateVo> bigSort = mainService.cateBigSort();
		List<CateVo> smallSort = mainService.cateSmallSort();
		model.addAttribute("bigSort", bigSort);
		model.addAttribute("smallSort", smallSort);
		
		List<HobbyVo> cateHobby = mainService.searchHobbyCate(pagingDto);
		
		model.addAttribute("cateHobby", cateHobby);

		List<HobbyVo> hobbyPopular = mainService.hobbyListPopular(pagingDto);
		model.addAttribute("hobbyPopular", hobbyPopular);
		model.addAttribute("pagingDto", pagingDto);
		return "main/main_hobby";
	}

	// 이벤트 리스트
	@RequestMapping(value="/mainEvent", method=RequestMethod.GET)
	public String mainEvent(Model model, PagingDto pagingDto) throws Exception {
		List<CateVo> category = mainService.selectCate();
		model.addAttribute("cates", JSONArray.fromObject(category));
		
		int count = eventService.getCountEvent(pagingDto);
		pagingDto.setCount(count);
		
		System.out.println("count: " + count);
		System.out.println("pagingDto: " + pagingDto);
		List<EventVo> eventList = eventService.showEventList(pagingDto);
		model.addAttribute("eventList", eventList);
		return "main/main_event";
	}
	// 전체 이벤트
	@RequestMapping(value="/mainEventListAll", method=RequestMethod.GET)
	public String mainEventListAll(Model model, PagingDto pagingDto) throws Exception {
		List<CateVo> category = mainService.selectCate();
		model.addAttribute("cates", JSONArray.fromObject(category));
		
		int count = eventService.getCountEventAll(pagingDto);
		pagingDto.setCount(count);
		
		System.out.println("count: " + count);
		System.out.println("pagingDto: " + pagingDto);
		List<EventVo> eventListAll = eventService.showEventListAll(pagingDto);
		model.addAttribute("eventListAll", eventListAll);
		return "main/main_event_all";
	}
	
	// 완료된 이벤트
	@RequestMapping(value="/mainEventListEnd", method=RequestMethod.GET)
	public String mainEventListEnd(Model model, PagingDto pagingDto) throws Exception {
		List<CateVo> category = mainService.selectCate();
		model.addAttribute("cates", JSONArray.fromObject(category));
		
		int count = eventService.getCountEventEnd(pagingDto);
		pagingDto.setCount(count);
		
		System.out.println("count: " + count);
		System.out.println("pagingDto: " + pagingDto);
		List<EventVo> eventListEnd = eventService.showEventListEnd(pagingDto);
		model.addAttribute("eventListEnd", eventListEnd);
		return "main/main_event_end";
	}

	// 이벤트 상세페이지
	@RequestMapping(value="/mainEventContent", method=RequestMethod.GET)
	public String mainEventContent(int e_no, Model model) throws Exception {
		List<CateVo> category = mainService.selectCate();
		model.addAttribute("cates", JSONArray.fromObject(category));
		EventVo eventVo = eventService.selectByEno(e_no);
		model.addAttribute("eventVo", eventVo);
		return "main/main_event_content";
	}
	
	@RequestMapping(value="/mainAboutUs", method=RequestMethod.GET)
	public String mainAboutUs(Model model) throws Exception {
		List<CateVo> category = mainService.selectCate();
		model.addAttribute("cates", JSONArray.fromObject(category));
		return "main/main_about_us";
	}
	
	@RequestMapping(value="/mainSearch", method=RequestMethod.GET)
	public String mainSearch(PagingDto pagingDto, Model model) throws Exception {
		List<CateVo> category = mainService.selectCate();
		model.addAttribute("cates", JSONArray.fromObject(category));
		int count1 = mainService.getCountHobbySearch(pagingDto);
		int count2 = mainService.getCountMemberSearch(pagingDto);
		int count;
		if (count1 >= count2) {
			count = count1;
		} else {
			count = count2;
		}
		pagingDto.setCount(count);
		
		System.out.println("count: " + count);
		System.out.println("pagingDto: " + pagingDto);
		
		List<HobbyVo> searchHobbyList = mainService.searchHobby(pagingDto);
		List<MemberVo> searchMemberList = mainService.searchMember(pagingDto);
		model.addAttribute("searchHobbyList", searchHobbyList);
		model.addAttribute("searchMemberList", searchMemberList);
		model.addAttribute("pagingDto", pagingDto);
		return "main/main_search";
	}
	
	// 카테고리
	public void getHobbyCate(Model model) throws Exception {
		
	}
}
