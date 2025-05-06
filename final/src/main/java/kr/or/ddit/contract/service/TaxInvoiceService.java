package kr.or.ddit.contract.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kr.or.ddit.contract.vo.CTaxInvoiceVO;
import kr.or.ddit.contract.vo.ContractDetailVO;
import kr.or.ddit.contract.vo.ContractObjectVO;
import kr.or.ddit.contract.vo.EnterPriceVO;
import kr.or.ddit.contract.vo.TaxinvoiceVO;

public interface TaxInvoiceService {
	
	// 세금계산서 상세 조회
	public TaxinvoiceVO taxinDetail(TaxinvoiceVO taxinvoiceVO);

	// 세금계산서 총 토탈 조회
	public int getTotal(Map<String, Object> map);

	// 세금계산서 리스트 조회
	public List<TaxinvoiceVO> list(Map<String, Object> map);

	// 세금계산서 수정
	public int taxinUp(TaxinvoiceVO taxInvoiceVO);

	// 세금 계산서 품목 조회
	public List<ContractObjectVO> objectDetail(ContractObjectVO contractObjectVO);

	// 세금계산서 거래처 총 토탈 조회
	public int getEntsTotal(Map<String, Object> map);

	// 세금계산서 거래처 리스트 조회
	public List<EnterPriceVO> getEnpList(Map<String, Object> map);

	// 세금계산서 발행 / 생성
	public int taxinCreate(TaxinvoiceVO taxinvoiceVO);

	// 세금계산서 삭제 
	public int delete(TaxinvoiceVO taxinvoiceVO);

	public int deleteTaxin(TaxinvoiceVO taxinvoiceVO);

	public int insertDetailAll(ContractDetailVO contractDetailVO);

//	public int insertDetailAll(List<ContractDetailVO> contractDetailList);
	


}
