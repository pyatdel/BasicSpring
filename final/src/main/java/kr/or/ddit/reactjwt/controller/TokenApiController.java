package kr.or.ddit.reactjwt.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.reactjwt.service.ReactUsersService;
import kr.or.ddit.reactjwt.service.TokenService;
import kr.or.ddit.reactjwt.vo.CreateAccessTokenRequestVO;
import kr.or.ddit.reactjwt.vo.CreateAccessTokenResponseVO;
import kr.or.ddit.reactjwt.vo.LoginRequestVO;
import kr.or.ddit.reactjwt.vo.ReactUsersVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@CrossOrigin("http://localhost:7921")
@RequestMapping("/api")
public class TokenApiController {
	
	@Autowired
	TokenService tokenService;
	
	@Autowired
	ReactUsersService reactUsersService;
	
	
	// 로그인 처리 및 토큰 발급
    @PostMapping("/reactlogin")
    public ResponseEntity<CreateAccessTokenResponseVO> login(@RequestBody LoginRequestVO loginRequest) {
        try {
            // ID와 비밀번호 검증 (구현 필요)
            boolean isValid = reactUsersService.validateLogin(loginRequest.getEmpId(), loginRequest.getEmpPw());
            if (!isValid) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
            }

            // 토큰 생성
            String accessToken = tokenService.createAccessToken(loginRequest.getEmpId());
            String refreshToken = tokenService.createRefreshToken(loginRequest.getEmpId());
            
            return ResponseEntity.ok(new CreateAccessTokenResponseVO(accessToken, refreshToken));
        } catch (Exception e) {
            log.error("Login error: ", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
	
	//{"refreshToken":"eyJ0eXAiOiJKV1QiLCJhbG..."}
 // 새 액세스 토큰 생성
    @PostMapping("/token")
    public ResponseEntity<CreateAccessTokenResponseVO> createNewAccessToken(@RequestBody CreateAccessTokenRequestVO request) {
        log.info("createNewAccessToken->request: {}", request);

        try {
            String newAccessToken = tokenService.createNewAccessToken(request.getRefreshToken());
            // 정상적인 토큰 생성 시 새로운 액세스 토큰을 반환
            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(new CreateAccessTokenResponseVO(newAccessToken, null)); // refreshToken을 반환하지 않음
        } catch (IllegalArgumentException e) {
            log.error("Invalid Refresh Token: ", e);
            // 리프레시 토큰이 유효하지 않으면, 에러 메시지와 함께 401 상태 코드를 반환
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(new CreateAccessTokenResponseVO("Invalid Refresh Token", null));
        } catch (Exception e) {
            log.error("Unexpected error: ", e);
            // 예기치 않은 에러가 발생하면 500 상태 코드와 함께 에러 메시지를 반환
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new CreateAccessTokenResponseVO("An error occurred", null));
        }
    }
    
    @GetMapping("/{empId}")
    public ReactUsersVO getEmpNoByEmpId(@PathVariable ("empId") String empId) {
    	ReactUsersVO users = new ReactUsersVO();
    	users.setEmpId(empId);
    	ReactUsersVO result = reactUsersService.getEmpNoByEmpId(users);
    	log.info("empNo : {}",result);
    	return result;
    }
    
    @GetMapping("/attendance/{empNo}")
    public ReactUsersVO getAttendanceByEmpNo(@PathVariable ("empNo") int empNo) {
    	ReactUsersVO users = new ReactUsersVO();
    	users.setEmpNo(empNo);
    	ReactUsersVO result = reactUsersService.getAttendanceByEmpNo(users);
    	log.info("empNo : {}",result);
    	return result;
    }
    
    
    
    
    
    
    
    
	
	

}
