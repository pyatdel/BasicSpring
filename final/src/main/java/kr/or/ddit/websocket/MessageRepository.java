package kr.or.ddit.websocket;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

/*
JPARepository를 상속받는 MessageRepository를 만들어준다.
countByReceiverIdAndReadStatus 메소드를 통해 웹소켓이 연결되면 읽지 않은 쪽지의 개수를 반환한다.
findAllByReceiverOrderBySendTimeDesc 메소드를 통해 클라이언트가 모든 메시지를 조회할 때 시간에 대한 내림차순으로 조회할 수 있게 해준다.
 */
public interface MessageRepository extends JpaRepository<MessageEntity, Long> {
 Long countByReceiverEmpNoAndReadStatus(Long receiverEmpNo, boolean readStatus);
 List<MessageEntity> findAllByReceiverOrderBySendTimeDesc(UserEntity receiver);
}
