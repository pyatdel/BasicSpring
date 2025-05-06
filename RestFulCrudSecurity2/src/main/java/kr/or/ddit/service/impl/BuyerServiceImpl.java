package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.BuyerMapper;
import kr.or.ddit.service.BuyerService;
import kr.or.ddit.vo.BuyerVO;

@Service
public class BuyerServiceImpl implements BuyerService {
	
	@Autowired
	BuyerMapper buyerMapper;
	
	@Override
	public List<BuyerVO> getBuyerList(){
		return this.buyerMapper.getBuyerList();
	}
}
