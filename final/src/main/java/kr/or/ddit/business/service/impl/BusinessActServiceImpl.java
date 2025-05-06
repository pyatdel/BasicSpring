package kr.or.ddit.business.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.business.mapper.BusinessActMapper;
import kr.or.ddit.business.service.BusinessActService;
import kr.or.ddit.business.vo.BusinessActVO;

@Service
public class BusinessActServiceImpl implements BusinessActService{

	@Autowired
	BusinessActMapper businessActMapper;
	
	@Override
	public List<BusinessActVO> list(Map<String, Object> map) {
		return this.businessActMapper.list(map);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.businessActMapper.getTotal(map);
	}

	@Override
	public List<BusinessActVO> listAll() {
		return this.businessActMapper.listAll();
	}

	@Override
	public int createPost(BusinessActVO businessActVO) {
		return this.businessActMapper.createPost(businessActVO);
	}

	@Override
	public List<BusinessActVO> getAllEntities() {
		return this.businessActMapper.getAllEntites();
	}

//	@Override
//	public BusinessActVO businessActDetail(Integer busNo) {
//		return this.businessActMapper.businessActDetail(busNo);
//	}

}
