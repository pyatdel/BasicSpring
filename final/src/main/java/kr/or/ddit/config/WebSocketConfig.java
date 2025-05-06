package kr.or.ddit.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import kr.or.ddit.websocket.WebSocketMessageHandler;

/*
WebSocketMessageHandler : 웹소켓 메시지를 처리하는 핸들러를 선언해주고 의존성 주입을 해준다.
registerWebSocketHandlers : 웹소켓 핸들러를 등록하기 위한 코드.
"/test"라는 엔드포인트에 대해 webSocketMessageHandler를 핸들러로 등록하고, setAllowedorigins("*")로 모든 CORS요청을 허용해준다.
웹소켓을 연결할 때 ws://loaclhost:8080/ws/test 로 연결을 해야한다.
 */
//WebSocket 기능을 활성화
@EnableWebSocket
//이 클래스를 스프링 설정 클래스로 선언
@Configuration
//WebSocketConfigurer 인터페이스를 구현하여 웹소켓 설정을 커스터마이징
public class WebSocketConfig implements WebSocketConfigurer {

 // 웹소켓 메시지를 처리하는 핸들러
 WebSocketMessageHandler webSocketMessageHandler;

 // 생성자를 통해 WebSocketMessageHandler 인스턴스를 주입받음
 public WebSocketConfig(WebSocketMessageHandler webSocketMessageHandler) {
     this.webSocketMessageHandler = webSocketMessageHandler;
 }

 // 웹소켓 핸들러를 등록하는 메소드를 오버라이드
 @Override
 public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
     registry.addHandler(webSocketMessageHandler, "/test").setAllowedOrigins("*");
 }
}
