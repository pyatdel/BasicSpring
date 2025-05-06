package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.member.vo.MemberVO;

public interface MemberService {
	MemberVO Login(MemberVO memberVO);

	MemberVO read(MemberVO memberVO);

	MemberVO getMemberByUsername(String empId);

	MemberVO getMemberById(String empId);

	int update(MemberVO memberVO);

	void updateProfileImage(MemberVO memberVO);

	String getProfileImage(String empId);

	List<MemberVO> getInfo(MemberVO memberVO);
	
	MemberVO getMemberByEmpNo(Long empNo);
}
