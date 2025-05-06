package kr.or.ddit.websocketalarm.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.websocketalarm.vo.AlarmVO;

public interface AlarmService {

	int saveAlarm(AlarmVO alarm);

	List<AlarmVO> alarmList(Map<String, Object> map);

	int getTotal(Map<String, Object> map);


}
