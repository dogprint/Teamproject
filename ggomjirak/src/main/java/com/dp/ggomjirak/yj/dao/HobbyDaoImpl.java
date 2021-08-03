package com.dp.ggomjirak.yj.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.dp.ggomjirak.vo.CompleteImgVo;
import com.dp.ggomjirak.vo.HobbyMaterialVo;
import com.dp.ggomjirak.vo.HobbyVo;
import com.dp.ggomjirak.vo.MakeStepVo;
import com.dp.ggomjirak.vo.MaterialVo;

@Repository
public class HobbyDaoImpl implements HobbyDao {
	
	private static final String NAMESPACE = "com.dp.ggomjirak.hobby.";
	
	@Inject
	SqlSession sqlSession;
	
	
	@Override
	public int insertHobby(HobbyVo hobbyVo) {
		sqlSession.insert(NAMESPACE + "insertHobby", hobbyVo);
		return hobbyVo.getHobby_no();
	}

	@Override
	public HobbyVo selectHobby2(HobbyVo hobbyVo) {
		return sqlSession.selectOne(NAMESPACE + "selectHobby2", hobbyVo);
	}
	
	@Override
	public HobbyVo selectHobby(int hobby_no) {
		return sqlSession.selectOne(NAMESPACE + "selectHobby", hobby_no);
	}

	@Override
	public void insertMakeStepVo(List<MakeStepVo> makeSteps) {
		sqlSession.insert(NAMESPACE + "insertMakeStep", makeSteps);
		
	}


	@Override
	public void insertHobbyMaterial(List<HobbyMaterialVo> hobbyMaterials) {
		sqlSession.insert(NAMESPACE + "insertHobbyMaterial", hobbyMaterials);
		
	}

	
	@Override
	public void insertCompleteImg(List<CompleteImgVo> completeImgs) {
		sqlSession.insert(NAMESPACE + "insertCompleteImg", completeImgs);
		
	}

	@Override
	public List<HobbyMaterialVo> selectHobbyMaterialList2(HobbyVo hobbyVo) {
		return sqlSession.selectList(NAMESPACE + "selectHobbyMaterialList2", hobbyVo);
	}

	@Override
	public List<HobbyMaterialVo> selectHobbyMaterialList(int hobby_no) {
		return sqlSession.selectList(NAMESPACE + "selectHobbyMaterialList", hobby_no);
	}

	@Override
	public List<MakeStepVo> selectMakeStepList2(HobbyVo hobbyVo) {
		return sqlSession.selectList(NAMESPACE + "selectMakeStepList2", hobbyVo);
	}

	@Override
	public List<MakeStepVo> selectMakeStepList(int hobby_no) {
		return sqlSession.selectList(NAMESPACE + "selectMakeStepList", hobby_no);
	}

	@Override
	public List<CompleteImgVo> selectCompleteImgListNotNull(int hobby_no) {
		return sqlSession.selectList(NAMESPACE + "selectCompleteImgListNotNull", hobby_no);
	}

	@Override
	public List<CompleteImgVo> selectCompleteImgListAll(int hobby_no) {
		return sqlSession.selectList(NAMESPACE + "selectCompleteImgListAll", hobby_no);
	}

	@Override
	public String selectCompleteImgName(CompleteImgVo completeImgVo) {
		return sqlSession.selectOne(NAMESPACE + "selectCompleteImgName", completeImgVo);
		
	}

	@Override
	public String selectMainImg(int hobby_no) {
		return sqlSession.selectOne(NAMESPACE + "selectMainImg", hobby_no);
	}


	@Override
	public void updateHobbyMaterial(List<HobbyMaterialVo> hobbyMaterials) {
		sqlSession.update(NAMESPACE + "updateHobbyMaterial", hobbyMaterials);
	}

	@Override
	public void updateMakeStep(List<MakeStepVo> makeSteps) {
		sqlSession.update(NAMESPACE + "updateMakeStep", makeSteps);
	}

	@Override
	public void deleteHobbyMaterial(List<HobbyMaterialVo> hobbyMaterials) {
		sqlSession.update(NAMESPACE + "deleteHobbyMaterial", hobbyMaterials);
	}

	@Override
	public void deleteMakeStep(List<MakeStepVo> makeSteps) {
		sqlSession.update(NAMESPACE + "deleteMakeStep", makeSteps);
	}

	@Override
	public void updateCompleteImg(List<CompleteImgVo> completeImgs) {
		sqlSession.update(NAMESPACE + "updateCompleteImg", completeImgs);
	}

	@Override
	public void updateHobby(HobbyVo hobbyVo) {
		sqlSession.update(NAMESPACE + "updateHobby", hobbyVo);
		
	}






}
