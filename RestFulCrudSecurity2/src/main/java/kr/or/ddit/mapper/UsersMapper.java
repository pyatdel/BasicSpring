package kr.or.ddit.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.UsersVO;

@Mapper
public interface UsersMapper {
	
	//email로 사용자 정보를 가져옴
	public UsersVO findByEmail(String email);

	//회원가입
	public int save(MemberVO memberVO);

	//권한등록
	public int saveAuths(MemberVO memberVO);
	
}
