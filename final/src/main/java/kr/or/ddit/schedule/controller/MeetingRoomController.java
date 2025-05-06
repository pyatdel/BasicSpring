package kr.or.ddit.schedule.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.schedule.service.MeetingRoomService;
import kr.or.ddit.schedule.vo.MeetingRoomVO;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.util.ArticlePage;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/schedule")
@Controller
public class MeetingRoomController {
	
	@Autowired
	MeetingRoomService meetingRoomService;
	
	@GetMapping("/meetingRoomList")
	public String meetingRoomList(Model model, MeetingRoomVO meetingRoomVO, 
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
		
		List<MeetingRoomVO> MeetingRoomVOList = this.meetingRoomService.meetRoomList(map);
		log.info("list->MeetingRoomVOList :{}",MeetingRoomVOList);
		
		
		int total = this.meetingRoomService.getTotal(map);
		
		// 페이지 객체 생성
		ArticlePage<MeetingRoomVO> articlePage = 
				new ArticlePage(total, currentPage, 10, MeetingRoomVOList,keyword);
		
		model.addAttribute("MeetingRoomVOList",MeetingRoomVOList);
		model.addAttribute("articlePage",articlePage);
		
		
		return "schedule/meetingRoomList";
	}
	

	@ResponseBody
	@PostMapping("/meetingRoomListAjax")
	public ArticlePage<MeetingRoomVO> meetingRoomListAjax(@RequestBody Map<String, Object> map) {
		
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
		
		List<MeetingRoomVO> MeetingRoomVOList = this.meetingRoomService.meetRoomList(map);
		log.debug("list->MeetingRoomVOList : {}" ,MeetingRoomVOList);
		
		
		// total, currentPage, size, content, keword
		int total = this.meetingRoomService.getTotal(map);
		
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
		
		ArticlePage<MeetingRoomVO> articlePage = 
				new ArticlePage<MeetingRoomVO>(total, currentPage, 10, MeetingRoomVOList, keyword,"ajax");
		
		return articlePage;
	}
	
//    @PostMapping("/meetingRoomReserve")
//    public ResponseEntity<String> reserveMeetingRoom(@RequestBody MeetingRoomVO meetingRoomVo) {
//        boolean success = meetingRoomService.reserveMeetingRoom(meetingRoomVo);
//        if (success) {
//            return ResponseEntity.ok("예약 성공");
//        } else {
//            re-turn ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("예약 실패");
//        }
//    }
//	

}
