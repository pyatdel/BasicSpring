package com.sumin.just.mapper;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.List;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.sumin.just.vo.IdolVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j			// Simple log4j
@SpringBootTest // 이걸 해주면 알아서 Juit5 연결시켜준다. 아주 편리@@@
public class IdolMapperTest {
	
	@Autowired
	private IdolMapper idolMapper; // private는 습관적으로 자주 사용해보자
	
	@Test
	@DisplayName("수정테스트") // 그냥 테스트 이름 붙이기
	@Disabled
	public void updIdolTest() {
		
		IdolVO idol = new IdolVO();
		idol.setIdolId(3);
		idol.setIdolName("진찬전");
		idol.setIdolAge(19);
		idol.setIdolSajin("비싸");
		
		idolMapper.updIdol(idol);
		
	}
	
	
	@Test
	@DisplayName("삭제테스트") // 그냥 테스트 이름 붙이기
	// 골뱅이Disabled
	public void delIdolTest() {
		
		IdolVO idol = new IdolVO();
		idol.setIdolId(3);
		idol.setIdolName("진찬전");
		idol.setIdolAge(19);
		idol.setIdolSajin("비싸");
		
		idolMapper.delIdol(idol);
		
	}
	
	@Test
	@DisplayName("1개 idol 가져오기") // 그냥 테스트 이름 붙이기
	// 골뱅이Disabled
	public void getIdolTest() {
		
		IdolVO idol = new IdolVO();
		idol.setIdolId(3);
		
		IdolVO jcVO = idolMapper.getIdol(idol);
		assertEquals("진찬전", jcVO.getIdolName());
		
	}
	
	@Test
	@DisplayName("리스트테스트")  // 그냥 테스트 이름 붙이기!
	// 골뱅이Disabled
	public void getIdolsTest() {
				
		List<IdolVO> mgList = idolMapper.getIdols();
		assertEquals(9,mgList.size());
	}
	
	// insert 테스트
	@Test // Junit 메뉴가 나온다
	@Disabled // 실행에서 제외
	public void insIdolTest() {
		
		int sum = 0;
		IdolVO idol = new IdolVO();
		for(int i=1; i<=10; i++) {
			idol = new IdolVO();
			idol.setIdolName("수민"+i+"돌");
			idol.setIdolAge(20+i);
			idol.setIdolSajin("사진 없대"+i);
			sum += idolMapper.insIdol(idol);
			
		}
		
		// idolMapper.insIdol(null)
		assertEquals(10, sum);
	}

}
