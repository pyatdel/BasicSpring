package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ContractMasterVO {
	private int contractNo;
	private int empNo;
	private String contractNm;
	private String conContent;
	private String contractPrice;
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
	
	//취소 사유
	private String cancelContent;
}
