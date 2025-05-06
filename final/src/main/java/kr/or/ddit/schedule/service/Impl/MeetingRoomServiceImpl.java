package kr.or.ddit.schedule.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.schedule.mapper.MeetingRoomMapper;
import kr.or.ddit.schedule.service.MeetingRoomService;
import kr.or.ddit.schedule.vo.MeetingRoomVO;

@Service
public class MeetingRoomServiceImpl implements MeetingRoomService {
	
	@Autowired
	MeetingRoomMapper meetingRoomMapper;
	
	@Override
	public List<MeetingRoomVO> meetRoomList(Map<String, Object> map) {
		return meetingRoomMapper.meetRoomList(map);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return meetingRoomMapper.getTotal(map);
	}
}
