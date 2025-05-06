package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SalesController {
	
	@GetMapping("/sales")
	String sales() {
		return "sales";
	}

}
