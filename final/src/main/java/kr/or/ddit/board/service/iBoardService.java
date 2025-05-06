package kr.or.ddit.board.service;


import java.util.List;
import java.util.Map;

import kr.or.ddit.board.vo.BoardReplyVO;
import kr.or.ddit.board.vo.BoardTypeVO;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.ReportVO;

public interface iBoardService {

	
	// 전체 행의 수
	public int getTotal(Map<String, Object> map);

	// 게시물 목록
	public List<BoardVO> list(Map<String, Object> map);

	// 게시물 상세
	public BoardVO detail(int bodNo);

	// 게시물 수정
	public int updatePost(BoardVO boardVO);

	// 게시물 삭제
	public int deletePost(BoardVO boardVO);

	// 게시물 등록
	public int insertPost(BoardVO boardVO);

	// 조회수 증가
	public int updateHit(BoardVO boardVO);

	// 게시판 타입
	public List<BoardTypeVO> bodListAll();

	// 댓글 등록
	public int createReplyPost(BoardReplyVO boardReplyVO);

	// 댓글 수정
	public int updateReplyPostAjax(BoardReplyVO boardReplyVO);

	// 댓글 가져오기
	public BoardReplyVO getBoardReply(BoardReplyVO boardReplyVO);

	// 댓글 목록
	public List<BoardReplyVO> selectReply(BoardVO boardVO);

	// 댓글 신고
	public int reportReplyPost(ReportVO reportVO);

	// 댓글 삭제
//	public int updatePostAjax(BoardReplyVO boardReplyVO);

	// 전체 댓글 수
	public int getReTotal(Map<String, Object> map);

	//  댓글 목록
	public List<BoardReplyVO> reList(Map<String, Object> map);

	// 댓글 삭제
	public int deleteReplyPost(BoardReplyVO boardReplyVO);

	// 전체 댓글 삭제
	public void deleteAllReply(int bodNo);

	// 게시물 읽음 표시
	public int updateRead(BoardVO boardVO);
	



}
