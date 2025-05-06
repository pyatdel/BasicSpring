package kr.or.ddit.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.or.ddit.member.mapper.MemberMapper;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.security.CustomUser;

@Service
public class UserDetailServiceImpl implements UserDetailsService {

    private final MemberMapper memberMapper;

    public UserDetailServiceImpl(MemberMapper memberMapper) {
        this.memberMapper = memberMapper;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        System.out.println("Received username: " + username);
        
        // DB에서 사용자 정보 조회
        MemberVO user = memberMapper.read(username);
        System.out.println("DB returned user: " + user);

        if (user == null) {
            throw new UsernameNotFoundException("User not found with username: " + username);
        }

        // 권한 설정
        List<GrantedAuthority> authorities = new ArrayList<>();
        if (user.getPostNo() == 0) {
            authorities.add(new SimpleGrantedAuthority("ROLE_ADMIN")); // 관리자 권한
        } else {
            authorities.add(new SimpleGrantedAuthority("ROLE_USER")); // 사용자 권한
        }

        // 디버깅: 권한 확인
        System.out.println("Assigned Authorities: " + authorities);

        // UserDetails 객체 생성 후 반환
//        return new org.springframework.security.core.userdetails.User(
//            user.getEmpId(),     // 사용자 ID
//            user.getEmpPw(),     // 사용자 비밀번호
//            user.isEnabled(),    // 계정 활성화 여부
//            true,                // 계정 만료 여부
//            true,                // 비밀번호 만료 여부
//            true,                // 계정 잠금 여부
//            authorities          // 사용자 권한 리스트
//        );
        return user==null?null:new CustomUser(user);
    }
}
