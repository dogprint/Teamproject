package com.dp.ggomjirak.my.service;

import java.util.List;

import com.dp.ggomjirak.vo.HobbyVo;
import com.dp.ggomjirak.vo.LikeBookmarkVo;
import com.dp.ggomjirak.vo.MemberVo;
import com.dp.ggomjirak.vo.PagingDto;
import com.dp.ggomjirak.vo.StoryPagingDto;
import com.dp.ggomjirak.vo.StoryVo;

public interface WorkroomService {
	public List<HobbyVo> listHobby(PagingDto pagingDto);
	public int hobbyCount(String user_id);
	public MemberVo getMemInfo(String user_id);
	public List<HobbyVo> searchHobby(PagingDto pagingDto);
	public List<StoryVo> searchStory(PagingDto pagingDto);
	public int searchHobbyCount(PagingDto pagingDto);
	public int searchStoryCount(PagingDto pagingDto);
	public List<LikeBookmarkVo> listBookmark(PagingDto pagingDto);
	public int bookmarkCount(String user_id);
}
