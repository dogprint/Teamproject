package com.dp.ggomjirak.my.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.dp.ggomjirak.my.dao.WorkRoomDao;
import com.dp.ggomjirak.vo.HobbyVo;
import com.dp.ggomjirak.vo.LikeBookmarkVo;
import com.dp.ggomjirak.vo.MemberVo;
import com.dp.ggomjirak.vo.PagingDto;
import com.dp.ggomjirak.vo.StoryPagingDto;
import com.dp.ggomjirak.vo.StoryVo;

@Service
public class WorkroomServiceImpl implements WorkroomService {

	@Inject
	WorkRoomDao workroomDao;

	@Override
	public List<HobbyVo> listHobby(PagingDto pagingDto) {
		List<HobbyVo> list = workroomDao.listHobby(pagingDto);
		return list;
	}

	@Override
	public int hobbyCount(String user_id) {
		int count = workroomDao.hobbyCount(user_id);
		return count;
	}
	
	@Override
	public MemberVo getMemInfo(String user_id) {
		MemberVo memberVo = workroomDao.getMemInfo(user_id);
//		System.out.println("service:" + memberVo);
		return memberVo;
	}

	@Override
	public List<HobbyVo> searchHobby(PagingDto pagingDto) {
		List<HobbyVo> list = workroomDao.searchHobby(pagingDto);
		return list;
	}

	@Override
	public List<StoryVo> searchStory(PagingDto pagingDto) {
		List<StoryVo> list = workroomDao.searchStory(pagingDto);
		return list;
	}

	@Override
	public int searchHobbyCount(PagingDto pagingDto) {
		int count = workroomDao.searchHobbyCount(pagingDto);
		return count;
	}

	@Override
	public int searchStoryCount(PagingDto pagingDto) {
		int count = workroomDao.searchStoryCount(pagingDto);
		return count;
	}

	@Override
	public List<LikeBookmarkVo> listBookmark(PagingDto pagingDto) {
		List<LikeBookmarkVo> list = workroomDao.listBookmark(pagingDto);
		return list;
	}

	@Override
	public int bookmarkCount(String user_id) {
		int count = workroomDao.bookmarkCount(user_id);
		return count;
	}


}
