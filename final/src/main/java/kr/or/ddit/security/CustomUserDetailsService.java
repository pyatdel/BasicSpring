package kr.or.ddit.security;

import java.util.Collections;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.or.ddit.member.mapper.MemberMapper;
import kr.or.ddit.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomUserDetailsService implements UserDetailsService{

   @Autowired
   private MemberMapper memberMapper;
   
   @Override
   public UserDetails loadUserByUsername(String empId) throws UsernameNotFoundException {
       MemberVO memberVO = memberMapper.read(empId);
       log.info("loadUserByUsername->memberVO : " + memberVO);
       if (memberVO == null) {
           throw new UsernameNotFoundException("User not found: " + empId);
       }
//       return new org.springframework.security.core.userdetails.User(
//    		   memberVO.getEmpId(),
//    		   memberVO.getEmpPw(),
//               Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER"))
//       );
       return memberVO==null?null:new CustomUser(memberVO);
   }
}