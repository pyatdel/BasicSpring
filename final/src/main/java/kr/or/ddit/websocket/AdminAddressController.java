package kr.or.ddit.websocket;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdminAddressController {

	@Autowired
    private AddressService addressService;

    // 주소록 전체 목록 조회
    @GetMapping("/adaddress")
    public String getAddressList(@RequestParam(defaultValue = "1") int page,
                                 @RequestParam(defaultValue = "10") int pageSize,
                                 @RequestParam(required = false) String keyword,
                                 Model model) {
        int totalCount = addressService.getAddressCount(keyword);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        List<AddressDto> addressList = addressService.getPagedAddresses(page, pageSize, keyword);

        model.addAttribute("addresses", addressList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("keyword", keyword);

        return "adaddress";
    }

    // 주소록 검색
    @GetMapping("/adaddress/search")
    public String searchAddresses(@RequestParam("keyword") String keyword, Model model) {
        List<AddressDto> results = addressService.searchAddresses(keyword);
        model.addAttribute("addresses", results);
        return "adaddress"; // 검색 결과도 동일 JSP 파일에 표시
    }
}
