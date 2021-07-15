package com.dp.ggomjirak.jh.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("main")
public class MainHomeController {

	@RequestMapping(value="/mainHome2", method=RequestMethod.GET)
	public String mainHome2() throws Exception {
		return "main/main_home2";
	}
	
	@RequestMapping(value="/mainHome3", method=RequestMethod.GET)
	public String mainHome3() throws Exception {
		return "main/main_home3";
	}
	
	@RequestMapping(value="/mainHobby", method=RequestMethod.GET)
	public String mainHobby() throws Exception {
		return "main/main_hobby";
	}
	
	@RequestMapping(value="/mainEvent", method=RequestMethod.GET)
	public String mainEvent() throws Exception {
		return "main/main_event";
	}
	
	@RequestMapping(value="/mainAboutUs", method=RequestMethod.GET)
	public String mainAboutUs() throws Exception {
		return "main/main_about_us";
	}
	
	@RequestMapping(value="/mainSearch", method=RequestMethod.GET)
	public String mainSearch() throws Exception {
		return "main/main_search";
	}
}
