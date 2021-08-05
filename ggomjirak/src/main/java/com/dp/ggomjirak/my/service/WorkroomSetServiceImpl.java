package com.dp.ggomjirak.my.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.dp.ggomjirak.my.dao.LikeBookmarkDao;
import com.dp.ggomjirak.my.dao.WorkroomSetDao;
import com.dp.ggomjirak.vo.FollowVo;
import com.dp.ggomjirak.vo.WorkroomVo;

@Service
public class WorkroomSetServiceImpl implements WorkroomSetService {

	@Inject
	WorkroomSetDao workroomSetDao;
	
	@Override
	public WorkroomVo getWrSet(String user_id) {
		WorkroomVo workroomVo = workroomSetDao.getWrSet(user_id);
		return workroomVo;
	}

	@Override
	public void updateWrName(WorkroomVo workroomVo) {
		workroomSetDao.updateWrName(workroomVo);
	}

	@Override
	public void updateWrIntro(String user_id, String wr_intro) {
		workroomSetDao.updateWrIntro(user_id, wr_intro);
	}

	@Override
	public List<FollowVo> followingList(String follower) {
		List<FollowVo> list = workroomSetDao.followingList(follower);
		return list;
	}

	@Override
	public List<LikeBookmarkDao> likeList(String user_id) {
		List<LikeBookmarkDao> list = workroomSetDao.likeList(user_id);
		return list;
	}

}
