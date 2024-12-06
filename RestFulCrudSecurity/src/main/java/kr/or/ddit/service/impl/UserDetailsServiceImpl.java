package kr.or.ddit.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.UsersMapper;

// 스프링 시큐리티에서 사용자 정보를 가져오는 인터페이스
// 기본 틀은 시큐리티가 부여하고 이를 확장하여 우리의 상황에 맞게 구현함
@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	// DI(의존성 주입) / Ioc(제어의 역전)
	@Autowired
	UsersMapper usersMapper;

	// 사용자 이름(email)으로 사용자의 정보를 가져오는 메서드
	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		return this.usersMapper.findByEmail(email);
	}

	

}
