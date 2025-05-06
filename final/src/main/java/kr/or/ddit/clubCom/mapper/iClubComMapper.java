package kr.or.ddit.clubCom.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.club.vo.ClubMemberVO;
import kr.or.ddit.clubCom.vo.ClubComTypeVO;
import kr.or.ddit.clubCom.vo.ClubComVO;

@Mapper
public interface iClubComMapper {

	// 동호회 게시물 타입번호
	public List<ClubComTypeVO> clubComListAll();
	
	// 동호회 멤버
	public ClubMemberVO clubMember(int empNo, int clubNo);
	
	// 게시물 작성
	public int insertPost(ClubComVO clubComVO);

	// 총 갯수
	public int getTotal(Map<String, Object> map);

	// 목록
	public List<ClubComVO> list(Map<String, Object> map);
	
}
