package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.LprodVO;
import kr.or.ddit.vo.ProdVO;

public interface LprodService {

	// LRPOD 테이블에 insert (상품 분류 등록)
	public int createPost(LprodVO lprodVO);
	
	// 상품 분류 상세보기 방법 1
	public LprodVO detail(int lprodId);
	
	/* 상품 분류 상세보기 방법 2 */
	// public LprodVO detail(LprodVO lprodVO);

	/*
	// 상품 분류 수정
	public int updatePost(ProdVO prodVO);
	*/
	
	// 상품 분류 삭제
	public int deletePost(LprodVO lprodVO);

	// 상품 분류 리스트
	public List<LprodVO> list(Map<String, Object> map);

	// 전체 행의 수
	public int getTotal(Map<String, Object> map);
	

	/* 등록할 대상 상품 미리 준비해보기
	 1. 상품 코드 : 상품분류에 해당하는 마지막 상품 코드 +1 가져옴
	 lprodVO{lprodId=10,lprodId=P501,lprodNm=도서류}
	 
	 결과 : string -> P101000007
	<select id="getMaxProdId" parameterType="kr.or.ddit.vo.LprodVO" 
			resultType="String">
	 */
	public String getMaxProdId(LprodVO lprodVo);
	
	
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
	public List<Map<String, Object>> getBuyerList(LprodVO lprodVO);
	
	
	// PROD 테이블에 다중 insert
	public int insertAllProd(LprodVO lprodVO);

	// !!! 상품 분류 전체 리스트!!!
	public List<LprodVO> listAll();

}
