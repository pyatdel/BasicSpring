package kr.or.ddit.websocketalarm.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AlarmVO {
	
	private int alarmNo;
	private int empNo;
	private String alarmType;
	private String alarmMessage;
	private String alarmStatus;
	private String createdAt;
	private Date readAt;
	private String linkUrl;
	private String isDeleted;
	
	private String empName;
	private int rnum;

}
