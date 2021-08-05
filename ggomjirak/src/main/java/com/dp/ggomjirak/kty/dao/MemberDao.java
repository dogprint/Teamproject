package com.dp.ggomjirak.kty.dao;

import java.util.List;

import com.dp.ggomjirak.vo.CateVo;
import com.dp.ggomjirak.vo.MemberVo;

public interface MemberDao {
	
	public MemberVo login(String user_id, String user_pw);
	
	public boolean checkDupId(String user_id);
	public boolean checkDupNick(String user_nick);
	public void insertMember(MemberVo memberVo);
	
	public MemberVo info(String user_id);
	
	public void updateArticle(MemberVo memberVo);
	public void updateAttach(MemberVo memberVo);
	public boolean checkDupNickProfile(String user_id, String user_nick);
	public void updateProfileArticle(MemberVo memberVo);
	public void updateSetupArticle(MemberVo memberVo);
	
	public List<CateVo> selectCate();
	public List<CateVo> cateBigSort();
	public List<CateVo> cateSmallSort();

}	
