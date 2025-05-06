package kr.or.ddit.att.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.att.vo.AnnualListVO;
import kr.or.ddit.att.vo.AttendanceCodeVO;

@Mapper
public interface AnnualMapper {

	public List<AnnualListVO> getList(Map<String, Object> map);

	public int getTotal(Map<String, Object> map);

	public List<AttendanceCodeVO> getAttendanceCode();

	public Integer annualSignUp(AnnualListVO annualSingUp);

	public Integer getEmpAnnual(int empNo);

	public List<AnnualListVO> getListAll(Map<String, Object> map);

	public int getAllTotal(Map<String, Object> map);

	public int updateAppStatus(List<Map<String,Integer>> empList, List<Integer> empNoList, List<Integer> annNoList, int appStatus);

	public List<AnnualListVO> getListComplete(Map<String, Object> map);

	public int updateAnnCnt(List<Integer> annNoList);

	int getApproverEmpNo(int annNo);

	public String getEmpName(int empNo);


}
