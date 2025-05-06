package kr.or.ddit.personnel.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("/personnel")
@Controller
@Slf4j
public class authority {

	@GetMapping("/authority")
	public String authority() {
		
		return "personnel/authority";
	}
	
}
