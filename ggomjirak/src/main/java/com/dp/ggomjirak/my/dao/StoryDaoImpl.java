package com.dp.ggomjirak.my.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.dp.ggomjirak.vo.StoryPagingDto;
import com.dp.ggomjirak.vo.StoryVo;

@Repository
public class StoryDaoImpl implements StoryDao{

	private static final String NAMESPACE = "com.dp.ggomjirak.story.";
	
	@Inject
	SqlSession sqlSession;

	@Override
	public void insertStory(StoryVo storyVo) {
		System.out.println("daoStoryVo:" + storyVo);
		sqlSession.insert(NAMESPACE + "insertStory", storyVo);
	}

	@Override
	public List<StoryVo> listStory(StoryPagingDto storyPagingDto) {
		List<StoryVo> list = sqlSession.selectList(NAMESPACE + "listStory", storyPagingDto);
		return list;
	}

	@Override
	public void deleteStory(int st_no) {
		sqlSession.delete(NAMESPACE + "deleteStory", st_no);
	}

	@Override
	public void updateStory(StoryVo storyVo) {
		sqlSession.update(NAMESPACE + "updateStory", storyVo);
		
	}

	@Override
	public StoryVo selectStory(int st_no) {
		StoryVo storyVo = sqlSession.selectOne(NAMESPACE + "selectStory", st_no);
		return storyVo;
	}

	@Override
	public void updateCommentCnt(int st_no, int count) {
		Map<String, Integer> map = new HashMap<>();
		map.put("st_no", st_no);
		map.put("count", count);
		sqlSession.update(NAMESPACE + "updateCommentCnt", map);
		
	}

	@Override
	public int storyCount(StoryPagingDto storyPagingDto) {
		int count = sqlSession.selectOne(NAMESPACE + "storyCount", storyPagingDto);
		return count;
	}

	@Override
	public void updateLikeCount(int st_no, int count) {
		Map<String, Integer> map = new HashMap<>();
		map.put("st_no", st_no);
		map.put("count", count);
		sqlSession.update(NAMESPACE + "updateLikeCount", map);
	}

	@Override
	public void insertLike(int st_no, String user_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("st_no", st_no);
		map.put("user_id", user_id);
		sqlSession.insert(NAMESPACE + "insertLike", map);
	}

	@Override
	public void deleteLike(int st_no, String user_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("st_no", st_no);
		map.put("user_id", user_id);
		sqlSession.delete(NAMESPACE + "deleteLike", map);
	}

	@Override
	public int likeCheck(int st_no, String user_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("st_no", st_no);
		map.put("user_id", user_id);
		int count = sqlSession.selectOne(NAMESPACE + "likeCheck", map);
		return count;
	}

	@Override
	public int likeAll(int st_no) {
		int count = sqlSession.selectOne(NAMESPACE + "likeAll", st_no);
		System.out.println("dao count:" + count);
		return count;
	}
	
}
