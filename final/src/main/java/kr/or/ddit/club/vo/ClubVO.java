package kr.or.ddit.club.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.community.vo.CommunityVO;
import kr.or.ddit.file.vo.FileGroupVO;
import kr.or.ddit.personnel.vo.EmployeeVO;
import lombok.Data;

@Data
public class ClubVO {

	private int						clubNo;				// 동호회번호
	private String					clubName;			// 동호회명
	private String					clubDesc;			// 동호회설명
	private Date					clubCreDate;		// 개설일
	private String					clubCreMem;			// 개설인명
	private int						clubHit;			// 조회수
	private int						clubSec;			// 1.공개 2.비공개
	
	private int						maxMember;			// 최대회원수
	private int						nowMember;			// 현재회원수
	private int						clubState;			// 1.활성2.비활성
	private int						joinWay;			// 1.자동가입2.승인
	private Date					requestDate;		// 개설신청일
	private int						clubOpenState;		// 1.개설승인2.개설반려
	private int						clubPat;			// 1.클래식형 2.피드형
	private Date					clubModiDate;		// 수정일
	private Long					fileGroupNo;		// 첨부파일 그룹 번호
	private String					fileSaveLocate;		//동호회 이미지
	
	// CommunityVO
	private int						comNo;				// 커뮤니티 번호
	private CommunityVO				communityVO; 		// 커뮤니티 정보
	
	// FileGroupVO
	private FileGroupVO				fileGroupVO;		 // 파일 그룹 번호
	private MultipartFile[]			uploadFile;//<input type="file" name="uploadFile" id="uploadFile" style="display: none" multiple />
	
	
	// ClubMemberVO
	private List<ClubMemberVO>		memberList; 		// 동호회 멤버 목록
	
	// ClubJoinRequestVO
	private List<ClubJoinRequestVO>	joinRequestList;	// 동호회 신청 목록
	
	
	// EmployeeVO
	private int						empNo;				// 직원번호
	private EmployeeVO				employeeVO;
	
	// ClubCategoryVO
	private ClubCategoryVO			clubCategoryVO;
	
	
}
