package kr.or.ddit.personnel.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.business.vo.EmployeeVO;
import kr.or.ddit.personnel.mapper.OrganizationChartMapper;
import kr.or.ddit.personnel.service.OrganizationChartService;

@Service
public class OrganizationChartServiceImpl implements OrganizationChartService {
	
	@Autowired
	OrganizationChartMapper organizationChartMapper;

	@Override
	public List<EmployeeVO> OrganizationList() {
		return this.organizationChartMapper.OrganizationList();
	}

	//부서별 직원 리스트 가져오기
	@Override
	public List<EmployeeVO> getEmployeesByDepartment(String empName) {
		return this.organizationChartMapper.getEmployeesByDepartment(empName);
	}

	
}
