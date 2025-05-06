package kr.or.ddit.att.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.att.service.AnnualService;
import kr.or.ddit.att.vo.AnnualListVO;
import kr.or.ddit.att.vo.AttendanceCodeVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.util.ArticlePage;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/manageratt")
@Controller
public class ManagerAnnualListController {
	
	@Autowired
	AnnualService annualService;
	
	@GetMapping("/managerAnnualList")
	public String annualListGet(Model model, AnnualListVO annualListVO,
			@RequestParam(value="currentPage",required=false, defaultValue ="1") int currentPage,
			@RequestParam(value="keyword",required=false, defaultValue="") String keyword){
		
		//UserDetailServiceImpl->CustomUser
				Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
				CustomUser userDetails = (CustomUser)principal; 
				log.info("commuteList->userDetails : " + userDetails.getMember());
				MemberVO memberVO = userDetails.getMember();
				int empNo = memberVO.getEmpNo();
				int deptNo = memberVO.getDeptNo();
				log.info("commuteList->memberVO : " + memberVO);
				log.info("empNo :" + empNo);
				
		Map<String, Object>map = new HashMap<String, Object>();
		map.put("dept",deptNo);
		map.put("empNo", empNo);
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		
		log.info("list -> map:{}" ,map);
		
		List<AnnualListVO> AnnualVOList = this.annualService.getListAll(map);
		log.info("list => AnnualVOList: {}", AnnualVOList);
		
		int total = this.annualService.getAllTotal(map);
		
		ArticlePage<AnnualListVO> articlePage = 
				new ArticlePage(total, currentPage, 10, AnnualVOList, keyword);
		model.addAttribute("AnnualVOList",AnnualVOList);
		model.addAttribute("articlePage",articlePage);
		
		return "manageratt/managerAnnualList";
	}
	
	@ResponseBody
	@PostMapping("/managerAnnualList")
	public ArticlePage<AnnualListVO> documentAttList(@RequestBody Map<String, Object> map) {
		
		//UserDetailServiceImpl->CustomUser
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		CustomUser userDetails = (CustomUser)principal; 
		log.info("commuteList->userDetails : " + userDetails.getMember());
		MemberVO memberVO = userDetails.getMember();
		int empNo = memberVO.getEmpNo();
		int deptNo = memberVO.getDeptNo();
		log.info("commuteList->memberVO : " + memberVO);
		log.info("empNo :" + empNo);
		
		map.put("deptNo", deptNo);
		map.put("empNo",empNo);
		log.debug("list -> map: {}", map);
		
		List<AnnualListVO> AnnualVOList  = this.annualService.getListAll(map);
		log.debug("list->AnnualVOList : {}" ,AnnualVOList);
		
		// total, currentPage, size, content, keword
		int total = this.annualService.getAllTotal(map);
		
		// 1. currentPage
		int currentPage = 1;
		if(map.get("currentPage") != null) {
			// map.get("currentPage") -> null
			//			null.toString() -> 오류발생
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		}
		// 2. keyword
		String keyword = "";
		// map.get("keyword") -> null
		//		null.toString() -> 오류발생
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		ArticlePage<AnnualListVO> articlePage = 
				new ArticlePage<AnnualListVO>(total, currentPage, 10, AnnualVOList , keyword,"ajax");
		
		log.info("articlePage {}",articlePage);
		
		return articlePage;
	}
	
//	@GetMapping("/attendanceCode1")
//	public String getAttendanceCode1(Model model) {
//		
//		List<AttendanceCodeVO> attendanceCodeList = annualService.getAttendanceCode();
//		model.addAttribute("attendanceCodeList",attendanceCodeList);
//		return "att/annualList";
//	}
	
	@ResponseBody
	@GetMapping("/managerAttendanceCode")
	public List<AttendanceCodeVO> getAttendanceCode() {
		return annualService.getAttendanceCode(); 
	}
//	
//	@GetMapping("/blankDetail")
//	public String BlankDetail() {
//		return "";
//	}
//	
	@PostMapping("/managerAnnualSignUp")
	public ResponseEntity<Integer> AnnualSignUp(@RequestBody AnnualListVO annualSingUp) {
		
		int result = annualService.annualSignUp(annualSingUp);
		
		if(result > 0) {
			log.info("휴가신청 성공");
		}else {
			log.info("휴가신청 실패");
		}
		log.info("휴가신청: {}",result);
		return ResponseEntity.ok(result);
	}
	
