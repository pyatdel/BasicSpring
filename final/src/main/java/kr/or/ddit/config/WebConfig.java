package kr.or.ddit.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import kr.or.ddit.chat.controller.ChatHandler;

@Configuration
@EnableWebSocket
public class WebConfig implements WebMvcConfigurer, WebSocketConfigurer{
	
	 @Autowired
    private ChatHandler chatHandler;
	 
	@Override
	public void addCorsMappings(CorsRegistry registry) {
		registry.addMapping("/**") // 모든 경로에 대해
		
		.allowedOrigins("http://localhost:7921", "http://192.168.56.1:7921", "http://localhost:8020", "http://192.168.56.1:8020","http://192.168.141.23:7921","http://192.168.141.23:8020") // 허용할 클라이언트 도메인
			        .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS") // 허용할 HTTP 메서드
			        .allowedHeaders("*") // 모든 헤더 허용
			        .allowCredentials(true); // 쿠키 및 인증 정보 허용
		
		
		
	}
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
	    registry.addHandler(chatHandler, "/chat")
	        .setAllowedOrigins("http://localhost:8020")  // 구체적인 origin으로 변경
	        .addInterceptors(new HttpSessionHandshakeInterceptor())
	        .withSockJS();  // SockJS 지원 추가
	}
	
	

}
