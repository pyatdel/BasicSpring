package kr.or.ddit.contract.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.contract.vo.ExpenditureVO;

@Mapper
public interface ExpenditureMapper {

	public List<ExpenditureVO> expditList(Map<String, Object> map);

	public int getTotal(Map<String, Object> map);

}
