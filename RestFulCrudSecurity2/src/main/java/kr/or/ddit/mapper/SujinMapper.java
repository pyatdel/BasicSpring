package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.SujinVO;

//스프링 프레임워크에게 알려줌
//	자바빈객체로 등록(메모리)
@Mapper
public interface SujinMapper {
	// Get List
	List<SujinVO> listSujin(Map<String, Object> map);
	// Get One
	SujinVO getSujin(SujinVO sujinVO);
	// insert
	int  insertSujin(SujinVO sujinVO);
	// update
	int  updateSujin(SujinVO sujinVO);
	// delete
	int  deleteSujin(SujinVO sujinVO);
	//전체 행의 수
	int getTotal(Map<String, Object> map);
}
