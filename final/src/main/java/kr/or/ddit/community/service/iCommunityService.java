package kr.or.ddit.community.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.community.vo.CommunityReplyVO;
import kr.or.ddit.community.vo.CommunityStateTypeVO;
import kr.or.ddit.community.vo.CommunityTypeVO;
import kr.or.ddit.community.vo.CommunityVO;

public interface iCommunityService {

	// 커뮤니티 타입
	public List<CommunityTypeVO> comListAll();

	// 커뮤니티 등록
	public int insertPost(CommunityVO communityVO);

	// 커뮤니티 게시글 타입
	public List<CommunityStateTypeVO> comStateListAll();

	// 조회수 증가
	public int updateHit(CommunityVO communityVO);

	// 상세 페이지
	public CommunityVO detail(int comNo);

	// 전체 행의 수
	public int getTotal(Map<String, Object> map);

	// 게시물 목록
	public List<CommunityVO> list(Map<String, Object> map);

	// 게시물 수정
	public int updatePost(CommunityVO communityVO);

	// 게시물 삭제
	public int deletePost(CommunityVO communityVO);

	// 댓글 생성
	public int createReplyPost(CommunityReplyVO communityReplyVO);

	// 전체 댓글 수
	public int getReTotal(Map<String, Object> map);

	// 댓글 목록
	public List<CommunityReplyVO> reList(Map<String, Object> map);

	// 댓글 삭제
	public int deleteReplyPost(CommunityReplyVO communityReplyVO);

	// 댓글 수정
	public int updateReplyPostAjax(CommunityReplyVO communityReplyVO);




}
