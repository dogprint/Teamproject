package com.dp.ggomjirak.my.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.dp.ggomjirak.vo.HobbyVo;
import com.dp.ggomjirak.vo.LikeBookmarkVo;
import com.dp.ggomjirak.vo.MemberVo;
import com.dp.ggomjirak.vo.PagingDto;
import com.dp.ggomjirak.vo.StoryPagingDto;
import com.dp.ggomjirak.vo.StoryVo;

@Repository
public class WorkroomDaoImpl implements WorkRoomDao {

	private static final String NAMESPACE = "com.dp.ggomjirak.workroom.";
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<HobbyVo> listHobby(PagingDto pagingDto) {
		List<HobbyVo> list = sqlSession.selectList(NAMESPACE + "listHobby", pagingDto);
		return list;
	}
	
	@Override
	public int hobbyCount(String user_id) {
		int count = sqlSession.selectOne(NAMESPACE + "hobbyCount", user_id);
		return count;
	}
	
	@Override
	public MemberVo getMemInfo(String user_id) {
		MemberVo memberVo = sqlSession.selectOne(NAMESPACE + "getMemInfo", user_id);
//		System.out.println(memberVo);
		return memberVo;
	}

	@Override
	public List<HobbyVo> searchHobby(PagingDto pagingDto) {
		List<HobbyVo> list = sqlSession.selectList(NAMESPACE + "searchHobby", pagingDto);
		return list;
	}

	@Override
	public List<StoryVo> searchStory(PagingDto pagingDto) {
		List<StoryVo> list = sqlSession.selectList(NAMESPACE + "searchStory" , pagingDto);
		return list;
	}

	@Override
	public int searchHobbyCount(PagingDto pagingDto) {
		int count = sqlSession.selectOne(NAMESPACE + "searchHobbyCount", pagingDto);
		return count;
	}

	@Override
	public int searchStoryCount(PagingDto pagingDto) {
		int count = sqlSession.selectOne(NAMESPACE + "searchStoryCount", pagingDto);
		return count;
	}

	@Override
	public List<LikeBookmarkVo> listBookmark(PagingDto pagingDto) {
		List<LikeBookmarkVo> list = sqlSession.selectList(NAMESPACE + "listBookmark", pagingDto);
		return list;
	}

	@Override
	public int bookmarkCount(String user_id) {
		int count = sqlSession.selectOne(NAMESPACE + "bookmarkCount", user_id);
		return count;
	}

}
