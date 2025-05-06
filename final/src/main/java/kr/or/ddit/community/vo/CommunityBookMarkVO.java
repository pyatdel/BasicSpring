package kr.or.ddit.community.vo;

import java.util.Date;

import kr.or.ddit.personnel.vo.EmployeeVO;
import lombok.Data;

@Data
public class CommunityBookMarkVO {

	private int 			bookNo;			// 북마크 번호
	private Date 			bookDate;		// 북마크한 날짜
	
	// CommunityVO
	private int 			comNo;			// 커뮤니티 번호
	private CommunityVO		communityVO;
	
	// EmployeeVO
	private int 			empNo;			// 직원번호
	private EmployeeVO 		employeeVO;
}
