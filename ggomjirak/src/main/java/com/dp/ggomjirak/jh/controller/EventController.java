package com.dp.ggomjirak.jh.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dp.ggomjirak.jh.service.EventService;
import com.dp.ggomjirak.vo.EventVo;
import com.dp.ggomjirak.vo.PagingDto;

@Controller
@RequestMapping("event")
public class EventController {
	
	@Inject
	private EventService eventService;
	
	
	// 이벤트 리스트 (진행중)
	@RequestMapping(value="/managerEvent", method=RequestMethod.GET)
	public String managerEvent(Model model, PagingDto pagingDto) throws Exception {
		int count = eventService.getCountEventAll(pagingDto);
		pagingDto.setEndRow(10);
		pagingDto.setPerPage(10);
		pagingDto.setCount(count);
		
		System.out.println("count: " + count);
		System.out.println("pagingDto: " + pagingDto);
		List<EventVo> eventListAll = eventService.showEventListAll(pagingDto);
		model.addAttribute("eventListAll", eventListAll);
		return "manager/event/manager_event";
	}
	
	// 이벤트 상세페이지
	@RequestMapping(value="/managerEventContent", method=RequestMethod.GET)
	public String managerEventContent(int e_no, Model model) throws Exception {
		EventVo eventVo = eventService.selectByEno(e_no);
		model.addAttribute("eventVo", eventVo);
		return "manager/event/manager_event_content";
	}
	
	// 이벤트 작성폼
	@RequestMapping(value="/managerEventWrite", method=RequestMethod.GET)
	public String managerEventWrite() throws Exception {
		return "manager/event/manager_event_write";
	}
	
	// 이벤트 작성 실행
	@RequestMapping(value="/managerEventWriteRun", method=RequestMethod.POST)
	public String managerEventWriteRun(EventVo eventVo, RedirectAttributes rttr) throws Exception {
		eventService.insertEvent(eventVo);
		rttr.addFlashAttribute("writeMsg", "success");
		return "redirect:/event/managerEvent";
	}
	
	
	// 이벤트 수정 페이지
	@RequestMapping(value="/managerEventModify", method=RequestMethod.GET)
	public String managerEventModify(int e_no, Model model) throws Exception {
		EventVo eventVo = eventService.selectByEno(e_no);
		model.addAttribute("eventVo", eventVo);
		return "manager/event/manager_event_modify";
	}
	
	// 이벤트 수정 실행
	@RequestMapping(value="/managerEventModifyRun", method=RequestMethod.POST)
	public String managerEventModifyRun(EventVo eventVo, RedirectAttributes rttr) throws Exception {
		eventService.updateEvent(eventVo);
		rttr.addFlashAttribute("modifyMsg", "success");
		return "redirect:/event/managerEventContent?e_no=" + eventVo.getE_no();
	}
	
	// 이벤트 삭제 실행
	@RequestMapping(value="/managerEventDeleteRun", method=RequestMethod.GET)
	public String managerEventDeleteRun(int e_no, RedirectAttributes rttr) throws Exception {
		eventService.deleteEvent(e_no);
		rttr.addFlashAttribute("deleteMsg", "success");
		return "redirect:/event/managerEvent";
	}
	
	// 메인 이벤트 리스트
	@RequestMapping(value="/managerMainEvent", method=RequestMethod.GET)
	public String managerMainEvent(Model model, PagingDto pagingDto) throws Exception {
		int count = eventService.getCountMainEventBanner(pagingDto);
		pagingDto.setEndRow(10);
		pagingDto.setPerPage(10);
		pagingDto.setCount(count);
		
		System.out.println("count: " + count);
		System.out.println("pagingDto: " + pagingDto);
		List<EventVo> mainEvent = eventService.mainEventBannerList(pagingDto);
		model.addAttribute("mainEvent", mainEvent);
		return "manager/event/manager_main_event";
	}
	
	// 메인 이벤트 등록
	@RequestMapping(value="/managerMainEventInsertRun", method=RequestMethod.GET)
	public String managerMainEventInsertRun(Model model, int e_no) throws Exception {
		eventService.insertMainEvent(e_no);
		return "redirect:/event/managerEvent";
	}
	
	// 메인 이벤트  삭제
	@RequestMapping(value="/managerMainEventDeleteRun", method=RequestMethod.GET)
	public String managerMainEventDeleteRun(Model model, int e_no) throws Exception {
		eventService.deleteMainEvent(e_no);
		return "redirect:/event/managerMainEvent";
	}

}
