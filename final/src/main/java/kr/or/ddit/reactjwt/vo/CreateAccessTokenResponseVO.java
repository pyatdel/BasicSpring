package kr.or.ddit.reactjwt.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CreateAccessTokenResponseVO {
	private String accessToken;
	private String refreshToken;

}
