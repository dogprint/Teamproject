package com.dp.ggomjirak.my.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.dp.ggomjirak.vo.HobbyVo;
import com.dp.ggomjirak.vo.MadeByMeVo;

@Repository
public class MadeByMeImpl implements MadeByMeDao {

	private static final String NAMESPACE = "com.dp.ggomjirak.madebyme.";
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public void insertMbm(MadeByMeVo madebymeVo) {
		sqlSession.insert(NAMESPACE + "insertMbm", madebymeVo);
	}

	@Override
	public HobbyVo selectHobby(int hobby_no) {
		HobbyVo hobbyVo = sqlSession.selectOne(NAMESPACE + "selectHobby", hobby_no);
		return hobbyVo;
	}

}
