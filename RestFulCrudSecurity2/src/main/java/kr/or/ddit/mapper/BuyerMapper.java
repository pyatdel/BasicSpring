package kr.or.ddit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.BuyerVO;

@Mapper
public interface BuyerMapper {
	
	public List<BuyerVO> getBuyerList();
	
}
