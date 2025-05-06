package kr.or.ddit.clubCom.vo;

import java.util.Date;

import kr.or.ddit.club.vo.ClubMemberVO;
import kr.or.ddit.club.vo.ClubVO;
import kr.or.ddit.personnel.vo.EmployeeVO;
import lombok.Data;

@Data
public class ClubComVO {

	private int clubComNo;// 게시물 번호
	private String clubComTitle;// 제목
	private String clubComCont;// 내용
	private String clubComWriter;// 작성자
	private Date clubComCreDate;// 작성일
	private Date clubComModiDate;// 수정일
	private int clubComHit;// 조회수
	
	// ClubVO
	private int					clubNo;			// 동호회번호
	private ClubVO				clubVo;
	
	// ClubComTypeVO
	private int					clubComTypeNo;	// 동호회게시판 타입번호
	private ClubComTypeVO		clubComTypeVO;
	
	// ClubMember
	private int					clubMemNo;		// 동호회 회원번호
	private ClubMemberVO		clubMemberVO;	
	
	// EmployeeVO
	private int					empNo;			// 직원 번호
	private EmployeeVO			employeeVO;		
}
