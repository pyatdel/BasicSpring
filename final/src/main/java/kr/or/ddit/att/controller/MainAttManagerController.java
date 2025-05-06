package kr.or.ddit.att.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.att.service.AttManagerService;
import kr.or.ddit.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/att")
@Controller
public class MainAttManagerController {
	
	@Autowired
	AttManagerService attManagerService;
	
	@GetMapping("/MainAttManager")
	public String profile(Model model, MemberVO memberVO) {
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
		MemberVO getUser = attManagerService.getUser(userInfo);
		userInfo = attManagerService.profileRead(userInfo);
		log.info("Fetched MemberVO: {}",userInfo);
		
		if (userInfo != null) {
	        model.addAttribute("userInfo", userInfo);
	        model.addAttribute("getUser",getUser);
	    } else {
	        log.warn("User not found");
	        model.addAttribute("error", "User not found");
	    }
		
		
		// 현재 시스템 기간 구하기
		long systemTime = System.currentTimeMillis();
		
		// 출력 형태를 위한 frommater
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.KOREA);
		
		// format에 맞게 출력하기 위한 문자열 변환
		String dTime = formatter.format(systemTime);
		
		log.info("현재 시각 : {}" ,dTime);
		
		model.addAttribute("dTime",dTime);
		
		return "main";
		
	}

	@PostMapping("/MainCheckIn")
	@ResponseBody
	public Map<String,Object> CheckIn(@RequestParam int empNo) {
		Map<String, Object> response = new HashMap<>();
		try {
			LocalDateTime now = LocalDateTime.now(); // 현재시간
			LocalTime checkInTime = now.toLocalTime();
			int status;
			int perception;
			if(checkInTime.isBefore(LocalTime.of(9, 0))) {
				status = AttendanceStatus.ON_TIME; // 출근처리
				perception = AttendanceStatus.ON_TIME;
			}else if(checkInTime.isBefore(LocalTime.of(9, 10).plusSeconds(50))) {
				status = AttendanceStatus.ON_TIME; // 9시 10분 50초 까지도 정시출근으로 인정
				perception = AttendanceStatus.ON_TIME;
			}else {
				status = AttendanceStatus.LATE; // 지각 처리
				perception = AttendanceStatus.LATE;
			}
			
			attManagerService.insertAttendance(empNo,status,perception);
			
			if(empNo <= 0) {
				response.put("message", "유효하지않은 사원 번호입니다.");
				response.put("status", "error");
				response.put("perception", perception);
				return response;
			}
			
			response.put("message", "출근 완료!");
			response.put("status", "success");
			response.put("serverTime", now); // 서버의 현재 시간 추가
	        return response;
			
		}catch(Exception e){
			e.printStackTrace();
			response.put("message", "출근 처리 중 오류 발생");
			response.put("status", "error");
			return response;
		}
	}
	
	@GetMapping("/MainCheckStatus")
	public Map<String, Object> checkAttendanceStatus(@RequestParam int empNo){
		
		int isCheckedIn = attManagerService.isEmployeeCheckedIn(empNo);
		Map<String, Object> response = new HashMap();
		response.put("isCheckedIn", isCheckedIn > 0); // 출근 기록이 있으면 true
		log.info("출근 상태: {}", isCheckedIn > 0 ? "이미 출근" : "출근 가능");
		return response;
		
	}
	
	
	@PutMapping("/MainCheckOut")
	@ResponseBody
	public Map<String,Object> CheckOut(@RequestParam int empNo) {
		Map<String, Object> response = new HashMap<>();
		try {
			if(empNo <= 0) {
				response.put("message", "유효하지않은 사원 번호입니다.");
				response.put("status", "error");
				return response;
			}
			
			// 퇴근 상태 업데이트 처리
			attManagerService.updateAttendance(empNo);
			
			LocalDateTime now = LocalDateTime.now(); // 현재 시간
			
			response.put("message", "퇴근 완료!");
			response.put("status", "success");
			response.put("serverTime", now); // 서버의 현재 시간 추가
	        return response;
			
		}catch(Exception e){
			e.printStackTrace();
			response.put("message", "퇴근 처리 중 오류 발생");
			response.put("status", "error");
			return response;
		}
	}
	
	@GetMapping("/MainGetCheckInTime")
	@ResponseBody
	public Map<String, Object> getCheckInTime(@RequestParam int empNo){
		Map<String, Object> response = new HashMap<>();
		
		try {
			LocalDateTime checkInTime = attManagerService.getCheckInTime(empNo); // 출근 시간 조회
			if(checkInTime == null) {
				response.put("message","출근기록이 없습니다.");
				response.put("status", "error");
			}else {
				response.put("checkInTime", checkInTime);
				response.put("status", "success");
			}
		}catch(Exception e) {
			e.printStackTrace();
			response.put("message", "출근 시간 조회 중 오류 발생");
			response.put("status", "error");
		}
		return response;
		
	}
	
	
	
	public class AttendanceStatus {
		public static final int ON_TIME = 1; // 출근
		public static final int OUT_TIME = 2; // 퇴근
	    public static final int LATE = 3; // 지각
	    public static final int EARLY_TIME = 4; // 조퇴
	    public static final int ABSENTEEISM = 5; // 결근
	    public static final int OVER_TIME = 6; // 추가근무 야근
	    public static final int VACAION = 7; // 휴가
	    public static final int ANNUAL_LEAVE = 8; // 연차
	    public static final int HALF_MORNING = 9; // 오전 반차
	    public static final int HALF_AFTER = 10; // 오후 반차
	    
	    
	}
	
	

}
