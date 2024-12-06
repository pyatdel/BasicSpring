package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ProdMapper;
import kr.or.ddit.service.ProdService;
import kr.or.ddit.vo.ProdVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProdServiceImpl implements ProdService {

	@Autowired
	ProdMapper prodMapper;
	
	// 상품 업로드
	@Override
	public int createPost(ProdVO prodVO) {
		return this.prodMapper.createPost(prodVO);
	}

	// 상품 상세
	@Override
	public ProdVO detail(ProdVO prodVO) {
		return this.prodMapper.detail(prodVO);
	}

	// 자동 고유번호 
	@Override
	public String getMaxProdId(ProdVO prodVO) {
		return this.prodMapper.getMaxProdId(prodVO);
	}

	// 자동 거래처
	@Override
	public List<Map<String, Object>> getBuyerList(ProdVO prodVO) {
		return this.prodMapper.getBuyerList(prodVO);
	}

	// 상품분류 수정
	@Override
	public int updatePost(ProdVO prodVO) {
		return this.prodMapper.updatePost(prodVO);
	}

	// 총 페이지 수
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.prodMapper.getTotal(map);
	}

	@Override
	public List<ProdVO> list(Map<String, Object> map) {
		return this.prodMapper.list(map);
	}

	@Override
	public int deletePost(ProdVO prodVO) {
		return this.prodMapper.deletePost(prodVO);
	}


}
