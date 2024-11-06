package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.BookMapper;
import kr.or.ddit.vo.BookVO;

// 서비스 클래스 : 비즈니스 로직
// 스프링 MVC 구조에서 Controller와 DAO를 연결하는 역할
/*
스프링 프레임워크는 개발자가 직접 클래스를 생성하는 것을 지양하고,
* 프링은 인터페이스를 좋아해. 자꾸자꾸 좋아지면 Impl은 어떡해
인터페이스를 통해 접근하는 것을 권장하고 있기 때문.(확장성)
그래서 서비스 레이어는 인터페이스(BookService)와 클래스(BookServiceImpl)를 함께 사용함

Impl : implement의 약자
*/
// "프링아 이 클래스 서비스 클래야"라고 알려주자. 프링이가 자바빈으로 등록해줌.
@Service
public class BookServiceImpl implements BookService {

	// 데이터베이스 접근을 위해 BookMapper 인스턴스를 주입받자
	// DI(Dependency Injection):의존성 주입
	// IoC(Inversion of Control):제어의 역전
	@Autowired
	BookMapper bookMapper;
	
	// 도서 등록
	// bookVO{bookId=0,title=총알탄 개똥이, category=소설, price=10000,
	//       insertDate=null}
	@Override
	public int createPost(BookVO bookVO) {
		return this.bookMapper.createPost(bookVO);
	}

	// 도서 상세
	@Override
	public BookVO detail(BookVO bookVO) {
		 return this.bookMapper.detail(bookVO);		 
	}

	// 도서 수정
	@Override
	public int updatePost(BookVO bookVO) {
		return this.bookMapper.updatePost(bookVO);
	}

	// 도서 삭제
	@Override
	public int deletePost(BookVO bookVO) {
		return this.bookMapper.deletePost(bookVO);
	}

	// 도서 목록
	@Override
	public List<BookVO> list(Map<String, Object> map) {
		return this.bookMapper.list(map);
	}

	
}