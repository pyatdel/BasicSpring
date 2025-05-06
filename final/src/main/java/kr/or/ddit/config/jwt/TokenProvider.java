package kr.or.ddit.config.jwt;

import java.time.Duration;
import java.util.Collections;
import java.util.Date;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Header;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import kr.or.ddit.reactjwt.vo.ReactUsersVO;

@Service
public class TokenProvider {
	
	@Autowired
	JwtProperties jwtProperties;
	
	
	public String generateToken(ReactUsersVO usersVO, Duration expiredAt) {
		Date now = new Date();
		return makeToken(new Date(now.getTime() + expiredAt.toMillis()),usersVO);
	}
	
	 //1. JWT 토큰 생성 메서드
	/*
	토큰을 생성하는 메서드. 인자는 만료시간, 유저 정보를 받음.
	이 메서드에서는 set 계열의 메서드를 통해 여러 값을 지정함. 
	헤더는 typ(타입), 내용은 iss(발급자), iat(발급일시), 
	ext(만료 일시), sub(토큰 제목)이, 클레임에는 유저 ID를 지정함
	토큰을 만들 때는 프로퍼티즈 파일에 선언해둔 비밀값과 함께 HS256 방식으로 암호화함
	private String issuer;
	 private String secretKey;
	 */
	private String makeToken(Date expiry, ReactUsersVO usersVO) {
		Date now = new Date();
		return Jwts.builder()
					.setHeaderParam(Header.TYPE, Header.JWT_TYPE) // 헤더 typ:JWT
					.setIssuer(jwtProperties.getIssuer())
					.setIssuedAt(now) // 내용 api: 현재시간
					.setExpiration(expiry) // 내용 exp : expiry 멤버 변수값
					.setSubject(usersVO.getEmpEmail()) // 내용 sub: 유저의 이메일
					.claim("id", usersVO.getEmpId()) // 클레임id : 유저 ID
					// 서명 : 비밀값과 함꼐 해시값을 HS256방식으로 암호화
					.signWith(SignatureAlgorithm.HS256, jwtProperties.getSecretKey())
					.compact();
	}
	
	//2. JWT 토큰 유효성 검증 메서드
	/*
	토큰이 유효한지 검증하는 메서드. 프로퍼티즈 파일에 선언한 비밀값과 함게 토큰 
	복호화를 진행함.
	만약 복호화 과정에서 에러가 발생하면 유효하지 않은 토큰이므로 false를 반환하고 
	아무 에러도 발생하지 않으면 true를 반환함
	#토큰 발급자
	jwt.issuer=musicajae23@gmail.com
	 # JWT 키 (여러 문자가 섞일수록 안전하다)
	 jwt.secret_key=study-springboot
	 */
	public boolean validToken(String token) {
		try {
			Jwts.parser()
				.setSigningKey(jwtProperties.getSecretKey()) //비밀값으로 복호화
				.parseClaimsJws(token);
			
			return true;
			
		} catch (Exception e) {// 복호화 과정에서 에러가 나면 유효하지 않은 토큰
			return false;
		}
	}
	
	//3. 토큰 기반으로 인증 정보를 가져오는 메서드
	/*
	토큰을 받아 인증 정보를 담은 객체 Authentication을 반환하는 메서드임.
	프로퍼티즈 파일에 저장한 비밀값으로 토큰을 복호화한 뒤 클레임을 가져오는 private 
	메서드인 getClaims()를 호출해서
	클레임 정보를 반환받아 사용자 이메일이 들어 있는 토큰 제목 sub와 토큰 기반으로 
	인증 정보를 생성함.
	이 때 UsernamePasswordAuthenticationToken의 첫 인자로 들어가는 User는 
	프로젝트에서 만든 UsersVO 클래스가 아닌
	스프링 시큐리티에서 제공하는 객체인 User 클래스를 임포트해야 함
	 */
	
	public Authentication getAuthentication(String token) {
		 Claims claims = getClaims(token);
		 Set<SimpleGrantedAuthority> authorities = Collections.singleton(new 
			SimpleGrantedAuthority("ROLE_USER"));
		 return new UsernamePasswordAuthenticationToken(new
				 org.springframework.security.core.userdetails.User(claims.getSubject(), "", 
		authorities),token, authorities);
		 }
	
	 //4. 토큰 기반으로 유저 ID를 가져오는 메서드
	/*
	토큰 기반으로 사용자 ID를 가져오는 메서드임. 프로퍼티즈 파일에 저장한 비밀값으로 
	토큰을 복호화한 다음
	클레임을 가져오는 private 메서드인 getClaims()를 호출해서 클레임 정보를
	반환받고 클레임에서 id 키로 저장된 값을 가져와 반환함
	 */
	
	public Long getUserId(String token) {
		 Claims claims = getClaims(token);
		 return claims.get("id", Long.class);
		 }
		 /*
		 private String issuer;
		 private String secretKey;
		 */
	 private Claims getClaims(String token) {
	 return Jwts.parser()//클레임 조회
			 .setSigningKey(jwtProperties.getSecretKey())
			 .parseClaimsJws(token)
			 .getBody();
	 }
}
