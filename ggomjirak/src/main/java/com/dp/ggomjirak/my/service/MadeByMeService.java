package com.dp.ggomjirak.my.service;

import com.dp.ggomjirak.vo.HobbyVo;
import com.dp.ggomjirak.vo.MadeByMeVo;

public interface MadeByMeService {
	public void mbmWrite(MadeByMeVo madebymeVo);
	public HobbyVo selectHobby(int hobby_no);
}
