package kr.or.ddit.business.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BusinessChanceVO {
	
	//EMPLOYEE 
	private String residentNumber1;
	private String residentNumber2;
	private String empProfile;
	private int empAnnual;
	private int empNo;
	private String enabled;
	private String empId;
	private String empPw;
	private String empName;
	private String empEmail;
	private String empPhone;
	private String empZip;
	private String empStreet;
	private String empDetail;
	private String empSign;
	private Date empIn;
	private Date empOut;
	private int deptNo;
	private int postNo;
	
	//ENTERPRICE
	private String entTel;
	private String entCode;
	private String busNo;
	private String detailAdd;
	private String entEmail;
	private int entNo;
	private String entName;
	private Date birDate;
	private String roadAdd;
	private String repName;
	private String entType;
	private String entComment;
	private String entCust;
	private Date entRegDate;
	
	//CONTRACT_MASTER
	private String cancelContent;
	private String contractStatus;
//	private int entNo;
	private int conSeq;
	private long contractNo;
//	private int empNo;
	private String contractNm;
	private long contractPrice;
	private String contractType;
	private String state;
	private String stateStage; //영업 기회 상태 컬럼 추기 (state=1인 경우에만 사용)
	private Date fromDate;
	private Date toDate;
	private Date approvalDate;
	private String approvalEmp;
	private int fileGroupNo;
	private Date inputDatetime;
	private Date delDatetime;
	private String nttNt;
	private Date ctCreateDate;
	private String ctCreator;
	private Date ctModifyDate;
	private String ctModifier;
	private String entMemo;
	private int successRate;	//영업기회 성공률 컬럼 추가
}




