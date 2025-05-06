package kr.or.ddit.websocket;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AddressServiceImpl implements AddressService {
    private final AddressMapper addressMapper;

    @Autowired
    public AddressServiceImpl(AddressMapper addressMapper) {
        this.addressMapper = addressMapper;
    }

    @Override
    public List<AddressDto> getAllAddresses() {
        return addressMapper.getAllAddresses();
    }

    @Override
    public AddressDto getAddressById(String empId) {
        return addressMapper.getAddressById(empId);
    }

    @Override
    public List<AddressDto> searchAddresses(String keyword) {
        return addressMapper.searchAddresses(keyword);
    }
    
    @Override
    public List<AddressDto> getPagedAddresses(int page, int pageSize, String keyword) {
        int offset = (page - 1) * pageSize;
        return addressMapper.getPagedAddresses(offset, pageSize, keyword);
    }

    @Override
    public int getAddressCount(String keyword) {
        return addressMapper.getAddressCount(keyword);
    }
}
