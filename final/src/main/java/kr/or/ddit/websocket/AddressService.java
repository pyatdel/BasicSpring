package kr.or.ddit.websocket;

import java.util.List;

public interface AddressService {
    // 전체 주소록 조회
    List<AddressDto> getAllAddresses();

    // 특정 ID로 사용자 정보 조회
    AddressDto getAddressById(String empId);

    // 검색 키워드로 사용자 정보 조회
    List<AddressDto> searchAddresses(String keyword);
    
    List<AddressDto> getPagedAddresses(int page, int pageSize, String keyword);
    
    int getAddressCount(String keyword);
}
