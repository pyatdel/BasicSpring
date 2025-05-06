package kr.or.ddit.att.vo;

import lombok.Data;

@Data
public class AnnualListVO {
	private int annNo;
	private int empNo;
	private int annCate;
	private String annTitle;
	private String annContent;
	private int annTotal;
	private String annStartDate;
	private String annEndDate;
	private int appStatusCode;
	
	private int empAnnual;
	
	private int rnum;
	private String empName;
	private String appStatusName;
	
	private String annYear;
	private int annCnt;
	private int attendanceCode;
	private String attendanceName;
	
	private int deptNo;
	
	
}
