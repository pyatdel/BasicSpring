package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.SujinVO;

public interface SujinService {
	//메소드 시그니처
	
	// Get List
	List<SujinVO> listSujin(Map<String, Object> map);
	// Get One
	SujinVO getSujin(SujinVO sujinVO);
	// insert
	int  insertSujin(SujinVO sujinVO);
	// update
	int  updateSujin(SujinVO sujinVO);
	// delete
	int  deleteSujin(SujinVO sujinVO);
	//전체 행의 수
	int getTotal(Map<String, Object> map);
}
