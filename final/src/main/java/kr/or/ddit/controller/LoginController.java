package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class LoginController {
	
	@GetMapping("/")
	public String login() {
		
		return "login";
		
	}

	
}
