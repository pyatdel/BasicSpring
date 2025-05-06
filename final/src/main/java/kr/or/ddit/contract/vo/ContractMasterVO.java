package kr.or.ddit.contract.vo;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.file.vo.FileGroupVO;
import lombok.Data;
import lombok.ToString;

@ToString
@Data
public class ContractMasterVO {
	private int rnum;
	private long contractNo;
	private int empNo;
	private String empName;
	private String contractNm;
	private String conContent;
	private String contractPrice;
	private String contractType;
	private String state;
	private String fromDate;
	private String toDate;
	private String approvalDate;
	private String approvalEmp;
	private long fileGroupNo;
	private String inputDatetime;
	private String delDatetime;
	private String nttNt;
	private String ctCreateDate;
	private String ctCreator;
	private String ctModifyDate;
	private int ctModifier;
	private long entNo;
	private String entMemo;
	private String cancelContent;
	private String contractStatus;

	private int contractDetailNo;

	private String itemNm;
	private int itemQty;
	private int itemPrice;
	
	private String entTel;
	private String entCust;
	private String entName;
	private String entEmail;
	private String fromDatec;
	
	private MultipartFile[] uploadFiles;
	
	
	// MEMBER : FILE_GROUP = 1 : 1 = association
	private FileGroupVO fileGroupVO;	
	
	
	// 월별차트 vo
	private String month;
	private int year;
	private int totalContracts;
	private long totalPrice;

	// 연도별차트 vo
	private String years;
	private int yearContracts; // 연도별 계약건수 
	private long yearPrice; // 연도별 계약매출
	private int contractConcluded; // 연도별 계약상태 0:계약체결
	private int contractInprogress; // 연도별 계약상태 1:진행중
	private int contractCompleted; // 연도별 계약상태 2: 완료
	private int contractCancellation; // 연도별 계약상태 3:취소
	private int contractPending; // 연도별 계약상태 4.보류 

	// 계약 리스트 정렬기준 , 방향 
	private String sort;             // 정렬 기준 (price, date)
	private String direction;        // 정렬 방향 (ASC, DESC)

}
