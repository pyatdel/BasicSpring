package kr.or.ddit.workspace.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.schedule.vo.ScheduleVO;
import kr.or.ddit.workspace.service.GantService;
import kr.or.ddit.workspace.vo.GantVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/gantt")
@CrossOrigin(origins = "http://localhost:7921") 
@RestController
public class GantController {
	
	@Autowired
	GantService gantService;
	
	
	@PostMapping("/create")
	public int gantCreate(@RequestBody GantVO gantVO) {
		
		log.info("gantVO" + gantVO);
		int result = this.gantService.create(gantVO);
		
		return result;
		
		
	}
	// 간트차트 작업내용 리스트
	@GetMapping("/list")
	public List<GantVO> getGantList(){
		
		return gantService.getGantList();
	}
	
	// 간트차트 삭제 
	@DeleteMapping("/delete/{taskId}")
	public int gantDel(@PathVariable("taskId") String taskId ,GantVO gantVO ) {
		
		gantVO.setTaskId(taskId);
		
		int result = this.gantService.delete(gantVO);
		
		log.info("결과 데이터: {}",result);
		return result;
		
	}

	// 간트차트 수정 ~
	@PostMapping("/update")
	public int ganttUp(@RequestBody  GantVO gantVO) {
		
		int result = this.gantService.update(gantVO);
		
		log.info("결과 데이터: {}",result);
		
		return result;
		
		
		
	}
}
