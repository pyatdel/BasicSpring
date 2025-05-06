package kr.or.ddit.club.vo;

import java.util.Date;

import kr.or.ddit.personnel.vo.EmployeeVO;
import lombok.Data;

@Data
public class ClubJoinRequestVO {

	private int			reqNo;				// 가입신청번호
	private Date		reqDate;			// 가입신청일
	private String		reqCont;			// 가입신청내용
	private int			reqState;			// 1.대기2.승인3.반려
	
	// ClubVO
	private int			clubNo;				// 동호회 번호
	private ClubVO		clubVO;	
	
	// EmployeeVO
	private int			empNo;				// 직원번호
	private EmployeeVO	employeeVO;
}
