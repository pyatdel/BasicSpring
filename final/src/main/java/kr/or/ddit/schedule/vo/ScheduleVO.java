package kr.or.ddit.schedule.vo;

import lombok.Data;

@Data
public class ScheduleVO {
	private int id;
	private int empNo;
	private int scheDiv;
	private String title;
	private String content;
	private String start;
	private String end;
	private String allDay;
	private String backgroundColor;
	private String textColor;
	
	private int deptNo;
	private int postNo;
	private String empName;
	private String empId;

}
