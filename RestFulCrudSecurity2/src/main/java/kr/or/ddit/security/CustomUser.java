package kr.or.ddit.security;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import kr.or.ddit.vo.MemberVO;

import lombok.Getter;

//CustomUser 		= jsp의 principal
//CustomUser.member = jsp의 principal.member
@Getter
public class CustomUser extends User{

	private static final long serialVersionUID = 1L;
	private MemberVO member;

	public CustomUser (String username, String password, Collection<? extends GrantedAuthority> authorities){
		super(username, password, authorities);
	}
	
	
	public CustomUser (MemberVO memberVO){
		super(memberVO.getMemId(),memberVO.getMemPw(),
			  memberVO.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuthName())).collect(Collectors.toList()));
		this.member = memberVO;
	}
	
}