package kr.or.ddit.reactjwt.service;

import kr.or.ddit.reactjwt.vo.ReactUsersVO;

public interface ReactUsersService {
	
	// 토큰 서비스 추가하기
	public ReactUsersVO findById(String empId);
	
	boolean validateLogin (String empId, String empPw);
	
	public ReactUsersVO getUserByEmpId(String empId);

	public ReactUsersVO getEmpNoByEmpId(ReactUsersVO users);

	public ReactUsersVO getAttendanceByEmpNo(ReactUsersVO users);
	
	

}
