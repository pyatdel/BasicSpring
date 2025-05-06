package kr.or.ddit.websocketalarm.controller;

import java.util.Enumeration;
import java.util.Map;

import org.springframework.http.HttpHeaders;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Component
public class SampleSocketIntercepter implements HandshakeInterceptor {

	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attributes) throws Exception {
		
		HttpHeaders headers = request.getHeaders();
		System.out.println("Headers:" + headers);

		HttpServletRequest req = ((ServletServerHttpRequest)request).getServletRequest();
		HttpSession session  =  req.getSession(false);
	
		// HttpSession에 머가 들어있다면 담장
		if(session != null) {
			
			Enumeration<String> attNames = session.getAttributeNames();

			while(attNames.hasMoreElements()) {
				String attName = attNames.nextElement();
				Object attValue = session.getAttribute(attName); 				
				attributes.put(attName,attValue);
			}					
		}
		
		if(session == null) {
			System.out.println("세션에 값없음");
			return false;
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
