package kr.or.ddit.clubCom.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.club.vo.ClubMemberVO;
import kr.or.ddit.clubCom.mapper.iClubComMapper;
import kr.or.ddit.clubCom.service.iClubComService;
import kr.or.ddit.clubCom.vo.ClubComTypeVO;
import kr.or.ddit.clubCom.vo.ClubComVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ClubComServiceImpl implements iClubComService{

	@Autowired
	iClubComMapper iclubComMapper;

	@Override
	public List<ClubComTypeVO> clubComListAll() {
		return this.iclubComMapper.clubComListAll();
	}

	@Override
	public int insertPost(ClubComVO clubComVO) {
		return this.iclubComMapper.insertPost(clubComVO);
	}

	@Override
	public ClubMemberVO clubMember(int empNo, int clubNo) {
		return this.iclubComMapper.clubMember(empNo, clubNo);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.iclubComMapper.getTotal(map);
	}

	@Override
	public List<ClubComVO> list(Map<String, Object> map) {
		return this.iclubComMapper.list(map);
	}
}
