package kr.or.ddit.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

//스프링 프레임워크(디자인패턴 + 라이브러리들)에게
// 이 클래스는 컨트롤러야 라고 알려줌
// 미리 자바빈(객체)로 등록해줘
@Slf4j
@Controller
public class RestController {
	
	/*
	요청URI : /
	요청파라미터 : 
	요청방식 : get
	 */
	@GetMapping("/")
	public String home(Model model) {
		//forwarding : jsp리턴
		model.addAttribute("insa", "Hello JSP");
		
		///WEB-INF/views/ + home + .jsp
		return "home";
	}
	
	//크롬 -> /sujin/index URL을 요청 -> 스프링 시큐리티 필터 -> 서버
	//											통과(, "/sujin/**").permitAll())
	//												but 메소드 레벨에서 권한체킹
	//~전에 권한체킹  가졌냐 권한 ROLE_USER라는
	@PreAuthorize("hasRole('ROLE_USER')")
	@GetMapping("/sujin/index")
	public String index() {
		//forwarding : jsp리턴
		return "sujin/index";
	}
	
}









