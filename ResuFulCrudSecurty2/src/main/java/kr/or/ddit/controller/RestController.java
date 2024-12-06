package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

// 스프링 프레임워크(디자인패턴 + 라이브러리들)
// 이 클래스는 컨트롤러야
// 미리 자바빈(객체)로 등록해줘

@Slf4j
@Controller
public class RestController {
	
	/*
	 요청 URI : /
	 요청 파라미터 :
	 요청 방식 : get
	 */
	@GetMapping("/")
	public String home(Model model) {
		// forwarding
		model.addAttribute("insa","Hello JSP");
		
		// /WEB-INF/views/ + home + .jsp
		return "home";
		
	}
	
	@GetMapping("/sujin/index")
	public String index() {
		// forwarding : jsp리턴
		return "sujin/index";
	}
}
