package com.example.justice.sample;

import java.util.Enumeration;
import java.util.Map;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Component // Bean으로 만들어준다, new SuminSocketIntercepter()
public class SuminSocketIntercepter implements HandshakeInterceptor {

	// HttpSession에 담긴 정보를 WebsocketSession에 담아주는 기능
	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attributes) throws Exception {


		HttpServletRequest req = ((ServletServerHttpRequest)request).getServletRequest();
		HttpSession session  =  req.getSession(false);
	
		// HttpSession에 뭐가 들어있다면 저장
		if(session != null) {
			
			Enumeration<String> attNames = session.getAttributeNames();

			while(attNames.hasMoreElements()) {
				String attName = attNames.nextElement();
				Object attValue = session.getAttribute(attName); 				
				attributes.put(attName,attValue);
			}					
		}
		// 그냥 계속 진행
		return  true;  
		
	}

	@Override
	public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Exception exception) {
		// 지금은 할 일이 생각 안남
		
	}


}