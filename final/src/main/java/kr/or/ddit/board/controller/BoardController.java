package kr.or.ddit.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.board.service.iBoardService;
import kr.or.ddit.board.vo.BoardReplyVO;
import kr.or.ddit.board.vo.BoardTypeVO;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.ReportVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.util.ArticlePage;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/board")
@Controller
public class BoardController {

	@Autowired
	iBoardService iboardService;
	
        
	@GetMapping("/")
	public String home(Model model) {
	    // 현재 로그인한 사용자 정보 가져오기
	    CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    Integer userDeptNo = user.getMember().getDeptNo();

	    // 1. 공지사항 목록 
	    Map<String, Object> noticeMap = new HashMap<String, Object>();
	    noticeMap.put("currentPage", 1);
	    noticeMap.put("bodType", "1");
	    List<BoardVO> noticeList = this.iboardService.list(noticeMap);
	    noticeList = noticeList.subList(0, Math.min(5, noticeList.size()));

	    // 2. 부서게시판 목록
	    Map<String, Object> deptMap = new HashMap<String, Object>();
	    deptMap.put("currentPage", 1);
	    deptMap.put("bodType", "2");
	    deptMap.put("deptNo", userDeptNo);  // 사용자 부서번호 추가
	    List<BoardVO> deptList = this.iboardService.list(deptMap);
	    deptList = deptList.subList(0, Math.min(5, deptList.size()));

        // 3. QnA게시판 목록
        Map<String, Object> qnaMap = new HashMap<String, Object>();
        qnaMap.put("currentPage", 1);
        qnaMap.put("bodType", "3");
        List<BoardVO> qnaList = this.iboardService.list(qnaMap);
        qnaList = qnaList.subList(0, Math.min(5, qnaList.size()));

        // 4. 전체 게시물 목록 (bodType을 넣지 않음)
        Map<String, Object> allMap = new HashMap<String, Object>();
        allMap.put("currentPage", 1);
        // bodType을 설정하지 않음
        List<BoardVO> allPosts = this.iboardService.list(allMap);
        allPosts = allPosts.subList(0, Math.min(5, allPosts.size()));

        model.addAttribute("noticeList", noticeList);
        model.addAttribute("deptList", deptList);
        model.addAttribute("qnaList", qnaList);
        model.addAttribute("allPosts", allPosts);

        return "board/home";
    }
    
    
	@GetMapping("/form")
	public String form(Model model) {
		
		List<BoardTypeVO> boardTypeVOList = this.iboardService.bodListAll();
	    log.info("detail -> boardTypeVOList : " + boardTypeVOList);
		
		model.addAttribute("boardTypeVOList", boardTypeVOList);
				
		return "board/form";
	}
	
	
	@RequestMapping("/list")
	public String list(
	    @AuthenticationPrincipal CustomUser user,
	    @RequestParam(value="keyword", required=false, defaultValue="") String keyword,
	    @RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage,
	    @RequestParam(value="bodType", required=false) Integer bodType,
	    Model model) {

	    log.info("list->keyword : " + keyword);
	    log.info("list->currentPage : " + currentPage);
	    log.info("list->bodType : " + bodType);

	    log.info("user: " + user); // user 정보 확인
	    log.info("user deptNo: " + (user != null ? user.getMember().getDeptNo() : "null"));

	    Map<String,Object> map = new HashMap<String,Object>();
	    map.put("keyword", keyword);
	    map.put("currentPage", currentPage);
	    map.put("bodType", bodType);
	    map.put("deptNo", user.getMember().getDeptNo());
	    

	    log.info("list->map : " + map);

	    int total = this.iboardService.getTotal(map);
	    log.info("list->total : " + total);

	    List<BoardVO> boardVOList = this.iboardService.list(map);
	    log.info("list->boardVOList : " + boardVOList);

	    for (BoardVO board : boardVOList) {
	        log.info("Board No: " + board.getBodNo() + ", Dept No: " + board.getDeptNo());
	    }

	    if(boardVOList != null && !boardVOList.isEmpty()) {
	        log.info("현재 페이지(" + currentPage + ")의 첫 번째 행 BO_NO: " + boardVOList.get(0).getBodNo());
	    }

	    model.addAttribute("boardVOList", boardVOList);
	    model.addAttribute("bodType", bodType);
	    model.addAttribute("articlePage",
	        new ArticlePage<BoardVO>(total, currentPage, 15, boardVOList, keyword));

	    return "board/list";
	}
	
	
	@ResponseBody
	@PostMapping("/listAjax")
	public ArticlePage<BoardVO> listAjax(@RequestBody Map<String,Object> map,
	                                    @AuthenticationPrincipal CustomUser user) {
	    log.info("list->map : " + map);

	    // 로깅 강화
	    log.info("User DeptNo: {}", user.getMember().getDeptNo());

	    // deptNo 추가
	    map.put("deptNo", user.getMember().getDeptNo());

	    // 데이터 조회 전 map 상태 로깅
	    log.info("Map before query: {}", map);

	    // 로그인한 사용자의 부서번호 추가
	    map.put("deptNo", user.getMember().getDeptNo());

	    List<BoardVO> boardVOList = this.iboardService.list(map);
	    log.info("list->memberVOList : " + boardVOList);

	    int total = this.iboardService.getTotal(map);
	    log.info("list->total : " + total);

	    int currentPage = 1;
	    if(map.get("currentPage") != null) {
	        currentPage = Integer.parseInt(map.get("currentPage").toString());
	    }

	    String keyword = "";
	    if(map.get("keyword") != null) {
	        keyword = map.get("keyword").toString();
	    }

	    ArticlePage<BoardVO> articlePage =
	        new ArticlePage<BoardVO>(total, currentPage, 15, boardVOList
	                                , keyword, "ajax");

	    return articlePage;
	}
	
