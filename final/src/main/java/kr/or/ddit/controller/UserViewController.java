package kr.or.ddit.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.or.ddit.mapper.UsersMapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@PreAuthorize("isAnonymous()")
@Controller
public class UserViewController {
	
	@Autowired
	PasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	UsersMapper usersMapper;
	
	// /login 요청 URI를 요청하면 login() 메서드로 매핑됨
	// 뷰리졸버에 의해 /WEB-INF/views/ + login + .jsp로 조립되어 forwarding
	@GetMapping("/login")
	public String login() {
		String password = "java";
		String encodedPassword = this.bCryptPasswordEncoder.encode(password);
		
		log.info("java-> : " + encodedPassword);
		
		return "login";
	}
	
	// /signup 요청 URI를 요청하면 signup() 메서드로 매핑됨
	// 뷰리졸버에 의해 /WEB-INF/views/ + signup + .jsp로 조립되어 forwarding	
	@GetMapping("/signup")
	public String signup() {
		return "signup";
	}
	
	/**
	 * 기본 로그인을 위한 유저(TB_MEMBERS) 및 권한(TB_AUTHS)
	 * 테이블 생성 및 데이터 생성
	 */
	@PostMapping("/createMembersAuths")
	public String createMembersAuths() {
		//테이블이 이미 있는제 체크
		int chk = this.usersMapper.beforeChk();
		
		if(chk>0) {//이미 있으면
			return "exist";
		}else {
			return "noTables";
		}
	}
	
}
