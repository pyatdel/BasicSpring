package kr.or.ddit.system.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.system.mapper.NoticeMapper;
import kr.or.ddit.system.service.NoticeService;
import kr.or.ddit.system.vo.NoticeVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	NoticeMapper noticeMapper;

	// 공지사항 전체 개수
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.noticeMapper.getTotal(map);
	}

	// 공지사항 리스트 가져오기
	@Override
	public List<NoticeVO> noticeList(Map<String, Object> map) {
		return this.noticeMapper.noticeList(map);
	}

	// QnA 전체 개수
	@Override
	public int getQnaTotal(Map<String, Object> map) {
		return this.noticeMapper.getQnaTotal(map);
	}

	// QnA 리스트 가져오기
	@Override
	public List<NoticeVO> QnAList(Map<String, Object> map) {
		return this.noticeMapper.QnAList(map);
	}
	
	

}
