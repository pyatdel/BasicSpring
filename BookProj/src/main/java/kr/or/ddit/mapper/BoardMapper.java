package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.BoardVO;

//매퍼 인터페이스의 목적 : 매퍼XML의 쿼리실행
@Mapper
public interface BoardMapper {

	//게시글 등록
	public int insertPost(BoardVO boardVO);

	//게시물 상세보기
	public BoardVO detail(int boNo);

	//게시물 수정. 서비스레이어 호출->퍼시스턴스 레이어 호출->DB update 처리(매퍼xml)
	public int updatePost(BoardVO boardVO);

	//게시물 삭제
	public int deletePost(BoardVO boardVO);

	//게시물 목록
	public List<BoardVO> list(Map<String, Object> map);

	//전체 행의 수
	public int getTotal();
	
}
