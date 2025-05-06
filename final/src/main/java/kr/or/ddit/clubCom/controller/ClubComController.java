package kr.or.ddit.clubCom.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import io.swagger.v3.oas.annotations.parameters.RequestBody;
import kr.or.ddit.club.vo.ClubMemberVO;
import kr.or.ddit.clubCom.service.iClubComService;
import kr.or.ddit.clubCom.vo.ClubComTypeVO;
import kr.or.ddit.clubCom.vo.ClubComVO;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.util.ArticlePage;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/community/club/{clubNo}")
public class ClubComController {

	@Autowired
	iClubComService iclubComService;
	
	@GetMapping("/bForm")
	public String form(@PathVariable("clubNo") int clubNo, Model model) {
	    // 게시판 타입 목록 조회
	    List<ClubComTypeVO> clubComTypeVOList = this.iclubComService.clubComListAll();
	    log.info("clubComTypeVOList: {}", clubComTypeVOList);

	    // clubNo를 Model에 추가
	    log.info("PathVariable clubNo: {}", clubNo);
	    log.info("Model clubNo: {}", clubNo);
	    model.addAttribute("clubNo", clubNo);
	    model.addAttribute("clubComTypeVOList", clubComTypeVOList);

	    return "club/bForm";
	}

	
	@PostMapping("/insertPost")
	public String insertPost(@AuthenticationPrincipal CustomUser user, ClubComVO clubComVO) {
	    log.info("clubComVO before: {}", clubComVO);

	    int empNo = user.getMember().getEmpNo();
	    
	    // clubNo와 empNo로 clubMember 조회
	    ClubMemberVO clubMemberVO = iclubComService.clubMember(empNo, clubComVO.getClubNo());
	    log.info("clubMemberVO: {}", clubMemberVO);

	    // 필요한 값들 설정
	    clubComVO.setClubMemNo(clubMemberVO.getClubMemNo());
	    clubComVO.setEmpNo(empNo);
	    clubComVO.setClubComTypeNo(clubComVO.getClubComTypeVO().getClubComTypeNo());  // 추가된 부분
	    
	    log.info("clubComVO after: {}", clubComVO);

	    int result = iclubComService.insertPost(clubComVO);
	    log.info("insertPost result: {}", result);

	    // clubComTypeNo에 따라 type 결정
	    String type;
	    switch(clubComVO.getClubComTypeNo()) {
	        case 1: type = "notice"; break;
	        case 2: type = "free"; break;
	        case 3: type = "photo"; break;
	        default: return "redirect:/error";
	    }

	    return "redirect:/community/club/" + clubComVO.getClubNo() + "/" + type;
	}
	
	@GetMapping("/{type}")
	public String list(
	    @PathVariable String type,  // free, notice, photo
	    @AuthenticationPrincipal CustomUser user,
	    @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
	    @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
	    @PathVariable("clubNo") int clubNo,
	    Model model) {
	    
	    // type에 따라 clubComTypeNo 설정
	    int clubComTypeNo;
	    switch(type) {
	        case "notice": clubComTypeNo = 1; break;
	        case "free": clubComTypeNo = 2; break;
	        case "photo": clubComTypeNo = 3; break;
	        default: return "redirect:/error";
	    }
	    
	    Map<String, Object> map = new HashMap<>();
	    map.put("keyword", keyword);
	    map.put("currentPage", currentPage);
	    map.put("clubComTypeNo", clubComTypeNo);
	    map.put("clubNo", clubNo);
	    
	    int total = iclubComService.getTotal(map);
	    List<ClubComVO> clubComVOList = iclubComService.list(map);
	    
	    model.addAttribute("clubComVOList", clubComVOList);
	    model.addAttribute("type", type);  // JSP에서 type에 따라 다른 UI 표시
	    model.addAttribute("articlePage", 
	        new ArticlePage<ClubComVO>(total, currentPage, 15, clubComVOList, keyword));
	    
	    return "club/" + type;  // 각각의 JSP로 리턴
	}

	@ResponseBody
	@PostMapping("/listAjax")
	public ArticlePage<ClubComVO> listAjax(
	    @RequestBody Map<String, Object> map,
	    @AuthenticationPrincipal CustomUser user,
	    @PathVariable("clubNo") int clubNo) {
	    
	    map.put("clubNo", clubNo);
	    
	    List<ClubComVO> clubComVOList = iclubComService.list(map);
	    int total = iclubComService.getTotal(map);
	    
	    int currentPage = 1;
	    if(map.get("currentPage") != null) {
	        currentPage = Integer.parseInt(map.get("currentPage").toString());
	    }
	    
	    String keyword = "";
	    if(map.get("keyword") != null) {
	        keyword = map.get("keyword").toString();
	    }
	    
	    return new ArticlePage<ClubComVO>(total, currentPage, 15, clubComVOList, keyword, "ajax");
	}
	
	/*
	 @GetMapping("/free")
	    public String free() {
	        return "club/free";
	    }
	    */
	    
	    @GetMapping("/notice")
	    public String notice() {
	        return "club/notice";
	    }
	    
	    @GetMapping("/photo")
	    public String photo() {
	        return "club/photo";
	    }
	    
}
