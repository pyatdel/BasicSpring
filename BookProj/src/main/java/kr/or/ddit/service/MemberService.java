package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.MemberReplyVO;
import kr.or.ddit.vo.MemberVO;

public interface MemberService {
	/* 회원 목록
	<select id="list" resultType="kr.or.ddit.vo.MemberVO">
	 */
	public List<MemberVO> list(Map<String, Object> map);

	//회원 상세
	public MemberVO detail(String memId);

	//회원 수정
	public int updatePost(MemberVO memberVO);

	//회원 등록 실행
	public int createPost(MemberVO memberVO);

	//회원 가입 시 중복체크
	public int idDupChk(MemberVO memberVO);

	//회원 삭제
	public int deletePostAjax(MemberVO memberVO);

	//행의 수
	public int getTotal(Map<String, Object> map);

	//댓글 등록
	public int createReplyPost(MemberReplyVO memberReplyVO);

	/*
	댓글 목록 
	<select id="selectReply" parameterType="kr.or.ddit.vo.MemberVO"
		resultType="kr.or.ddit.vo.MemberReplyVO">
	 */
	public List<MemberReplyVO> selectReply(MemberVO memberVO);

	//update 실행. memberReplyVO{idx=9,..,replyContent=네네"...}
	public int updateReplyPostAjax(MemberReplyVO memberReplyVO);

	/*댓글 1건 가져오기
	 */
	public MemberReplyVO getMemberReply(MemberReplyVO memberReplyVO);

	//MEMBER_REPLY 테이블의 REPLY_STATUS 컬럼의 값을 0으로 update
	public int updatePostAjax(MemberReplyVO memberReplyVO);
}






