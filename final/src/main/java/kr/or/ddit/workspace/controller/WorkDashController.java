package kr.or.ddit.workspace.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.contract.vo.ContViewVO;
import kr.or.ddit.contract.vo.ContractMasterVO;
import kr.or.ddit.contract.vo.EnterPriceVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.workspace.service.WorkSpaceService;
import kr.or.ddit.workspace.vo.FileStorageVO;
import kr.or.ddit.workspace.vo.WorkSpaceVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@RequestMapping("/work")
@Controller
public class WorkDashController {

	@Autowired
	WorkSpaceService workSpaceService;
	
	
	@GetMapping("/workDash")
	public String workDashboard() {
		return "workspace/work";
		
	}
	
	@ResponseBody
	@PostMapping("/createWork")
	public int createWork(@RequestBody WorkSpaceVO workSpaceVO) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		CustomUser userDetails = (CustomUser)principal; 
		log.info("commuteList->userDetails : " + userDetails.getMember());
		
		MemberVO memberVO = userDetails.getMember();
		int empNo = memberVO.getEmpNo();
		
		
		workSpaceVO.setEmpNo(empNo);
		int result = this.workSpaceService.createWork(workSpaceVO);
		
		log.debug("workSpaceVO {} "+workSpaceVO);		
		
		return result;
		
		
		
	}
	@ResponseBody
	@PostMapping("/workDetail")
	public WorkSpaceVO workDetail(@RequestBody WorkSpaceVO workSpaceVO) {
		
		workSpaceVO = this.workSpaceService.workDetail(workSpaceVO);
		
		log.info("workSpaceVO  => detail :"+workSpaceVO);
		
		return workSpaceVO;
		
		
	}
	
	
	
	@ResponseBody
	@PostMapping("/proj")
	public ArticlePage<WorkSpaceVO> projectDash(@RequestBody  Map<String,Object>map ) {
		WorkSpaceVO workSpaceVO = new WorkSpaceVO();
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		CustomUser userDetails = (CustomUser)principal; 
		log.info("commuteList->userDetails : " + userDetails.getMember());
		
		MemberVO memberVO = userDetails.getMember();
		int empNo = memberVO.getEmpNo();
		int deptNo  = memberVO.getDeptNo();
		
		int projNo = 0;
		if (map.get("projNo") != null) {
		    projNo = Integer.parseInt(map.get("projNo").toString());
		}

		
		// 1) currentPage
		int currentPage = 1; // 1페이지로 잡아놓기
		if (map.get("currentPage") != null) {
			// null .toString() 은 오류 발생
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		}

		// 2) keyword
		String keyword = ""; // 검색어가 없는 것이 기본

		if (map.get("keyword") != null) {
			// null . toString() 은 오류 발생
			keyword = map.get("keyword").toString();
		}
		int total = this.workSpaceService.getTotal(map);
		
		
	    map.put("currentPage", currentPage);
	    map.put("keyword", keyword);
	    map.put("deptNo", deptNo);
	    map.put("empNo", empNo);
	    map.put("proj_no", projNo);

	    log.debug("map {} 체킁" + map);
	    
		List<WorkSpaceVO>workVOList = this.workSpaceService.myWorklist(map);
		
		
		ArticlePage<WorkSpaceVO> articlePage = new ArticlePage<WorkSpaceVO>(total, currentPage, 10, workVOList, keyword,"ajax");
		//log.debug("fileVOList {} "+fileVOList);

		
		
		// 데이터 리턴 -> ResponseBody(Object -> String ) = Serialize
		return articlePage;
	}
	@GetMapping("/projWorkspace")
	public String proList( Model model, Map<String,Object>map) {
		WorkSpaceVO workSpaceVO = new WorkSpaceVO();
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		CustomUser userDetails = (CustomUser)principal; 
		log.info("commuteList->userDetails : " + userDetails.getMember());
		
		MemberVO memberVO = userDetails.getMember();
		int deptNo  = memberVO.getDeptNo();
		
		int projNo = 0;
	    workSpaceVO.setDeptNo(deptNo);
	    map.put("deptNo",deptNo);
		List<WorkSpaceVO>projVOList = this.workSpaceService.projList(map); 
		
		model.addAttribute("projVOList",projVOList);
		log.debug("프로젝트 리스트 체킁 {}" + projVOList );
		// 데이터 리턴 -> ResponseBody(Object -> String ) = Serialize
		return "workspace/projWorkspace";
		
	}
	@ResponseBody
	@PostMapping("/deptList")
	public ArticlePage<WorkSpaceVO> deptList(@RequestBody  Map<String,Object>map ) {
		 WorkSpaceVO workSpaceVO = new WorkSpaceVO();
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		CustomUser userDetails = (CustomUser)principal; 
		log.info("commuteList->userDetails : " + userDetails.getMember());
		
		MemberVO memberVO = userDetails.getMember();
		int empNo = memberVO.getEmpNo();
		int deptNo  = memberVO.getDeptNo();
		
		log.info("뎁트넘버 체킁" + deptNo);

		int projNo = 0;
		if (map.get("projNo") != null) {
		    projNo = Integer.parseInt(map.get("projNo").toString());
		}

		// 1) currentPage
		int currentPage = 1; // 1페이지로 잡아놓기
		if (map.get("currentPage") != null) {
			// null .toString() 은 오류 발생
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		}

		// 2) keyword
		String keyword = ""; // 검색어가 없는 것이 기본

		if (map.get("keyword") != null) {
			// null . toString() 은 오류 발생
			keyword = map.get("keyword").toString();
		}
		
		
	    map.put("currentPage", currentPage);
	    map.put("keyword", keyword);
	    map.put("deptNo", deptNo);
	    map.put("empNo", empNo);
	    map.put("projNo", projNo);
	    
	    log.debug("map {} 체킁" + map);
	    int total = this.workSpaceService.deptGetTotal(map);
	    log.debug("토탈 {} 체킁" + total);
		List<WorkSpaceVO>deptworkVOList = this.workSpaceService.deptWorklist(map);
		ArticlePage<WorkSpaceVO> articlePage = new ArticlePage<WorkSpaceVO>(total, currentPage, 3, deptworkVOList, keyword,"ajax");
		//log.debug("fileVOList {} "+fileVOList);
		log.debug("부서 리스트  {} 체킁" + deptworkVOList);

		log.debug("프로젝트넘버 {} 체킁" + projNo);
		
		
		// 데이터 리턴 -> ResponseBody(Object -> String ) = Serialize
		return articlePage;
	}
	@ResponseBody
	@GetMapping("/projTotal") 
	public WorkSpaceVO projTotal() {
		WorkSpaceVO workSpaceVO = new WorkSpaceVO();
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		CustomUser userDetails = (CustomUser)principal; 
		log.info("commuteList->userDetails : " + userDetails.getMember());
		
		MemberVO memberVO = userDetails.getMember();
		int empNo = memberVO.getEmpNo();
		int deptNo  = memberVO.getDeptNo();
		
		log.info("체킁" + deptNo);
		
		return this.workSpaceService.projTotal(deptNo);
		
		
		
	}
}
