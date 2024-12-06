package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.BookVO;

@Mapper
public interface BookMapper {

	//도서 등록
	public int createPost(BookVO bookVO);

	//도서 상세
	public BookVO detail(BookVO bookVO);

	//도서 수정
	public int updatePost(BookVO bookVO);

	//도서 삭제
	public int deletePost(BookVO bookVO);

	//도서 목록
	public List<BookVO> list(Map<String, Object> map);
	
}
