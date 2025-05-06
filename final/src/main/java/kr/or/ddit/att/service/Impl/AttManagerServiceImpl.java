package kr.or.ddit.att.service.Impl;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.att.mapper.AttManagerMapper;
import kr.or.ddit.att.service.AttManagerService;
import kr.or.ddit.att.vo.AttManagerVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.schedule.vo.ScheduleVO;

@Service
public class AttManagerServiceImpl implements AttManagerService{
	
	@Autowired
	AttManagerMapper attManagerMapper;

	@Override
	public AttManagerVO CreateWorkTime(AttManagerVO attManagerVO) {
		return attManagerMapper.CreateWorkTime(attManagerVO);
	}

	@Override
	public AttManagerVO CheckIn(int empNo) {
		return attManagerMapper.CheckIn(empNo);
	}

	@Override
	public MemberVO profileRead(MemberVO userInfo) {
		return attManagerMapper.profileRead(userInfo);
	}

	@Override
	public int insertAttendance(int empNo, int status,int perception) {
		return attManagerMapper.insertAttendance(empNo,status,perception);
	}

	@Override
	public List<AttManagerVO> getAttendanceList(int empNo) {
		return attManagerMapper.getAttendanceList(empNo);
	}

	@Override
	public AttManagerVO AttendanceDetail(AttManagerVO attendance) {
		return attManagerMapper.AttendanceDetail(attendance);
	}

	@Override
	public MemberVO getUser(MemberVO userInfo) {
		return attManagerMapper.getUser(userInfo);
	}

	@Override
	public int isEmployeeCheckedIn(int empNo) {
		return attManagerMapper.isEmployeeCheckedIn(empNo);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return attManagerMapper.getTotal(map);
	}

	@Override
	public List<AttManagerVO> commuteList(Map<String, Object> map) {
		return attManagerMapper.commuteList(map);
	}

	@Override
	public int updateAttendance(int empNo) {
		return attManagerMapper.updateAttendance(empNo);
	}

	@Override
	public LocalDateTime getCheckInTime(int empNo) {
		return attManagerMapper.getCheckInTime(empNo);
	}

	@Override
	public List<Map<String, Object>> getDeptAvgAttendance() {
		return attManagerMapper.getDeptAvgAttendance();
	}

	@Override
	public List<Map<String, Object>> getEmpAvgAttendanceByDept(int deptNo) {
		return attManagerMapper.getEmpAvgAttendanceByDept(deptNo);
	}
	

}
