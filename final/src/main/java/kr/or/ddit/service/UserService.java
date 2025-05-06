package kr.or.ddit.service;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.vo.UsersVO;

public interface UserService {
	
	//회원 가입
	public int save(MemberVO memberVO);
	
	
	
}
