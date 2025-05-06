package kr.or.ddit.contract.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.or.ddit.contract.vo.ContViewVO;
import kr.or.ddit.contract.vo.ContractMasterVO;
import kr.or.ddit.contract.vo.EnterPriceVO;

public interface ContractMasterService {
	
	// 계약 리스트
	public List<ContractMasterVO>list(Map<String, Object> map);

	// 계약 토탈 수 
	public int getTotal(Map<String, Object> map);

	// 계약 상세 
	public ContViewVO detail(ContViewVO contViewVO);

	// 계약 거래처 리스트 조회
	public List<EnterPriceVO> getEnpList(EnterPriceVO enterPriceVO);

	// 계약 수정
	public int updateCm(ContViewVO contViewVO);

	// 계약 삭제
	public int deleteCm(ContViewVO contViewVO);

	// 계약 등록
	public int createCm(ContractMasterVO contractMasterVO);

	// 계약 등록
	public List<ContViewVO> getStatus();

	// 계약 건수/매출 데이터 
	public List<ContractMasterVO> chartData();

	// 년도별 계약 건수/매출  Sum 데이터
	public List<ContractMasterVO> chartYearData();

	// 계약 정렬기준 리스트 불러오기 (비동기)
	public List<ContractMasterVO> listPriceSort(Map<String, Object> map);
}
