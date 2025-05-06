package kr.or.ddit.business.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.business.mapper.BusinessChanceMapper;
import kr.or.ddit.business.service.BusinessChanceService;
import kr.or.ddit.business.vo.BusinessChanceVO;

@Service
public class BusinessChanceServiceImpl implements BusinessChanceService{

	@Autowired
	BusinessChanceMapper businessChanceMapper;

	@Override
	public List<BusinessChanceVO> list(Map<String, Object> map) {
		return this.businessChanceMapper.list(map);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.businessChanceMapper.getTotal(map);
	}

	@Override
	public List<BusinessChanceVO> successRate(Long contractNo) {
		return this.businessChanceMapper.successRate(contractNo);
	}

	@Override
	public List<BusinessChanceVO> stateList() {
		return this.businessChanceMapper.stateList();
	}
	
	
}
