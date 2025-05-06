package kr.or.ddit.club.controller;

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

import kr.or.ddit.club.service.iClubService;
import kr.or.ddit.club.vo.ClubCategoryVO;
import kr.or.ddit.club.vo.ClubJoinRequestVO;
import kr.or.ddit.club.vo.ClubMemberVO;
import kr.or.ddit.club.vo.ClubVO;
import kr.or.ddit.community.vo.CommunityVO;
import kr.or.ddit.personnel.service.DepartmentService;
import kr.or.ddit.personnel.service.EmployeeListService;
import kr.or.ddit.personnel.vo.DepartmentVO;
import kr.or.ddit.personnel.vo.EmployeeVO;
import kr.or.ddit.personnel.vo.PositionVO;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.util.ArticlePage;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/community/club")
@Controller
public class ClubController {

	@Autowired
	iClubService iclubService;
	
	@GetMapping("/manage/{clubNo}")
    public String manage(
        @PathVariable("clubNo") int clubNo,
        Model model) {
        
        // 동호회 관리 정보 조회
        ClubVO clubVO = this.iclubService.clubManage(clubNo);
        log.info("manage->clubVO : " + clubVO);
        
        // 멤버 리스트 조회
        List<ClubMemberVO> memberList = this.iclubService.getMemberList(clubNo);
        clubVO.setMemberList(memberList);
        log.info("manage->memberList : " + memberList);
        
        // 카테고리 목록 조회
        List<ClubCategoryVO> categories = this.iclubService.categoryList();
        log.info("manage->categories : " + categories);
        
        // 부서 목록 조회
        List<DepartmentVO> deptList = this.iclubService.deptList();
        log.info("manage->deptList : " + deptList);
        
        // 직책 목록 조회
        List<PositionVO> positionList = this.iclubService.positionList();
        log.info("manage->positionList : " + positionList);
        
        // 직원 정보 조회 
        // List<EmployeeVO> employeeList = this.employeeListService.employeeList();
        List<EmployeeVO> employeeList = this.iclubService.employeeList();
        log.info("manage->employeeList : " + employeeList);
        
        model.addAttribute("deptList", deptList);        
        model.addAttribute("positionList", positionList);
        model.addAttribute("club", clubVO);
        model.addAttribute("categories", categories);
        model.addAttribute("employeeList", employeeList);  
        
        return "club/manage";
    }
	
	@GetMapping("/list")
	public String list(
            @RequestParam(value="keyword", required=false, defaultValue="") String keyword,
            @RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage,
            @RequestParam(value="category", required=false) String category,
            @AuthenticationPrincipal CustomUser user,
            Model model) {
        
		int empNo = user.getMember().getEmpNo();
        log.info("list->keyword : " + keyword);
        log.info("list->currentPage : " + currentPage);
        log.info("list->category : " + category);
        
        // 검색 조건을 map에 담기
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("keyword", keyword);
        map.put("currentPage", currentPage);
        map.put("empNo", empNo);
        
        // category가 있고 비어있지 않을 때만 map에 추가
        if (category != null && !category.isEmpty()) {
            map.put("category", category);
        }
        
        log.info("list->map : " + map);
        
        // 내 동호회 목록 조회
        List<ClubVO> myClubs = iclubService.myClubs(empNo);
        model.addAttribute("myClubs", myClubs);
        
        // 전체 동호회 목록 조회
        int total = this.iclubService.getTotal(map);
        log.info("list->total : " + total);
        
        List<ClubVO> allClubs = this.iclubService.allClubs(map);
        log.info("list->allClubs : " + allClubs);
        
        model.addAttribute("allClubs", allClubs);
        model.addAttribute("category", category);
        model.addAttribute("articlePage", 
            new ArticlePage<ClubVO>(total, currentPage, 10, allClubs, keyword));
        
        return "club/list";
    }
    
