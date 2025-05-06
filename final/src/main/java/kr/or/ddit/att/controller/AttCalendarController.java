package kr.or.ddit.att.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.att.service.AttManagerService;
import kr.or.ddit.att.vo.AttManagerVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.schedule.vo.ScheduleVO;
import lombok.extern.slf4j.Slf4j;

@CrossOrigin("http://localhost:7921")
@Slf4j
@RequestMapping("/attSchedule")
@RestController
public class AttCalendarController {
	
	@Autowired
	AttManagerService attManagerService;
	
	@GetMapping("/scheduleList")
	public List<AttManagerVO> getAttendanceList(@RequestParam(value="empNo") int empNo){
		log.info("스케줄리스트-> {}",empNo);
		List<AttManagerVO> attendanceList = attManagerService.getAttendanceList(empNo);
		
		if(attendanceList != null && !attendanceList.isEmpty()) {
			log.info("스케줄 데이터: {}",attendanceList);
		}else {
			log.warn("스케줄 리스트가 비어있습니다.");
		}
		return attendanceList;
	}
	
	@GetMapping("/{id}")
	public AttManagerVO AttendanceDetail(@PathVariable(value = "id") int attNo) {
		AttManagerVO attendance = new AttManagerVO();
		attendance.setAttNo(attNo);
		AttManagerVO result = attManagerService.AttendanceDetail(attendance);
		log.info("디테일: {}",result);
		return result;
	}
	
	@GetMapping("/getUser")
	public MemberVO getUser(MemberVO memberVO) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();

	    // 새 MemberVO 객체 생성
	    MemberVO userInfo = new MemberVO();

	    if (auth != null && auth.getPrincipal() instanceof org.springframework.security.core.userdetails.User) {
	        // 로그인한 사용자 ID 가져오기
	        String empId = ((org.springframework.security.core.userdetails.User) auth.getPrincipal()).getUsername();
//	        String empNo = ((org.springframework.security.core.userdetails.User) auth.getPrincipal()).getUsername();
	        userInfo.setEmpId(empId); // empId 설정
//	        userInfo.setEmpNo(empNo);
	    }
		
		return attManagerService.getUser(userInfo);
	}
	
	

}
