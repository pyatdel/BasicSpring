package kr.or.ddit.personnel.service;

import java.util.List;

import kr.or.ddit.personnel.vo.PositionVO;

public interface PositionService {

	// employeeList create에서 직급 선택 할 수 있게 하기 위한 list
	public List<PositionVO> getPositionList();

}
