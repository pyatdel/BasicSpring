package kr.or.ddit.personnel.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class EmployeeController {

	// 직원 권한
	@GetMapping("/employee")
	public String employee() {
		
		return "";
	}
}
