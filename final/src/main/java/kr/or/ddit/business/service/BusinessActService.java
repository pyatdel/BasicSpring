package kr.or.ddit.business.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.business.vo.BusinessActVO;

public interface BusinessActService {

	public List<BusinessActVO> list(Map<String, Object> map);

	public int getTotal(Map<String, Object> map);

	//영업활동 - 유형분류
	public List<BusinessActVO> listAll();

	//영업활동 등록
	public int createPost(BusinessActVO businessActVO);

	//거래처 전체 리스트
	public List<BusinessActVO> getAllEntities();

//	public void create(BusinessActVO businessActVO);

//	BusinessActVO businessActDetail(Integer busNo);

}
