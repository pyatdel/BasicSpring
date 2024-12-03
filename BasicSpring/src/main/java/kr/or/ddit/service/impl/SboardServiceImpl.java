package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.SboardMapper;
import kr.or.ddit.service.isBoardService;
import kr.or.ddit.vo.SboardVO;

@Service
public class SboardServiceImpl implements isBoardService {

	@Autowired
	private SboardMapper sboardMapper;

	@Override
	public List<SboardVO> getList() {
		return sboardMapper.selectList();
	}
	

	

}
