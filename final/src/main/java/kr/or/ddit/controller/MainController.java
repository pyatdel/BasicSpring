package kr.or.ddit.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.board.service.iBoardService;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.cash.service.CashService;
import kr.or.ddit.cash.vo.SaleVO;
import kr.or.ddit.member.service.MemberService;
import kr.or.ddit.member.vo.MemberVO; // 올바른 VO 클래스 경로를 확인하세요.
import kr.or.ddit.sign.service.SignService;
import kr.or.ddit.sign.vo.SignVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping
@Controller
@Slf4j
public class MainController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	SignService signService;
	
	@Autowired
	private CashService cashService;
	
	@Autowired
    private iBoardService boardService;
	
	
	@GetMapping("/main")
	public String signHome(SignVO signVO,Model model,
			Principal principal){
		
			//로그인 아이디
			String reappEmpId = principal.getName();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("reappEmpId", reappEmpId);
			log.info("list->map:" + map);
			
			//대기
			List<SignVO> signVOList = this.signService.signListMain(map);
			
			model.addAttribute("signVOList",signVOList);
			
			// 공지사항 목록 가져오기
	        Map<String, Object> noticeMap = new HashMap<String, Object>();
	        noticeMap.put("currentPage", 1);
	        noticeMap.put("bodType", "1");  
	        List<BoardVO> noticeList = this.boardService.list(noticeMap);
	        
	        noticeList = noticeList.subList(0, Math.min(3, noticeList.size()));
	        model.addAttribute("noticeList", noticeList);
			
			//월 평균 매출액
			List<SaleVO> monthAvg = this.cashService.monthAvg();
			
			//누적 매출액
			List<SaleVO> totalSale = this.cashService.totalSale();
			
			//목표
			List<SaleVO> goalSale = this.cashService.goalSale();
			
			//계약 체결수
			List<SaleVO> confirmedSale = this.cashService.confirmedSale();
			
			//계약 체결률
			List<SaleVO> confirmedSalePer = this.cashService.confirmedSalePer();
			
			//객단가
			List<SaleVO> entSale = this.cashService.entSale();
			
			model.addAttribute("noticeList", noticeList);
			model.addAttribute("monthAvg", monthAvg);
			model.addAttribute("totalSale", totalSale);
			model.addAttribute("goalSale", goalSale);
			model.addAttribute("confirmedSale", confirmedSale);
			model.addAttribute("confirmedSalePer", confirmedSalePer);
			model.addAttribute("entSale", entSale);
			
			

		return "main";
	}
	
	@GetMapping("/adminmain")
	public String adminmain(Model model, MemberVO memberVO, Principal principal){
		
		//로그인 아이디
		String reappEmpId = principal.getName();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reappEmpId", reappEmpId);
		log.info("list->map:" + map);
		
		//대기
		List<SignVO> signVOList = this.signService.signListMain(map);
		
		model.addAttribute("signVOList",signVOList);
		
		// 공지사항 목록 가져오기
        Map<String, Object> noticeMap = new HashMap<String, Object>();
        noticeMap.put("currentPage", 1);
        noticeMap.put("bodType", "1");  
        List<BoardVO> noticeList = this.boardService.list(noticeMap);
        
        noticeList = noticeList.subList(0, Math.min(3, noticeList.size()));
        model.addAttribute("noticeList", noticeList);
		
		//월 평균 매출액
		List<SaleVO> monthAvg = this.cashService.monthAvg();
		
		//누적 매출액
		List<SaleVO> totalSale = this.cashService.totalSale();
		
		//목표
		List<SaleVO> goalSale = this.cashService.goalSale();
		
		//계약 체결수
		List<SaleVO> confirmedSale = this.cashService.confirmedSale();
		
		//계약 체결률
		List<SaleVO> confirmedSalePer = this.cashService.confirmedSalePer();
		
		//객단가
		List<SaleVO> entSale = this.cashService.entSale();
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("monthAvg", monthAvg);
		model.addAttribute("totalSale", totalSale);
		model.addAttribute("goalSale", goalSale);
		model.addAttribute("confirmedSale", confirmedSale);
		model.addAttribute("confirmedSalePer", confirmedSalePer);
		model.addAttribute("entSale", entSale);
		return "adminmain";
	}
	
//	@GetMapping("/main/cashPercent") 
//	public String getCashPercentData(Model model) {
//	
//		//월 평균 매출액
//		List<SaleVO> monthAvg = this.cashService.monthAvg();
//		
//		//누적 매출액
//		List<SaleVO> totalSale = this.cashService.totalSale();
//		
//		//목표
//		List<SaleVO> goalSale = this.cashService.goalSale();
//		
//		//계약 체결수
//		List<SaleVO> confirmedSale = this.cashService.confirmedSale();
//		
//		//계약 체결률
//		List<SaleVO> confirmedSalePer = this.cashService.confirmedSalePer();
//		
//		//객단가
//		List<SaleVO> entSale = this.cashService.entSale();
//		
//		
//		model.addAttribute("monthAvg", monthAvg);
//		model.addAttribute("totalSale", totalSale);
//		model.addAttribute("goalSale", goalSale);
//		model.addAttribute("confirmedSale", confirmedSale);
//		model.addAttribute("confirmedSalePer", confirmedSalePer);
//		model.addAttribute("entSale", entSale);
//		
//	
//		return "main";
//	}
	
}
