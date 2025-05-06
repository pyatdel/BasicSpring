package kr.or.ddit.personnel.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import kr.or.ddit.file.vo.FileDetailVO;
import lombok.Data;

@Data
public class EmployeeSalaryVO {
	
	private int empNo;
	private String enabled;
	private String empId;
	private String[] modalEmpIds;
	private String empName;
	private String empZip;
	private String empStreet;
	private String empDetail;
	private String empSign;
	private int empAnnual;
	private String empIn;
	private String empOut;
	private int deptNo;
	private int postNo;
	private int rnum;
	private String residentNumber1;
	private String residentNumber2;
	//SALARY_INPUT_STATUS Y,N
	private String salaryInputStatus;
	private int employeeCount;
	
	// 예산 테이블
	private Date expDate;
	private int expNo;
	
	//부서 1:n
	private String deptName;
	
	//직급 1:n
	private String postName;
	
	
	// salary 테이블, INSURANCE 테이블 vo 같이 사용
	private int salaryNo;
	private int salary;
	private int foodExpense;
	//"papago": "2024-12-24"
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date papago; // 정산일
	private int payDay; // 지급일
	private int addedHours; // 연장근무비
	private int afterTax; // 실수령액
	
	// 연
	private String year;
	// 월
	private String month;
	
	private int incomeTax; // 소득세(%)
	private int healthInsurance; // 건강보험(%)
	private int nationalPension; //국민연금(%)
	
	// 기본금*소득세(%)
	private int salaryIncomeTax;
	// 기본금*건강보험(%)
	private int salaryHealthInsurance;
	// 기본금*국민연금(%)
	private int salaryNationalPension;
	
	
	// 공제합계 : 소득세+건강보험+국민연금
	private int insurance;
	
	//차인지급액 : 기본급+식대-(소득세+건강보험+국민연금)
	private int difference;
	
	//급여합계 : 기본급+식대
	private int salaryTotal;
	
	//일괄지급
	private int totalSalary;
	private int totalFood;
	private int totalAddedHours;
	
}
