package kr.or.ddit.personnel.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.personnel.vo.EmployeeSalaryVO;
import kr.or.ddit.personnel.vo.EmployeeVO;

@Mapper
public interface EmployeeSalaryMapper {

	// 사원번호 클릭 시 옆에 데이터 나오게 하기
	public EmployeeVO slaryPost(String empId);

	// 급여 등록
	public int salaryCreate(EmployeeSalaryVO employeeSalaryVO);

	// 전체 개수
	public int getTotal(Map<String, Object> map);
	
	//직원 급여 페이지 : 직원 조회
	public List<EmployeeSalaryVO> salaryList(Map<String, Object> map);

	// 연 월 데이터 가져오기
	public List<EmployeeSalaryVO> getSalariesByYearMonth(String year,String month);
	
	//일괄 지급 등록(인건비)
	public int modalSalary(Map<String, Object> queryMap);
	
	//일괄 지급 등록(추가수당비)
	public int modalSalary2(Map<String, Object> queryMap);
	
	//일괄 지급 등록(식비)
	public int modalSalary3(Map<String, Object> queryMap);



	// 모달 리스트
	public List<EmployeeSalaryVO> modalList(Map<String, Object> map);

	// 전체개수(모달)
	public int getModalTotal(Map<String, Object> map);

	//급여 중복 등록 체크
	public int salaryDupChk(EmployeeSalaryVO employeeSalaryVO);

	//급여 명세서
	public List<EmployeeSalaryVO> paystubList(Map<String, Object> map);
}
