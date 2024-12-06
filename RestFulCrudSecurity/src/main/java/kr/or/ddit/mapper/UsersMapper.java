package kr.or.ddit.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.security.core.userdetails.UserDetails;

import kr.or.ddit.vo.UsersVO;

@Mapper
public interface UsersMapper {

	// 쿼리 실행(1명의 로그인을 위함)
	// WHERE	EMAIL = 'test@test.com'
	public UsersVO findByEmail(String email);

	//email과 password를 입력받아 회원 가입 처리(id는 기본키로써 자동생성)
	public Long save(UsersVO usersVO);

}
