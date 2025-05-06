package kr.or.ddit.chat.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ChatMessageVO {
    private String type;    // 메시지 타입 (ENTER, TALK, LEAVE)
    private String sender;  // 발신자 이름
    private String message; // 메시지 내용
    private Timestamp time;    // 발송 시간
}