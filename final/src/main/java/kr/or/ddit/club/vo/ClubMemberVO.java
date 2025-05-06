package kr.or.ddit.club.vo;

import java.util.Date;

import kr.or.ddit.personnel.vo.EmployeeVO;
import lombok.Data;

@Data
public class ClubMemberVO {

	private int			clubMemNo;		// 동호회회원번호
	private Date		joinDate;		// 가입일자
	private int			memState;		// 1.활동중2.정지3.탈퇴
	private String		stateMemo;		// 한줄소개
	private Date		lastAccDate;	// 마지막접속일
	private int			memCreState;	// 1:개설인2.가입인 
	
	// ClubVO
	private int			clubNo;			// 동호회번호
	private ClubVO		clubVO;
	
	// EmployeeVO
	private int			EmpNo;			// 직원 번호
	private EmployeeVO	employeeVO; 	// 직원 정보
	
	// ClubRole
	private int 		roleNo;			// 1.마스터2.부마스터3.일반사용자
	private ClubRoleVO	clubRoleVO;
}
