package kr.or.ddit.business.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.business.service.BusinessChanceService;
import kr.or.ddit.business.vo.BusinessChanceVO;
import kr.or.ddit.cash.vo.SaleVO;
import kr.or.ddit.util.ArticlePage;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/business")
@Controller
@Slf4j
public class BusinessChanceController {
	
	@Autowired
	BusinessChanceService businessChanceService;
	
	@GetMapping("/busChance")
	public String list (@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
	        			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
	        			@RequestParam(value = "contractNo", required = false, defaultValue = "0") Long contractNo,
	        			Model model) {
		
		Map<String, Object> map = new HashMap<>();
	    map.put("currentPage", currentPage);
	    map.put("keyword", keyword);

	    List<BusinessChanceVO> busChanceVOList = this.businessChanceService.list(map);
	    int total = this.businessChanceService.getTotal(map);
	    

	    ArticlePage<BusinessChanceVO> articlePage = 
	            new ArticlePage<>(total, currentPage, 10, busChanceVOList, keyword);

	    model.addAttribute("busChanceVOList", busChanceVOList);
	    model.addAttribute("articlePage", articlePage);
	    log.info("busChanceVOList -> total :", total);
	    
//	    //영업기회 성공률
//	    List<BusinessChanceVO> successRateVOList = this.businessChanceService.successRate(contractNo);
//	    model.addAttribute("successRateVOList",successRateVOList);
//	    log.info("successRateVOList : ", successRateVOList);
	    
	    
	    List<BusinessChanceVO> stateList = this.businessChanceService.stateList();
	    model.addAttribute("stateList",stateList);
	    
	    
		return "business/busChance";
		
	}
	
}
