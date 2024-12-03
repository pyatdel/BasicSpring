package kr.or.ddit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.SboardVO;

@Mapper
public interface SboardMapper {

	// 목록
	public List<SboardVO> selectList();

}
