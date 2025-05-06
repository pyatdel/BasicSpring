package kr.or.ddit.reactjwt.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.or.ddit.reactjwt.mapper.ReactUsersMapper;
import kr.or.ddit.reactjwt.service.ReactUsersService;
import kr.or.ddit.reactjwt.vo.ReactUsersVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ReactUsersServiceImpl implements ReactUsersService{
	
	@Autowired
	ReactUsersMapper reactUsersMapper;
	
	@Autowired
	BCryptPasswordEncoder bCryptPasswordEncoder;

	@Override
	public ReactUsersVO findById(String empId) {
		return this.reactUsersMapper.findById(empId);
	}

	@Override
	public boolean validateLogin(String empId, String empPw) {
		ReactUsersVO user = this.findById(empId);
		log.info("DB 비밀번호: {}", user.getEmpPw());
		log.info("입력된 비밀번호 : {}", empPw);
		if(user == null || user.getEmpPw() == null || user.getEmpPw().isEmpty()) {
			log.error("사용자 정보 또는 비밀번호가 비어 있습니다.");
			return false; //사용자 아이디 존재 x
		}
		
		boolean result = bCryptPasswordEncoder.matches(empPw, user.getEmpPw());
		log.info("비밀번호 일치여부: {}",result);
		// 비밀번호 검증
		return result;
	}

	@Override
	public ReactUsersVO getUserByEmpId(String empId) {
		ReactUsersVO user = new ReactUsersVO();
		user.setEmpId(empId);
		return reactUsersMapper.findById(empId);
	}

	@Override
	public ReactUsersVO getEmpNoByEmpId(ReactUsersVO users) {
		return reactUsersMapper.getEmpNoByEmpId(users);
	}

	@Override
	public ReactUsersVO getAttendanceByEmpNo(ReactUsersVO users) {
		return reactUsersMapper.getAttendanceByEmpNo(users);
	}

	
	
}
