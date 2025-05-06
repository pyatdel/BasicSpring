package kr.or.ddit.websocketalarm.service;

public interface WebSocketHandlerService {
	
	// 특정 직원에게 메시지 전송
	public void sendMessageToUser(int empNo, String message,String url);
	
	// 전 직원에게 메시지 전송
	public void sendImportantNotification(String message, String linkUrl);
	

}
