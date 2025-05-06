package kr.or.ddit.schedule.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.schedule.vo.MeetingRoomVO;

@Mapper
public interface MeetingRoomMapper {
	List<MeetingRoomVO> meetRoomList(Map<String, Object> map);

	int getTotal(Map<String, Object> map);

}
