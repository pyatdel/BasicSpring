package kr.or.ddit.workspace.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.workspace.mapper.GantMapper;
import kr.or.ddit.workspace.service.GantService;
import kr.or.ddit.workspace.vo.GantVO;

@Service
public class GantServiceImpl implements GantService {

	@Autowired
	GantMapper gantMapper;
	
	
	// 간트차트 작업내용 등록
	@Override
	public int create(GantVO gantVO) {
		return this.gantMapper.create(gantVO);
	}

	// 간트차트 작업내용 리스트
	@Override
	public List<GantVO> getGantList() {
		return this.gantMapper.getGantList();
	}
	
	// 간트차트 작업내용 삭제 
	@Override
	public int delete(GantVO gantVO) {
		return this.gantMapper.delete(gantVO);
	}

	// 간트차트 작업내용 수정
	@Override
	public int update(GantVO gantVO) {
		return this.gantMapper.update(gantVO);
	}

}
