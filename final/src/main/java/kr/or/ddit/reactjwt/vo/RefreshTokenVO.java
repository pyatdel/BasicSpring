package kr.or.ddit.reactjwt.vo;

import lombok.Data;

@Data
public class RefreshTokenVO {
	 private Long id;
	 private String empId;
	 private String refreshToken;
	 public RefreshTokenVO(String empId, String refreshToken) {
	 this.empId = empId;
	 this.refreshToken = refreshToken;
	 }
	 public RefreshTokenVO update(String newRefreshToken) {
	 this.refreshToken = newRefreshToken;
	 return this;
	 }

}
