package kr.or.ddit.club.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ClubRoleVO {

	private int		roleNo;			// 권한 번호
	private String	roleName;		// 권한 이름
	private String	roleDesc;		// 권한 설명
	private Date	roleCreDate;	// 권한 부여일
	private Date	roleModiDate;	// 권한 변경일
}
