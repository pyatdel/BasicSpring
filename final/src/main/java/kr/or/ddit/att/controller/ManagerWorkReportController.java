package kr.or.ddit.att.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.att.service.AttManagerService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/manageratt")
@Controller
public class ManagerWorkReportController {
	
	@Autowired
	AttManagerService attManagerService;
	
	@GetMapping("/managerWorkReport")
	public String BlankList() {
		return "manageratt/managerWorkReport";
	}
	
	@ResponseBody
	@GetMapping("/deptAvg")
	public List<Map<String,Object>> getDeptAvgAttendance() {
		return attManagerService.getDeptAvgAttendance();
	}
	
	@ResponseBody
	@GetMapping("/employeesAvg")
	public List<Map<String, Object>> getEmpAvgAttendanceByDept(@RequestParam("deptNo") int deptNo){
		return attManagerService.getEmpAvgAttendanceByDept(deptNo);
	}
	
	
	
	
	
	

}
