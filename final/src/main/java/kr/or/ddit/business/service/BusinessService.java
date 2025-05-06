package kr.or.ddit.business.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.CustInfoVO;
import kr.or.ddit.vo.EnterpriceVO;

public interface BusinessService {
	
	//총 행 수
	public List<EnterpriceVO> getTotal(Map<String, Object> map);

	//모든 고객 리스트
	public List<EnterpriceVO> custList(Map<String, Object> map);

	//대기중인 고객 관리
	public List<EnterpriceVO> waitCustList(Map<String, Object> map);

	//계약 취소 고객
	public List<EnterpriceVO> delCustList(Map<String, Object> map);

	
	//영업 통계 및 분석
	public List<CustInfoVO> busStat();  //월별 계약 체결 수
	public List<CustInfoVO> conStat();  //계약 체결률
	public List<CustInfoVO> getContractByCategory(); // 카테고리별 계약 체결 비율
	public List<CustInfoVO> getContractByStatus(); // 계약상태별 계약 체결 비율
	public List<CustInfoVO> getContractByEnterprise(); // 기업별 계약 체결 비율

	//내 고객 페이징 처리
	public List<EnterpriceVO> getPagedCustList(Map<String, Object> map);

	public int getTotalCount();



}
