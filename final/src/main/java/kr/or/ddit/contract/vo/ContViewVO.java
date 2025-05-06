package kr.or.ddit.contract.vo;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.file.vo.FileGroupVO;
import lombok.Data;

@Data
public class ContViewVO {
	private long contractNo;
	private String contractNm;
	private int empNo;
	private String empName;
	private String fromDate;
	private String toDate;
	private String contractPrice;
	private String entMemo;
	private int entNo;
	private String contractType;
	private String entName;
	private String entType;
	private String stateDesc;
	private String entRegDate;
	private String entTel;
	private String entCust;
	private String roadAdd;
	private String contractStatus;
	private String approvalDate;
	private String approvalEmp;
	private String tDate;
	private String fDate;
	private MultipartFile[] uploadFiles;
	
	
	// MEMBER : FILE_GROUP = 1 : 1 = association
	private FileGroupVO fileGroupVO;	

	private long fileGroupNo;
	
	
}
