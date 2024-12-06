package kr.or.ddit.mapper;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import kr.or.ddit.vo.BoardVO;

//해당 클래스를 스프링 부트와 연동해 테스트
@SpringBootTest
class BoardMapperTest {

	@Autowired
	BoardMapper boardMapper;
	
	@Test
	void testDetail() {
		//1. 예상 데이터
		BoardVO expected = new BoardVO();
		expected.setBoNo(1);
		expected.setBoTitle("개똥이게임");
		expected.setBoWriter("이정재");
		expected.setBoContent("<p>asdf</p>");
		expected.setBoDate(null);
		expected.setBoHit(0);
		
		//2. 실제 데이터
		BoardVO boardVO = this.boardMapper.detail(1);
		boardVO.setBoDate(null);
		boardVO.setBoContent(boardVO.getBoContent().replaceAll("(\r\n|\n)", ""));
		
		//3. 비교 및 검증
		assertEquals(expected.toString(), boardVO.toString());
		
	}

}
