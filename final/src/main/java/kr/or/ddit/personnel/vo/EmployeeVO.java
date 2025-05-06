package kr.or.ddit.personnel.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.file.vo.FileGroupVO;
import lombok.Data;

@Data
public class EmployeeVO {
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
	private String empIn;
	private String empOut;
	private int deptNo;
	private int postNo;
	private int rnum;
	private String empProfile;
	private String residentNumber1;
	private String residentNumber2;
	private int empInCount;
	private int empOutCount;
	private int empCount;
	private String year;            // 연도
	
	//부서 1:n
	private String deptName;
	
	private  DepartmentVO departmentVO;
	
	//직급 1:n
	private String postName;
	private List<EmployeeSalaryVO> salaryVOList;
	
	// MEMBER : FILE_GROUP = 1 : 1 = association
	private FileGroupVO fileGroupVO;	

	private long fileGroupNo;
	
	private MultipartFile[] uploadFile;
	
	private PositionVO positionVO;
	
}
