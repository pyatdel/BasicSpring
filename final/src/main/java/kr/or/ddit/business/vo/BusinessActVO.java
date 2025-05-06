package kr.or.ddit.business.vo;



import java.util.Date;

import lombok.Data;

@Data
public class BusinessActVO {
	
	private int rnum;
	
	//SCHEDULE_T
	private Integer id;
	private int empNo;
	private int scheDiv;
	private String title;
	private String content;
	private String start;
	private String end;
	private String allDay;
	private String backgroundColor;
	private String textColor;
	
	
	//SCHEDULE_DETAIL
//	private int scheDiv;
	private String scheName;
	
	
	//BUSINESS
	private Integer busNo;
	private String busType;
//	private String content;
	private String inout;
	private String innerValue;
	private String outterValue;
//	private int scheDiv;
//	private int empNo;
	private int percent;
	private int entNo;
	private String busDate;
	
	//EMPOLYEE
	private String residentNumber1;
	private String residentNumber2;
	private String empProfile;
//	private int empNo;
	private String enabled;
	private String empId;
	private String empPw;
	private String empName;
	private String empEmail;
	private String empPhone;
	
	//ENTERPRICE
	private String entTel;
	private String entCode;
//	private String busNo;
	private String detailAdd;
	private String entEmail;
//	private int entNo;
	private String entName;
	private Date birDate;
	private String roadAdd;
	private String repName;
	private String entType;
	private String entComment;
	private String entCust;
	private Date entRegDate;

}
