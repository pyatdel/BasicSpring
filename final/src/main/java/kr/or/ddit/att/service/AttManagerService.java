package kr.or.ddit.att.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import kr.or.ddit.att.vo.AttManagerVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.schedule.vo.ScheduleVO;

public interface AttManagerService {

	public AttManagerVO CreateWorkTime(AttManagerVO attManagerVO);

	public AttManagerVO CheckIn(int empNo);

	public MemberVO profileRead(MemberVO userInfo);

	public int insertAttendance(int empNo, int status, int perception);

	public List<AttManagerVO> getAttendanceList(int empNo);

	public AttManagerVO AttendanceDetail(AttManagerVO attendance);

	public MemberVO getUser(MemberVO userInfo);

	public int isEmployeeCheckedIn(int empNo);

	public int getTotal(Map<String, Object> map);

	public List<AttManagerVO> commuteList(Map<String, Object> map);

	public int updateAttendance(int empNo);

	public LocalDateTime getCheckInTime(int empNo);

	public List<Map<String, Object>> getDeptAvgAttendance();

	public List<Map<String, Object>> getEmpAvgAttendanceByDept(int deptNo);

}
