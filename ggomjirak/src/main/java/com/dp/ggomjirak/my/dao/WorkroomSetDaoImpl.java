package com.dp.ggomjirak.my.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.dp.ggomjirak.vo.FollowVo;
import com.dp.ggomjirak.vo.WorkroomVo;

@Repository
public class WorkroomSetDaoImpl implements WorkroomSetDao {

	private static final String NAMESPACE = "com.dp.ggomjirak.workroomset.";
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public WorkroomVo getWrSet(String user_id) {
		WorkroomVo workroomVo = sqlSession.selectOne(NAMESPACE + "getWrSet", user_id);
		return workroomVo;
	}

	@Override
	public void updateWrName(WorkroomVo workroomVo) {
//		Map<String, String> map = new HashMap<String, String>();
//		map.put("wr_name", wr_name);
//		map.put("user_id", user_id);
		sqlSession.update(NAMESPACE + "updateWrName", workroomVo);
	}

	@Override
	public void updateWrIntro(String user_id, String wr_intro) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("wr_intro", wr_intro);
		map.put("user_id", user_id);
		sqlSession.update(NAMESPACE + "updateWrIntro", map);
		
	}

	@Override
	public List<FollowVo> followingList(String follower) {
		List<FollowVo> list = sqlSession.selectList(NAMESPACE + "followingList", follower);
		return list;
	}

	@Override
	public List<LikeBookmarkDao> likeList(String user_id) {
		List<LikeBookmarkDao> list = sqlSession.selectList(NAMESPACE + "likeList", user_id);
		return list;
	}

}
