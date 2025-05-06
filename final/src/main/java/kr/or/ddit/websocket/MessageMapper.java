package kr.or.ddit.websocket;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.data.repository.query.Param;

@Mapper
public interface MessageMapper {

    // 메시지 삽입
    void insertMessage(MessageDto messageDto);
    
    int deleteMessage(@Param("messageId") int messageId);
    
    // 수신 메시지 조회
    List<MessageDto> selectMessagesByReceiver(@Param("receiverEmpNo") Long receiverEmpNo);

    // 특정 메시지 상세 조회
    MessageDto selectMessageById(@Param("messageId") Long messageId);

   String getReceiverNameById(String receiverId);
   
    Long getReceiverEmpNoById(@Param("receiverEmpId") String receiverEmpId);
    
    MessageDto selectMessageById(@Param("messageId") int messageId);
    
    void updateReadStatus(@Param("messageId") Long messageId);
}
