package kr.or.ddit.websocket;

import java.time.LocalDateTime;

import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/*
한 명의 유저는 여러 개의 쪽지를 보낼 수 있다. 그래서 sender와 receiver에 ManyToOne 설정을 해준다. DB에 저장될 때는 유저의 회원번호가 저장된다.

골뱅이CreationTimestamp는 데이터의 생성 시간을 기록하기 위해 사용된다. 예를 들어, 데이터베이스의 테이블에 새로운 레코드가 추가될 때, 해당 레코드의 생성 시간을 CreationTimestamp로 기록할 수 있다.
골뱅이ColumnDefault 는 데이터베이스 테이블의 컬럼에 기본값을 설정하는 기능이다. 데이터베이스에 새로운 레코드가 추가될 때 해당 컬럼이 비어있으면 자동으로 설정한 기본값이 적용된다.
(fetch = FetchType.LAZY)는 JPA에서 엔티티를 로딩할 때 사용되는 옵션 중 하나다.
FetchType.LAZY는 연관된 엔티티를 실제로 사용하는 시점까지 로딩을 지연시키는 방식이다.
FetchType.EAGER는 연관된 엔티티를 즉시 로딩하는 방식이다. 해당 엔티티를 조회할 때 연관된 엔티티도 함께 로딩된다.
예를 들어, 게시물과 댓글이 일대다 관계일 때, 게시물을 조회할 때는 댓글을 함께 로딩하지 않고, 게시물을 실제로 사용하는 시점에서 댓글을 로딩하도록 설정할 수 있다.
 */
@Entity(name = "message")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class MessageEntity {
    @Id
    @GeneratedValue(strategy =GenerationType.IDENTITY)
    private Long messageId; // 쪽지 번호
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sender_emp_no")
    private UserEntity sender; // 송신자
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name ="receiver_emp_no")
    private UserEntity receiver; // 수신자
    private String content; // 내용

    @CreationTimestamp // 현재 시간 자동 삽입
    private LocalDateTime sendTime; // 송신 시간
    @ColumnDefault("FALSE")
    private boolean readStatus; // 읽음 여부
}

