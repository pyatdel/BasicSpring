package kr.or.ddit.contract.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.contract.mapper.ExpenditureMapper;
import kr.or.ddit.contract.service.ExpenditureService;
import kr.or.ddit.contract.vo.ExpenditureVO;

@Service
public class ExpenditureServiceImpl implements ExpenditureService {

	@Autowired
	ExpenditureMapper expenditureMapper;
	
	@Override
	public List<ExpenditureVO> expditList(Map<String, Object> map) {
		return this.expenditureMapper.expditList(map);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.expenditureMapper.getTotal(map);
	}
	
}
