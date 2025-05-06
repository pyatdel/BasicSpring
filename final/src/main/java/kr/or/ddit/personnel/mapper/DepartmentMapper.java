package kr.or.ddit.personnel.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.personnel.vo.DepartmentVO;

@Mapper
public interface DepartmentMapper {

	// employeeList create에서 부서 선택 할 수 있게 하기 위한 list
	public List<DepartmentVO> getDepartmentList();

	// 부서명 가져오기
	public DepartmentVO getDeptName(int deptNo);

}
