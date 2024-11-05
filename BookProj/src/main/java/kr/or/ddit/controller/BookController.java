package kr.or.ddit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.BookService;
import kr.or.ddit.vo.BookVO;
import lombok.extern.slf4j.Slf4j;

/*
Controller 어노테이션
스프링 프레임워크에게 "이 클래스는 웹 브라우저의 요청(request)를
받아들이는 컨트롤러야" 라고 알려주는 것임.
--스프링은 servlet-context.xml의 context:component-scan의 설정에 의해
이 클래스를 자바빈 객체로 등록(메모리에 바인딩).

log.info : 썰
써ㄹ풀4람
*/
@Slf4j
@Controller
public class BookController {
	
	// DI(Dependency Injection) : 의존성 주입
	// IoC(Inversion of Control) : 제어의 역전
	@Autowired
	BookService bookService;
	
	// 책 입력 화면
	/*
	 요청 URI : /create
	 요청 파라미터 : 없음
	 요청 방식 : get
	 */
	// RequesetMapping 어노테이션 : 웹 브라우저의 요청에 실행되는 자바 메소드 지정
	/*
	method 속성은 http 요청 메소드를 의미함. 일반적인 웹 페이지 개발에서 GEt 메소드는
	데이터를 변경하지 않는 경우에, POST 메소드는 데이터가 변경될 경우 사용
	책 생성 화면은 웹 브라우저에 화면을 보여줄 뿐 데이터의 변경이 일어나지 않으므로
		GET 메소드를 사용함
	 */
	@RequestMapping(value="/create",method=RequestMethod.GET)
	public ModelAndView create() {
		/*
		 ModelAndView
		 1) Model : Controller가 반환할 데이터(String, int, List, Map, VO..)를 담당
		 2) View : 화면을 담당(뷰(View : JSP)의 경로)
		 */
		ModelAndView mav = new ModelAndView();
		// application.properties
		/*
		spring.mvc.view.prefix=/WEB-INF/views/
		spring.mvc.view.suffix=.jsp
		 */
		// prefix(접두어) : /WEB-INF/views/
		// suffix(접미어) : .jsp
		// /WEB-INF/views/ + book/create + .jsp
		// forwarding : jsp
		mav.setViewName("book/create");
		
		return mav;
	}
	
	/* 
	요청 URI : /createPost
	요청 파라미터 : request{title=총알탄 개똥이, category=소설, price="10000"}
	요청 방식 : post
	
	스프링에서 파라미터의 명과 매개변수 명이 같으면 파라미터 값이 매개변수 값으로 할당됨
	모든 파라미터는 문자. 그래서 price의 값이 "12000"도 숫자형 문자임
	*/
	@RequestMapping(value="/createPost",method=RequestMethod.POST)
	public ModelAndView createPost(String title, String category,
			int price) {
		log.info("title : " + title);
		log.info("category : " + category);
		log.info("price : " + price);
		
		// BookVO에 값을 넣어보자
		BookVO bookVO = new BookVO();
		bookVO.setTitle(title);
		bookVO.setCategory(category);
		bookVO.setPrice(price);
		
		// BOOK 테이블에 도서를 등록
		// I/U/D의 return Type은 int타입
		int result = this.bookService.createPost(bookVO);
		log.info("createPost->result : " + result);
		
		ModelAndView mav = new ModelAndView();
		// redirect : URI를 재요청
		mav.setViewName("redirect:/create");
		
		return mav;
	}// end createPost
	
