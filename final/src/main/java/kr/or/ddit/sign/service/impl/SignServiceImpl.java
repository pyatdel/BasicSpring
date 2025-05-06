package kr.or.ddit.sign.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.validation.constraints.Max;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.sign.mapper.SignMapper;
import kr.or.ddit.sign.service.SignService;
import kr.or.ddit.sign.vo.SignVO;
import kr.or.ddit.upload.cotroller.UploadController;
import kr.or.ddit.websocketalarm.service.AlarmService;
import kr.or.ddit.websocketalarm.service.WebSocketHandlerService;
import kr.or.ddit.websocketalarm.vo.AlarmVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class SignServiceImpl implements SignService {

	@Autowired
	SignMapper signMapper;
	
	@Autowired
	UploadController uploadController;
	
	@Autowired
	AlarmService alarmService;
	
	@Autowired
	WebSocketHandlerService webSocketService;
	
	// 결재 대기 리스트
	@Override
	public List<SignVO> signList(Map<String, Object> map) {
		return this.signMapper.signList(map);
	}

	// 결재 대기 전체 행
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.signMapper.getTotal(map);
	}


	// 결재 올린거 내용 상세 보기
	@Override
	public SignVO detail(SignVO signVO) {
		return this.signMapper.detail(signVO);
	}

	//반려버튼(retract) update로 처리 예정
	@Override
	public int retract(SignVO signVO) {
		return this.signMapper.retract(signVO);
	}

	// 결재 등록 폼
	@Override
	public SignVO create(int empNo) {
		return this.signMapper.create(empNo);
	}

	// 결재 종류 가져오기
	@Override
	public List<SignVO> getSignVOList() {
		return this.signMapper.getSignVOList();
	}

	// 결재요청 전체 행 수
	@Override
	public int getRequestTotal(Map<String, Object> map) {
		return this.signMapper.getRequestTotal(map);
	}

	// 결재요청 리스트
	@Override
	public List<SignVO> request(Map<String, Object> map) {
		return this.signMapper.request(map);
	}

	//종결함 전체 행 수
	@Override
	public int getEndTotal(Map<String, Object> map) {
		return this.signMapper.getEndTotal(map);
	}

	//종결함 리스트
	@Override
	public List<SignVO> end(Map<String, Object> map) {
		return this.signMapper.end(map);
	}

	//회수함 전체 행 수
	@Override
	public int getCollectTotal(Map<String, Object> map) {
		return this.signMapper.getCollectTotal(map);
	}

	//회수함 리스트
	@Override
	public List<SignVO> collect(Map<String, Object> map) {
		return this.signMapper.collect(map);
	}


	//열람/공람 전체 행 수
	@Override
	public int getReadingTotal(Map<String, Object> map) {
		return this.signMapper.getReadingTotal(map);
	}

	//열람/공람 리스트
	@Override
	public List<SignVO> reading(Map<String, Object> map) {
		return this.signMapper.reading(map);
	}

	//부서 문서함 전체 행수
	@Override
	public int getDepartmentTotal(Map<String, Object> map) {
		return this.signMapper.getDepartmentTotal(map);
	}

	//부서 문서함 리스트
	@Override
	public List<SignVO> department(Map<String, Object> map) {
		return this.signMapper.department(map);
	}

	//결재선 부서,직급 리스트
	@Override
	public List<SignVO> getSignLineList() {
		return this.signMapper.getSignLineList();
	}

	//결재선 부서
	@Override
	public List<SignVO> getDepartmentVOList() {
		return this.signMapper.getDepartmentVOList();
	}

	//결재선 해당 부서 직원 불려오기
	@Override
	public List<SignVO> signLinePost(Map<String, Object> map) {
		return this.signMapper.signLinePost(map);
	}
	
	
	//결재선 선택 -> 결재선 등록 -> 결재 폼에 보여야함
	@Override
	public int createPost(SignVO signVO) {
		int result = 0;
		
		// 결재 그룹 등록
		// this.signMapper.createGroupPost(signVO);
		result = this.signMapper.createGroupPost(signVO);
		
		//ex) 두 명 
		//empIds=[20241224002, 20241231003]
		String[] empIds = signVO.getEmpIds();
		String[] referenceEmpIds = signVO.getReferenceEmpIds();
		int counter = 1;
		
		//결재
		for(String empId : empIds) {
			//두 명이면 insert가 2 번 일어나야 함
			//목적 : empId, appOrder
			signVO.setEmpId(empId);
			signVO.setAppOrder(counter++);
			
			int insertResult = this.signMapper.createPost(signVO);
		    log.info("INSERT 결과: {}, empId: {}", insertResult, empId);

		    result += insertResult;
		    
			if(insertResult > 0) {
				
				Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
	            CustomUser userDetails = (CustomUser)principal; 
	            log.info("commuteList->userDetails : " + userDetails.getMember());
	            MemberVO memberVO = userDetails.getMember();
	            String empName = memberVO.getEmpName();
	            log.info("commuteList->memberVO : " + memberVO);
				
				// empNo에 해당하는 empName, empId 조회
		        Map<String, Object> empInfo = signMapper.getEmpInfo(empId); // 수정할 부분
		        
		        log.info("empId: {}, empInfo: {}", empId, empInfo);
		        log.info("empNo: {}, empName: {} ", empInfo.get("EMPNO"),empInfo.get("EMPNAME"));
		        
		        
		        Integer empNo = ((BigDecimal) empInfo.get("EMPNO")).intValue();
		        
				
				// 결재선 등록 성공시 결재자에게 알림
				String message = "📢 " + empName + "님이 결재를 요청했습니다.";
				
				// 알림 VO 생성
				AlarmVO alarm = new AlarmVO();
	            alarm.setEmpNo(empNo);
	            alarm.setAlarmType("결재 요청");
	            alarm.setAlarmMessage(message);
	            alarm.setLinkUrl("/sign/signList");
	            alarm.setEmpName(empName);
	            alarm.setAlarmStatus("안 읽음");
	            
	            // 알림 DB 저장
	            alarmService.saveAlarm(alarm);
	            
	         // WebSocket 알림 전송
	            webSocketService.sendMessageToUser(empNo, message,alarm.getLinkUrl());
			}
			/* result += this.signMapper.createPost(signVO); */
			log.info("결재선empId: {}", empId);
		}
		
		//참조
		for(String empId : referenceEmpIds) {
			signVO.setEmpId(empId);
			signVO.setAppOrder(counter++);
			
			int insertResult2 = this.signMapper.createPost2(signVO);
			log.info("insertResult2 결과: {}, empId: {}", insertResult2, empId);
			
			result += insertResult2;
			
			/* result += this.signMapper.createPost(signVO); */
			log.info("참조선empId:", empId);
		}
		
		return result;
	}

	//결재선 이름 가져오기
	@Override
	public List<SignVO> getAppListName() {
		return this.signMapper.getAppListName();
	}

	// 참조선 가져오기
	@Override
	public List<SignVO> getReferenceEmpIds() {
		return this.signMapper.getReferenceEmpIds();
	}


	@Override
	public int createFormPost(SignVO signVO) {// 파일 첨부
		MultipartFile[] uploadFile = signVO.getUploadFile();
		
		long fileGroupNo = this.uploadController.multiImageUpload(uploadFile);
		log.info("createFormPost->fileGroupNo : " + fileGroupNo);
		
		signVO.setFileGroupNo(fileGroupNo);
		
		int result = this.signMapper.createFormPost(signVO);
		
		log.info("signVO 이거뭐지 : {}",signVO);
		log.info("result 이거뭐지 : {}",result);
		
		return result;
	}

	// 삽입 작업 성공 시, 삽입된 데이터를 조회
	@Override
	public List<SignVO> getInsertedApprovalList(long appGroupCode) {
		return this.signMapper.getInsertedApprovalList(appGroupCode);
	}

	////선택된 결재 라인 보이게
	@Override
	public List<SignVO> getAppLineList(SignVO signVO) {
		return this.signMapper.getAppLineList(signVO);
	}

	//선택된 참조 라인 보이게
	@Override
	public List<SignVO> getAppLineList2(SignVO signVO) {
		return this.signMapper.getAppLineList2(signVO);
	}

	// 승인 버튼 클릭-> approval_hist 테이블에 insert
	@Override
	public int approvalPost(SignVO signVO) {
		return this.signMapper.approvalPost(signVO);
	}

	//empId를 조건으로 하여 그 직원이 결재 완료 시 보여질 도장 이미지를 가져옴
	@Override
	public String getFileSaveLocate(String empId) {
		return this.signMapper.getFileSaveLocate(empId);
	}

	//그 결재문서가 종료됐다면 1
	@Override
	public int getFinalCheckStatus(SignVO signVO) {
		return this.signMapper.getFinalCheckStatus(signVO);
	}

	//반려 사유 가져오기
	@Override
	public SignVO retractDetail(SignVO signVO) {
		return this.signMapper.retractDetail(signVO);
	}

	//main
	@Override
	public List<SignVO> signListMain(Map<String, Object> map) {
		return this.signMapper.signListMain(map);
	}


	

}
