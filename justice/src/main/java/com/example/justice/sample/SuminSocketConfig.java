package com.example.justice.sample;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSocket
public class SuminSocketConfig implements WebSocketConfigurer  {

	@Autowired
	private SuminSocketIntercepter suminSocketIntercepter;
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		
		log.debug("체크");
		registry
		.addHandler(webSocketHandler(), "/jcmc")
//		.addHandler(webSocketHandler(), "/alarm")
		.setAllowedOriginPatterns("*")
		.addInterceptors(suminSocketIntercepter);
		
	}

	
	@Bean
	protected WebSocketHandler webSocketHandler() {
		log.debug("체크");
		return new SuminWebsocketHandler();
	}

}
