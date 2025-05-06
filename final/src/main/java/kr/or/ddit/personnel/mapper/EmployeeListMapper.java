package kr.or.ddit.personnel.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.personnel.vo.EmployeeVO;

@Mapper
public interface EmployeeListMapper {

	// 전체 행의 수
	public int getTotal(Map<String, Object> map);

	// 직원 목록 전체 조회
	public List<EmployeeVO> list(Map<String, Object> map);
	
	//직원 목록 자세히 보기
	public EmployeeVO detail(EmployeeVO employeeVO);

	// 직원 수정 페이지
	public int updatePost(EmployeeVO employeeVO);

	// 직원 등록
	public int createPost(EmployeeVO employeeVO);

	//직원 탈퇴 처리
	public int delete(EmployeeVO employeeVO);

	//직원 사원번호 중복 체크
	public int idDupChk(EmployeeVO employeeVO);

	//퇴사자 리스트
	public List<EmployeeVO> resign(Map<String, Object> map);

	// 퇴사자 개수
	public int getResignTotal(Map<String, Object> map);

	//입사,퇴사,총인원수
	public List<EmployeeVO> chartList(Map<String, Object> map);

	

}
