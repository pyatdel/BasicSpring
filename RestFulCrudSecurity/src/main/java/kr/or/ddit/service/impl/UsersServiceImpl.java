package kr.or.ddit.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.UsersMapper;
import kr.or.ddit.service.UsersService;
import kr.or.ddit.vo.UsersVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UsersServiceImpl implements UsersService {
	
		@Autowired
		UsersMapper usersMapper;
	
		// 비밀번호 암호화 처리기
		@Autowired
		BCryptPasswordEncoder bCryptPasswordEncoder;
	
		/*
		 요청 URI : /user
		 요청 파라미터 : request{email=test@test.com,password=java}
		 요청 방식 : post
		 */
		
		//회원 등록
	   //email과 password를 입력받아 회원 가입 처리(id는 기본키로써 자동생성)
	   @Override
	   public Long save(UsersVO usersVO) {
	      //암호화(encrypt) 처리
		   String password = usersVO.getPassword(); // java
		   password = this.bCryptPasswordEncoder.encode(password); // 암호화
	      
	       //패스워드를 저장 시 시큐리티를 설정하며 패스워드 인코딩용으로 등록한 빈(bCryptPasswordEncoder)을
	      //   사용해서 암호화한 후에 저장하자
		   usersVO.setPassword(password); // ASPOFISADFJAASDFFQEWREGASDF
		   log.info("save->usersVO : " + usersVO);
		   
	      Long result = this.usersMapper.save(usersVO);
	      log.info("save->result : " + result);
	      
	      return result;
	   }

}
