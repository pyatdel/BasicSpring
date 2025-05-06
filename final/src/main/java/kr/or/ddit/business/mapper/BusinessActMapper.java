package kr.or.ddit.business.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.business.vo.BusinessActVO;

@Mapper
public interface BusinessActMapper {

	public List<BusinessActVO> list(Map<String, Object> map);

	public int getTotal(Map<String, Object> map);

	//영업활동 - 유형 분류 (이메일, 미팅, SMS 등등..)
	public List<BusinessActVO> listAll();

	//영업활동 등록
	public int createPost(BusinessActVO businessActVO);

	//거래처 전체 리스트
	public List<BusinessActVO> getAllEntites();

//	BusinessActVO businessActDetail(Integer busNo);

}
