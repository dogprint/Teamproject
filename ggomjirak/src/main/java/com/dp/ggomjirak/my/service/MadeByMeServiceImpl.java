package com.dp.ggomjirak.my.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.dp.ggomjirak.my.dao.MadeByMeDao;
import com.dp.ggomjirak.vo.HobbyVo;
import com.dp.ggomjirak.vo.MadeByMeVo;

@Service
public class MadeByMeServiceImpl implements MadeByMeService {

	@Inject
	MadeByMeDao madebymeDao;
	
	@Override
	public void mbmWrite(MadeByMeVo madebymeVo) {
		madebymeDao.insertMbm(madebymeVo);
	}

	@Override
	public HobbyVo selectHobby(int hobby_no) {
		HobbyVo hobbyVo = madebymeDao.selectHobby(hobby_no);
		return hobbyVo;
	}

}
