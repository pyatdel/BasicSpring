package kr.or.ddit.reactjwt.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.reactjwt.mapper.RefreshTokenMapper;
import kr.or.ddit.reactjwt.service.RefreshTokenService;
import kr.or.ddit.reactjwt.vo.RefreshTokenVO;

@Service
public class RefreshTokenServiceImpl implements RefreshTokenService {
	
	@Autowired
	RefreshTokenMapper refreshTokenMapper;

	@Override
	public RefreshTokenVO findByRefreshToken(String refreshToken) {
		return this.refreshTokenMapper.findbyRefreshToken(refreshToken);
	}
	

}
