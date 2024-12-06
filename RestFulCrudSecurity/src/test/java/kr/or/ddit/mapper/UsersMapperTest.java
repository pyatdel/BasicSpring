package kr.or.ddit.mapper;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import kr.or.ddit.vo.UsersVO;

@SpringBootTest
class UsersMapperTest {
	
	@Autowired
	UsersMapper usersMapper;

	@Test
	@DisplayName("로그인체크")
	void testFindByEmail() {
		// 예상데이터
		UsersVO usersVO = new UsersVO();
		usersVO.setId(1);
		usersVO.setEmail("test@test.com");
		usersVO.setPassword("java");
		
		// 실제데이터
		UsersVO usersVOTest = this.usersMapper.findByEmail("test@test.com");
		usersVOTest.setCreatedAt(null);
		
		// 예상데이터와 실제데이터 비교
		assertEquals(usersVO.toString(), usersVOTest.toString());
	}

}
