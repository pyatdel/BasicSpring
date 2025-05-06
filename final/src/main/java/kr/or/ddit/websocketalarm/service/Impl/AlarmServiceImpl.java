package kr.or.ddit.websocketalarm.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.websocketalarm.mapper.AlarmMapper;
import kr.or.ddit.websocketalarm.service.AlarmService;
import kr.or.ddit.websocketalarm.vo.AlarmVO;

@Service
public class AlarmServiceImpl implements AlarmService {

	@Autowired
	AlarmMapper alarmMapper;
	
	@Override
	public int saveAlarm(AlarmVO alarm) {
		return alarmMapper.saveAlarm(alarm);
	}

	@Override
	public List<AlarmVO> alarmList(Map<String, Object> map) {
		return alarmMapper.alarmList(map);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return alarmMapper.getTotal(map);
	}


}
