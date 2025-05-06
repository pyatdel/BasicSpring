package kr.or.ddit.websocket;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.data.repository.query.Param;

@Mapper
public interface AddressMapper {
	// 전체 주소록 조회
    List<AddressDto> getAllAddresses();

    // 특정 ID로 사용자 정보 조회
    AddressDto getAddressById(String empId);

    // 검색 키워드로 사용자 정보 조회
    List<AddressDto> searchAddresses(String keyword);
    
    List<AddressDto> getPagedAddresses(@Param("offset") int offset, @Param("pageSize") int pageSize, @Param("keyword") String keyword);
    
    int getAddressCount(@Param("keyword") String keyword);
}
