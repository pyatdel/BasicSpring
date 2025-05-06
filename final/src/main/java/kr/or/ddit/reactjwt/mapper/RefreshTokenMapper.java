package kr.or.ddit.reactjwt.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.reactjwt.vo.RefreshTokenVO;

@Mapper
public interface RefreshTokenMapper {
	 RefreshTokenVO findbyUserId(String empId);
	 RefreshTokenVO findbyRefreshToken(String refreshToken);

}
