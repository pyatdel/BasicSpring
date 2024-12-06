package kr.or.ddit.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.StudVO;

@Mapper
public interface StudMapper {

	//학생 등록
	public int createPost(StudVO studVO);
	
	/*학생 상세보기
	<select id="detail" parameterType="kr.or.ddit.vo.StudVO"
			resultMap="studMap">
	*/
	public StudVO detail(StudVO studVO);
}
