

package kr.or.ddit.workspace.vo;

import java.util.Date;

import lombok.Data;

@Data
public class WorkSpaceVO {
	private int projNo;
	private String projName;
	private String projContent;
	private int projMan;
	private String projType;
	private Date projCreateDate;
	private long contractNo;
	private int empNo;
	private int deptNo;
	private String empName ;
	private String taskMemo;
	
	private int important;
	private String taskType;
	private String startDate;
	private String endDate;
	private String taskStatus;
	private int percent;
	private int taskNo;
	
	
	
	private int concluded; // 0 계약체결
	private int inprogress; // 1 진행중
	private int completed; //  2 계약완료 
	private int rnum;
	private int total; // 토탈
}
