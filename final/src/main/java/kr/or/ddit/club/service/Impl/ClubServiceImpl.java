package kr.or.ddit.club.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.club.mapper.iClubMapper;
import kr.or.ddit.club.service.iClubService;
import kr.or.ddit.club.vo.ClubCategoryVO;
import kr.or.ddit.club.vo.ClubJoinRequestVO;
import kr.or.ddit.club.vo.ClubMemberVO;
import kr.or.ddit.club.vo.ClubVO;
import kr.or.ddit.community.vo.CommunityVO;
import kr.or.ddit.file.vo.FileGroupVO;
import kr.or.ddit.personnel.vo.DepartmentVO;
import kr.or.ddit.personnel.vo.EmployeeVO;
import kr.or.ddit.personnel.vo.PositionVO;
import kr.or.ddit.upload.cotroller.UploadController;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ClubServiceImpl implements iClubService {

	@Autowired
	iClubMapper iclubMapper;
	
	@Autowired
	UploadController uploadController;

	@Override
	public List<ClubCategoryVO> clubListAll() {
		return this.iclubMapper.clubListAll();
	}

	@Override
	public int insertPost(ClubVO clubVO) {
		MultipartFile[] uploadFiles = clubVO.getUploadFile();//동호회 아이콘 추출
		log.info("ClubServiceImpl->insertPost->uploadFiles : " + uploadFiles);
		
		Long fileGroupNo = this.uploadController.multiImageUpload(uploadFiles);
		log.info("ClubServiceImpl->insertPost->fileGroupNo : " + fileGroupNo);
		
		//첨부파일 그룹 번호 세팅
		clubVO.setFileGroupNo(fileGroupNo);
		
		return this.iclubMapper.insertPost(clubVO);
	}

	@Override
	public int updateHit(ClubVO clubVO) {
		return this.iclubMapper.updateHit(clubVO);
	}

	@Override
	public ClubVO myPage(int clubNo) {
		return this.iclubMapper.myPage(clubNo);
	}

//	@Override
//	public int updateMember(int clubNo, int empNo, int memState) {
//		return this.iclubMapper.updateMember(clubNo, empNo, memState);
//	}

	@Override
	public List<ClubMemberVO> getMemberList(int clubNo) {
		return this.iclubMapper.getMemberList(clubNo);
	}

	@Override
	public List<ClubVO> myClubs(int empNo) {
		return this.iclubMapper.myClubs(empNo);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.iclubMapper.getTotal(map);
	}

	@Override
	public List<ClubVO> allClubs(Map<String, Object> map) {
		return this.iclubMapper.allClubs(map);
	}

	@Override
	public int clubRequest(ClubJoinRequestVO clubJoinRequestVO) {
		return this.iclubMapper.clubRequest(clubJoinRequestVO);
	}

	@Override
	public int updateRequest(ClubJoinRequestVO clubJoinRequestVO) {
		return this.iclubMapper.updateRequest(clubJoinRequestVO);
	}

	@Override
	public List<ClubJoinRequestVO> joinRequestList(int clubNo) {
		return this.iclubMapper.joinRequestList(clubNo);
	}

	@Override
	public int addMember(ClubMemberVO clubMemberVO) {
		return this.iclubMapper.addMember(clubMemberVO);
	}

	@Override
	public ClubVO clubManage(int clubNo) {
		return this.iclubMapper.clubManage(clubNo);
	}

	@Override
	public List<ClubCategoryVO> categoryList() {
		return this.iclubMapper.categoryList();
	}

	@Override
	public int updateClub(ClubVO clubVO) {
		return this.iclubMapper.updateClub(clubVO);
	}

	@Override
	public int updateCommunity(CommunityVO communityVO) {
		return this.iclubMapper.updateCommunity(communityVO);
	}

	@Override
	public int deletePost(ClubVO clubVO) {
		return this.iclubMapper.deletePost(clubVO);
	}

	// 커뮤니티 목록 조회
	@Override
	public List<CommunityVO> communityListAll() {
		return this.iclubMapper.communityListAll();
	}

	@Override
	public int updateRole(ClubMemberVO clubMemberVO) {
		return this.iclubMapper.updateRole(clubMemberVO);
	}

	@Override
	public ClubMemberVO memberDetail(ClubMemberVO clubMemberVO) {
		return this.iclubMapper.memberDetail(clubMemberVO);
	}

	@Override
	public ClubVO myPage(ClubVO clubVO) {
		return this.iclubMapper.myPage(clubVO);
	}

	@Override
	public List<EmployeeVO> inviteMemberList(Map<String, Object> map) {
		return this.iclubMapper.inviteMemberList(map);
	}

	@Override
	public int inviteMembers(Map<String, Object> map) {
		return this.iclubMapper.inviteMembers(map);
	}

	@Override
	public List<EmployeeVO> employeeList() {
		return this.iclubMapper.employeeList();
	}

	@Override
	public List<DepartmentVO> deptList() {
		return this.iclubMapper.deptList();
	}

	@Override
	public List<PositionVO> positionList() {
		return this.iclubMapper.positionList();
	}

	@Override
	public int updateMember(int clubNo) {
		return this.iclubMapper.updateMember(clubNo);
	}

	@Override
	public int kickMember(ClubMemberVO clubMemberVO) {
		return this.iclubMapper.kickMember(clubMemberVO);
	}

	@Override
	public int closeClub(ClubVO clubVO) {
		return this.iclubMapper.closeClub(clubVO);
	}







	
}