    @ResponseBody
    @PostMapping("/listAjax")
    public ArticlePage<ClubVO> listAjax(@RequestBody Map<String,Object> map, 
                                       @AuthenticationPrincipal CustomUser user) {  
        log.info("listAjax->map : " + map);
        
        map.put("empNo", user.getMember().getEmpNo());
        log.info("empNo : " + user.getMember().getEmpNo());
        
        List<ClubVO> allClubs = this.iclubService.allClubs(map);
        log.info("listAjax->allClubs : " + allClubs);
        
        int total = this.iclubService.getTotal(map);
        log.info("listAjax->total : " + total);
        
        int currentPage = 1;
        if(map.get("currentPage") != null) {
            currentPage = Integer.parseInt(map.get("currentPage").toString());
        }
        
        String keyword = "";
        if(map.get("keyword") != null) {
            keyword = map.get("keyword").toString();
        }
        
        String category = "";
        if(map.get("category") != null) {
            category = map.get("category").toString();
        }
        
        ArticlePage<ClubVO> articlePage = 
            new ArticlePage<ClubVO>(total, currentPage, 10, allClubs, keyword, "ajax");
        
        return articlePage;
    }
    
    
    @GetMapping("/myPage/{clubNo}")
    public String myPage(
           @PathVariable(value="clubNo") int clubNo,
           @RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
           @AuthenticationPrincipal CustomUser user,
           Model model) {

       // clubVO 생성 및 설정
       ClubVO clubVO = new ClubVO();
       clubVO.setClubNo(clubNo);
       clubVO.setEmpNo(user.getMember().getEmpNo());

       // 조회수 업데이트
       this.iclubService.updateHit(clubVO);

       // 동호회 정보 조회 
       clubVO = this.iclubService.myPage(clubVO);

       // 멤버 리스트
       List<ClubMemberVO> memberList = this.iclubService.getMemberList(clubNo);
       clubVO.setMemberList(memberList);

       // 현재 사용자의 권한 정보 조회
       ClubMemberVO currentMember = new ClubMemberVO();
       currentMember.setClubNo(clubNo);
       currentMember.setEmpNo(user.getMember().getEmpNo());
       ClubMemberVO memberRole = iclubService.memberDetail(currentMember);
       
       // 가입 신청 리스트
       List<ClubJoinRequestVO> joinRequestList = this.iclubService.joinRequestList(clubNo);
       clubVO.setJoinRequestList(joinRequestList);

       // WebSocket URL 정보 추가
       model.addAttribute("wsUrl", "/chat");
       model.addAttribute("clubVO", clubVO);
       model.addAttribute("memberRole", memberRole); 

       return "club/myPage";
    }
    
    @GetMapping("/form")
	public String form(Model model, @AuthenticationPrincipal CustomUser user) {
	    
    	// 카테고리 목록 조회
	    List<ClubCategoryVO> clubCategoryVOList = this.iclubService.clubListAll();
	    log.info("form -> clubCategoryVOList : " + clubCategoryVOList);
	    
	    // 커뮤니티 목록 조회
//	    List<CommunityVO> communityVOList = this.iclubService.communityListAll();
//	    log.info("form -> communityVOList : " + communityVOList);
	    
	    // 부서명 조회 - CustomUser에서 MemberVO를 통해 deptNo 가져오기
	    // DepartmentVO departmentVO = departmentService.getDeptName(user.getMember().getDeptNo());
	    int deptNo = user.getMember().getDeptNo();
	    log.info("form -> deptNo : " + deptNo);
	    
	    model.addAttribute("clubCategoryVOList", clubCategoryVOList);
//	    model.addAttribute("communityVOList", communityVOList);
	    model.addAttribute("deptNo", deptNo);
	    
	    return "club/form";
	}
    
