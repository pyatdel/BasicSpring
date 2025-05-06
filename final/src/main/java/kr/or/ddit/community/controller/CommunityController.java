package kr.or.ddit.community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.community.service.iCommunityService;
import kr.or.ddit.community.vo.CommunityReplyVO;
import kr.or.ddit.community.vo.CommunityStateTypeVO;
import kr.or.ddit.community.vo.CommunityTypeVO;
import kr.or.ddit.community.vo.CommunityVO;
import kr.or.ddit.personnel.service.DepartmentService;
import kr.or.ddit.personnel.vo.DepartmentVO;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.util.ArticlePage;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/community")
@Controller
public class CommunityController {
	
	@Autowired
	iCommunityService icommunityService;
	
	@Autowired
    DepartmentService departmentService;
	
	
	
	@GetMapping("/form")
	public String form(Model model, @AuthenticationPrincipal CustomUser user) {
	    // 커뮤니티 타입 목록 조회
	    List<CommunityTypeVO> communityTypeVOList = this.icommunityService.comListAll();
	    log.info("detail -> communityTypeVOList : " + communityTypeVOList);
	    
	    // 커뮤니티 게시글 목록 조회
	    List<CommunityStateTypeVO> communityStateTypeVOList = this.icommunityService.comStateListAll();
	    log.info("detail -> communityStateTypeVOList : " + communityStateTypeVOList);
	    
	    // 부서명 조회 - CustomUser에서 MemberVO를 통해 deptNo 가져오기
	    DepartmentVO departmentVO = departmentService.getDeptName(user.getMember().getDeptNo());
	    log.info("form -> departmentVO : " + departmentVO);
	    
	    model.addAttribute("communityTypeVOList", communityTypeVOList);
	    model.addAttribute("communityStateTypeVOList", communityStateTypeVOList);
	    model.addAttribute("departmentVO", departmentVO);
	    
	    return "community/form";
	}
	
	
	
	
	
	@PostMapping("/insertPost")
	public String insertPost(CommunityVO communityVO) {

		log.info("insertPost->communityVO before : " + communityVO);
	    
	    log.info("insertPost->uploadFile : " + communityVO.getUploadFile());
	    
	    int result = this.icommunityService.insertPost(communityVO);
	    log.info("insertPost->result : " + result);
	    
	    log.info("전달받은 데이터: {}", communityVO);
	    
	    return "redirect:/community/detail/" + communityVO.getComNo();
	}
	
	@GetMapping("/detail/{comNo}")
	public String detail(
	        @PathVariable(value="comNo") int comNo,
	        @RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
	        Model model) {
	    log.info("detail->comNo : " + comNo);
	    
	    Map<String,Object> map = new HashMap<String,Object>();
	    map.put("comNo", comNo);
	    map.put("currentPage", currentPage);
	    log.info("detail->map : " + map);
	    
	    CommunityVO communityVO = new CommunityVO();
	    communityVO.setComNo(comNo);
	    this.icommunityService.updateHit(communityVO);
	        
	    communityVO = this.icommunityService.detail(comNo);
	    log.info("detail->communityVO : " + communityVO);
	    
	    
	    // 댓글 목록
//	    List<CommunityReplyVO> communityReplyVOList = this.icommunityService.selectReply(communityVO);
	    List<CommunityReplyVO> communityReplyVOList = this.icommunityService.reList(map);
	    log.info("detail->communityReplyVOList : " + communityReplyVOList);
	    
	    // 전체 댓글 수 조회
	    int total = this.icommunityService.getReTotal(map);
	    log.info("detail->total : " + total);

	    log.info("댓글 목록: " + communityReplyVOList);
	    
	    model.addAttribute("communityReplyVOList", communityReplyVOList);
	    model.addAttribute("articlePage", 
	            new ArticlePage<CommunityReplyVO>(total, currentPage, 5, communityReplyVOList, ""));
	    
	    
	    model.addAttribute("communityVO", communityVO);
	    
	    return "community/detail";
	}
	
	@ResponseBody
	@PostMapping("/detailAjax")
	public ArticlePage<CommunityReplyVO> detailAjax(@RequestBody Map<String,Object> map) {
		log.info("detailAjax->map : " + map);
	    
	    List<CommunityReplyVO> communityReplyVOList = this.icommunityService.reList(map);
	    log.info("detailAjax->communityReplyVOList : " + communityReplyVOList);
	    
	    int total = this.icommunityService.getReTotal(map);
	    log.info("detailAjax->total : " + total);
	    
	    int currentPage = 1;
	    if(map.get("currentPage") != null) {
	        currentPage = Integer.parseInt(map.get("currentPage").toString());
	    }
	    
	    String keyword = "";
	    if(map.get("keyword") != null) {
	        keyword = map.get("keyword").toString();
	    }
	    
	    ArticlePage<CommunityReplyVO> articlePage = 
	    		new ArticlePage<CommunityReplyVO>(total, currentPage, 5, communityReplyVOList, keyword, "ajax");
	    
	    return articlePage;
	}
	
