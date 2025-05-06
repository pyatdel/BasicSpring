package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class EnterpriceVO {
	private int entNo;
	private String entName;
	private int busNo;
	private Date birDate;
	private String busAdd;
	private String repName;
	private String entType;
	private String entComment;
	private String entCust;
	private Date entRegDate;
	
	private String state;//0:계약완료 1:진행중 2: 완료 3:취소 4.보류
	
}
