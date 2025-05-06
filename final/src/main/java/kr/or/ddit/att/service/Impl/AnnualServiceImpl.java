package kr.or.ddit.att.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.att.mapper.AnnualMapper;
import kr.or.ddit.att.service.AnnualService;
import kr.or.ddit.att.vo.AnnualListVO;
import kr.or.ddit.att.vo.AttendanceCodeVO;
import kr.or.ddit.websocketalarm.controller.SampleWebSocketHandler;
import kr.or.ddit.websocketalarm.service.AlarmService;
import kr.or.ddit.websocketalarm.service.WebSocketHandlerService;
import kr.or.ddit.websocketalarm.vo.AlarmVO;

@Service
public class AnnualServiceImpl implements AnnualService {
	
	@Autowired
	AnnualMapper annualMapper;
	
	@Autowired
	private WebSocketHandlerService webSocketService;
	
	@Autowired
    private AlarmService alarmService; // 알림 저장 서비스
	
	@Override
	public List<AnnualListVO> getList(Map<String, Object> map) {
		return annualMapper.getList(map);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return annualMapper.getTotal(map);
	}

	@Override
	public List<AttendanceCodeVO> getAttendanceCode() {
		return annualMapper.getAttendanceCode();
	}
	
	@Override
	public int getApproverEmpNo(int annNo) {
	    return annualMapper.getApproverEmpNo(annNo);
	}

	@Override
	public int annualSignUp(AnnualListVO annualSignUp) {
		int result = annualMapper.annualSignUp(annualSignUp);
		
		if (result > 0) {
            // 휴가 신청 성공 시 승인자에게 알림 전송
            Integer approverEmpNo = annualMapper.getApproverEmpNo(annualSignUp.getEmpNo()); // 승인자 조회
            String message = "📢 " + annualSignUp.getEmpName() + "님이 휴가를 신청했습니다.";
            
            // 알림 VO 생성
            AlarmVO alarm = new AlarmVO();
            alarm.setEmpNo(approverEmpNo);
            alarm.setAlarmType("휴가 신청");
            alarm.setAlarmMessage(message);
            alarm.setLinkUrl("/att/annualList");
            alarm.setAlarmStatus("N");
            alarm.setEmpName(annualSignUp.getEmpName());
            
            // 알림 DB 저장
            alarmService.saveAlarm(alarm);

            // WebSocket 알림 전송
            webSocketService.sendMessageToUser(approverEmpNo, message,alarm.getLinkUrl());
        }

        return result;
	}

	@Override
	public int getEmpAnnual(int empNo) {
		return annualMapper.getEmpAnnual(empNo);
	}

	@Override
	public List<AnnualListVO> getListAll(Map<String, Object> map) {
		return annualMapper.getListAll(map);
	}

	@Override
	public int getAllTotal(Map<String, Object> map) {
		return annualMapper.getAllTotal(map);
	}

	@Override
	public int updateAppStatus(List<Map<String,Integer>> empList, List<Integer> empNoList, List<Integer> annNoList, int appStatus) {
		
		// Step 1 : APP_STATUS_CODE 업데이트
		int updateCount = annualMapper.updateAppStatus(empList,empNoList, annNoList, appStatus);
		
		// Step 2 : ANN_CNT 업데이트 (appStatus가 4일 경우)
		if(appStatus == 4) {
			updateCount += annualMapper.updateAnnCnt(annNoList);
		}
		
		// Step 3 : 승인자 -> 휴가자에게 알림 전송
        for (int empNo : empNoList) {
            String message = "✅ 휴가 신청이 승인되었습니다.";
            
            String empName = annualMapper.getEmpName(empNo);
            
         // 알림 VO 생성
            AlarmVO alarm = new AlarmVO();
            alarm.setEmpNo(empNo);
            alarm.setAlarmType("승인 알림");
            alarm.setAlarmMessage(message);
            alarm.setLinkUrl("/att/annualList");
            alarm.setAlarmStatus("N");
            alarm.setEmpName(empName);
            
            // 알림 DB 저장
            alarmService.saveAlarm(alarm);

            // WebSocket 알림 전송
            webSocketService.sendMessageToUser(empNo, message,alarm.getLinkUrl());
        }
		
		return updateCount; // 총 업데이트된 행 수 반환
	}

	@Override
	public List<AnnualListVO> getListComplete(Map<String, Object> map) {
		return annualMapper.getListComplete(map);
	}
	
	

}
