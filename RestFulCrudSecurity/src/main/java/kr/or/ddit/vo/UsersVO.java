package kr.or.ddit.vo;

import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;

// UserDetails를 상속받아 인증(로그인) 객체로 사용
// UserDetails : 스프링 시큐리티에서 제공해주는 인터페이스
@Data
public class UsersVO implements UserDetails{ 

	private int id;
	private String email; // 아이디
	private String password;
	private Date createdAt;
	private Date updatedAt;
	
	// 사용자의 권한들 반환
	// 		   GrantedAutority(인터페이스) : ROLE_ADMIN, ROLE_MEMBER..
	// SimpleGrantedAuthority(구현 클래스)
	// user : 로그인 된 유저(시큐리티와 약속됨)
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return List.of(new SimpleGrantedAuthority("user"));
	}
	
	// 사용자의 아이디를 반환(고유한 값)
	@Override
	public String getUsername() {
		return this.email;
	}
	
	// 사용자의 비밀번호 반환
	public String getPassword() {
		return this.password;
	}
	
	//계정 만료 여부 반환
   @Override
   public boolean isAccountNonExpired() {
      //만료되었는지 확인하는 로직
      return true; //true -> 만료되지 않았음
   }
   
   //계정 잠금 여부 반환
   @Override
   public boolean isAccountNonLocked() {
      //계정 잠금되었는지 확인하는 로직
      return true; //true -> 잠금되지 않았음
   }
   
   //패스워드의 만료 여부 반환
   @Override
   public boolean isCredentialsNonExpired() {
      //패스워드가 만료되었는지 확인하는 로직
      return true; //true -> 만료되지 않았음
   }
   
   //계정 사용 가능 여부 반환
   @Override
   public boolean isEnabled() {
      //계정의 사용 가능한지 확인하는 로직
      return true; //true -> 사용 가능
   }
}
