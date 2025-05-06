package kr.or.ddit.att.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.att.vo.AnnualListVO;
import kr.or.ddit.att.vo.AttendanceCodeVO;

public interface AnnualService {
	
	//  연차리스트
	public List<AnnualListVO> getList(Map<String, Object> map);
	
	// 관리자 연차 리스트 
	public List<AnnualListVO> getListAll(Map<String, Object> map);

	public int getTotal(Map<String, Object> map);
	
	public List<AttendanceCodeVO> getAttendanceCode();

	public int annualSignUp(AnnualListVO annualSignUp);

	public int getEmpAnnual(int empNo);

	public int getAllTotal(Map<String, Object> map);

	public int updateAppStatus(List<Map<String,Integer>> empList,List<Integer> empNoList, List<Integer> annNoList, int appStatus);

	public List<AnnualListVO> getListComplete(Map<String, Object> map);
	
	public int getApproverEmpNo(int annNo);
	

}
