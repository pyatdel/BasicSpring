package kr.or.ddit.system.vo;


import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.file.vo.FileGroupVO;
import lombok.Data;

@Data
public class SystemReportVO {
	
	//boardType 테이블
	private int bodTypeNo;
	private String bodTypeName; // 1:공지 2:부서 3:QnA
	
	
	//board 테이블
	private int 	bodNo;			// 일반게시판번호
	private String 	bodTitle;		// 일반게시판제목
	private String 	bodWriter;		// 일반게시판작성자
	private String 	bodCont;		// 일반게시판내용
	private Date 	bodCreDate;		// 일반게시판작성일
	private int 	bodHit;			// 일반게시판조회수
	private Date 	bodModiDate;	// 일반게시판수정일
	private int 	repNo;			// 신고번호
	private int 	bodState;		// 1.삭제 2.안삭제
	private int		noticeType;		// 1.긴급 2.일반 3.다른게시판
	
	
	private FileGroupVO fileGroupVO;
	private MultipartFile[] uploadFile;
	
	//번호
	private int rnum;

	//report 테이블
	private int bodIdx;			// 게시판댓글번호
	private String repReason;	// 신고사유
	private int repState;		// 1.처리중 2:완료 3:취소
	private Date repDate;		// 신고일자
	private Date repResult;		// 처리일자
	private int repType;		// 1:게시물 2:댓글
	private String repTypeDescription; // 게시물 / 댓글 글자 가져오기
	private String repCont;		// 신고내용
	private String repWriter;	// 신고작성자
	
	//report_TYPE 테이블
	private String repTypeName;
	
}
