package kr.or.ddit.sign.vo;



import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.file.vo.FileGroupVO;
import lombok.Data;

@Data
public class SignVO {

	private int docNo;
	private String docTitle;
	private String docContent;
	private Date writeDate;
	private int originalEmpNo;
	private String originalEmpName;
	private String originalPostName;
	private String originalDeptName;
	private int empNo;
	private int appDocNo;
	private int appStatusCode;
	private long appGroupCode;
	private int appHistNo;
	
	//APPROVAL_STATUS 테이블 1.대기2.진행중3.반려4.완료
	private String appStatusName;
	
	//APPROVAL_DOCUMENT_FORM 테이블 1.계약서2.지출결의서3.품의서
	private String appDocName;
	
	// 직원 테이블
	private String empName;
	private String empId;
	private String empSign;
	private String fileSaveLocate;
	/*
	<input type="text" name="empIds" value="a001"..
	<input type="text" name="empIds" value="b001"..
	 */
	private String[] empIds;
	
	//직급 테이블
	private int postNo;
	private String postName;
	
	//부서 테이블
	private int deptNo;
	private String deptName;
	
	//번호
	private int rnum;
	
	// sign : signDetailVO 1:1 
	private SignDetailVO signDetailVOList;
	
	//이미지 파일들
	private MultipartFile[] uploadFiles;

	//참조선 id 리스트
	private String[] referenceEmpIds;
	/* private List<String> referenceEmpIds; */
	
	//APPROVAL_CODE 테이블
	private int appListCode;
	private String appListName;

	//APPROVAL_LIST 테이블
	private int appNo;
	private int reappEmpId;
	private int appOrder;
	private Date appDate;
	private int appIdx;
	
	//APPROVAL_TYPE 테이블
	private int appTypeId;
	private String appTypeName;
	
	//이전 결재자 직원 번호
	private int befEmpNo;
	//이전 결재자 결재여부(2은 승인)
	private int befAppTypeId;
	
	// sign : FILE_GROUP = 1 : 1 = association
	private FileGroupVO fileGroupVO;	

	private long fileGroupNo;
	
	private MultipartFile[] uploadFile;
	
	private int finalCheckStatus;
	
	//반려 사유
	private String rejectStatus;
}
