package com.example.justice.sample;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SuminWebsocketHandler extends TextWebSocketHandler {

	private static List<WebSocketSession> list = new ArrayList<WebSocketSession>();
	
	@Override  // 처음 접속 되었을 때 자동 실행
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("## 누군가 접속");
		list.add(session);
	}

	@Override  // 이게 제일 중요, 여기에 모든 처리 로직이 들어감, 
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String uMsg = message.getPayload();
		
		Map<String,Object> yjMap = session.getAttributes(); // 웹 소켓 세션
		
		// 웹 소켓 session에 http session값이 잘 담겨 있는지 확인
		for(String yjKey : yjMap.keySet()) {
			
			log.info("스캔 {} {}", yjKey,yjMap.get(yjKey));
		}
		
		// 잭스 라이브러리 직접 사용하여 변환!!!
		ObjectMapper objMapper = new ObjectMapper(); // 변환기 생성
		
		//json문자열을 자바 객체로 변환
		SuminVO  suminVO  = objMapper.readValue(uMsg, SuminVO.class);
		        
		log.info("클라이언트가 보낸 메세지 {}",uMsg);
		log.info("변환 성공? {}", suminVO);
		
		suminVO.setMsg("맞대 "+suminVO.getMsg());
		// 자바객체를 json문자열로 바꾸어 줌
		String jsonMsg = objMapper.writeValueAsString(suminVO);
		TextMessage txtMsg = new TextMessage(jsonMsg);
		
		// 접속한 사람들 모두에게 전달, (BroadCast)
		for (WebSocketSession wSession : list) {
			//if(session != webSocketSession) { // 보낸 사람이 아닐 때만!
			    if(wSession.isOpen()) {}// 필요할 수 있음
				wSession.sendMessage(txtMsg);
			//}
		}
	}
	
	@Override  // 접속이 해제 되었을 때 자동 실행
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("## 누군가 떠남");
		list.remove(session);
	}

}
