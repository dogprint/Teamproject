package com.dp.ggomjirak.my.service;

import java.util.List;

import com.dp.ggomjirak.my.dao.LikeBookmarkDao;
import com.dp.ggomjirak.vo.FollowVo;
import com.dp.ggomjirak.vo.WorkroomVo;

public interface WorkroomSetService {
	public WorkroomVo getWrSet(String user_id);
	public void updateWrName(WorkroomVo workroomVo);
	public void updateWrIntro(String user_id, String wr_intro);
	public List<FollowVo> followingList(String follower);
	public List<LikeBookmarkDao> likeList(String user_id);
}
