package kr.or.ddit.community.vo;

import java.util.Date;

import kr.or.ddit.personnel.vo.EmployeeVO;
import lombok.Data;

@Data
public class CommunityReplyVO {

	private int 			comIdx;					// 커뮤니티 댓글 번호
	private String 			comReWriter;			// 커뮤니티 댓글 작성자
	private Date 			comReDate;				// 커뮤니티 댓글 작성일
	private String 			comReCont;				// 커뮤니티 댓글 내용
	private int 			comParentIdx;			// 커뮤니티 부모 댓글 번호
	private int 			comReState;				// 1.안삭제 2.삭제
	private String 			comParentReWriter;		// 커뮤니티 부모 댓글 작성자
	private int 			comLvl;					// 커뮤니티 댓글 단계
	
	// CommunityVO
	private int 			comNo;					// 커뮤니티 번호
	private CommunityVO		communityVO;
	
	// EmployeeVO
	private int				empNo;					// 직원 번호
	private EmployeeVO		employeeVO;
}
