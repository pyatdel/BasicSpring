package kr.or.ddit.websocket;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

/*
HashMap을 사용해서 id와 웹소켓 세션을 매핑시켜줬다. id로 매핑을 시킨 이유는 클라이언트에서 로그인이 성공하면, 아이디값을 저장하고 그 값을 웹소켓 연결때 사용하기 위해서다.
afterConnectionEstablished : 웹소켓 연결이 설정되고 바로 실행되는 메소드이다.
먼저 웹 소켓 세션에서 사용자 id를 찾는다. 웹소켓에 연결할 때 "uid" 파라미터를 붙여서 보내야 searchUserName 메소드가 작동한다. 그 후 id와 세션을 SessionMap에 넣어준다.
서버는 파라미터에서 파싱한 uid를 통해 사용자를 찾고 읽지 않은 쪽지의 개수를 웹소켓 메시지로 전송한다.
afterConnectionClosed : 웹소켓 연결이 종료된 후 실행되는 메소드
웹소켓 세션에서 사용자 id를 찾아내서 제거한다.
sendNotification : 쪽지를 보내고 상대방에게 쪽지가 도착했다는 웹소켓 메시지를 전송할 때 쓰인다.
searchUserName : 웹소켓 세션의 URI를 파싱해 사용자 id를 찾는 메소드이다. ws://localhost:8080/test?uid={uid} 로 연결을 요청해야 파라미터 값을 파싱할 수 있다.
 */
//웹소켓 메시지를 처리하는 클래스
@Component
public class WebSocketMessageHandler extends TextWebSocketHandler {
	// 사용자 id와 웹소켓 세션을 매핑하는 hashmap
    HashMap<String, WebSocketSession> sessionMap = new HashMap<>();
    private final MessageRepository messageRepository;
    private final UserRepository userRepository;

    public WebSocketMessageHandler(
            @Autowired MessageRepository messageRepository,
            UserRepository userRepository) {
        this.messageRepository = messageRepository;
        this.userRepository = userRepository;
    }

    // 웹소켓 연결이 설정된 후에 실행되는 메소드
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	// 웹소켓 세션으로부터 사용자 id를 찾아냄
        String empId = searchUserName(session);
        // 세션맵에 사용자 id와 웹소켓 세션을 추가
        sessionMap.put(empId, session);
        
        // 웹소켓 세션의 URI를 파싱하여 uid를 얻어냄
//        UriComponents uriComponents =
//                UriComponentsBuilder.fromUriString(Objects.requireNonNull(session.getUri()).toString()).build();
//        String uid = uriComponents.getQueryParams().getFirst("uid");
        // uid를 통해 사용자를 찾음
        UserEntity user = userRepository.findByEmpId(empId);
        // 해당 사용자가 존재하는 경우
        if (user != null) {
        	// 사용자의 ID를 얻어냄
            Long empNo = user.getEmpNo();
            // 해당 사용자가 읽지 않은 메시지의 개수를 얻어냄
            Long unreadMessagesCount = messageRepository.countByReceiverEmpNoAndReadStatus(empNo, false);
            // 웹소켓 메시지로 읽지 않은 메시지의 개수를 전송
            session.sendMessage(new TextMessage("읽지 않은 쪽지의 개수: " + unreadMessagesCount));
        } else {
        	// 해당 사용자가 존재하지 않는 경우, 오류 메시지를 전송
            session.sendMessage(new TextMessage("존재하지 않는 사용자입니다."));
        }
    }

    // 웹소켓 연결이 종료된 후에 실행되는 메소드
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
    	// 웹소켓 세션으로부터 사용자 이름을 찾아냄
        String empId = searchUserName(session);
        // 세션맵에서 해당 사용자를 제거
        sessionMap.remove(empId);
    }
    
    // 특정 사용자에게 웹소켓 메시지를 전송하는 메소드
    public void sendNotification(String empId, String message) throws Exception {
    	// 세션맵에서 사용자의 웹소켓 세션을 얻어냄
        WebSocketSession session = sessionMap.get(empId);
        // 해당 세션이 존재하고 열려있는 경우, 메시지를 전송
        if (session != null && session.isOpen()) {
            session.sendMessage(new TextMessage(message));
        }
    }
    
    // 웹소켓 세션의 URI를 파싱하여 사용자 id를 찾아내는 메소드
    public String searchUserName(WebSocketSession session) {
        UriComponents uriComponents = UriComponentsBuilder.fromUriString(session.getUri().toString()).build();
        return uriComponents.getQueryParams().getFirst("empId");
    }
}