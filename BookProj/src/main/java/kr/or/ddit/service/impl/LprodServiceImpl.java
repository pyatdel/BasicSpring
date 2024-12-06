package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.LprodMapper;
import kr.or.ddit.service.LprodService;
import kr.or.ddit.vo.LprodVO;
import kr.or.ddit.vo.ProdVO;

@Service
public class LprodServiceImpl implements LprodService {

	@Autowired
	LprodMapper lprodMapper;
	
	//LPROD 테이블에 insert
	@Override
	public int createPost(LprodVO lprodVO) {
		return this.lprodMapper.createPost(lprodVO);
	}

	//상품분류 상세
	@Override
	public LprodVO detail(int lprodId) {
		return this.lprodMapper.detail(lprodId);
	}

	//상품분류 수정
	/*
	@Override
	public int updatePost(LprodVO lprodVO) {
		return this.lprodMapper.updatePost(lprodVO);
	}
	*/
	//상품분류 삭제
	@Override
	public int deletePost(LprodVO lprodVO) {
		return this.lprodMapper.deletePost(lprodVO);
	}

	//상품 목록
	@Override
	public List<LprodVO> list(Map<String, Object> map) {
		return this.lprodMapper.list(map);
	}

	//전체 행의 수 *******
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.lprodMapper.getTotal(map);
	}
	
	/*등록할 대상 상품 미리 준비해보기
	1. 상품 코드 : 상품분류에 해당하는 마지막 상품 코드 + 1 가져옴
	lprodVO{lprodId=10,lprodId=P501,lprodNm=도서류}
	
	결과 : P101000007
	<select id="getMaxProdId" parameterType="kr.or.ddit.vo.LprodVO"
		resultType="String">
	 */
	@Override
	public String getMaxProdId(LprodVO lprodVO) {
		return this.lprodMapper.getMaxProdId(lprodVO);
	}
	
	/*등록할 대상 상품 미리 준비해보기
	2. 거래처 코드 : select 태그 구성을 위해 상품분류에 해당하는 거래처 목록을 준비
	lprodVO{lprodId=10,lprodGu=P501,lprodNm=도서류}
	리턴 : [
			{BUYER_ID=P30201,BUYER_NAME=한국화장품}, 
			{BUYER_ID=P30202,BUYER_NAME=피리어스},
			{BUYER_ID=P30203,BUYER_NAME=참존} 
		]
	<select id="getBuyerList" parameterType="kr.or.ddit.vo.LprodVO"
		resultType="hashMap">
	*/
	@Override
	public List<Map<String,Object>> getBuyerList(LprodVO lprodVO){
		return this.lprodMapper.getBuyerList(lprodVO);
	}
	
	//PROD 테이블에 다중insert
	//<update id="insertAllProd" parameterType="kr.or.ddit.vo.LprodVO">
	@Override
	public int insertAllProd(LprodVO lprodVO) {
		return this.lprodMapper.insertAllProd(lprodVO);
	}

	@Override
	public List<LprodVO> listAll() {
		return this.lprodMapper.listAll();
	}

}





