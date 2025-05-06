package kr.or.ddit.personnel.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.personnel.mapper.PositionMapper;
import kr.or.ddit.personnel.service.PositionService;
import kr.or.ddit.personnel.vo.PositionVO;

@Service
public class PositionServiceImpl implements PositionService {
	
	@Autowired
	PositionMapper positionMapper;

	// employeeList create에서 직급 선택 할 수 있게 하기 위한 list
	@Override
	public List<PositionVO> getPositionList() {
		return this.positionMapper.getPositionList();
	}

}
