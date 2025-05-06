package kr.or.ddit.websocket;

import java.sql.Date;
import java.time.LocalDateTime;

import lombok.Data;

/*
sender : 쪽지 송신자의 닉네임을 나타내는 String 타입의 필드이다. @JsonProperty 어노테이션을 사용하여 JSON 직렬화 시에 필드명을 "sender"로 지정했다.
receiver : 쪽지 수신자의 닉네임을 나타내는 String 타입의 필드이다. @JsonProperty 어노테이션을 사용하여 JSON 직렬화 시에 필드명을 "receiver"로 지정했다.
content : 쪽지의 내용을 나타내는 String 타입의 필드이다. @NotBlank 어노테이션을 사용하여 내용이 비어있지 않도록 유효성 검사를 수행하게 했다.
 */
//@Getter
//@Setter
//@NoArgsConstructor
//@AllArgsConstructor
//@ToString
@Data
public class MessageDto {
   private int masageSeq;
    private Long messageId; // 메시지 ID
    private Long senderEmpNo; // 송신자 번호
    private String senderName; // 송신자 이름
    private Long receiverEmpNo; // 수신자 번호
    private String receiverName; // 수신자 이름
    private String content; // 메시지 내용
    private LocalDateTime sendTime; // 전송 시간
    private boolean readStatus; // 읽음 여부
    private String senderEmpId;
    private String receiverEmpId;
 // Getters and Setters
    public String getSenderEmpId() {
        return senderEmpId;
    }

    public void setSenderEmpId(String senderEmpId) {
        this.senderEmpId = senderEmpId;
    }

    public String getReceiverEmpId() {
        return receiverEmpId;
    }

    public void setReceiverEmpId(String receiverEmpId) {
        this.receiverEmpId = receiverEmpId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public boolean isReadStatus() {
        return readStatus;
    }

    public void setReadStatus(boolean readStatus) {
        this.readStatus = readStatus;
    }
}