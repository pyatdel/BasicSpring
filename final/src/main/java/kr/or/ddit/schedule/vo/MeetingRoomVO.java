package kr.or.ddit.schedule.vo;

import java.util.Date;

import lombok.Data;
@Data
public class MeetingRoomVO {
	private int deptNo;
	private int postNo;
	private String empName;
	private String empId;

	private String roomName;
	
	private int reservationId;
	private int roomId;
	private int empNo;
	private Date reservationDate;
	private String startTime;
	private String endTime;
	private String status;
	private String createdAt;
	private String updatedAt;
}
