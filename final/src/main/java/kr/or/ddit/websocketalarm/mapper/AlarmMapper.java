package kr.or.ddit.websocketalarm.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.websocketalarm.vo.AlarmVO;

@Mapper
public interface AlarmMapper {

	int saveAlarm(AlarmVO alarm);

	List<AlarmVO> alarmList(Map<String, Object> map);

	int getTotal(Map<String, Object> map);

}
