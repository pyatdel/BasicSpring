package kr.or.ddit.schedule.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.schedule.vo.MeetingRoomVO;

public interface MeetingRoomService {
	List<MeetingRoomVO> meetRoomList(Map<String, Object> map);

	int getTotal(Map<String, Object> map);

}
