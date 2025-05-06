package kr.or.ddit.personnel.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.personnel.mapper.EmployeeSalaryMapper;
import kr.or.ddit.personnel.service.EmployeeSalaryService;
import kr.or.ddit.personnel.vo.EmployeeSalaryVO;
import kr.or.ddit.personnel.vo.EmployeeVO;

@Service
public class EmployeeSalaryImpl implements EmployeeSalaryService {

	@Autowired
	EmployeeSalaryMapper employeeSalaryMapper;

	// 사원번호 클릭 시 옆에 데이터 나오게 하기
	@Override
	public EmployeeVO slaryPost(String empId) {
		return this.employeeSalaryMapper.slaryPost(empId);
	}

	// 급여 등록
	@Override
	public int salaryCreate(EmployeeSalaryVO employeeSalaryVO) {
		return this.employeeSalaryMapper.salaryCreate(employeeSalaryVO);
	}

	//전체 개수
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.employeeSalaryMapper.getTotal(map);
	}

	//직원 급여 페이지 : 직원 조회
	@Override
	public List<EmployeeSalaryVO> salaryList(Map<String, Object> map) {
		return this.employeeSalaryMapper.salaryList(map);
	}

	// 연 월 데이터 가져오기
	@Override
	public List<EmployeeSalaryVO> getSalariesByYearMonth(String year,String month) {
		return this.employeeSalaryMapper.getSalariesByYearMonth(year,month);
	}

	//일괄 지급 등록
	@Override
	public int modalSalary(Map<String, Object> queryMap) {
		return this.employeeSalaryMapper.modalSalary(queryMap);
	}
	//일괄 지급 등록
	@Override
	public int modalSalary2(Map<String, Object> queryMap) {
		return this.employeeSalaryMapper.modalSalary2(queryMap);
	}
	//일괄 지급 등록
	@Override
	public int modalSalary3(Map<String, Object> queryMap) {
		return this.employeeSalaryMapper.modalSalary3(queryMap);
	}


	// 모달 리스트
	@Override
	public List<EmployeeSalaryVO> modalList(Map<String, Object> map) {
		return this.employeeSalaryMapper.modalList(map);
	}

	//급여 중복 등록 체크
	@Override
	public int salaryDupChk(EmployeeSalaryVO employeeSalaryVO) {
		return this.employeeSalaryMapper.salaryDupChk(employeeSalaryVO);
	}

	//급여 명세서
	@Override
	public List<EmployeeSalaryVO> paystubList(Map<String, Object> map) {
		return this.employeeSalaryMapper.paystubList(map);
	}




}
