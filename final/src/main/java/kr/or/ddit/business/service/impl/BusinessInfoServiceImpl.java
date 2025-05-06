package kr.or.ddit.business.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.business.mapper.BusinessInfoMapper;
import kr.or.ddit.business.service.BusinessInfoService;
import kr.or.ddit.business.vo.EnterpriceVO;
import kr.or.ddit.contract.vo.ContViewVO;
import kr.or.ddit.vo.ContractMasterVO;
import kr.or.ddit.vo.CustInfoVO;

@Service
public class BusinessInfoServiceImpl implements BusinessInfoService{

	@Autowired
	BusinessInfoMapper businessInfoMapper;

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.businessInfoMapper.getTotal(map);
	}

	@Override
	public List<CustInfoVO> list(Map<String, Object> map) {
		return this.businessInfoMapper.list(map);
	}

	@Override
	public CustInfoVO detail(int entNo) {
		return this.businessInfoMapper.detail(entNo);
	}

	@Override
	public List<CustInfoVO> detailList(int entNo) {
		return this.businessInfoMapper.detailList(entNo);
	}
	
	@Override
	public int update(ContViewVO contViewVO) {
		return this.businessInfoMapper.update(contViewVO);
	}

	@Override
	public int delete(EnterpriceVO enterpriceVO) {
		return businessInfoMapper.delete(enterpriceVO);
	}

	@Override
	public int deleteByEntNo(String entNo) {
		return businessInfoMapper.deleteMyEntNo(entNo);
	}


	@Override
	public int createPost(CustInfoVO custInfoVO) {
		return this.businessInfoMapper.createPost(custInfoVO);
	}

	@Override
	public int updatePost(CustInfoVO custInfoVO) {
		return this.businessInfoMapper.updatePost(custInfoVO);
	}

	@Override
	public int deletePost(CustInfoVO custInfoVO) {
		return this.businessInfoMapper.deletePostAjax(custInfoVO);
	}

	@Override
	public int idDupChk(CustInfoVO custInfoVO) {
		return this.businessInfoMapper.idDupChk(custInfoVO);
	}




}