	@PostMapping("/updatePost")
	public String updatePost(CommunityVO communityVO) {
		log.info("updatePost->communityVO : " + communityVO);
		
		
		int result = this.icommunityService.updatePost(communityVO);
		
		log.info("updatePost->result : " + result);
		
		return "redirect:/community/detail/" + communityVO.getComNo();
	}
	
	
	@PostMapping("/deletePost")
	public String deletePost(CommunityVO communityVO) {
	    log.info("deletePost->communityVO : " + communityVO);
	    
	    // 1. 모든 댓글 삭제
	    // this.icommunityService.deleteAllReply(communityVO.getComNo());  
	    
	    // 2. 게시글 삭제
	    int result = this.icommunityService.deletePost(communityVO);
	    
	    log.info("Post->result : " + result);
	    
	    return "redirect:/community/list";
	}
	
	
	@RequestMapping("/list")
	public String list(
		    @RequestParam(value="keyword", required=false, defaultValue="") String keyword,
		    @RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage,
		    @RequestParam(value="comType", required=false) String comType,  
		    Model model) {
		
		
		log.info("list->keyword : " + keyword);
		log.info("list->currentPage : " + currentPage);
		log.info("list->comType : " + comType);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyword",keyword);
		map.put("currentPage",currentPage);
		
		// comType이 있고 비어있지 않을 때만 map에 추가
		if (comType != null && !comType.isEmpty()) {
	        map.put("comType", comType);
	    }
		
		log.info("list->map : " + map);
		
		int total = this.icommunityService.getTotal(map);
		log.info("list->total : " + total);
		
		List<CommunityVO> communityVOList = this.icommunityService.list(map);
		log.info("list->boardVOList : " + communityVOList);
		
		if(communityVOList != null && !communityVOList.isEmpty()) {
	        log.info("현재 페이지(" + currentPage + ")의 첫 번째 행 COM_NO: " + communityVOList.get(0).getComNo());
	    }
		
		model.addAttribute("communityVOList", communityVOList);
		model.addAttribute("comType", comType);
		model.addAttribute("articlePage", 
				new ArticlePage<CommunityVO>(total, currentPage, 15, communityVOList, keyword));
		return "community/list";
	}
	
	@ResponseBody
	@PostMapping("/listAjax")
	public ArticlePage<CommunityVO> listAjax(@RequestBody Map<String,Object> map) {

		log.info("list->map : " + map);
		
		List<CommunityVO> communityVOList = this.icommunityService.list(map);
		log.info("list->communityVOList : " + communityVOList);
		

		int total = this.icommunityService.getTotal(map);

		log.info("list->total : " + total);
		
		int currentPage = 1;
				
		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		}
		
		String keyword = "";
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();
		}
		
		String bodType = "";
	    if(map.get("comType") != null) {
	        bodType = map.get("comType").toString();
	    }
		
		ArticlePage<CommunityVO> articlePage = 
				new ArticlePage<CommunityVO>(total, currentPage, 15, communityVOList
						, keyword, "ajax");
		
		return articlePage;
	}
	
	@PostMapping("/createReplyPost")
	public String createReplyPost(CommunityReplyVO communityReplyVO, 
	                            @AuthenticationPrincipal CustomUser user) {

	    // 로그인한 사용자의 empNo 설정    
		communityReplyVO.setEmpNo((user.getMember().getEmpNo()));
	    
	    log.info("createReplyPost->communityReplyVO : " + communityReplyVO);
	    
	    //1. COMMUNITY_REPLY 테이블에 insert
	    int result = this.icommunityService.createReplyPost(communityReplyVO);
	    log.info("createReplyPost->communityReplyVO : " + communityReplyVO);
	    
	    //2. 상세 페이지로 redirect
	    return "redirect:/community/detail/" + communityReplyVO.getComNo();
	}
	
	@ResponseBody
	@PostMapping("/createReplyPostAjax")
	public int createReplyPostAjax(@RequestBody CommunityReplyVO communityReplyVO, 
	                              @AuthenticationPrincipal CustomUser user) {  // CustomUser 추가
	    // 로그인한 사용자의 empNo 설정    
	    communityReplyVO.setEmpNo((user.getMember().getEmpNo()));
	    
	    log.info("createReplyPost->communityReplyVO : " + communityReplyVO);
	    
	    int result = this.icommunityService.createReplyPost(communityReplyVO);
	    log.info("createReplyPost->communityReplyVO : " + communityReplyVO);
	    
	    return result;
	}
	
	@PostMapping("/deleteReplyPost")
	public String deleteReplyPost(CommunityReplyVO communityReplyVO) {
	    log.info("deleteReplyPost->communityReplyVO : " + communityReplyVO);
	    
	    int result = this.icommunityService.deleteReplyPost(communityReplyVO);
	    
	    log.info("deleteReplyPost->result : " + result);
	    
	    return "redirect:/community/detail/" + communityReplyVO.getComNo();
	}

	@ResponseBody
	@PostMapping("/updateReplyPostAjax")
	public int updateReplyPostAjax(@RequestBody CommunityReplyVO communityReplyVO, 
	                                @AuthenticationPrincipal CustomUser user) {
	    // 수정하는 사용자의 사번 설정
	    communityReplyVO.setEmpNo(user.getMember().getEmpNo());
	    
	    log.info("updateReplyPostAjax->communityReplyVO : " + communityReplyVO);
	    
	    int result = this.icommunityService.updateReplyPostAjax(communityReplyVO);
	    
	    log.info("updateReplyPostAjax->result : " + result);
	    
	    return result;
	}
	
	
    
}
