package kr.or.ddit.business.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.business.mapper.BusinessMapper;
import kr.or.ddit.business.service.BusinessService;
import kr.or.ddit.vo.CustInfoVO;
import kr.or.ddit.vo.EnterpriceVO;

@Service
public class BusinessServiceImpl implements BusinessService{

	@Autowired
	BusinessMapper businessMapper;
	
	@Override
	public List<EnterpriceVO> custList(Map<String, Object> map) {
		return this.businessMapper.custList(map);
	}

	@Override
	public List<EnterpriceVO> waitCustList(Map<String, Object> map) {
		return this.businessMapper.waitCustList(map);
	}

	@Override
	public List<EnterpriceVO> delCustList(Map<String, Object> map) {
		return this.businessMapper.delCustList(map);
	}
	
	@Override
	public  List<EnterpriceVO> getTotal(Map<String, Object> map) {
		return this.businessMapper.getTotal(map);
	}
	
	@Override
	public List<CustInfoVO> busStat() {
		return this.businessMapper.busStat();
	}
	
	@Override
	public List<CustInfoVO> conStat() {
		return this.businessMapper.conStat();
	}
	
	@Override
    public List<CustInfoVO> getContractByCategory() {
        return this.businessMapper.getContractByCategory();
    }


    @Override
    public List<CustInfoVO> getContractByStatus() {
        return this.businessMapper.getContractByStatus();
    }


    @Override
    public List<CustInfoVO> getContractByEnterprise() {
        return this.businessMapper.getContractByEnterprise();
    }

	@Override
	public List<EnterpriceVO> getPagedCustList(Map<String, Object> map) {
		
//		int page = (int) map.get("page");
//        int size = (int) map.get("size");
//
//        int startRow = (page - 1) * size;
//        map.put("startRow", startRow);
//        map.put("endRow", startRow + size);

		return this.businessMapper.getPagedCustList(map);
	}

	@Override
	public int getTotalCount() {
		return this.businessMapper.getTotalCount();
	}


}
