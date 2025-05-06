package kr.or.ddit.websocketalarm.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.att.vo.AttManagerVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.websocketalarm.service.AlarmService;
import kr.or.ddit.websocketalarm.vo.AlarmVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AlarmController {
	
	@Autowired
	AlarmService alarmService;
	
//	@Autowired
//	private SampleWebSocketHandler webSocketHandler;
		
	@ResponseBody	
	@PostMapping("/alarmInsert")
    public int saveAlarm(AlarmVO alarm) {
		
		//UserDetailServiceImpl->CustomUser
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		CustomUser userDetails = (CustomUser)principal; 
		log.info("commuteList->userDetails : " + userDetails.getMember());
		MemberVO memberVO = userDetails.getMember();
		int empNo = memberVO.getEmpNo();
		String empName = memberVO.getEmpName();
		log.info("commuteList->memberVO : " + memberVO);
		log.info("empNo :" + empNo);
		
		alarm.setEmpNo(empNo);
		alarm.setEmpName(empName);
		
		int result = alarmService.saveAlarm(alarm);
		
		return result;
    	
    }
	
	@ResponseBody
	@GetMapping("/alarm")
	public String alarmPage(@RequestParam int empNo) {
		
		//UserDetailServiceImpl->CustomUser
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		CustomUser userDetails = (CustomUser)principal; 
		log.info("commuteList->userDetails : " + userDetails.getMember());
		MemberVO memberVO = userDetails.getMember();
		empNo = memberVO.getEmpNo();
		log.info("commuteList->memberVO : " + memberVO);
		log.info("empNo :" + empNo);
		
		return "alarm";
	}
	
	@GetMapping("/alarmList")
	public String alarmList(Model model, AlarmVO alarmVo, 
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
		
		List<AlarmVO> AlarmVoList = this.alarmService.alarmList(map);
		log.info("list->AttManagerVOList :{}",AlarmVoList);
		
		
		int total = this.alarmService.getTotal(map);
		
		// 페이지 객체 생성
		ArticlePage<AlarmVO> articlePage = 
				new ArticlePage(total, currentPage, 10, AlarmVoList,keyword);
		
		model.addAttribute("AttManagerVOList",AlarmVoList);
		model.addAttribute("articlePage",articlePage);
		
		
		return "alarmList";
	}
	

	@ResponseBody
	@PostMapping("/alarmListAjax")
	public ArticlePage<AlarmVO> alarmListAjax(@RequestBody Map<String, Object> map) {
		
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
		
		
		List<AlarmVO> AlarmVoList = this.alarmService.alarmList(map);
		log.debug("list->AlarmVoList : {}" ,AlarmVoList);
		
		
		
		
		// total, currentPage, size, content, keword
		int total = alarmService.getTotal(map);
		
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
		
		ArticlePage<AlarmVO> articlePage = 
				new ArticlePage<AlarmVO>(total, currentPage, 10, AlarmVoList, keyword,"ajax");
		
		return articlePage;
	}

}
