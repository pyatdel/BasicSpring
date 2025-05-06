package kr.or.ddit.websocket;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import kr.or.ddit.att.mapper.AnnualMapper;
import kr.or.ddit.member.service.MemberService;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.websocketalarm.service.AlarmService;
import kr.or.ddit.websocketalarm.service.WebSocketHandlerService;
import kr.or.ddit.websocketalarm.vo.AlarmVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MessageServiceImpl implements MessageService {
    private final MessageMapper messageMapper;
    private final MemberService memberService;
    
    
    @Autowired
	AnnualMapper annualMapper;
	
	@Autowired
	private WebSocketHandlerService webSocketService;
	
	@Autowired
    private AlarmService alarmService; // 알림 저장 서비스

    @Autowired
    public MessageServiceImpl(MessageMapper messageMapper, MemberService memberService) {
        this.messageMapper = messageMapper;
        this.memberService = memberService;
    }

    @Override
    public MessageDto SendMessage(MessageDto messageDto, UserDetails userDetails) {
        MemberVO loggedInUser = memberService.getMemberByUsername(userDetails.getUsername());
        if (loggedInUser == null) {
            throw new IllegalArgumentException("로그인된 사용자 정보를 찾을 수 없습니다.");
        }

        // 로그인한 사용자의 사번 설정
        messageDto.setSenderEmpNo((long) loggedInUser.getEmpNo());

        // 수신자의 EMP_NO 설정
        Long receiverEmpNo = messageMapper.getReceiverEmpNoById(messageDto.getReceiverEmpId());
        
        log.info("receiverEmpNo {}",receiverEmpNo);
        if (receiverEmpNo == null) {
            throw new IllegalArgumentException("수신자를 찾을 수 없습니다.");
        }
        messageDto.setReceiverEmpNo(receiverEmpNo);

        messageMapper.insertMessage(messageDto);
        
        // 쪽지 성공 시 승인자에게 알림 전송
        Long approverEmpNo = receiverEmpNo; // 승인자 조회
        String message = loggedInUser.getEmpName() + "님이 쪽지를 보냈습니다.";
//        
        // 알림 VO 생성
        AlarmVO alarm = new AlarmVO();
        alarm.setEmpNo(approverEmpNo.intValue());
        alarm.setAlarmType("쪽지 알림");
        alarm.setAlarmMessage(message);
        alarm.setLinkUrl("/message/list/inbox");
        alarm.setEmpName(loggedInUser.getEmpName());
        alarm.setAlarmStatus("안 읽음");
        
        // 알림 DB 저장
        alarmService.saveAlarm(alarm);

        // WebSocket 알림 전송
        webSocketService.sendMessageToUser(approverEmpNo.intValue(), message, alarm.getLinkUrl());
        
        return messageDto;
    }

    @Override
    public List<MessageDto> ReadAllMessage(String empId, UserDetails userDetails) {
        MemberVO loggedInUser = memberService.getMemberByUsername(userDetails.getUsername());
        if (loggedInUser == null || !loggedInUser.getEmpId().equals(empId)) {
            throw new AccessDeniedException("사용자 인증 실패");
        }

        return messageMapper.selectMessagesByReceiver((long) loggedInUser.getEmpNo());
    }

    @Override
    public MessageDto ReadMessage(Long messageId, UserDetails userDetails) {
        MemberVO loggedInUser = memberService.getMemberByUsername(userDetails.getUsername());
        if (loggedInUser == null) {
            throw new IllegalArgumentException("로그인된 사용자 정보를 찾을 수 없습니다.");
        }

        MessageDto message = messageMapper.selectMessageById(messageId);
        if (!message.getReceiverEmpNo().equals((long) loggedInUser.getEmpNo())) {
            throw new AccessDeniedException("이 메시지를 읽을 권한이 없습니다.");
        }

        return message;
    }
    
    @Override
    public void sendMessage(MessageDto messageDto) {
        messageMapper.insertMessage(messageDto);
    }
    
    @Override
    public String getReceiverNameById(String receiverId) {
        return messageMapper.getReceiverNameById(receiverId);
    }
    
    @Override
    public boolean deleteMessage(int messageId) {
        try {
            int result = messageMapper.deleteMessage(messageId);
            return result > 0;
        } catch (Exception e) {
            log.error("Error deleting message: ", e);
            return false;
        }
    }
    
    @Override
    public MessageDto getMessageById(int messageId) {
        return messageMapper.selectMessageById(messageId);
    }

   @Override
   public MessageDto getMessageById(Long messageId) {
      return messageMapper.selectMessageById(messageId);
   }
   
   @Override
   public void updateReadStatus(Long messageId) {
       messageMapper.updateReadStatus(messageId);
   }
}
