package kr.or.ddit.websocket;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

//쪽지를 보내기 위해서는 유저가 필요하다. 그래서 기본적인 UserEntity를 생성해줬다.
//UserEntity.java
@Entity(name = "employee")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class UserEntity {
 @Id
 @GeneratedValue(strategy = GenerationType.IDENTITY) // 직원 번호 자동 생성
 private Long empNo; // 직원 번호 (EMP_NO)
 private String empId; // 직원 아이디 (EMP_ID)
 private String empPw; // 직원 비밀번호 (EMP_PW)
 private String empName; // 직원 이름 (EMP_NAME)
 private String empEmail; // 직원 이메일 (EMP_EMAIL)
 private String empPhone; // 직원 전화번호 (EMP_PHONE)
}

