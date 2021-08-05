package com.dp.ggomjirak.my.controller;


import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dp.ggomjirak.my.service.MadeByMeService;
import com.dp.ggomjirak.vo.HobbyVo;
import com.dp.ggomjirak.vo.MadeByMeVo;
import com.dp.ggomjirak.vo.MemberVo;

@Controller
@RequestMapping(value="/mbm")
public class MadeByMeController {
	
	@Inject
	MadeByMeService madebymeService;
	
	@RequestMapping("/write/{hobby_no}")
	public String mbmWrite(@PathVariable("hobby_no")int hobby_no, Model model, HttpSession session) throws Exception {
		MemberVo memberVo = (MemberVo)session.getAttribute("loginVo");
		
		HobbyVo hobbyVo = madebymeService.selectHobby(hobby_no);
		model.addAttribute("user_id", memberVo.getUser_id());
		model.addAttribute("hobbyVo", hobbyVo);
		return "workroom/madebyme_write";
	}
	
	@RequestMapping("/writeRun")
	public String mbmWriteRun(MadeByMeVo madebymeVo, HttpSession session) throws Exception {
		MemberVo memberVo = (MemberVo)session.getAttribute("loginVo");
		System.out.println(madebymeVo);
		String user_id = memberVo.getUser_id();
		madebymeVo.setUser_id(user_id);
		madebymeService.mbmWrite(madebymeVo);
		return "redirect:/hobby/content/" + madebymeVo.getHobby_no();
	}

}





