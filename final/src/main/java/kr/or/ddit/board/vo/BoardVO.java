package kr.or.ddit.board.vo;



import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.file.vo.FileGroupVO;
import kr.or.ddit.personnel.vo.DepartmentVO;
import kr.or.ddit.personnel.vo.EmployeeVO;
import lombok.Data;

@Data
public class BoardVO {

	private int 	bodNo;							// 일반게시판번호
	private String 	bodTitle;						// 일반게시판제목
	private String 	bodWriter;						// 일반게시판작성자
	private String 	bodCont;						// 일반게시판내용
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date 	bodCreDate;						// 일반게시판작성일
	private int 	bodHit;							// 일반게시판조회수
	private Date 	bodModiDate;					// 일반게시판수정일
	private int 	repNo;							// 신고번호
	private int 	bodState;						// 1.안삭제 2.삭제
	private int		noticeType;						// 1.긴급 2.일반 3.다른게시판
	private int		bodRead;						// 1.읽음 2.안읽음
	private int		bodReCnt;						// 게시물 댓글 갯수
	
	
	// FileGroupVO
	private MultipartFile[] 	uploadFile;			// 파일 업로드
	private FileGroupVO 		fileGroupVO;
	
	//BoardType
	private int					bodTypeNo;			// 1.공지사항 2.부서 3.QnA
	private BoardTypeVO 		boardTypeVO;
	
	// EmployeeVO
	private int 				empNo;				// 직원번호
	private int					deptNo;				// 부서번호
	private EmployeeVO 			employeeVO;
	
	// DepartmentVO
	private DepartmentVO 		departmentVO;		
	
}
