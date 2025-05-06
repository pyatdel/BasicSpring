package kr.or.ddit.business.vo;

import java.util.Date;

import lombok.Data;

@Data
public class EmployeeVO {
	private String residentNumber1;
	private String residentNumber2;
	private String empProfile;
	private int empNo;
	private String enabled;
	private String empId;
	private String empPw;
	private String empName;
	private String empEmail;
	private String empPhone;
	private String empZip;
	private String empStreet;
	private String empDetail;
	private String empSign;
	private int empAnnual;
	private Date empIn;
	private Date empOut;
	private int deptNo;
	private int postNo;
}
