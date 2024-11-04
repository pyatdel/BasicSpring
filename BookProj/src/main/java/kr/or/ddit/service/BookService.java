package kr.or.ddit.service;

import kr.or.ddit.vo.BookVO;

public interface BookService {

	// 도서 등록
	public int createPost(BookVO bookVO);

	// 도서 상세
	public BookVO detail(BookVO bookVO);

}