	// 책 상세보기
	// 요청된 URI 주소 : http://localhost:8050/detail?bookId=3
	// 요청 파라미터, 쿼리 스트링(Query String) : bookId="3" 
	// 요청 방식 : get
	// 매개 변수 : bookVO => {"bookId":"3","title":"","category":"","price":0,"insertDate":""}
	@RequestMapping(value="/detail",method=RequestMethod.GET)
	public ModelAndView detail(int bookId,
			BookVO bookVO, ModelAndView mav) {
		// detail->bookId : 1
		log.info("detail->bookId : " + bookId);
		/*
		detail->bookVO : BookVO(bookId=1, title=null, category=null, price=0, insertDate=null)
		 */
		log.info("detail->bookVO : " + bookVO);
		
		// 1. 도서 상세보기
		// BookVO(bookId=1, title=개똥이의 여행, category=소설, price=12000, insertDate=24/11/04)
		bookVO = this.bookService.detail(bookVO);
		log.info("detail->bookVO : " + bookVO);
		
		// 2. model : 데이터를 jsp로 넘겨줌
		// session.setAttribute(속성명, 데이터)
//		ModelAndView mav = new ModelAndView();
		mav.addObject("bookVO", bookVO);
		
		// 3.forwarding => 데이터를 jsp로 넘겨줌 / 
		// but, redirect => URL재요청. 데이터를 jsp로 못넘겨줌
		// view : jsp의 경로
		// /WEB-INF/views/ + ... + .jsp
		mav.setViewName("book/detail");
		
		return mav;
	}
	
	/*
	요청 URI : /updatePost
	요청 파라미터 : request{bookId=1, title=개똥이의 여행, category=소설, price=12000}
	요청 방식 : post
	 */
	@RequestMapping(value="/updatePost", method=RequestMethod.POST)
	public ModelAndView updatePost(BookVO bookVO,
			ModelAndView mav) {
		/*
		BookVO(bookId=1, title=개똥이의 모험, category=소설, price=12000, insertDate=null)
		 */
		log.info("updatePost->bookVO : " + bookVO);
		
		// I/U/D의 경우 return타입 : int
		int result = this.bookService.updatePost(bookVO);
		log.info("updatePost->result : " + result);
		
		//상세 화면으로 redirect. URI를 재요청
		mav.setViewName("redirect:/detail?bookId="+bookVO.getBookId());
		
		return mav;
	}
	
	/**
	요청 URI : /deletePost
	요청 파라미터 : request{bookId=3,title=김정민과 박선혜의 콜라보, category=음악, price=1200000}
	요청 방식 : post
	*/
	@RequestMapping(value="/deletePost",method=RequestMethod.POST)
	public ModelAndView deletePost(BookVO bookVO,
			ModelAndView mav) {
		// {bookId=3,title=김정민과 박선혜의 콜라보, category=음악, price=1200000
		//	,insertDate=null)}
		log.info("deletePost->bookVO : " + bookVO);
		
		// 1. 도서 삭제
		int result = this.bookService.deletePost(bookVO);
		log.info("deletePost->result : " + result);
		
		// 2. 삭제 후 처리		
		// 2-1. 삭제 성공
		if(result>0) {
			//목록으로 요청 이동(상세페이지가 없으므로)
			mav.setViewName("redirect:/list");
		}else {
		// 2-2. 삭제 실패
			//상세 페이지로 이동
			mav.setViewName("redirect:/detail?bookId="+bookVO.getBookId());
		}
		
		return mav;
	}
	
	/*
	 요청 URI : /list?keyword=알탄 or /list or /list?keyword=
	 요청 파라미터 : keyword=알탄
	 요청 방식 : get
	 
	 required=false : 선택사항. 파라미터가 없어도 무관
	 */
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public ModelAndView list(ModelAndView mav) {
		
		// 1. list메서드를 통해 매퍼xml의 SELECT문을 실행
		List<BookVO> bookVOList = this.bookService.list();
		log.info("list->bookVOList : " + bookVOList);
		
		// 2. mav의 속성명으로 bookVOList, 
		//	값으로 List<BookVO>타입의 bookVOList객체		
		
		// 3. list.jsp에 JSTL의 c:forEach 태그로 목록 출력을 완성해보자
		
		// forwarding : jsp응답
		mav.setViewName("book/list");
		
		return mav;
	}
}