	@ResponseBody
	@GetMapping("/getManagerEmpAnnual")
	public Map<String, Object> getEmpAnnual() {
		
		//UserDetailServiceImpl->CustomUser
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		CustomUser userDetails = (CustomUser)principal; 
		log.info("commuteList->userDetails : " + userDetails.getMember());
		MemberVO memberVO = userDetails.getMember();
		int empNo = memberVO.getEmpNo();
		log.info("commuteList->memberVO :  {}", memberVO);
		log.info("empNo : {}", empNo);
		
		// empAnnual 값 가져오기
		int getEmpAnnual = annualService.getEmpAnnual(empNo);
		log.info("getEmpAnnual: {} ",getEmpAnnual);
		
		// JSON 으로 반환할 데이터 준비
		Map<String, Object> response = new HashMap<>();
		response.put("empAnnual", getEmpAnnual);
		
		return response;
		
	}
	
	@ResponseBody
	@PutMapping("/updateAppStatus")
	public int updateAppStatusAndAnnCnt(@RequestBody Map<String,Object> requestData) {
		int appStatus = (Integer)requestData.get("appStatus");
		List<Map<String,Integer>> empList = (List<Map<String,Integer>>) requestData.get("empList");
		
		// empNo 와 annNo를 분리하여 리스트로 저장
		List<Integer> empNoList = new ArrayList<>();
		List<Integer> annNoList = new ArrayList<>();
		
		for(Map<String,Integer> empData : empList) {
			empNoList.add(empData.get("empNo"));
			annNoList.add(empData.get("annNo"));
		}
		
		int updateCount = annualService.updateAppStatus(empList,empNoList, annNoList, appStatus);
		
		log.info("updateCount : {}",updateCount);
		return updateCount;
	}
	
	
	@GetMapping("/managerAnnualComplete")
	public String GetManagerAnnualCompleteList(Model model, AnnualListVO annualListVO,
			@RequestParam(value="currentPage",required=false, defaultValue ="1") int currentPage,
			@RequestParam(value="keyword",required=false, defaultValue="") String keyword){
		
		//UserDetailServiceImpl->CustomUser
				Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
				CustomUser userDetails = (CustomUser)principal; 
				log.info("commuteList->userDetails : " + userDetails.getMember());
				MemberVO memberVO = userDetails.getMember();
				int empNo = memberVO.getEmpNo();
				int deptNo = memberVO.getDeptNo();
				log.info("commuteList->memberVO : " + memberVO);
				log.info("empNo :" + empNo);
				
		Map<String, Object>map = new HashMap<String, Object>();
		map.put("dept",deptNo);
		map.put("empNo", empNo);
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		
		log.info("list -> map:{}" ,map);
		
		List<AnnualListVO> AnnualVOList = this.annualService.getListComplete(map);
		log.info("list => AnnualVOList: {}", AnnualVOList);
		
		int total = this.annualService.getAllTotal(map);
		
		ArticlePage<AnnualListVO> articlePage = 
				new ArticlePage(total, currentPage, 10, AnnualVOList, keyword);
		model.addAttribute("AnnualVOList",AnnualVOList);
		model.addAttribute("articlePage",articlePage);
		
		return "manageratt/managerAnnualComplete";
	}
	
	
	@ResponseBody
	@PostMapping("/managerAnnualComplete")
	public ArticlePage<AnnualListVO> managerAnnualComplete (@RequestBody Map<String, Object> map) {
		//UserDetailServiceImpl->CustomUser
				Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
				CustomUser userDetails = (CustomUser)principal; 
				log.info("commuteList->userDetails : " + userDetails.getMember());
				MemberVO memberVO = userDetails.getMember();
				int empNo = memberVO.getEmpNo();
				int deptNo = memberVO.getDeptNo();
				log.info("commuteList->memberVO : " + memberVO);
				log.info("empNo :" + empNo);
				
				map.put("deptNo", deptNo);
				map.put("empNo",empNo);
				log.debug("list -> map: {}", map);
				
				List<AnnualListVO> AnnualVOList  = this.annualService.getListComplete(map);
				log.debug("list->AnnualVOList : {}" ,AnnualVOList);
				
				// total, currentPage, size, content, keword
				int total = this.annualService.getAllTotal(map);
				
				// 1. currentPage
				int currentPage = 1;
				if(map.get("currentPage") != null) {
					// map.get("currentPage") -> null
					//			null.toString() -> 오류발생
					currentPage = Integer.parseInt(map.get("currentPage").toString());
				}
				// 2. keyword
				String keyword = "";
				// map.get("keyword") -> null
				//		null.toString() -> 오류발생
				if(map.get("keyword") != null) {
					keyword = map.get("keyword").toString();
				}
				
				ArticlePage<AnnualListVO> articlePage = 
						new ArticlePage<AnnualListVO>(total, currentPage, 10, AnnualVOList , keyword,"ajax");
				
				log.info("articlePage {}",articlePage);
				
				return articlePage;
	}
	

}
