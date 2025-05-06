package kr.or.ddit.schedule.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.schedule.service.ScheduleService;
import kr.or.ddit.schedule.vo.ScheduleVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin("http://localhost:7921")
@RequestMapping("/schedule")
@RestController
public class ScheduleController {
	
	@Autowired
	ScheduleService scheduleService;
	
	@GetMapping("/scheduleList")
	public List<ScheduleVO> getScheduleList(@RequestParam(value="empNo") String empNo){
		log.info("스케줄리스트-> {}",empNo);
		return scheduleService.getScheduleList(empNo);
	}
	
	@GetMapping("/DeptSchedule")
	public List<ScheduleVO> getDeptScheduleList(@RequestParam(value="deptNo")int deptNo){
		
		ScheduleVO scheduleVO = new ScheduleVO();
		scheduleVO.setScheDiv(1);
		scheduleVO.setDeptNo(deptNo);
		
		log.info("부서별 일정 : {}",scheduleVO);
		return scheduleService.getDeptScheduleList(scheduleVO);
	}
	
	@GetMapping("/getInComScheduleList")
	public List<ScheduleVO> getInComScheduleList(@RequestParam(value="empNo") String empNo){
		return scheduleService.getInComScheduleList(empNo);
	}
	
	@GetMapping("/getVisitSchedule")
	public List<ScheduleVO> getVisitScheduleList(@RequestParam(value="empNo") String empNo){
		return scheduleService.getVisitScheduleList(empNo);
	}
	
	@GetMapping("/getMyScheduleList")
	public List<ScheduleVO> getMyScheduleList(@RequestParam(value="empNo") String empNo){
		return scheduleService.getMyScheduleList(empNo);
	}
	
	
	
	@GetMapping("/{id}")
	public ScheduleVO ScheduleDetail(@PathVariable("id") int id) {
		ScheduleVO schedule = new ScheduleVO();
		schedule.setId(id);
		ScheduleVO result = scheduleService.scheduleDetail(schedule);
		log.info("디테일: {}",result);
		return result;
	}
	
	@PostMapping("/create")
	public int createSchedule(@RequestBody ScheduleVO schedule) {
		log.info("스케줄 생성(전): {}",schedule);
		int result = scheduleService.createSchedule(schedule);
		log.info("스케줄 생성(후): {}",result);
		
		return result;
	}
	
	@PutMapping("/update")
	public int updateSchedule(@RequestBody ScheduleVO schedule) {
		log.info("수정요청 데이터 :{}",schedule);
		int result = scheduleService.updateSchedule(schedule);
		log.info("결과 데이터: {}",result);
		return result;
	}
	
	@DeleteMapping("/delete/{id}")
	public int deleteSchedule(@PathVariable("id") int id) {
		ScheduleVO schedule = new ScheduleVO();
		schedule.setId(id);
		return scheduleService.deleteSchedule(schedule);
	}
	

}
