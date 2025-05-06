package kr.or.ddit.workspace.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.workspace.vo.WorkSpaceVO;

public interface WorkSpaceService {

	public int getTotal(Map<String, Object> map);

	public List<WorkSpaceVO> myWorklist(Map<String, Object> map);

	public WorkSpaceVO projTotal(int deptNo);

	public List<WorkSpaceVO> deptWorklist(Map<String, Object> map);

	public int deptGetTotal(Map<String, Object> map);

	public List<WorkSpaceVO> projList(Map<String,Object>map);

	public int createWork(WorkSpaceVO workSpaceVO);

	public WorkSpaceVO workDetail(WorkSpaceVO workSpaceVO);

}
