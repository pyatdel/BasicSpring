package kr.or.ddit.config.jwt;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Component
@ConfigurationProperties("jwt")
public class JwtProperties {
	/* application.properties
	 	# token secret key
		# 토큰 발급자
		jwt.issuer=nonesleep.local
		# JWT 키 (여러 문자가 섞일수록 안전하다)
		jwt.secret_key=KroR!ddit401nonesleepuinone
	 */
	private String issuer;
	private String secretKey;

}
