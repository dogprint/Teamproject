package com.dp.ggomjirak.yj.dao;

import java.util.List;

import com.dp.ggomjirak.vo.CateVo;
import com.dp.ggomjirak.vo.CostVo;
import com.dp.ggomjirak.vo.LevelVo;
import com.dp.ggomjirak.vo.TimeVo;

public interface CateDao {
	
	public List<CateVo> getCateList();
	public List<TimeVo> getTimeList();
	public List<LevelVo> getLevelList();
	public List<CostVo> getCostList();
}
