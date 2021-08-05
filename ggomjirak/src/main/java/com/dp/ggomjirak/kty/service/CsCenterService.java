package com.dp.ggomjirak.kty.service;

import java.util.List;

//import com.dp.ggomjirak.vo.PagingDto;
import com.dp.ggomjirak.vo.QnAVo;

public interface CsCenterService {
	
	public List<QnAVo> listAll(String userID);
	public void wirteRun(QnAVo qnAVo);
	public QnAVo content(int qna_no);
	public void updateRun(QnAVo qnAVo);
	public void deleteRun(int qna_no);
	
}
