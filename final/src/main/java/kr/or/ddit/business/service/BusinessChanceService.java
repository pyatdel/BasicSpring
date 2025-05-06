package kr.or.ddit.business.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.business.vo.BusinessChanceVO;

public interface BusinessChanceService {

	//영업기회 리스트
	public List<BusinessChanceVO> list(Map<String, Object> map);

	//총 행 수
	public int getTotal(Map<String, Object> map);

	//영업기회 성공률
	public List<BusinessChanceVO> successRate(Long contractNo);

	//영업기회 상태리스트
	public List<BusinessChanceVO> stateList();

}
