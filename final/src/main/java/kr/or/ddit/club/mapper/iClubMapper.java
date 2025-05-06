package kr.or.ddit.club.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.club.vo.ClubCategoryVO;
import kr.or.ddit.club.vo.ClubJoinRequestVO;
import kr.or.ddit.club.vo.ClubMemberVO;
import kr.or.ddit.club.vo.ClubVO;
import kr.or.ddit.community.vo.CommunityVO;
import kr.or.ddit.personnel.vo.DepartmentVO;
import kr.or.ddit.personnel.vo.EmployeeVO;
import kr.or.ddit.personnel.vo.PositionVO;

@Mapper
public interface iClubMapper {

	// 동호회 종류 목록
	public List<ClubCategoryVO> clubListAll();

	// 동호회 생성
	public int insertPost(ClubVO clubVO);

	// 조회수
	public int updateHit(ClubVO clubVO);

	// 동호회 상세
	public ClubVO myPage(int clubNo);
	
	// 동호회 회원 추가 
	public int addMember(ClubMemberVO clubMemberVO);

	// 회원 상태 변경 및 현재 회원 수 업데이트
//	public int updateMember(int clubNo, int empNo, int memState);

	// 동호회 회원 목록 조회
	public List<ClubMemberVO> getMemberList(int clubNo);
	
	// 내 동호회 목록
	public List<ClubVO> myClubs(int empNo);

	// 총 동호회 목록
	public int getTotal(Map<String, Object> map);

	// 페이지 내 전체 동호회 목록
	public List<ClubVO> allClubs(Map<String, Object> map);

	// 동호회 가입
	public int clubRequest(ClubJoinRequestVO clubJoinRequestVO);

	// 가입 승인/거절
	public int updateRequest(ClubJoinRequestVO clubJoinRequestVO);
	
	// 가입 신청 목록
	public List<ClubJoinRequestVO> joinRequestList(int clubNo);

	// 동호회 정보 수정
	public int updatePost(ClubVO clubVO);

	// 동호회 관리
	public ClubVO clubManage(int clubNo);

	// 동호회 카테고리 목록
	public List<ClubCategoryVO> categoryList();
	
	// 동호회 정보 수정
	public int updateClub(ClubVO clubVO);

	// 커뮤니티 정보 수정
	public int updateCommunity(CommunityVO communityVO);

	// 동호회 삭제
	public int deletePost(ClubVO clubVO);

	// 커뮤니티 목록 조회
	public List<CommunityVO> communityListAll();
	
	// 동호회 멤버 권한 설정
	public int updateRole(ClubMemberVO clubMemberVO);

	// 동호회 멤버 상세
	public ClubMemberVO memberDetail(ClubMemberVO clubMemberVO);
	
	// 동호회 정보 조회
	public ClubVO myPage(ClubVO clubVO);
	
	// 멤버 초대 목록
	public List<EmployeeVO> inviteMemberList(Map<String, Object> map);

	// 멤버 초대
	public int inviteMembers(Map<String, Object> map);
	
	// 직원 목록
	public List<EmployeeVO> employeeList();
	
	// 부서 목록
	public List<DepartmentVO> deptList();

	// 직책 목록
	public List<PositionVO> positionList();
	
	// 멤버 수정
	public int updateMember(int clubNo);

	// 멤버 추방
	public int kickMember(ClubMemberVO clubMemberVO);
	
	// 동호회 폐쇄
	public int closeClub(ClubVO clubVO);
	
}
