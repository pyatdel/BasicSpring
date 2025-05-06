package kr.or.ddit.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.BuyerService;
import kr.or.ddit.service.LprodService;
import kr.or.ddit.service.ProdService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.BuyerVO;
import kr.or.ddit.vo.LprodVO;
import kr.or.ddit.vo.ProdVO;
import lombok.extern.slf4j.Slf4j;

@PreAuthorize("hasAnyRole('ROLE_USER','ROLE_ALBA')")
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
	
	//1. 공지사항 등록 - 로그인 한 관리자만 접근 가능
	//골뱅이PreAuthorize("hasRole('ROLE_ADMIN')")
	//골뱅이PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_MEMBER')")
	//2. 공지사항 등록 - 로그인(인증) 한 관리자 또는 회원(인가)만 접근 가능
	//골뱅이PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")	
	//골뱅이Secured({"ROLE_MEMBER","ROLE_ADMIN"})
	//3. 공지사항 등록 - 로그인(인증) 한 관리자 이면서 회원(인가)만 접근 가능
	//골뱅이PreAuthorize("hasRole('ROLE_ADMIN') and hasRole('ROLE_MEMBER')")
	//4. 로그인한 사용자만 접근 가능(권한과 상관 없음)
	//골뱅이PreAuthorize("isAuthenticated()")
	//5. 로그인 안 한 사용자가 접근 가능 -> 로그인 한 사용자는 접근 불가
	//골뱅이PreAuthorize("isAnonymous()")
	//6. 누구나 접근 가능(PreAuthorize 생략)
	// 상품 목록
	@GetMapping("/list")
	public String list(
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		log.info("list -> map : " + map);
		
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
	
	// 상품 목록 - 비동기
	@ResponseBody
	@PostMapping("/listAjax")
	public ArticlePage<ProdVO> listAjax(@RequestBody Map<String, Object> map) {
		
		log.info("listAjax -> map : " + map);
		
		int total = this.prodService.getTotal(map);
		log.info("listAjax -> total : " + total);
		
		List<ProdVO> prodVOList = this.prodService.list(map);
		log.info("listAjax -> prodVOList : " + prodVOList);
		
		int currentPage = 1;
		
		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		}
		
		String keyword = "";
		
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		ArticlePage<ProdVO> articlePage = new ArticlePage<>(total, currentPage, 10, prodVOList, keyword, "ajax");
		
		return articlePage;
	}
	
	// 상품 상세
	@GetMapping("/detail")
	public String detail(ProdVO prodVO, Model model) {
		
		prodVO = this.prodService.detail(prodVO);
		log.info("detail -> prodVO : {}", prodVO);
		// !!!상품분류코드를 위함!!!
		List<LprodVO> lprodVOList = this.lprodService.listAll();
		log.info("create -> lprodVOList : " + lprodVOList);
		
		// !!!거래처 목록!!!
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
	/*
	// 상품 등록
	@PostMapping("/createPost")
	public String createPost(ProdVO prodVO) {
		log.info("createPost->prodVO : " + prodVO);
		
		int result = this.prodService.createPost(prodVO);
		log.info("result : ", result);
		
		return "redirect:/prod/detail?prodId="+prodVO.getProdId();
	}
	*/
	// 상품 등록 - 비동기
	@ResponseBody
	@PostMapping("/createPostAjax")
	public int createPostAjax(@RequestBody ProdVO prodVO) {
		log.info("createPostAjax->prodVO : " + prodVO);
		
		int result = this.prodService.createPost(prodVO);
		log.info("createPostAjax -> result : " + result);
		
		return result;
	}
	
	// 상품 수정
	@PostMapping("/updatePost")
	public String updatePost(ProdVO prodVO) {
		log.info("updatePost : prodVO : " + prodVO);
		
		int result = this.prodService.updatePost(prodVO);
		log.info("updatePost -> result : " + result);
		
		return "redirect:/prod/detail?prodId="+prodVO.getProdId();
	}
	
	// 상품 수정 - 비동기
	@ResponseBody
	@PutMapping("/updatePostAjax")
	public int updatePostAjax(@RequestBody ProdVO prodVO) {
		// log.info("updatePostAjax -> prodId : " + prodId);
		log.info("updatePostAjax -> prodVO : " + prodVO);
		
		int result = this.prodService.updatePost(prodVO);
		log.info("updatePostAjax -> result : " + result);
		
		return result;
	}

	// 상품 삭제
	@PostMapping("deletePost")
	public String deletePost(ProdVO prodVO) {
		log.info("deletePost -> prodVO : " + prodVO);
		
		int result = this.prodService.deletePost(prodVO);
		log.info("deletePost -> result : " + result);
		
		return "redirect:/prod/list";
		
	}
	
	// 상품 삭제 - 비동기
	@ResponseBody
	@DeleteMapping("deletePostAjax")
	public int deletePostAjax(@RequestBody ProdVO prodVO) {
		log.info("deletePostAjax -> prodVO : " + prodVO);
		
		int result = this.prodService.deletePost(prodVO);
		log.info("deletePostAjax -> result : " + result);
		
		return result;
		
	}
}
