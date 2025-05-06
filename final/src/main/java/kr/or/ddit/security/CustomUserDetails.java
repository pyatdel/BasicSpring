package kr.or.ddit.security;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import kr.or.ddit.member.vo.MemberVO;

public class CustomUserDetails implements UserDetails {
	
	private final MemberVO member;
	private int empNo;
    private String username;
    private String password;
    private boolean enabled;
    private Collection<? extends GrantedAuthority> authorities;

    public CustomUserDetails(int empNo, String username, String password, boolean enabled, Collection<? extends GrantedAuthority> authorities) {
    	this.member = new MemberVO();
		this.empNo = empNo;
        this.username = username;
        this.password = password;
        this.enabled = enabled;
        this.authorities = authorities;
    }

    public int getEmpNo() {
		return empNo;
	}

	public void setEmpNo(int empNo) {
		this.empNo = empNo;
	}

	@Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return username;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true; // 계정 만료 여부
    }

    @Override
    public boolean isAccountNonLocked() {
        return true; // 계정 잠금 여부
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true; // 비밀번호 만료 여부
    }

    @Override
    public boolean isEnabled() {
        return enabled; // 계정 활성화 여부
    }
}

