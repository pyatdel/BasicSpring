package kr.or.ddit.system.service;

import java.util.List;
import java.util.Map;


import kr.or.ddit.system.vo.NoticeVO;

public interface NoticeService {

	// 공지사항 전체 개수
	public int getTotal(Map<String, Object> map);

	// 공지사항 리스트 가져오기
	public List<NoticeVO> noticeList(Map<String, Object> map);

	// QnA 전체 개수
	public int getQnaTotal(Map<String, Object> map);

	// QnA 리스트 가져오기
	public List<NoticeVO> QnAList(Map<String, Object> map);


}
