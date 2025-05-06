package kr.or.ddit.personnel.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.personnel.mapper.DepartmentMapper;
import kr.or.ddit.personnel.service.DepartmentService;
import kr.or.ddit.personnel.vo.DepartmentVO;

@Service
public class DepartmentServiceImpl implements DepartmentService {
	
	@Autowired
	DepartmentMapper departmentMapper;

	// employeeList create에서 부서 선택 할 수 있게 하기 위한 list
	@Override
	public List<DepartmentVO> getDepartmentList() {
		return this.departmentMapper.getDepartmentList();
	}

	@Override
	public DepartmentVO getDeptName(int deptNo) {
		return this.departmentMapper.getDeptName(deptNo);
	}

}
