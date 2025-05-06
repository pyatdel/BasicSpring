package kr.or.ddit.contract.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/estimate")
public class EstimateController {
	
	
	@GetMapping("/list")
	public String estimatelist() {
		
		return "contract/list";
		
		
	}
}