    //동호회 개설(/community/club/form)에서 [개설하기]버튼 클릭
    //<input type="file" name="uploadFile" id="uploadFile" style="display: none">
    @PostMapping("/insertPost")
    public String insertPost(
        @AuthenticationPrincipal CustomUser user,
        ClubVO clubVO) {
        
        // 동호회 생성자 직원번호 설정
        clubVO.setEmpNo(user.getMember().getEmpNo());

        /*
        ClubVO(clubNo=0, clubName=2025년 1월 식약처프로젝트 동호회, clubDesc=2025년 1월 식약처프로젝트 동호회, 
        clubCreDate=null, clubCreMem=31, clubHit=0, clubSec=1, maxMember=0, nowMember=0, 
        clubState=0, joinWay=0, requestDate=null, clubOpenState=0, clubPat=1, clubModiDate=null, 
        comNo=20, communityVO=null, fileGroupVO=null, 
        uploadFile=[org.springframework.web.multipart.suppo..], memberList=null, 
        joinRequestList=null, empNo=31, employeeVO=null, clubCategoryVO=null)
         */
        log.info("insertPost->clubVO before : " + clubVO);
        
        int result = this.iclubService.insertPost(clubVO);
        log.info("insertPost->result : " + result);
        
        return "redirect:/community/club/myPage/" + clubVO.getClubNo();
    }
    
    
    @ResponseBody
    @PostMapping("/updateAjax")
    public ClubVO updateAjax(ClubVO clubVO, CommunityVO communityVO) {
        log.info("updateAjax->clubVO(전) : " + clubVO);
        log.info("updateAjax->communityVO(전) : " + communityVO);

        // Club 테이블 업데이트
        int result = this.iclubService.updateClub(clubVO);
        
        // Community 테이블 업데이트
        communityVO.setComNo(clubVO.getComNo());  
        result += this.iclubService.updateCommunity(communityVO);
        
        log.info("updateAjax->result : " + result);

        // 업데이트된 정보를 다시 조회
        clubVO = this.iclubService.clubManage(clubVO.getClubNo());
        log.info("updateAjax->clubVO(후) : " + clubVO);

        return clubVO;
    }
    
    @PostMapping("/deletePost")
    public String deletePost(
        @AuthenticationPrincipal CustomUser user, 
        ClubVO clubVO) {
        
        // 삭제자의 사번 설정
        clubVO.setEmpNo(user.getMember().getEmpNo());
        
        log.info("deletePost->clubVO : " + clubVO);
        
        // 클럽 포스트 삭제 
        int result = this.iclubService.deletePost(clubVO);
        
        log.info("deletePost->result : " + result);
        
        return "redirect:/community/club/list";
    }
    
    // 동호회 가입 신청
    @PostMapping("/clubRequest")
    public String clubRequest(ClubJoinRequestVO clubJoinRequestVO) {
        
        log.info("clubJoinRequestVO : " + clubJoinRequestVO);
        
        // 가입 신청 처리
        int result = iclubService.clubRequest(clubJoinRequestVO);
        
        return "redirect:/community/club/myPage/" + clubJoinRequestVO.getClubNo();
    }
    
    // 가입 신청 상태 변경 (승인/거절)
    @PostMapping("/updateRequest")
    public String updateRequest(ClubJoinRequestVO clubJoinRequestVO) {
        log.info("updateRequest -> clubJoinRequestVO : " + clubJoinRequestVO);
        
        // 상태 변경 처리 (승인시 자동으로 회원 추가)
        int result = iclubService.updateRequest(clubJoinRequestVO);
        log.info("update request result : " + result);
        
        return "redirect:/community/club/myPage/" + clubJoinRequestVO.getClubNo();
    }
    
    // 동호회 회원 추가
    @PostMapping("/joinMember")
    public String joinMember(ClubMemberVO clubMemberVO) {
        log.info("clubMemberVO : " + clubMemberVO);
        
        // 회원 추가 처리
        int result = iclubService.addMember(clubMemberVO);
        log.info("join member result : " + result);
        
        // 현재 회원 수 업데이트
        result = iclubService.updateMember(clubMemberVO.getClubNo());
        
        return "redirect:/community/club/myPage/" + clubMemberVO.getClubNo();
    }
    
