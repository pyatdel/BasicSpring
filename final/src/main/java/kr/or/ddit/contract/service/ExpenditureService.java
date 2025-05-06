package kr.or.ddit.contract.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.contract.vo.ExpenditureVO;

public interface ExpenditureService {

	public List<ExpenditureVO> expditList(Map<String, Object> map);

	public int getTotal(Map<String, Object> map);

}
