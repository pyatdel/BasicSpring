package kr.or.ddit.reactjwt.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CreateAccessTokenRequestVO {
	private String refreshToken;

}
