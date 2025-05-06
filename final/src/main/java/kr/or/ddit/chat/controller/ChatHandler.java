package kr.or.ddit.chat.controller;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.chat.vo.ChatMessageVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class ChatHandler extends TextWebSocketHandler {
    
    private static List<WebSocketSession> sessions = new ArrayList<>();
    private final ObjectMapper objectMapper = new ObjectMapper();
    
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessions.add(session);
        log.info("## 새로운 연결: {}", session.getId());
    }
    
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
       String payload = message.getPayload();
       
       ChatMessageVO chatMessageVO = objectMapper.readValue(payload, ChatMessageVO.class);
       chatMessageVO.setTime(new Timestamp(System.currentTimeMillis()));
       
       log.debug("메시지 수신: {}", message.getPayload());
       
       // 클라이언트로 직접 payload 전송
       TextMessage textMessage = new TextMessage(message.getPayload());
       
       for(WebSocketSession sess : sessions) {
           sess.sendMessage(textMessage);
       }
    }
    
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessions.remove(session);
        log.info("새로운 WebSocket 연결: {}", session.getId());
    }
    
    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
    	log.error("WebSocket 에러 발생: {}", session.getId(), exception);
    }
}