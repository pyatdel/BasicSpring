package kr.or.ddit.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.service.UserService;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.UsersVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UserApiController {
	
	@Autowired
	UserService userService;
	
	/*
      요청URI : /user
      요청파라미터 : request{memId=z010,memName=개똥이10,memPw=java,uploadFiles=파일객체}
      요청방식 : post
	 */
	@PostMapping("/user")
	public String signup(MemberVO memberVO) {
		/*
		MemberVO(memId=u001, memName=성원태2, memPw=java, memEnable=false
		, memRegdate=null, uploadFiles=파일객체들
		 */
		log.info("signup->memberVO(전) : " + memberVO);
		
		//회원 가입 메서드 호출
		int result = this.userService.save(memberVO);
		log.info("signup->memberVO(후) : " + memberVO);
		//회원 가입이 완료된 이후에 로그인 페이지로 이동		
		return "redirect:/login";
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		new SecurityContextLogoutHandler().logout(request, response, 
				SecurityContextHolder.getContext().getAuthentication()
		);
		
		return "redirect:/login";
	}
}







