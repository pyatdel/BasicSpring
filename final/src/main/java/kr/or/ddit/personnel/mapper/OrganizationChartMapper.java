package kr.or.ddit.personnel.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.business.vo.EmployeeVO;

@Mapper
public interface OrganizationChartMapper {

	// 조직도 리스트 가져오기
	public List<EmployeeVO> OrganizationList();

	//부서별 직원 리스트 가져오기
	public List<EmployeeVO> getEmployeesByDepartment(String empName);

}
