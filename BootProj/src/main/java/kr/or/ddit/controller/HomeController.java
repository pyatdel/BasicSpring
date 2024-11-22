package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

// 스프링 프레임워크가 이 클래스를 컨트롤러로써
// 자바빈(객체)으로 등록해줌
@Controller
public class HomeController {

		/*
	   요청 URI : /
	   요청 파라미터 : 
	   요청 방식 : get
	    */
	
	@GetMapping("/")
	public String home() {
		// /WEB-INF/views/ + home + .jsp 로 조립이 되어, home.jsp가 만들어진다
		return "home";
	}
}
