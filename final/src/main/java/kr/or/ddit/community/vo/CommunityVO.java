package kr.or.ddit.community.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.file.vo.FileGroupVO;
import kr.or.ddit.personnel.vo.EmployeeVO;
import lombok.Data;

@Data
public class CommunityVO {

	private int 					comNo;					// 커뮤니티번호
	private String 					comTitle;				// 커뮤니티제목
	private String					comWriter;				// 커뮤니티작성자
	private String 					comCont;				// 커뮤니티내용
	private Date 					comCreDate;				// 커뮤니티작성일
	private Date 					comModiDate;			// 커뮤니티수정일
	private int 					comState;				// 1.안삭제 2.삭제
	private int 					comHit;					// 커뮤니티조회수
	private int						comSec;					// 1.안익명 2.익명
	private int						comPwd;					// 커뮤니티 비밀번호
	
	
	

	// EmployeeVO
	private int						empNo;					// 직원번호
	private EmployeeVO				employeeVO;
	
	// FileGroupVO
	private FileGroupVO				fileGroupVO;			// 파일 그룹 번호
	private MultipartFile[]			uploadFile;
	
	// communityTypeVO
	private int						comTypeNo;				// 커뮤니티 타입 번호
	private CommunityTypeVO			communityTypeVO;
	
	// communityStateTypeVO
	private int						comStateTypeNo;			// 1.일반 2.질문 3.정보 4.비밀
	private CommunityStateTypeVO	communityStateTypeVO;
	
	

}
