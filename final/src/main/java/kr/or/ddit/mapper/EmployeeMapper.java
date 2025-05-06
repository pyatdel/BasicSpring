package kr.or.ddit.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.EmployeeVO;

@Mapper
public interface EmployeeMapper {
	EmployeeVO getEmployeeByEmpId(String empId);
}
