package kr.or.ddit.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import kr.or.ddit.service.UsersService;
import kr.or.ddit.vo.UsersVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UserApiController {
	
	@Autowired
	UsersService usersService;
	/*
    요청URI : /user
    요청파라미터 : request{email=test@test.com,password=java}
    요청방식 : post
    */
	@PostMapping("/user")
	public String user(UsersVO usersVO) {
		
		// 회원 가입 메서드 호출
		Long result = this.usersService.save(usersVO);
		log.info("user->result : " + result);
		
		// 회원 가입이 완료된 이휴에 로그인 페이지로 이동
		return "redirect:/login";
	}

}
