package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.SujinVO;

public interface SujinService {

	   // Get List
	   List<SujinVO> listSujin();
	   // Get One
	   SujinVO getSujin(SujinVO sujinVO);
	   // insert
	   int  insertSujin(SujinVO sujinVO);
	   // update
	   int  updateSujin(SujinVO sujinVO);
	   // delete
	   int  deleteSujin(SujinVO sujinVO);
	   
}
