package kr.or.ddit.reactjwt.service.Impl;

import java.time.Duration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.config.jwt.TokenProvider;
import kr.or.ddit.reactjwt.service.ReactUsersService;
import kr.or.ddit.reactjwt.service.RefreshTokenService;
import kr.or.ddit.reactjwt.service.TokenService;
import kr.or.ddit.reactjwt.vo.ReactUsersVO;
import kr.or.ddit.reactjwt.vo.RefreshTokenVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TokenServiceImpl implements TokenService{
	
	@Autowired
	TokenProvider tokenProvider;
	
	@Autowired
	RefreshTokenService refreshTokenService;
	
	@Autowired
	ReactUsersService reactUsersService;
	//전달받은 리프레시 토큰으로 토큰 유효성 검사를 진행하고, 유효한 토큰일 때 
	//리프레시
	//토큰으로 사용자 ID를 찾음. 마지막으로는 사용자 ID로 사용자를 찾은 후에 토큰 
	//제공자의 
	// generateToken() 메서드를 호출해서 새로운 액세스 토큰을 생성함
	
	public String createNewAccessToken(String refreshToken) {
		//토큰 유효성 검사에 실패하면 예외 발생
		if(!tokenProvider.validToken(refreshToken)) {
			log.error("refresh token: {}",refreshToken);
			throw new IllegalArgumentException("Unexpected token");
		 }
		 //refreshToken : eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1N...
		 String empId = refreshTokenService.findByRefreshToken(refreshToken).getEmpId();
		 //createNewAccessToken->userId : 1
		 log.info("createNewAccessToken->empId : {} ", empId);
		 ReactUsersVO user = this.reactUsersService.findById(empId);
		 if (user == null) {
	            log.error("User not found for empId: {}", empId);
	            throw new IllegalArgumentException("User not found");
	        }
		/*
		 user : UsersVO(id=1, email=musicajae23@gmail.com, password=test, 
		createdAt=Tue Nov 19 12:24:36 KST 2024, updatedAt=null)
		 */
		 log.info("createNewAccessToken->user : {}", user);
		 return tokenProvider.generateToken(user, Duration.ofHours(2));
	 }
	
	@Override
    public String createAccessToken(String empId) {
        ReactUsersVO user = reactUsersService.findById(empId);
        if (user == null) {
            log.error("User not found for empId: {}", empId);
            throw new IllegalArgumentException("User not found");
        }
        return tokenProvider.generateToken(user, Duration.ofMinutes(30));
    }

    @Override
    public String createRefreshToken(String empId) {
        ReactUsersVO user = reactUsersService.findById(empId);
        if (user == null) {
            log.error("User not found for empId: {}", empId);
            throw new IllegalArgumentException("User not found");
        }

        // 리프레시 토큰 생성
        String refreshToken = tokenProvider.generateToken(user, Duration.ofDays(7));


        return refreshToken;
    }
	
	
}
	
	
	

