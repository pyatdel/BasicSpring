package kr.or.ddit.reactjwt.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.reactjwt.vo.ReactUsersVO;

@Mapper
public interface ReactUsersMapper {
	
	// empNo로 사용자 정보를 가져옴
	public ReactUsersVO findByEmpNo(int empNo);

	// 토큰 서비스 추가하기
	public ReactUsersVO findById(String empId);

	public ReactUsersVO getEmpNoByEmpId(ReactUsersVO users);

	public ReactUsersVO getAttendanceByEmpNo(ReactUsersVO users);


}
