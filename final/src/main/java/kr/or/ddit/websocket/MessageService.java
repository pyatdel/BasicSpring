package kr.or.ddit.websocket;

import java.util.List;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

@Service
public interface MessageService {
   public String getReceiverNameById(String receiverId);

   MessageDto SendMessage(MessageDto messageDto,
         org.springframework.security.core.userdetails.UserDetails userDetails);

   List<MessageDto> ReadAllMessage(String empId, UserDetails userDetails);

   MessageDto ReadMessage(Long messageId, UserDetails userDetails);

   void sendMessage(MessageDto messageDto);
   
    boolean deleteMessage(int messageId);

   MessageDto getMessageById(int messageId);

   public MessageDto getMessageById(Long messageId);
   
   void updateReadStatus(Long messageId);
}
