package com.dp.ggomjirak.my.dao;

import com.dp.ggomjirak.vo.HobbyVo;
import com.dp.ggomjirak.vo.MadeByMeVo;

public interface MadeByMeDao {
	public void insertMbm(MadeByMeVo madebymeVo);
	public HobbyVo selectHobby(int hobby_no);
}
