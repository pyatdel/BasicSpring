package kr.or.ddit.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.security.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LoginSuccessController {

    @GetMapping("/loginSuccess")
    public String loginSuccess(Authentication authentication, HttpSession session) {
        // Spring Security 기본 User 객체 가져오기
        org.springframework.security.core.userdetails.User user =
                (org.springframework.security.core.userdetails.User) authentication.getPrincipal();
        // 사용자 이름이나 기타 정보를 session에 저장
        String username = user.getUsername();
        session.setAttribute("EMP_ID", username);
        
        	
        // empNo 가져오기
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		CustomUser userDetails = (CustomUser)principal; 
		log.info("commuteList->userDetails : " + userDetails.getMember());
		MemberVO memberVO = userDetails.getMember();
		String empName = memberVO.getEmpName();
		int empNo = memberVO.getEmpNo();
		session.setAttribute("EMP_NO", empNo); // empNo를 세션에 저장
		session.setAttribute("EMP_NAME", empName);
        
        // 사용자 권한에 따라 리다이렉트
        if (authentication.getAuthorities().stream()
                .anyMatch(auth -> auth.getAuthority().equals("ROLE_ADMIN"))) {
            return "redirect:/adminmain";
        } else {
            return "redirect:/main";
        }
    }
}
