package com.dp.ggomjirak.jh.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.dp.ggomjirak.jh.dao.EventDao;
import com.dp.ggomjirak.vo.EventVo;
import com.dp.ggomjirak.vo.PagingDto;

@Service
public class EventServiceImpl implements EventService {
	
	@Inject
	private EventDao eventDao;

	@Override
	public List<EventVo> getEventBannerList() {
		List<EventVo> list = eventDao.getEventBannerList();
		return list;
	}

	@Override
	public int getCountBanner(PagingDto pagingDto) {
		int count = eventDao.getCountBanner(pagingDto);
		return count;
	}

	@Override
	public List<EventVo> showEventListAll(PagingDto pagingDto) {
		List<EventVo> list = eventDao.showEventListAll(pagingDto);
		return list;
	}
	
	@Override
	public List<EventVo> showEventList(PagingDto pagingDto) {
		List<EventVo> list = eventDao.showEventList(pagingDto);
		return list; 
	}

	@Override
	public List<EventVo> showEventListEnd(PagingDto pagingDto) {
		List<EventVo> list = eventDao.showEventListEnd(pagingDto);
		return list;
	}

	@Override
	public List<EventVo> showEventListDelete(PagingDto pagingDto) {
		List<EventVo> list = eventDao.showEventListDelete(pagingDto);
		return list;
	}

	@Override
	public int getCountEventAll(PagingDto pagingDto) {
		int count = eventDao.getCountEventAll(pagingDto);
		return count;
	}

	@Override
	public int getCountEvent(PagingDto pagingDto) {
		int count = eventDao.getCountEvent(pagingDto);
		return count;
	}

	@Override
	public int getCountEventEnd(PagingDto pagingDto) {
		int count = eventDao.getCountEventEnd(pagingDto);
		return count;
	}

	@Override
	public int getCountEventDelete(PagingDto pagingDto) {
		int count = eventDao.getCountEventDelete(pagingDto);
		return count;
	}

	@Override
	public EventVo selectByEno(int e_no) {
		EventVo eventVo = eventDao.selectByEno(e_no);
		return eventVo;
	}

	@Override
	public void insertEvent(EventVo eventVo) {
		eventDao.insertEvent(eventVo);
	}

	@Override
	public void updateEvent(EventVo eventVo) {
		eventDao.updateEvent(eventVo);
		
	}

	@Override
	public void deleteEvent(int e_no) {
		eventDao.deleteEvent(e_no);
		eventDao.deleteMainEvent(e_no);
	}

	@Override
	public List<EventVo> mainEventBannerList(PagingDto pagingDto) {
		List<EventVo> list = eventDao.mainEventBannerList(pagingDto);
		return list;
	}

	@Override
	public int getCountMainEventBanner(PagingDto pagingDto) {
		int count = eventDao.getCountMainEventBanner(pagingDto);
		return count;
	}

	@Override
	public void insertMainEvent(int e_no) {
		eventDao.insertMainEvent(e_no);
		
	}

	@Override
	public void deleteMainEvent(int e_no) {
		eventDao.deleteMainEvent(e_no);
		
	}



}
