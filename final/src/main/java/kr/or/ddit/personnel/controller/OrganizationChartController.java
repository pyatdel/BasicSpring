package kr.or.ddit.personnel.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import io.swagger.v3.oas.annotations.parameters.RequestBody;
import kr.or.ddit.business.vo.EmployeeVO;
import kr.or.ddit.personnel.service.OrganizationChartService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin("http://localhost:7921")
@RequestMapping("/organizationChart")
@Controller
public class OrganizationChartController {

	@Autowired 
	OrganizationChartService organizationChartService;
	
	//부서 목록을 가져오기
	@GetMapping("/organizationList")
	@ResponseBody
	public List<EmployeeVO> OrganizationList() {
		log.info("조직도 불러오기->{}");
		
		List<EmployeeVO> result = organizationChartService.OrganizationList();
		log.info("체킁 result: {}", result);
		
		return result;
	}
	
	// 특정 부서의 직원 목록을 가져오는 메소드
	@GetMapping("/organizationList/{empName}")
    @ResponseBody
    public List<EmployeeVO> getEmployeesByDepartment(@PathVariable("empName") String empName) {
        log.info("부서 No {}에 대한 직원 목록 불러오기", empName);
        
        return organizationChartService.getEmployeesByDepartment(empName);  // 서비스에서 직원 목록 받아오기
    }
	
	@GetMapping("/chart")
	public String chart() {
		
		return "personnel/organizationChart";
	}
	
}
