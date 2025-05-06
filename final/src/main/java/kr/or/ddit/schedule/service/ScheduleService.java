package kr.or.ddit.schedule.service;

import java.util.List;

import kr.or.ddit.schedule.vo.ScheduleVO;

public interface ScheduleService {

	List<ScheduleVO> getScheduleList(String empNo);

	public int createSchedule(ScheduleVO schedule);

	public ScheduleVO scheduleDetail(ScheduleVO schedule);

	public int updateSchedule(ScheduleVO schedule);

	public int deleteSchedule(ScheduleVO schedule);

	List<ScheduleVO> getDeptScheduleList(ScheduleVO scheduleVO);

	List<ScheduleVO> getVisitScheduleList(String empNo);

	List<ScheduleVO> getInComScheduleList(String empNo);

	List<ScheduleVO> getMyScheduleList(String empNo);

}
