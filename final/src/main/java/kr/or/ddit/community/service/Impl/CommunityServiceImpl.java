package kr.or.ddit.community.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.community.mapper.iCommunityMapper;
import kr.or.ddit.community.service.iCommunityService;
import kr.or.ddit.community.vo.CommunityReplyVO;
import kr.or.ddit.community.vo.CommunityStateTypeVO;
import kr.or.ddit.community.vo.CommunityTypeVO;
import kr.or.ddit.community.vo.CommunityVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CommunityServiceImpl implements iCommunityService{
	
	@Autowired
	iCommunityMapper icommunityMapper;

	@Override
	public List<CommunityTypeVO> comListAll() {
		return this.icommunityMapper.comListAll();
	}

	@Override
	public int insertPost(CommunityVO communityVO) {
		return this.icommunityMapper.insertPost(communityVO);
	}

	@Override
	public List<CommunityStateTypeVO> comStateListAll() {
		return this.icommunityMapper.comStateListAll();
	}

	@Override
	public int updateHit(CommunityVO communityVO) {
		return this.icommunityMapper.updateHit(communityVO);
	}

	@Override
	public CommunityVO detail(int comNo) {
		return this.icommunityMapper.detail(comNo);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.icommunityMapper.getTotal(map);
	}

	@Override
	public List<CommunityVO> list(Map<String, Object> map) {
		return this.icommunityMapper.list(map);
	}

	@Override
	public int updatePost(CommunityVO communityVO) {
		return this.icommunityMapper.updatePost(communityVO);
	}

	@Override
	public int deletePost(CommunityVO communityVO) {
		return this.icommunityMapper.deletePost(communityVO);
	}

	@Override
	public int createReplyPost(CommunityReplyVO communityReplyVO) {
		return this.icommunityMapper.createReplyPost(communityReplyVO);
	}

	@Override
	public int getReTotal(Map<String, Object> map) {
		return this.icommunityMapper.getReTotal(map);
	}

	@Override
	public List<CommunityReplyVO> reList(Map<String, Object> map) {
		return this.icommunityMapper.reList(map);
	}

	@Override
	public int deleteReplyPost(CommunityReplyVO communityReplyVO) {
		return this.icommunityMapper.deleteReplyPost(communityReplyVO);
	}

	@Override
	public int updateReplyPostAjax(CommunityReplyVO communityReplyVO) {
		return this.icommunityMapper.updateReplyPostAjax(communityReplyVO);
	}


	

}
