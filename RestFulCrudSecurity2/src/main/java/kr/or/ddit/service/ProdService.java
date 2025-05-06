package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ProdVO;

public interface ProdService {

	// 상품 목록
	public List<ProdVO> list(Map<String, Object> map);

	// 전체 행 수 구하기
	public int getTotal(Map<String, Object> map);

	// 상품 추가
	public int createPost(ProdVO prodVO);

	// 상품 상세
	public ProdVO detail(ProdVO prodVO);

	// 상품 수정
	public int updatePost(ProdVO prodVO);

	// 상품 삭제
	public int deletePost(ProdVO prodVO);

	

}
