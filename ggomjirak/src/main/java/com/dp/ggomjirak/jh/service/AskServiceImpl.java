package com.dp.ggomjirak.jh.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dp.ggomjirak.jh.dao.AskDao;
import com.dp.ggomjirak.vo.PagingDto;
import com.dp.ggomjirak.vo.QnAVo;

@Service
public class AskServiceImpl implements AskService {
	
	@Inject
	private AskDao askDao;

	// 문의
	@Override
	public List<QnAVo> selectQnAList(PagingDto pagingDto) {
		List<QnAVo> list = askDao.selectQnAList(pagingDto);
		return list;
	}

	@Override
	public int getCountQnA(PagingDto pagingDto) {
		int count = askDao.getCountQnA(pagingDto);
		return count;
	}

	@Override
	public int getCountQnAMain() {
		int count = askDao.getCountQnAMain();
		return count;
	}

	@Override
	public QnAVo selectQnaByNo(int qna_no) {
		QnAVo qnaVo = askDao.selectQnaByNo(qna_no);
		return qnaVo;
	}

	@Transactional
	@Override
	public void insertAnswer(QnAVo qnaVo) {
		int nextval = askDao.getNextVal();
		qnaVo.setQna_no(nextval);
		askDao.insertAnswer(qnaVo);
		System.out.println(nextval);
		qnaVo.setQna_no(qnaVo.getA_no());
		qnaVo.setA_no(nextval);
		askDao.updateAno(qnaVo);
		System.out.println("service: " + qnaVo);
	}

}
