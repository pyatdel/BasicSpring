package kr.or.ddit.websocketalarm.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.websocketalarm.controller.SampleWebSocketHandler;
import kr.or.ddit.websocketalarm.service.WebSocketHandlerService;

@Service
public class WebSocketHandlerServiceImpl implements WebSocketHandlerService{
	
	@Autowired
    private SampleWebSocketHandler webSocketHandler;

    // 특정 직원에게 메시지 전송
    public void sendMessageToUser(int empNo, String message,String url) {
        webSocketHandler.sendMessageToUser(empNo, message,url);
    }

	@Override
	public void sendImportantNotification(String message, String linkUrl) {
		webSocketHandler.sendImportantNotification(message,linkUrl);
	}

}
