package kr.or.ddit.workspace.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.workspace.vo.GantVO;

@Mapper
public interface GantMapper {

	// 간트차트 작업내용 등록
	public int create(GantVO gantVO);

	// 간트차트 작업내용 리스트
	public List<GantVO> getGantList();

	// 간트차트 작업내용 삭제 
	public int delete(GantVO gantVO);


	// 간트차트 작업내용 수정
	public int update(GantVO gantVO);

}
