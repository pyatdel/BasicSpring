package kr.or.ddit.att.vo;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class AttManagerVO {
	private String time;
	private int situation;
	private int empNo;
	
	private String empName;
	private String postName;
	private String attendanceTime;
	private String attendanceName;
	private int rnum;
	
	private int attNo;
	private String attInTime;
	private String attOutTime;
	
	private LocalDateTime attInDateTime;
	
	private int attWorkTime;
	private String createDate;
	private int creator;
	private String modifyDate;
	private int modifier;
	
	private String attDate;
	private String attInTimeStr;
	private String attOutTimeStr;
	private String attWorkTimeStr;
	private int attEndanceCode;
	private String reason;
	
	private String perception;
	private String perceptionText;
	
	private String dotClass;
	
	
}
