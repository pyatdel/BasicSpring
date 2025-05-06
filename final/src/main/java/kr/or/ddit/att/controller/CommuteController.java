package kr.or.ddit.att.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import jakarta.servlet.http.HttpSession;
import kr.or.ddit.att.service.AttManagerService;
import kr.or.ddit.att.vo.AttManagerVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.security.CustomUserDetails;
import kr.or.ddit.util.ArticlePage;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/att")
@Controller
public class CommuteController {
	
	@Autowired
	AttManagerService attManagerService;
	
	@GetMapping("/commuteList")
	public String commuteList(Model model, AttManagerVO attManagerVO, 
			@RequestParam(value="currentPage",required=false,defaultValue="1")int currentPage,
			@RequestParam(value= "keyword",required=false,defaultValue = "") String keyword) {
		
		//UserDetailServiceImpl->CustomUser
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		CustomUser userDetails = (CustomUser)principal; 
		log.info("commuteList->userDetails : " + userDetails.getMember());
		MemberVO memberVO = userDetails.getMember();
		int empNo = memberVO.getEmpNo();
		log.info("commuteList->memberVO : " + memberVO);
		log.info("empNo :" + empNo);
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("empNo",empNo);
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		
		log.info("list->map: {}" ,map);
		
		List<AttManagerVO> AttManagerVOList = this.attManagerService.commuteList(map);
		log.info("list->AttManagerVOList :{}",AttManagerVOList);
		
		for(AttManagerVO vo : AttManagerVOList) {
			String perceptionText = vo.getPerceptionText();
			if("정상 출근".equals(perceptionText)) {
				vo.setDotClass("green-dot");
			}else if (perceptionText != null) {
				vo.setDotClass("red-dot");
			}else {
				vo.setDotClass("default-dot");
			}
		}
		
		int total = this.attManagerService.getTotal(map);
		
		// 페이지 객체 생성
		ArticlePage<AttManagerVO> articlePage = 
				new ArticlePage(total, currentPage, 10, AttManagerVOList,keyword);
		
		model.addAttribute("AttManagerVOList",AttManagerVOList);
		model.addAttribute("articlePage",articlePage);
		
		
		return "att/commuteList";
	}
	

	@ResponseBody
	@PostMapping("/commuteListAjax")
	public ArticlePage<AttManagerVO> commuteListAjax(@RequestBody Map<String, Object> map) {
		
		//UserDetailServiceImpl->CustomUser
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		CustomUser userDetails = (CustomUser)principal; 
		log.info("commuteList->userDetails : " + userDetails.getMember());
		MemberVO memberVO = userDetails.getMember();
		int empNo = memberVO.getEmpNo();
		log.info("commuteList->memberVO : " + memberVO);
		log.info("empNo :" + empNo);
				
				
		map.put("empNo",empNo);
		log.debug("list -> map: {}", map);
		
		List<AttManagerVO> AttManagerVOList = this.attManagerService.commuteList(map);
		log.debug("list->AttManagerVOList : {}" ,AttManagerVOList);
		
		for(AttManagerVO vo : AttManagerVOList) {
			String perception = vo.getPerception();
			if("정상 출근".equals(perception)) {
				vo.setDotClass("green-dot");
			}else if (perception != null) {
				vo.setDotClass("red-dot");
			}else {
				vo.setDotClass("default-dot");
			}
		}
		
		// total, currentPage, size, content, keword
		int total = this.attManagerService.getTotal(map);
		
		// 1. currentPage
		int currentPage = 1;
		if(map.get("currentPage") != null) {
			
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		}
		// 2. keyword
		String keyword = "";
		// map.get("keyword") -> null
		//		null.toString() -> 오류발생
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		ArticlePage<AttManagerVO> articlePage = 
				new ArticlePage<AttManagerVO>(total, currentPage, 10, AttManagerVOList, keyword,"ajax");
		
		return articlePage;
	}
//	
//	@DeleteMapping("/blankDelete")
//	public String BlankDelete() {
//		return "";
//	}
	
	

}
