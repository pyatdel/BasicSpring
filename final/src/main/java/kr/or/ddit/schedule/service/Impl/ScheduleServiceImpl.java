package kr.or.ddit.schedule.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.schedule.mapper.ScheduleMapper;
import kr.or.ddit.schedule.service.ScheduleService;
import kr.or.ddit.schedule.vo.ScheduleVO;

@Service
public class ScheduleServiceImpl implements ScheduleService {
	
	@Autowired
	ScheduleMapper scheduleMapper;

	@Override
	public List<ScheduleVO> getScheduleList(String empNo) {
		
		return scheduleMapper.getScheduleList(empNo);
	}

	@Override
	public int createSchedule(ScheduleVO schedule) {
		return scheduleMapper.createSchedule(schedule);
	}

	@Override
	public ScheduleVO scheduleDetail(ScheduleVO schedule) {
		return scheduleMapper.scheduleDetail(schedule);
	}

	@Override
	public int updateSchedule(ScheduleVO schedule) {
		return scheduleMapper.updateSchedule(schedule);
	}

	@Override
	public int deleteSchedule(ScheduleVO schedule) {
		return scheduleMapper.deleteSchedule(schedule);
	}

	@Override
	public List<ScheduleVO> getDeptScheduleList(ScheduleVO scheduleVO) {
		return scheduleMapper.getDeptScheduleList(scheduleVO);
	}

	@Override
	public List<ScheduleVO> getVisitScheduleList(String empNo) {
		return scheduleMapper.getVisitScheduleList(empNo);
	}

	@Override
	public List<ScheduleVO> getInComScheduleList(String empNo) {
		return scheduleMapper.getInComScheduleList(empNo);
	}

	@Override
	public List<ScheduleVO> getMyScheduleList(String empNo) {
		return scheduleMapper.getMyScheduleList(empNo);
	}

}
