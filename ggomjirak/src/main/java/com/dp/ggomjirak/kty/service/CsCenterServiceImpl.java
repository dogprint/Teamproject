package com.dp.ggomjirak.kty.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dp.ggomjirak.kty.dao.CsCenterDao;
import com.dp.ggomjirak.vo.QnAVo;

@Service
public class CsCenterServiceImpl implements CsCenterService {

	@Inject
	private CsCenterDao csCenterDao;

	@Override
	public List<QnAVo> listAll(String userID) {
		List<QnAVo> list = csCenterDao.listAll(userID);
		return list;
	}

	@Transactional
	@Override
	public void wirteRun(QnAVo qnAVo) {
		int nextval = csCenterDao.getNextVal();
		//System.out.println("csCenterDao.getNextVal():" + nextval);
		qnAVo.setQna_no(nextval);
		//System.out.println("qnAVo:" + qnAVo);
		csCenterDao.insertArticle(qnAVo);
	}
	
	@Override
	public QnAVo content(int qna_no) {
		QnAVo qnAVo = csCenterDao.selectByBno(qna_no);
		return qnAVo;
	}

	@Transactional
	@Override
	public void updateRun(QnAVo qnAVo) {
		csCenterDao.updateArticle(qnAVo);
	}

	@Transactional
	@Override
	public void deleteRun(int qna_no) {
		csCenterDao.deleteArticle(qna_no);
	}


}