    // 동호회 회원 목록 조회
    @GetMapping("/memberList/{clubNo}")
    public String getMemberList(@PathVariable("clubNo") int clubNo, Model model) {
        
    	log.info("clubNo : " + clubNo);
    	
        List<ClubMemberVO> memberList = iclubService.getMemberList(clubNo);
        log.info("memberList : " + memberList);
        
        model.addAttribute("memberList", memberList);
        
        return "club/memberList";
    }
    
    // 동호회 멤버 권한 설정
    @PostMapping("/updateRole")
    public String updateRole(
        ClubMemberVO clubMemberVO,
        @AuthenticationPrincipal CustomUser user) {
        
        log.info("updateRole->clubMemberVO : " + clubMemberVO);
        
        // 권한 변경 처리
        int result = iclubService.updateRole(clubMemberVO);
        log.info("updateRole result : " + result);
        
        return "redirect:/community/club/myPage/" + clubMemberVO.getClubNo();
    }

    // 동호회 멤버의 현재 권한 조회
    @GetMapping("/memberRole")
    @ResponseBody
    public ClubMemberVO getMemberRole(ClubMemberVO clubMemberVO) {
        log.info("getMemberRole->clubMemberVO : " + clubMemberVO);
        
        return iclubService.memberDetail(clubMemberVO);
    }
    
    @ResponseBody
    @GetMapping("/inviteMemberList")
    public List<EmployeeVO> inviteMemberList(
        EmployeeVO employeeVO,
        @RequestParam("clubNo") int clubNo
    ) {
        log.info("inviteMemberList");
        log.info("employeeVO : " + employeeVO);
        log.info("clubNo : " + clubNo);
        
        Map<String, Object> map = new HashMap<>();
        map.put("employeeVO", employeeVO);
        map.put("clubNo", clubNo);
        
        return iclubService.inviteMemberList(map);
    }

    @ResponseBody
    @PostMapping("/inviteMembers")
    public int inviteMembers(
        @RequestParam("clubNo") int clubNo,
        @RequestParam("empNoList") List<Integer> empNoList
    ) {
        log.info("inviteMembers");
        log.info("clubNo : " + clubNo);
        log.info("empNoList : " + empNoList);

        Map<String, Object> map = new HashMap<>();
        map.put("clubNo", clubNo);
        map.put("empNoList", empNoList);

        int result = iclubService.inviteMembers(map);
        result = iclubService.updateMember(clubNo);
        
        return iclubService.inviteMembers(map);
    }
    
    // 동호회 멤버 추방
    @PostMapping("/kickMember")
    public String kickMember(ClubMemberVO clubMemberVO) {
        log.info("kickMember->clubMemberVO : " + clubMemberVO);
        
        // 멤버 추방 처리
        int result = iclubService.kickMember(clubMemberVO);
        log.info("kick member result : " + result);
        
        // 현재 회원 수 업데이트
        result = iclubService.updateMember(clubMemberVO.getClubNo());
        
        return "redirect:/community/club/myPage/" + clubMemberVO.getClubNo();
    }
    
    // 동호회 폐쇄
    @PostMapping("/closeClub")
    public String closeClub(
        @AuthenticationPrincipal CustomUser user,
        ClubVO clubVO) {
        
        // 폐쇄 요청자의 사번 설정
        clubVO.setEmpNo(user.getMember().getEmpNo());
        
        log.info("closeClub->clubVO : " + clubVO);
        
        // 클럽 폐쇄 처리
        int result = this.iclubService.closeClub(clubVO);
        
        log.info("closeClub->result : " + result);
        
        return "redirect:/community/club/list";
    }
    
   
    
}