	@GetMapping("/detail/{bodNo}")
	public String detail(
	        @PathVariable(value="bodNo") int bodNo,
	        @RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
	        Model model) {
	    log.info("detail->bodNo : " + bodNo);
	    
	    Map<String,Object> map = new HashMap<String,Object>();
	    map.put("bodNo", bodNo);
	    map.put("currentPage", currentPage);
	    log.info("detail->map : " + map);
	    
	    BoardVO boardVO = new BoardVO();
	    boardVO.setBodNo(bodNo);
	    
	    // 조회수 증가
	    this.iboardService.updateHit(boardVO);
	    // 읽음 상태 업데이트 
	    this.iboardService.updateRead(boardVO);
	        
	    boardVO = this.iboardService.detail(bodNo);
	    log.info("detail->boardVO : " + boardVO);
	    
	    List<BoardReplyVO> boardReplyVOList = this.iboardService.reList(map);
	    log.info("detail->boardReplyVOList : " + boardReplyVOList);
	    
	    int total = this.iboardService.getReTotal(map);
	    log.info("detail->total : " + total);
	    
	    model.addAttribute("boardVO", boardVO);
	    model.addAttribute("boardReplyVOList", boardReplyVOList);
	    model.addAttribute("articlePage", 
	            new ArticlePage<BoardReplyVO>(total, currentPage, 5, boardReplyVOList, ""));
	    
	    return "board/detail";
	}
	
	@ResponseBody
	@PostMapping("/detailAjax")
	public ArticlePage<BoardReplyVO> detailAjax(@RequestBody Map<String,Object> map) {
		log.info("detailAjax->map : " + map);
	    
	    List<BoardReplyVO> boardReplyVOList = this.iboardService.reList(map);
	    log.info("detailAjax->boardReplyVOList : " + boardReplyVOList);
	    
	    int total = this.iboardService.getReTotal(map);
	    log.info("detailAjax->total : " + total);
	    
	    int currentPage = 1;
	    if(map.get("currentPage") != null) {
	        currentPage = Integer.parseInt(map.get("currentPage").toString());
	    }
	    
	    String keyword = "";
	    if(map.get("keyword") != null) {
	        keyword = map.get("keyword").toString();
	    }
	    
	    ArticlePage<BoardReplyVO> articlePage = 
	    		new ArticlePage<BoardReplyVO>(total, currentPage, 5, boardReplyVOList, keyword, "ajax");
	    
	    return articlePage;
	}
	
	@PostMapping("/updatePost")
	public String updatePost(
	    @AuthenticationPrincipal CustomUser user,
	    BoardVO boardVO) {
	    
	    // 수정자 정보 설정
	    boardVO.setEmpNo(user.getMember().getEmpNo());
	    boardVO.setBodWriter(user.getMember().getEmpName());
	    
	    int result = this.iboardService.updatePost(boardVO);
	    log.info("updatePost->result : " + result);
	    
	    return "redirect:/board/detail/" + boardVO.getBodNo();
	}
	
