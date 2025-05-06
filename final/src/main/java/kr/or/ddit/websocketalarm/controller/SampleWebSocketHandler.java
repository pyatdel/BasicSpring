package kr.or.ddit.websocketalarm.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSocket
public class SampleWebSocketHandler extends TextWebSocketHandler {
	
    private static List<WebSocketSession> list = new ArrayList<>();
    private static final Map<Integer, WebSocketSession> sessionMap = new ConcurrentHashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        list.add(session);

        // URL에서 empNo 추출 (예: /ws/alarm/1001)
        String empNoStr = session.getUri().getPath().split("/ws/alarm/")[1];
        Integer empNo = Integer.parseInt(empNoStr);

        sessionMap.put(empNo, session);

        log.info("## {}번 직원 접속", empNo);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        log.info("## 메시지 수신: {}", message.getPayload());

        // 모든 접속된 사용자에게 메시지 전송 (기존 list 활용)
        for (WebSocketSession webSocketSession : list) {
            if (webSocketSession.isOpen()) {
                webSocketSession.sendMessage(message);
            }
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        list.remove(session);

        Integer empNo = sessionMap.entrySet().stream()
                .filter(entry -> entry.getValue().equals(session))
                .map(Map.Entry::getKey)
                .findFirst().orElse(null);

        if (empNo != null) {
            sessionMap.remove(empNo);
            log.info("## {}번 직원 연결 종료", empNo);
        }
    }

    // 특정 직원에게 알림 보내기 (sessionMap 활용)
    public void sendMessageToUser(Integer empNo, String message,String url) {
        WebSocketSession session = sessionMap.get(empNo);
        if (session != null && session.isOpen()) {
            try {
            	
            	// JSON 객체 생성
                ObjectMapper objectMapper = new ObjectMapper();
                Map<String, String> messageData = new HashMap<>();
                messageData.put("message", message);
                messageData.put("url", url);

                // JSON 문자열 변환
                String jsonMessage = objectMapper.writeValueAsString(messageData);
            	
            	
                session.sendMessage(new TextMessage(jsonMessage));
            } catch (IOException e) {
                log.error("## {}번 직원에게 메시지 전송 실패: {}", empNo, e.getMessage());
            }
        }
    }

	public void sendImportantNotification(String message, String linkUrl) {
			
	}
}
