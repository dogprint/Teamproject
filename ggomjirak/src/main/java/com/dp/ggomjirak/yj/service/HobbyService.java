package com.dp.ggomjirak.yj.service;

import java.util.List;

import com.dp.ggomjirak.vo.CompleteImgVo;
import com.dp.ggomjirak.vo.HobbyMaterialVo;
import com.dp.ggomjirak.vo.HobbyVo;
import com.dp.ggomjirak.vo.MakeStepVo;

public interface HobbyService {
	
	/** 글작성
	 * @param hobbyVo
	 */
	public void insertHobbyArticle (HobbyVo hobbyVo); 
	
	public HobbyVo selectHobbyArticle (int hobby_no, boolean isUpdate);
	
	public String selectCompleteImgName (CompleteImgVo completeImgVo);
	public String selectMainImg(int hobby_no);
//	public String selectMakeStepImg(MakeStepVo makeStepVo);
	
	//* 수정작업
	public void updateHobbyArticle(HobbyVo hobbyVo);
}
