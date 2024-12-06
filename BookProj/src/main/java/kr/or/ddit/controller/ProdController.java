package kr.or.ddit.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.service.BuyerService;
import kr.or.ddit.service.LprodService;
import kr.or.ddit.service.ProdService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.BuyerVO;
import kr.or.ddit.vo.LprodVO;
import kr.or.ddit.vo.ProdVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/prod")
public class ProdController {
	
	@Autowired
	ProdService prodService;
	
	@Autowired
	LprodService lprodService;
	
	@Autowired
	BuyerService buyerService;
	
	// 상품 목록
	@GetMapping("/list")
	public String list(
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		
		List<ProdVO> prodVOList = this.prodService.list(map);
		log.info("list -> prodVOList : " + prodVOList);
		
		int total = this.prodService.getTotal(map);
		ArticlePage<ProdVO> articlePage = 
				new ArticlePage<ProdVO>(total, currentPage, 10, prodVOList, keyword);
		
		model.addAttribute("prodVOList", prodVOList);
		model.addAttribute("articlePage", articlePage);
		
		return "prod/list";
	}
	
	// 상품 상세
	@GetMapping("/detail")
	public String detail(ProdVO prodVO, Model model) {
		
		prodVO = this.prodService.detail(prodVO);
		log.info("detail -> prodVO : {}", prodVO);
		
		// 상품분류 목록 추가
	    List<LprodVO> lprodVOList = this.lprodService.listAll();
	    log.info("detail -> lprodVOList : " + lprodVOList);
	    
	    // 거래처 목록 추가
	    List<BuyerVO> buyerVOList = this.buyerService.getBuyerList();
	    log.info("detail -> buyerVOList : {}", buyerVOList);
	    
	    model.addAttribute("prodVO", prodVO);
	    model.addAttribute("lprodVOList", lprodVOList);
	    model.addAttribute("buyerVOList", buyerVOList);
		
		return "prod/detail";
		
	}
	
	// 상품 등록 페이지
	@GetMapping("/create")
	public String create(Model model) {
		
		// !!!상품분류코드를 위함!!!
		List<LprodVO> lprodVOList = this.lprodService.listAll();
		log.info("create -> lprodVOList : " + lprodVOList);
		
		// !!!거래처 목록!!!
		List<BuyerVO> buyerVOList = this.buyerService.getBuyerList();
		log.info("detail -> buyerVOList : {}", buyerVOList);
		
		model.addAttribute("lprodVOList", lprodVOList);
		model.addAttribute("buyerVOList", buyerVOList);
		return "prod/create";
	}
	
	// 상품 등록
	@PostMapping("/createPost")
	public String createPost(ProdVO prodVO) {
		log.info("createPost->prodVO : " + prodVO);
		
		int result = this.prodService.createPost(prodVO);
		log.info("result : ", result);
		
		return "redirect:/prod/detail?prodId="+prodVO.getProdId();
		
	}
	
	
	@RequestMapping(value="/updatePost",method=RequestMethod.POST)
	public String updatePost(ProdVO prodVO) {
		log.info("updatePost->prodVO : " + prodVO);
		
		//상품분류 수정
		int result = this.prodService.updatePost(prodVO);
		log.info("updatePost->result : " + result);
		
		//3) 확인 버튼 클릭 시 submit 되어 update 처리 후 
		//		/prod/detail?lprodId=10 로 redirect
		return "redirect:/prod/detail?prodId="+prodVO.getProdId();
	}
	
	
	/*
	@RequestMapping(value="/deletePost",method=RequestMethod.POST)
	public String deletePost(@RequestParam("prodId") String prodId) {
		
		return "redirect:/prod/list";
	}

*/
	@RequestMapping(value="/deletePost",method=RequestMethod.POST)
	public String deletePost(ProdVO prodVO) {
		log.info("deletePost->lprodVO : " + prodVO);
		
		int result = this.prodService.deletePost(prodVO);
		log.info("deletePost->result : " + result);
		
		//LprodController의 deletePost 메소드에서
		// 삭제처리 완료 후 /lprod/list로 redirect 함
		return "redirect:/prod/list";
	}
}
