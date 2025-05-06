package kr.or.ddit.personnel.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.personnel.vo.PositionVO;

@Mapper
public interface PositionMapper {

	// employeeList create에서 직급 선택 할 수 있게 하기 위한 list
	public List<PositionVO> getPositionList();

}
