package kr.or.ddit.service;

import kr.or.ddit.vo.UsersVO;

public interface UsersService {

	
	// 회원 등록
	public Long save(UsersVO usersVO);
}
