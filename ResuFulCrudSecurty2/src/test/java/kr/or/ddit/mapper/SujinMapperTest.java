package kr.or.ddit.mapper;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import kr.or.ddit.vo.SujinVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
class SujinMapperTest {

	// DI / IoC
	@Autowired
	SujinMapper sujinMapper;
	
	@Test
	@DisplayName("SUJIN테이블에 insert테스트")
	void testInsertSujin() {
		// 1. 예상 데이터
		int expect = 1;
		
		// 2. 실제 데이터
		SujinVO sujinVO = new SujinVO();
		sujinVO.setSujinContent("즐거운 여행1");
		sujinVO.setSujinName("개똥이");
		sujinVO.setSujinFile("");
		
		// <insert id="insertSujin" parameterType="SujinVO">
		int result = this.sujinMapper.insertSujin(sujinVO);
		log.info("testInsertSujin->result : " + result);
		
		// 3. 비교 및 검증
		assertEquals(expect, result);
	}

}
