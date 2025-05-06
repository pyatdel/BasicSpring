package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ProdMapper;
import kr.or.ddit.service.ProdService;
import kr.or.ddit.vo.ProdVO;

@Service
public class ProdServiceImpl implements ProdService {

	@Autowired
	ProdMapper prodMapper;
	
	// 상품 목록
	@Override
	public List<ProdVO> list(Map<String, Object> map) {
		return this.prodMapper.list(map);
	}

	// 전체 행 구하기
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.prodMapper.getTotal(map);
	}

	// 상품 추가
	@Override
	public int createPost(ProdVO prodVO) {
		return this.prodMapper.createPost(prodVO);
	}

	// 상품 상세
	@Override
	public ProdVO detail(ProdVO prodVO) {
		return this.prodMapper.detail(prodVO);
	}

	// 상품 수정
	@Override
	public int updatePost(ProdVO prodVO) {
		return this.prodMapper.updatePost(prodVO);
	}

	// 상품 삭제
	@Override
	public int deletePost(ProdVO prodVO) {
		return this.prodMapper.deletePost(prodVO);
	}

}
