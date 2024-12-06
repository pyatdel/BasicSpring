package kr.or.ddit.service;

import kr.or.ddit.vo.StudVO;

public interface StudService {
	//메소드 시그니처
	
	//학생 등록
	public int createPost(StudVO studVO);

	//학생 상세
	public StudVO detail(StudVO studVO);
	
}
