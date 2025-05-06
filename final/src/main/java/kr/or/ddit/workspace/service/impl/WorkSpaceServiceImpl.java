package kr.or.ddit.workspace.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.workspace.mapper.WorkSpaceMapper;
import kr.or.ddit.workspace.service.WorkSpaceService;
import kr.or.ddit.workspace.vo.WorkSpaceVO;


@Service
public class WorkSpaceServiceImpl implements WorkSpaceService {

	
	@Autowired
	WorkSpaceMapper workSpaceMapper;
	
	
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.workSpaceMapper.getTotal(map);
	}


	@Override
	public List<WorkSpaceVO> myWorklist(Map<String, Object> map) {
		return this.workSpaceMapper.myWorklist(map);
	}


	@Override
	public WorkSpaceVO projTotal(int deptNo) {
		return this.workSpaceMapper.projTotal(deptNo);
	}


	@Override
	public List<WorkSpaceVO> deptWorklist(Map<String, Object> map) {
		return this.workSpaceMapper.deptWorklist(map);
	}


	@Override
	public int deptGetTotal(Map<String, Object> map) {
		return this.workSpaceMapper.deptGetTotal(map);
	}


	@Override
	public List<WorkSpaceVO> projList(Map<String,Object>map) {
		return this.workSpaceMapper.projList(map);
	}


	@Override
	public int createWork(WorkSpaceVO workSpaceVO) {
		return this.workSpaceMapper.createWork(workSpaceVO);
	}


	@Override
	public WorkSpaceVO workDetail(WorkSpaceVO workSpaceVO) {
		return this.workSpaceMapper.workDetail(workSpaceVO);
	}

}
