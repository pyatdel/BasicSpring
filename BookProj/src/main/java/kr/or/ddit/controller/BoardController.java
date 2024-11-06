package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.vo.BoardVO;
import lombok.extern.slf4j.Slf4j;

/*
 Controller 애너테이션
 스프링 프레임워크에게 "이 클래스는 웹 브라우저의 요청(request)를
 받아들이는 컨트롤러야" 라고 알려주는 것임.
 */
// 클래스 레벨에서 요청 URI를 매핑
@RequestMapping("/board")
@Controller
@Slf4j
public class BoardController {
	/*
	 * 게시글 등록 폼
	 * 요청 URI : /board/form
	 * 요청 파라미터 :
	 * 요청 방식 : get 
	 */
	
	// 메서드 레벨에서 요청 URI를 매핑
	// 클래스 레벨 + 메서드 레벨 => /board/form
	@RequestMapping(value="/form", method=RequestMethod.GET)
	public String form() {
		// forwarding : jsp리턴
		return "board/form";
		
	}
	
	/*
	요청URI : /board/insertPost
       요청파라미터 : request{boTitle=개똥이게임,boWriter=이정재,boContent=개똥이게임2탄}
       요청방식 : post
	 */
	@RequestMapping(value="/insertPost", method=RequestMethod.POST)
	public String insertPost(BoardVO boardVO) {
		log.info("insertPost->boardVO : " + boardVO);
		
		// redirect : 새로운 URI 요청
		return "redirect:/board/form";
	}
}
