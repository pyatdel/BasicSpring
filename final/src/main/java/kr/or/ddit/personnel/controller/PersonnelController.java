package kr.or.ddit.personnel.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

//스프링 프레임워크가 이 클래스를 컨트롤러로써
//	자바빈(객체)으로 등록해줌.
@Controller
@Slf4j
public class PersonnelController {
	
	/*
	test
	 */
	@GetMapping("/managerMain")
	public String personnel() {
		// /WEB-INF/views/ + home + .jsp
		return "personnel/personnel";
	}
	
}

