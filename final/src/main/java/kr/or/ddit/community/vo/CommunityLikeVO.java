package kr.or.ddit.community.vo;

import java.util.Date;

import kr.or.ddit.personnel.vo.EmployeeVO;
import lombok.Data;

@Data
public class CommunityLikeVO {

	private int 			likeNo;			// 좋아요번호
	private Date 			likeDate;		// 좋아요 누른 날짜
	
	// CommunityVO
	private int 			comNo;			// 커뮤니티 번호
	private CommunityVO		communityVO;
	
	// EmployeeVO
	private int 			empNo;			// 직원번호
	private EmployeeVO 		employeeVO;
}
