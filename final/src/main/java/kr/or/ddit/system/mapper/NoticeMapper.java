package kr.or.ddit.system.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.system.vo.NoticeVO;

@Mapper
public interface NoticeMapper {

	// 공지사항 전체 개수
	public int getTotal(Map<String, Object> map);

	// 공지사항 리스트 가져오기
	public List<NoticeVO> noticeList(Map<String, Object> map);

	// QnA 전체 개수
	public int getQnaTotal(Map<String, Object> map);

	// QnA 리스트 가져오기
	public List<NoticeVO> QnAList(Map<String, Object> map);
}
