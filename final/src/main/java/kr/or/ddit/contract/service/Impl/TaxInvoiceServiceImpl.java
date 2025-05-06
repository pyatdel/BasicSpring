package kr.or.ddit.contract.service.Impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.contract.mapper.TaxInvoiceMapper;
import kr.or.ddit.contract.service.TaxInvoiceService;
import kr.or.ddit.contract.vo.CTaxInvoiceVO;
import kr.or.ddit.contract.vo.ContractDetailVO;
import kr.or.ddit.contract.vo.ContractObjectVO;
import kr.or.ddit.contract.vo.EnterPriceVO;
import kr.or.ddit.contract.vo.TaxinvoiceVO;

@Service
public class TaxInvoiceServiceImpl implements TaxInvoiceService {

	@Autowired
	TaxInvoiceMapper taxInvoiceMapper;

	// 세금계산서 상세 조회
	@Override
	public TaxinvoiceVO  taxinDetail(TaxinvoiceVO taxinvoiceVO) {
		return this.taxInvoiceMapper.taxinDetail(taxinvoiceVO);
	}

	// 세금계산서 총 토탈 조회
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.taxInvoiceMapper.getTotal(map);
	}

	// 세금계산서 리스트 조회
	@Override
	public List<TaxinvoiceVO> list(Map<String, Object> map) {
		return this.taxInvoiceMapper.list(map);
	}

	// 세금계산서 수정
	@Override
	public int taxinUp(TaxinvoiceVO taxInvoiceVO) {
		return this.taxInvoiceMapper.taxinUp(taxInvoiceVO);
	}

	// 세금 계산서 품목 조회
	@Override
	public List<ContractObjectVO> objectDetail(ContractObjectVO contractObjectVO) {
		return this.taxInvoiceMapper.objectDetail(contractObjectVO);
	}

	// 세금계산서 거래처 총 토탈 조회
	@Override
	public int getEntsTotal(Map<String, Object> map) {
		return this.taxInvoiceMapper.getEntTotal(map);
	}

	// 세금계산서 거래처 리스트 조회ㄴ
	@Override
	public List<EnterPriceVO> getEnpList(Map<String, Object> map) {
		return this.taxInvoiceMapper.getEnpList(map);
	}

	// 세금계산서 발행 / 생성
	@Override
	public int taxinCreate(TaxinvoiceVO taxinvoiceVO) {
		return this.taxInvoiceMapper.taxinCreate(taxinvoiceVO);
	}

	// 세금계산서 삭제 
	@Override
	public int delete(TaxinvoiceVO taxinvoiceVO) {
		return this.taxInvoiceMapper.delete(taxinvoiceVO);
	}

	@Override
	public int deleteTaxin(TaxinvoiceVO taxinvoiceVO) {
		return this.taxInvoiceMapper.deleteTaxin(taxinvoiceVO);
	}

	@Override
	public int insertDetailAll(ContractDetailVO contractDetailVO) {
		return this.taxInvoiceMapper.insertDetailAll(contractDetailVO);
	}



	/*
	@Override
	public int insertDetailAll(List<ContractDetailVO> contractDetailList) {
	    int result = 0;
	    
	    // contractDetailList가 null이거나 비어있는 경우 처리
	    if (contractDetailList == null || contractDetailList.isEmpty()) {
	        return 0;  // 처리할 데이터가 없으면 0을 반환
	    }

	    // 유효한 항목들만 처리
	    for (ContractDetailVO contractDetailVO : contractDetailList) {
	        if (contractDetailVO.getItemCode() != null && !contractDetailVO.getItemCode().isEmpty() 
	                && contractDetailVO.getItemQty() > 0 && contractDetailVO.getItemPrice() > 0) {
	            // DB에 삽입
	            result += taxInvoiceMapper.insertDetailAll(contractDetailVO);  // 개별 삽입
	        }
	    }

	    return result;  // 성공적으로 삽입된 레코드 수 반환
	}
	*/


}
