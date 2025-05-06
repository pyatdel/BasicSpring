package kr.or.ddit.websocket;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<UserEntity, Long> {
    boolean existsByEmpNo(Long empNo);
    UserEntity findByEmpNo(Long empNo);
    UserEntity findByEmpId(String empId);
    
}

