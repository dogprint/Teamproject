package com.dp.ggomjirak.jh.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dp.ggomjirak.jh.dao.ManagerDao;
import com.dp.ggomjirak.vo.CateStrVo;
import com.dp.ggomjirak.vo.ManagerVo;
import com.dp.ggomjirak.vo.MemberActivVo;
import com.dp.ggomjirak.vo.MemberVo;
import com.dp.ggomjirak.vo.PagingDto;
import com.dp.ggomjirak.vo.WorkroomVo;

@Service
public class ManagerServiceImpl implements ManagerService {

	@Inject
	private ManagerDao managerDao;


	@Override
	public List<MemberVo> showMemberList(PagingDto pagingDto) {
		List<MemberVo> list = managerDao.showMemberList(pagingDto);
		return list;
	}

	@Override
	public List<MemberVo> showMemberListLeave(PagingDto pagingDto) {
		List<MemberVo> list = managerDao.showMemberListLeave(pagingDto);
		return list;
	}
	

	@Override
	public int getCountMemberList(PagingDto pagingDto) {
		int count = managerDao.getCountMemberList(pagingDto);
		return count;
	}

	@Override
	public int getCountMemberListLeave(PagingDto pagingDto) {
		int count = managerDao.getCountMemberListLeave(pagingDto);
		return count;
	}


	@Override
	public List<ManagerVo> showManagerList(PagingDto pagingDto) {
		List<ManagerVo> list = managerDao.showManagerList(pagingDto);
		return list;
	}

	@Override
	public int getCountManager(PagingDto pagingDto) {
		int count = managerDao.getCountManager(pagingDto);
		return count;
	}

	@Override
	public MemberVo selectMemberById(String user_id) {
		MemberVo memberVo = managerDao.selectMemberById(user_id);
		return memberVo;
	}
	

	@Override
	public CateStrVo selectCateStr(String user_id) {
		CateStrVo cateVo = managerDao.selectCateStr(user_id);
		return cateVo;
	}

	@Override
	public String selectGradeById(String user_id) {
		String grade = managerDao.selectGradeById(user_id);
		return grade;
	}

	@Override
	public MemberActivVo selectMemberActivById(String user_id) {
		MemberActivVo activeVo = managerDao.selectMemberActivById(user_id);
		return activeVo;
	}

	@Override
	public String selectMemberIntroById(String user_id) {
		String intro = managerDao.selectMemberIntroById(user_id);
		return intro;
	}

	@Transactional
	@Override
	public void updateMember(MemberVo memberVo, WorkroomVo workroomVo) {
		managerDao.updateMemberInfo(memberVo);
		managerDao.updateMemberDetail(memberVo);
		managerDao.updateMemberWorkroom(workroomVo);
		
	}


	@Override
	public void deleteMember(String user_id) {
		managerDao.deleteMember(user_id);
		
	}

	@Override
	public void cancleDeleteMember(String user_id) {
		managerDao.cancleDeleteMember(user_id);
		
	}
	

	@Override
	public void insertManager(ManagerVo managerVo) {
		managerDao.insertManager(managerVo);
		
	}

	@Override
	public void deleteManager(String user_id) {
		managerDao.deleteManager(user_id);
		
	}
	

	@Override
	public List<MemberVo> selectPopularMemberList() {
		List<MemberVo> list = managerDao.selectPopularMemberList();
		return list;
	}

	@Override
	public int getMemberCount() {
		int count = managerDao.getMemberCount();
		return count;
	}

	@Override
	public List<Integer> getAllUserGrade() {
		List<Integer> list = managerDao.getAllUserGrade();
		return list;
	}















}
