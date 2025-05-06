package kr.or.ddit.business.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.business.service.BusinessActService;
import kr.or.ddit.business.vo.BusinessActVO;
import kr.or.ddit.cash.vo.SaleVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.sign.vo.SignVO;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.CustInfoVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/business")
@Slf4j
@Controller
public class BusinessActController {
	
	@Autowired
	BusinessActService businessActService; 
	
	
	
//	@GetMapping("/busAct")
//	public String businessAct() {
//		
//		return "business/busAct";
//	}
	// 결재 등록 폼
	
	
		
	@GetMapping("/busAct")
    public String list(
        @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
        @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
        Model model) {
        
        Map<String, Object> map = new HashMap<>();
        map.put("currentPage", currentPage);
        map.put("keyword", keyword);

        List<BusinessActVO> businessActVOList = this.businessActService.list(map);
        log.info("Retrieved customer info: {}", businessActVOList);
        
        List<BusinessActVO> entList = this.businessActService.getAllEntities(); // 거래처 목록 가져오기

        int total = this.businessActService.getTotal(map);
        ArticlePage<BusinessActVO> articlePage = new ArticlePage<>(total, currentPage, 10, businessActVOList, keyword);
        
        model.addAttribute("businessActVOList", businessActVOList);
        model.addAttribute("articlePage", articlePage);
	    model.addAttribute("entList", entList);
        
        return "business/busAct";
    }
	
	@PostMapping("/busAct/create")
	public String createPost(BusinessActVO businessActVO) {
		
		log.info("createPost->businessActVO : " + businessActVO);
		
		int result = this.businessActService.createPost(businessActVO);
		log.info("result : ", result);
		
		return "redirect:/business/busAct";
	}

	
	// 상품 등록 페이지
	@GetMapping("/actCreate")
	public String create(Model model) {
		
		// 영업 유형 분류를 위해 (이메일, 미팅, SMS 등등..)
		List<BusinessActVO> busTypeVOList = this.businessActService.listAll();
		log.info("actCreate -> lprodVOList : " + busTypeVOList);
		
		model.addAttribute("busTypeVOList", busTypeVOList);
		
		return "business/actCreate";
	}
	
	

	
	
	@RequestMapping("/create")
	public String showBusinessForm(Model model) {
	    List<BusinessActVO> entList = this.businessActService.getAllEntities(); // 거래처 목록 가져오기
	    model.addAttribute("entList", entList);
	    return "business/busAct"; // JSP 페이지 반환
	}

}