	@PostMapping("/deletePost")
	public String deletePost(
	    @AuthenticationPrincipal CustomUser user,
	    BoardVO boardVO) {

	    // 삭제자의 사번 설정
	    boardVO.setEmpNo(user.getMember().getEmpNo());
	        
	    log.info("deletePost->boardVO : " + boardVO);
	    
	    // 1. 모든 댓글 삭제
	    this.iboardService.deleteAllReply(boardVO.getBodNo());  
	    
	    // 2. 게시글 삭제
	    int result = this.iboardService.deletePost(boardVO);
	    
	    log.info("deletePost->result : " + result);
	    
	    return "redirect:/board/list";
	}
	
	
	@PostMapping("/insertPost")
	public String insertPost(@AuthenticationPrincipal CustomUser user, BoardVO boardVO) {
	    // 로그인한 사용자의 정보 가져오기
	    MemberVO memberVO = user.getMember();
	    log.info("memberVO : ", memberVO);
	    
	    // 게시글 작성자 정보 설정
	    boardVO.setEmpNo(memberVO.getEmpNo());      // 직원 번호
	    boardVO.setBodWriter(memberVO.getEmpName()); // 직원 이름
	    
	    
	    log.info("empNo : {}", memberVO.getEmpNo());
	    log.info("empName : {}", user.getMember().getEmpName());
	    log.info("insertPost->boardVO befSore : {}", boardVO);
	    log.info("insertPost->uploadFile : {}", boardVO.getUploadFile());

	    int result = this.iboardService.insertPost(boardVO);
	    log.info("insertPost->result : {}", result);

	    return "redirect:/board/detail/" + boardVO.getBodNo();
	}
	
	@PostMapping("/createReplyPost")
	public String createReplyPost(
	    @AuthenticationPrincipal CustomUser user, 
	    BoardReplyVO boardReplyVO) {

	    // 현재 로그인한 사용자 정보 설정
	    boardReplyVO.setBodReWriter(user.getMember().getEmpName());  
	    boardReplyVO.setEmpNo(user.getMember().getEmpNo());
	    
	    
	    
	    log.info("createReplyPost->boardReplyVO : " + boardReplyVO);
	    
	    //1. BOARD_REPLY 테이블에 insert
	    int result = this.iboardService.createReplyPost(boardReplyVO);
	    log.info("createReplyPost->boardReplyVO : " + boardReplyVO);
	    
	    //2. 상세 페이지로 redirect
	    return "redirect:/board/detail/" + boardReplyVO.getBodNo();
	}
	
	
	@ResponseBody
	@PostMapping("/createReplyPostAjax")
	public int createReplyPostAjax(
	    @AuthenticationPrincipal CustomUser user,
	    @RequestBody BoardReplyVO boardReplyVO) {  

	    // 현재 로그인한 사용자 정보 설정
	    boardReplyVO.setBodReWriter(user.getMember().getEmpName());  
	    boardReplyVO.setEmpNo(user.getMember().getEmpNo());       
	    
	    log.info("createReplyPost->boardReplyVO : " + boardReplyVO);
	    
	    int result = this.iboardService.createReplyPost(boardReplyVO);
	    log.info("createReplyPost->boardReplyVO : " + boardReplyVO);
	    
	    return result;
	}
	
	/*
	@ResponseBody
	@PutMapping("/updatePostAjax/{idx}")
	public int updatePostAjax(@PathVariable(value="idx") int idx,
			@RequestBody BoardReplyVO boardReplyVO) {
		
		log.info("updatePostAjax->idx : " + idx);
		
		log.info("updatePostAjax->boardReplyVO : " + boardReplyVO);
		
		
		int result = this.iboardService.updatePostAjax(boardReplyVO);
		log.info("updatePostAjax->result : " + result);
		
		//데이터
		return result;
	}
	*/
	
	@PostMapping("/deleteReplyPost/{bodIdx}")
	public String deleteReplyPost(BoardReplyVO boardReplyVO) {
		log.info("deletePost->boardVO : " + boardReplyVO);
		
		int result = this.iboardService.deleteReplyPost(boardReplyVO);
		
		log.info("`Post->result : " + result);
		
		return "redirect:/board/detail/" + boardReplyVO.getBodNo();
	}
	
	
	/*
	   data{"bodNo": "4","bodIdx": "19","repType": 2,
	   		"repCont": "ㅁㅁㅁ","repReason": "욕설/비방"}
	 */
	@ResponseBody
	@PostMapping("/reportReplyPost")
	public int reportReplyPost(
	    @AuthenticationPrincipal CustomUser user,
	    @RequestBody ReportVO reportVO) {
	    
	    // 신고자 정보 설정
	    reportVO.setRepWriter(user.getMember().getEmpName());  // 신고자 이름
	    reportVO.setEmpNo(user.getMember().getEmpNo());      // 신고자 사번
	    
	    log.info("reportReplyPost->reportVO : " + reportVO);
	    
	    int result = this.iboardService.reportReplyPost(reportVO);
	    log.info("reportReplyPost->result : " + result);
	    
	    return result;
	}
}
