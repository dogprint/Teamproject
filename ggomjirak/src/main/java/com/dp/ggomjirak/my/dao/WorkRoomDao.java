package com.dp.ggomjirak.my.dao;

import java.util.List;

import com.dp.ggomjirak.vo.HobbyVo;
import com.dp.ggomjirak.vo.LikeBookmarkVo;
import com.dp.ggomjirak.vo.MemberVo;
import com.dp.ggomjirak.vo.PagingDto;
import com.dp.ggomjirak.vo.StoryPagingDto;
import com.dp.ggomjirak.vo.StoryVo;

public interface WorkRoomDao {
	// 취미 리스트
	public List<HobbyVo> listHobby(PagingDto pagingDto);
	// 취미 총 갯수
	public int hobbyCount(String user_id);
	// 프로필카드용 유저정보
	public MemberVo getMemInfo(String user_id);
	// 취미, 스토리 검색
	public List<HobbyVo> searchHobby(PagingDto pagingDto);
	public List<StoryVo> searchStory(PagingDto pagingDto);
	// 검색 후 총 갯수
	public int searchHobbyCount(PagingDto pagingDto);
	public int searchStoryCount(PagingDto pagingDto);
	// 북마크 목록 불러오기
	public List<LikeBookmarkVo> listBookmark(PagingDto pagingDto);
	// 북마크 총 갯수
	public int bookmarkCount(String user_id);
}
