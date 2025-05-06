package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.LprodMapper;
import kr.or.ddit.service.LprodService;
import kr.or.ddit.vo.LprodVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LprodServiceImpl implements LprodService {

	@Autowired
	LprodMapper lprodMapper;
	
	// 상품 분류 등록
	@Override
	public int createPost(LprodVO lprodVO) {
		return this.lprodMapper.createPost(lprodVO);
	}
	
	// 상품 분류 상세보기 방법 1
	@Override
	public LprodVO detail(int lprodId) {
		return this.lprodMapper.detail(lprodId);
	}
	
	/* 방법 2
	// 상품 분류 상세보기
	@Override
	public LprodVO detail(LprodVO lprodVO) {
		return this.lprodMapper.detail(lprodVO);
	}
	*/
	
	// 상품 분류 수정 
	@Override
	public int updatePost(LprodVO lprodVO) {
		return this.lprodMapper.updatePost(lprodVO);
	}

	// 상품 분류 삭제
	@Override
	public int deletePost(LprodVO lprodVO) {
		return this.lprodMapper.deletePost(lprodVO);
	}

	// 상품 분류 리스트
	@Override
	public List<LprodVO> list(Map<String, Object> map) {
		return this.lprodMapper.list(map);
	}
	
	// 상품 분류 전체 리스트
	@Override
	public List<LprodVO> listAll(){
		return this.lprodMapper.listAll();
	}

	// 전체 행의 수
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.lprodMapper.getTotal(map);
	}

	
	/* 등록할 대상 상품 미리 준비해보기
	 1. 상품 코드 : 상품분류에 해당하는 마지막 상품 코드 +1 가져옴
	 lprodVO{lprodId=10,lprodId=P501,lprodNm=도서류}
	 
	 결과 : string -> P101000007
	<select id="getMaxProdId" parameterType="kr.or.ddit.vo.LprodVO" 
			resultType="String">
	 */
	@Override
	public String getMaxProdId(LprodVO lprodVo) {
		return this.lprodMapper.getMaxProdId(lprodVo);
	}

	
	/* 등록할 대상 상품 미리 준비해보기
	2. 거래처 코드 : select 태그 구성을 위해 상품분류에 해당하는 거래처 목록을 준비
	
	lprodVO{lprodId=10,lprodId=P501,lprodNm=도서류}
	리턴 : map리스트 
		[
			{BUYER_ID=P30201,BUYER_NAME=한국화장품},
			{BUYER_ID=P30202,BUYER_NAME=피리어스},
			{BUYER_ID=P30203,BUYER_NAME=참존}
		  ]
	 <select id="getbBuyerList" parameterType="kr.or.ddit.vo.LprodVO" 
 			resultType="hashMap">
	*/
	@Override
	public List<Map<String, Object>> getBuyerList(LprodVO lprodVO) {
		return this.lprodMapper.getBuyerList(lprodVO);
	}

	
	// PROD 테이블에 다중 insert
	@Override
	public int insertAllProd(LprodVO lprodVO) {
		return this.lprodMapper.insertAllProd(lprodVO);
	}
	
	
}
