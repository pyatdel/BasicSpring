package kr.or.ddit.contract.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@RequestMapping("/conimpl")
@Controller
public class ContractImpleController {

	
	@GetMapping("/gant")
	public String gant() {
		return "contract/conimpl/gant";
		
	}
}
