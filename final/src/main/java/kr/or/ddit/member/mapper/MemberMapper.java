package kr.or.ddit.member.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.or.ddit.member.vo.MemberVO;

@Mapper
public interface MemberMapper {
	MemberVO Login(MemberVO memberVO);

	MemberVO getMemberByUsername(String empId);

	MemberVO findByUsername(String username);

	MemberVO read(MemberVO memberVO);

	MemberVO read(String empId);

	int updateMember(MemberVO memberVO);

	void updateProfileImage(MemberVO memberVO);

	String readProfileImage(String empId);

	List<MemberVO> getInfo(MemberVO memberVO);

	MemberVO readByEmpNo(Long empNo);
}
