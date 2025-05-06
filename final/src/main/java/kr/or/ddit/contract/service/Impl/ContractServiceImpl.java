package kr.or.ddit.contract.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.contract.mapper.ContractMapper;
import kr.or.ddit.contract.service.ContractMasterService;
import kr.or.ddit.contract.vo.ContViewVO;
import kr.or.ddit.contract.vo.ContractMasterVO;
import kr.or.ddit.contract.vo.EnterPriceVO;
import kr.or.ddit.upload.cotroller.UploadController;
@Service
public class ContractServiceImpl implements ContractMasterService {

	@Autowired
	ContractMapper contractMapper;
	
	@Autowired
	UploadController uploadController;
	
	// 계약 리스트
	@Override
	public List<ContractMasterVO> list(Map<String, Object> map) {
		return this.contractMapper.list(map) ;
	}
	
	// 계약 토탈 수
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.contractMapper.getTotal(map);
	}
	
	// 계약 상세
	@Override
	public ContViewVO detail(ContViewVO contViewVO) {
		return this.contractMapper.detail(contViewVO);
	}
	
	// 계약 거래처 리스트 조회
	@Override
	public List<EnterPriceVO> getEnpList(EnterPriceVO enterPriceVO) {
		return this.contractMapper.getEnpList(enterPriceVO);
	}

	// 계약 수정
	@Override
	public int updateCm(ContViewVO contViewVO) {
		return this.contractMapper.updateCm(contViewVO);
	}

	// 계약 삭제
	@Override
	public int deleteCm(ContViewVO contViewVO) {
		return this.contractMapper.deleteCm(contViewVO);
	}

	// 계약 등록
	@Override
	public int createCm(ContractMasterVO contractMasterVO) {
		
		MultipartFile [] uploadFiles = contractMasterVO.getUploadFiles();
		
		if(uploadFiles != null && uploadFiles[0].getOriginalFilename().length()>0) {
		
		long fileGroupNo = this.uploadController.multiImageUpload(uploadFiles);
		
		contractMasterVO.setFileGroupNo(fileGroupNo);
		}
		
		int result = this.contractMapper.createCm(contractMasterVO); 
		return result;
		
	
	}

	// 계약 등록ㄴ
	@Override
	public List<ContViewVO> getStatus() {
		return this.contractMapper.getStatus();
	}

	// 계약 건수/매출 데이터 
	@Override
	public List<ContractMasterVO> chartData() {
		return this.contractMapper.chartDate();
	}
	
	// 년도별 계약 건수/매출  Sum 데이터
	@Override
	public List<ContractMasterVO> chartYearData() {
		return this.contractMapper.chartYearData();
	}

	// 계약 정렬기준 리스트 불러오기 (비동기)
	@Override
	public List<ContractMasterVO> listPriceSort(Map<String, Object> map) {
		return this.contractMapper.listPriceSort(map);
	}

}
