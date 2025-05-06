package kr.or.ddit.personnel.service;

import java.util.List;

import kr.or.ddit.business.vo.EmployeeVO;

public interface OrganizationChartService {

	public List<EmployeeVO> OrganizationList();

	//부서별 직원 리스트 가져오기
	public List<EmployeeVO> getEmployeesByDepartment(String empName);

}
