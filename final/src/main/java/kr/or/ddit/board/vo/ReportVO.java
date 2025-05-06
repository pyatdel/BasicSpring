package kr.or.ddit.board.vo;

import java.util.Date;

import kr.or.ddit.personnel.vo.EmployeeVO;
import lombok.Data;

@Data
public class ReportVO {
	
	private int 		repNo;				// 신고번호
	private int 		bodNo;				// 게시판번호
	private int 		bodIdx;				// 게시판댓글번호
	private String 		repReason;			// 신고사유
	private int 		repState;			// 1.처리중 2:완료 3:취소
	private Date 		repDate;			// 신고일자
	private Date 		repResult;			// 처리일자
	private int 		repType;			// 1:게시물 2:댓글
	private String 		repCont;			// 신고내용
	private String 		repWriter;			// 신고작성자
	
	// EmployeeVO
	private int			empNo;				// 직원번호
	private EmployeeVO	employeeVO;
}
