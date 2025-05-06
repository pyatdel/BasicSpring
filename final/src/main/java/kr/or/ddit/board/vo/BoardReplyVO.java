package kr.or.ddit.board.vo;

import java.util.Date;

import kr.or.ddit.personnel.vo.EmployeeVO;
import lombok.Data;

@Data
public class BoardReplyVO {

	private int			bodIdx;					// 게시판댓글번호
	private String		bodReWriter;			// 게시판댓글작성자
	private String		bodParentReWriter;		// 게시판부모댓글작성자
	private Date		bodReDate;				// 게시판댓글작성일
	private String		bodReCont;				// 게시판댓글내용
	private int			bodReState;				// 1.삭제 2.안삭제
	private int			bodParentIdx;			// 게시판부모댓글번호
	private int			bodNo;					// 게시판번호
	private int			bodLvl;					// 게시판댓글단계
	
	// EmployeeVO
	private int			empNo;					// 직원번호
	private EmployeeVO	employeeVO;
}
