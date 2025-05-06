package kr.or.ddit.business.vo;

import java.util.Date;

import kr.or.ddit.business.vo.ContractMasterVO;
import lombok.Data;

@Data
public class ContractMasterVO {
	private long contractNo;
	private int empNo;
	private String contractNm;
	private String conContent;
	private int contractPrice;
	private String contractType;
	private String state;
	private Date fromDate;
	private Date toDate;
	private Date approvalDate;
	private String approvalEmp;
	private String fNo;
	private Date inputDatetime;
	private Date delDatetime;
	private String nttNt;
	private Date ctCreateDate;
	private int ctCreator;
	private Date ctModifyDate;
	private int ctModifier;
	private int entNo;
	private String entMemo;
	private String contractStatus;
	
	//취소 사유
	private String cancelContent;
}

