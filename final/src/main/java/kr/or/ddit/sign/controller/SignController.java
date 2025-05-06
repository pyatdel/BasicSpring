package kr.or.ddit.sign.controller;

import java.security.Principal;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.sign.service.SignService;
import kr.or.ddit.sign.vo.ResultVO;
import kr.or.ddit.sign.vo.SignVO;
import kr.or.ddit.util.ArticlePage;
import lombok.extern.slf4j.Slf4j;


@RequestMapping("/sign")
@Controller
@Slf4j
public class SignController {

	@Autowired
	SignService signService;
	
	// 결재대기 리스트 조회
	@GetMapping("/signList")
	public String signList(SignVO signVO,Model model,
		@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
		@RequestParam(value="keyword",required = false, defaultValue = "") String keyword,
		Principal principal) {

		//로그인 한 아이디
		String empNo = principal.getName();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		map.put("empNo", empNo);
		log.info("list->map:" + map);
		
		// 전체 행의 수
		int total = this.signService.getTotal(map);
		log.info("list->total:" + total);
		
		//map{currentPage=1, keyword=}
		List<SignVO> signVOList = this.signService.signList(map);
		log.info("list->signVOList : " + signVOList);
		/*list->signVOList : [SignVO(docNo=1, docTitle=신입사원 입사 기념품, docContent=null, writeDate=2025-01-02, 
		empNo=6, appDocNo=0, appStatusCode=1, appStatusName=대기, appDocName=null, empName=양마강, postNo=0, 
		postName=과장, deptNo=0, deptName=개발부, rnum=1), */
		
		//페이지네이션
		ArticlePage<SignVO> articlePage = 
				new ArticlePage<SignVO>(total, currentPage, 5, signVOList, keyword);
		
		model.addAttribute("signVOList",signVOList);
		model.addAttribute("articlePage",articlePage);
		
		return "sign/list";
	}
	
	// 비동기 결재대기 리스트 조회
	@ResponseBody
	@PostMapping("/listAjax")
	public ArticlePage<SignVO> listAjax(@RequestBody Map<String, Object> map, Principal principal) {
		
		//로그인 아이디
		String reappEmpId = principal.getName();
		
		map.put("reappEmpId", reappEmpId);
		
		log.info("listAjax->map : " +map);
		//전체 행의 수
		int total = this.signService.getTotal(map);
		
		List<SignVO> signVOList = this.signService.signList(map);
		log.info("listAjax->signVOList : " +signVOList);
		
		int currentPage = Integer.parseInt(map.get("currentPage").toString());
		
		String keyword = "";
		
		if(map.get("keyword")!=null) {
			keyword = map.get("keyword").toString();
		}
		// 로그로 keyword 확인
	    log.info("검색어: " + keyword);
		
		// 비동기 페이지 네이션 : ajax
		ArticlePage<SignVO> articlePage
			= new ArticlePage<SignVO>(total, currentPage, 5, signVOList, keyword, "ajax");
		
		return articlePage;
	}
	
	// 결재 올린거 내용 상세 보기 + 결재선
	@GetMapping("/detail")
	public String detail(SignVO signVO, Model model) {
		log.info("detail->signVO {}",signVO);
		
		
		//결재선 데이터 보이게
		List<SignVO> signLineList = this.signService.getSignLineList();
		log.info("detail -> signLineList : " + signLineList);
		//결재선 부서
		List<SignVO> departmentVOList = this.signService.getDepartmentVOList();
		log.info("detail -> departmentVOList : " + departmentVOList);
		
		//선택된 결재 라인 보이게
		List<SignVO> appLineList = this.signService.getAppLineList(signVO);
		log.info("detail 결재자 어디있니? -> appLineList : " + appLineList);
		
		//선택된 참조 라인 보이게
		List<SignVO> appLineList2 = this.signService.getAppLineList2(signVO);
		
		// 기안자(작성자), 기안일, 부서, 직급, 결재종류, 제목, 내용 가져오기
		signVO = this.signService.detail(signVO);
		
		//그 결재문서가 종료됐다면 1
		//SELECT COUNT(*) FROM APPROVAL_HIST WHERE DOC_NO = 12 AND FINAL_CHECK_STATUS = 1
		log.info("detail->signVO에 docNo가 있어야 함 : " + signVO);
		int finalCheckStatus = this.signService.getFinalCheckStatus(signVO);
		log.info("결재문서가 종료됐나요? -> finalCheckStatus : " + finalCheckStatus);
		
		model.addAttribute("signVO",signVO);
		model.addAttribute("signLineList",signLineList);
		model.addAttribute("departmentVOList",departmentVOList);
		model.addAttribute("appLineList",appLineList);
		model.addAttribute("appLineList2",appLineList2);
		model.addAttribute("finalCheckStatus",finalCheckStatus);//결재문서 종료여부(1 : 종료, 0 : 결재중)
		
		
		
		return "sign/detail" ;
	}
	
	// 승인 버튼 클릭-> approval_hist 테이블에 insert
	//JSONString{"docNo":10,"appTypeId":2}
	@ResponseBody
	@PostMapping("/approvalPost")
	public SignVO approvalPost(@RequestBody SignVO signVO, Model model, Principal principal) {
		
		//로그인 한 직원의 아이디( ex) 20241226123 )
		String empId = principal.getName();
		signVO.setEmpId(empId);
		
		//signVO{docNo=10,appTypeId=2,empId=20241226123}
		int result = this.signService.approvalPost(signVO);
		log.info("result->approvalPost 체킁",result);
		
		String fileSaveLocate = "";
		if(result>0) {//APPROVAL_HIST테이블에 insert 성공
			fileSaveLocate = this.signService.getFileSaveLocate(empId);
			signVO.setFileSaveLocate(fileSaveLocate);
		}else {//APPROVAL_HIST테이블에 insert 실패
			fileSaveLocate = "";
		}
		
		log.info("approvalPost->signVO : " + signVO);
		
		return signVO;
	}
	
	
	//결재선 해당 부서 직원 불려오기
	@ResponseBody
	@PostMapping("/signLinePost")
	public List<SignVO> signLinePost(@RequestBody Map<String, Object> map) {
		// 체킁체킁{deptName=개발부}
		log.info("체킁체킁"+map);
		String deptName = map.get("deptName").toString();
		
		List<SignVO> dName = this.signService.signLinePost(map);
		log.info("화긴화긴"+dName);
		
		String keyword = ""; // 검색 없는 것이 기본
		
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();// keyword에 값 넣기
		}
		// 로그로 keyword 확인
	    log.info("검색어: " + keyword);
		
		return dName;
	}
		
		// 결재 등록 폼
		@GetMapping("/create")
		public String create(SignVO signVO, Model model) {
			
			// 로그인한 사람 데이터 넘기는 것
			//UserDetailServiceImpl->CustomUser
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
            CustomUser userDetails = (CustomUser)principal; 
            log.info("commuteList->userDetails : " + userDetails.getMember());
            MemberVO memberVO = userDetails.getMember();
            int empNo = memberVO.getEmpNo();
            log.info("commuteList->memberVO : " + memberVO);
            log.info("empNo :" + empNo);
            
			//결재선 직급 등 리스트
			List<SignVO> signLineList = this.signService.getSignLineList();
			log.info("create -> signLineList : " + signLineList);
			//결재선 부서
			List<SignVO> departmentVOList = this.signService.getDepartmentVOList();
			log.info("create -> departmentVOList : " + departmentVOList);
			
			//결재선 이름 가져오기
			List<SignVO> appListNameList = this.signService.getAppListName();
			log.info("create-> appListName : " + appListNameList);
			
			// 참조선 가져오기
			List<SignVO> referenceEmpIds = this.signService.getReferenceEmpIds();
			
			model.addAttribute("signLineList",signLineList);
			model.addAttribute("referenceEmpIds",referenceEmpIds);
			model.addAttribute("departmentVOList",departmentVOList);
			model.addAttribute("appListNameList",appListNameList);
			
		   // 로그인 한 기안자(작성자), 기안일, 부서, 직급, 결재선
			log.info("create-> empNo : " + empNo);
			signVO = this.signService.create(empNo);
			log.info("create킁킁킁->signVO :",signVO);
			
			// 결재종류 가져오기
			List<SignVO> signVOList = this.signService.getSignVOList();

			model.addAttribute("signVO",signVO);
			model.addAttribute("signVOList",signVOList);
			
			return "sign/create" ;
		}	
		
		//결재 등록
		@ResponseBody
		@PostMapping("/createFormPost")
		public String createFormPost(SignVO signVO) {
			
			int result = this.signService.createFormPost(signVO);
			log.info("체킁!!!createFormPost->result : " + result);
			
			return "redirect:/sign/detail?appGroupCode="+signVO.getAppGroupCode();
		}
		
		//결재선 선택 -> 결재선 등록 -> 결재 폼에 보여야함
		@PostMapping("/createPost")
		public String createPost(@RequestBody SignVO signVO) {

			//결재선
			int result = this.signService.createPost(signVO);
			log.info("createPost->result : " + result);
			
			return "redirect:/sign/create";
		}
		
		//결재자 데이터 넣기
		@ResponseBody
		@PostMapping("/createPostAjax")
		public Map<String, Object> createPostAjax(@ModelAttribute SignVO signVO) {
			/*
			SignVO(docNo=0, docTitle=null, docContent=null, writeDate=null, empNo=0, appDocNo=0, appStatusCode=0, fileGroupNo=0, 
			appGroupCode=0, appStatusName=null, appDocName=null, empName=null, empId=null, 
						empIds=[20161121001], 
			postNo=0, postName=null, 
			deptNo=0, deptName=null, rnum=0, signDetailVOList=null, fileGroupVO=null, uploadFiles=null, 
						referenceEmpIds=[20241231002], 
			appListCode=0, appListName=null, appNo=0, reappEmpId=0, appOrder=0, appDate=null, appIdx=0, appTypeId=0, appTypeName=null, uploadFile=null)
			 */
			log.info("createPostAjax->signVO : " + signVO);
			
			//등록 폼(결재-empIds와 참조-referenceEmpIds를 insert함)
			int result = this.signService.createPost(signVO);
			log.info("createPostAjax->result : " + result);
			log.info("signVO.getAppGroupCode() : " + signVO.getAppGroupCode());
			
			 // 삽입 작업 성공 시, 삽입된 데이터를 조회
		    List<SignVO> insertedData = this.signService.getInsertedApprovalList(signVO.getAppGroupCode());
		    log.info("createPostAjax->insertedData: " + insertedData);

		    // 결과를 반환
		    Map<String, Object> response = new HashMap<>();
		    response.put("result", result);
		    response.put("approvalList", insertedData); // 삽입된 데이터 포함
			
			return response;
			
		}
		
	//반려버튼(retract) insert로 처리 예정
	@ResponseBody
	@PostMapping("/retract") // json 형태로 받으려면 requestbody가 필요하다
	public ResultVO retract(@RequestBody SignVO signVO, Model model, Principal principal) {
		
		//로그인 한 직원의 아이디( ex) 20241226123 )
				String empId = principal.getName();
				signVO.setEmpId(empId);
		
		ResultVO resultVO = new ResultVO();
		
		try {
			int result = this.signService.retract(signVO);
			log.info("retract->result : " + result);
			if(result > 0) {
				resultVO.setResultCode(ResultVO.RESULT_CODE_200);
				resultVO.setResultMessage("성공적으로 반려가 처리되었습니다.");
			}else {
				resultVO.setResultCode(ResultVO.RESULT_CODE_201);
				resultVO.setResultMessage("반려 처리 대상 결재가 존재하지 않습니다. 다시 확인하시고 시도해 주시기 바랍니다.");
			}
		
		}catch(RuntimeException e) {
			log.error(e.getMessage());
			resultVO.setResultCode(ResultVO.RESULT_CODE_201);
			resultVO.setResultMessage(ResultVO.RESULT_MESSAGE_EXCEPTION);
		}
		
		
		return resultVO;
	}
	
	// 반려 사유 포함 상세페이지
	@GetMapping("/retractDetail")
	public String retractDetail(SignVO signVO, Model model) {
		log.info("retractDetail->signVO {}",signVO);
		
		//결재선 데이터 보이게
		List<SignVO> signLineList = this.signService.getSignLineList();
		log.info("retractDetail -> signLineList : " + signLineList);
		//결재선 부서
		List<SignVO> departmentVOList = this.signService.getDepartmentVOList();
		log.info("retractDetail -> departmentVOList : " + departmentVOList);
		
		//선택된 결재 라인 보이게
		List<SignVO> appLineList = this.signService.getAppLineList(signVO);
		log.info("retractDetail 결재자 어디있니? -> appLineList : " + appLineList);
		
		//선택된 참조 라인 보이게
		List<SignVO> appLineList2 = this.signService.getAppLineList2(signVO);
		
		// 기안자(작성자), 기안일, 부서, 직급, 결재종류, 제목, 내용 가져오기
		signVO = this.signService.retractDetail(signVO);
		//그 결재문서가 종료됐다면 1
		//SELECT COUNT(*) FROM APPROVAL_HIST WHERE DOC_NO = 12 AND FINAL_CHECK_STATUS = 1
		log.info("retractDetail->signVO에 docNo가 있어야 함 : " + signVO);
		int finalCheckStatus = this.signService.getFinalCheckStatus(signVO);
		log.info("결재문서가 종료됐나요? -> finalCheckStatus : " + finalCheckStatus);
		
		model.addAttribute("signVO",signVO);
		model.addAttribute("signLineList",signLineList);
		model.addAttribute("departmentVOList",departmentVOList);
		model.addAttribute("appLineList",appLineList);
		model.addAttribute("appLineList2",appLineList2);
		model.addAttribute("finalCheckStatus",finalCheckStatus);//결재문서 종료여부(1 : 종료, 0 : 결재중)
		
		return "sign/retractDetail";
	}
	
	// 결재요청 리스트 조회
		@GetMapping("/request")
		public String request(SignVO signVO,Model model,
			@RequestParam(value="currentPage",required=true,defaultValue="1")int currentPage,
			@RequestParam(value="keyword",required = false, defaultValue = "")String keyword
			,Principal principal) {
			
			//로그인 한 아이디
			String empNo = principal.getName();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("currentPage", currentPage);
			map.put("keyword", keyword);
			map.put("empNo", empNo);
			log.info("list->map:" + map);
			
			// 전체 행의 수
			int total = this.signService.getRequestTotal(map);
			log.info("list->requestTotal:" + total);
			
			//map{currentPage=1, keyword=}
			List<SignVO> signVOList = this.signService.request(map);
			log.info("list->request : " + signVOList);
			/*list->signVOList : [SignVO(docNo=1, docTitle=신입사원 입사 기념품, docContent=null, writeDate=2025-01-02, 
			empNo=6, appDocNo=0, appStatusCode=1, appStatusName=대기, appDocName=null, empName=양마강, postNo=0, 
			postName=과장, deptNo=0, deptName=개발부, rnum=1), */
			
			//페이지네이션
			ArticlePage<SignVO> articlePage = 
					new ArticlePage<SignVO>(total, currentPage, 5, signVOList, keyword);
			
			model.addAttribute("signVOList",signVOList);
			model.addAttribute("articlePage",articlePage);
			
			return "sign/request";
		}
		
		// 비동기 결재요청 리스트 조회
		@ResponseBody
		@PostMapping("/requestAjax")
		public ArticlePage<SignVO> requestAjax(@RequestBody Map<String, Object> map ,Principal principal) {
			log.info("requestAjax->map : " +map);
			
			//로그인 아이디
			String reappEmpId = principal.getName();
			log.info("reappEmpId 있니?", reappEmpId);
			
			map.put("reappEmpId", reappEmpId);
			
			//전체 행의 수
			int total = this.signService.getRequestTotal(map);
			
			List<SignVO> signVOList = this.signService.request(map);
			
			int currentPage = 1;
			if(map.get("currentPage") != null) {
				currentPage = Integer.parseInt(map.get("currentPage").toString());
			}
			
			String keyword = "";
			
			if(map.get("keyword")!=null) {
				keyword = map.get("keyword").toString();
			}
			
			// 비동기 페이지 네이션 : ajax
			ArticlePage<SignVO> articlePage
				= new ArticlePage<SignVO>(total, currentPage, 5, signVOList, keyword, "ajax");
			
			return articlePage;
		}
	
	
		// 종결함 리스트 조회
		@GetMapping("/end") 
		public String end(SignVO signVO,Model model,
			@RequestParam(value="currentPage",required=false,defaultValue="1")int currentPage,
			@RequestParam(value="keyword",required = false, defaultValue = "")String keyword
			,Principal principal) {

			//로그인 한 아이디
			String empNo = principal.getName();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("currentPage", currentPage);
			map.put("keyword", keyword);
			map.put("empNo", empNo);
			
			log.info("list->map:" + map);
			
			// 전체 행의 수
			int total = this.signService.getEndTotal(map);
			log.info("list->total:" + total);
			
			//map{currentPage=1, keyword=}
			List<SignVO> signVOList = this.signService.end(map);
			log.info("list->signVOList : " + signVOList);
			/*list->signVOList : [SignVO(docNo=1, docTitle=신입사원 입사 기념품, docContent=null, writeDate=2025-01-02, 
			empNo=6, appDocNo=0, appStatusCode=1, appStatusName=대기, appDocName=null, empName=양마강, postNo=0, 
			postName=과장, deptNo=0, deptName=개발부, rnum=1), */
			
			//페이지네이션
			ArticlePage<SignVO> articlePage = 
					new ArticlePage<SignVO>(total, currentPage, 5, signVOList, keyword);
			
			model.addAttribute("signVOList",signVOList);
			model.addAttribute("articlePage",articlePage);
			
			return "sign/end";
		}
		
		// 비동기 종결함 리스트 조회
		@ResponseBody
		@PostMapping("/endAjax")
		public ArticlePage<SignVO> endAjax(@RequestBody Map<String, Object> map,Principal principal) {
			log.info("listAjax->map : " +map);
			
			//로그인 아이디
			String reappEmpId = principal.getName();
			
			map.put("reappEmpId", reappEmpId);
			
			log.info("listAjax->map : " +map);
			
			
			//전체 행의 수
			int total = this.signService.getEndTotal(map);
			
			List<SignVO> signVOList = this.signService.end(map);
			
			int currentPage = Integer.parseInt(map.get("currentPage").toString());
			
			String keyword = "";
			
			if(map.get("keyword")!=null) {
				keyword = map.get("keyword").toString();
			}
			
			// 비동기 페이지 네이션 : ajax
			ArticlePage<SignVO> articlePage
				= new ArticlePage<SignVO>(total, currentPage, 5, signVOList, keyword, "ajax");
			
			return articlePage;
		}
		
		// 반려함 리스트 조회
		@GetMapping("/collect")
		public String collect(SignVO signVO,Model model,
			@RequestParam(value="currentPage",required=false,defaultValue="1")int currentPage,
			@RequestParam(value="keyword",required = false, defaultValue = "")String keyword
			,Principal principal) {

			//로그인 한 아이디
			String empNo = principal.getName();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("currentPage", currentPage);
			map.put("keyword", keyword);
			map.put("empNo", empNo);
			log.info("list->map:" + map);
			
			// 전체 행의 수
			int total = this.signService.getCollectTotal(map);
			log.info("list->total:" + total);
			
			//map{currentPage=1, keyword=}
			List<SignVO> signVOList = this.signService.collect(map);
			log.info("list->signVOList : " + signVOList);
			/*list->signVOList : [SignVO(docNo=1, docTitle=신입사원 입사 기념품, docContent=null, writeDate=2025-01-02, 
			empNo=6, appDocNo=0, appStatusCode=1, appStatusName=대기, appDocName=null, empName=양마강, postNo=0, 
			postName=과장, deptNo=0, deptName=개발부, rnum=1), */
			
			//페이지네이션
			ArticlePage<SignVO> articlePage = 
					new ArticlePage<SignVO>(total, currentPage, 5, signVOList, keyword);
			
			model.addAttribute("signVOList",signVOList);
			model.addAttribute("articlePage",articlePage);
			
			return "sign/collect";
		}
		
		// 비동기 반려함 리스트 조회
		@ResponseBody
		@PostMapping("/collectAjax")
		public ArticlePage<SignVO> collectAjax(@RequestBody Map<String, Object> map,Principal principal) {
			log.info("listAjax->map : " +map);
			
			//로그인 아이디
			String reappEmpId = principal.getName();
			
			map.put("reappEmpId", reappEmpId);
			
			//전체 행의 수
			int total = this.signService.getCollectTotal(map);
			
			List<SignVO> signVOList = this.signService.collect(map);
			
			int currentPage = Integer.parseInt(map.get("currentPage").toString());
			
			String keyword = "";
			
			if(map.get("keyword")!=null) {
				keyword = map.get("keyword").toString();
			}
			
			// 비동기 페이지 네이션 : ajax
			ArticlePage<SignVO> articlePage
				= new ArticlePage<SignVO>(total, currentPage, 5, signVOList, keyword, "ajax");
			
			return articlePage;
		}
		
		
		// 열람/공람 리스트 조회
		@GetMapping("/reading")
		public String reading(SignVO signVO,Model model,
			@RequestParam(value="currentPage",required=false,defaultValue="1")int currentPage,
			@RequestParam(value="keyword",required = false, defaultValue = "")String keyword
			,Principal principal) {

			//로그인 한 아이디
			String empNo = principal.getName();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("currentPage", currentPage);
			map.put("keyword", keyword);
			map.put("empNo", empNo);
			log.info("list->map:" + map);
			
			// 전체 행의 수
			int total = this.signService.getReadingTotal(map);
			log.info("list->total:" + total);
			
			//map{currentPage=1, keyword=}
			List<SignVO> signVOList = this.signService.reading(map);
			log.info("list->signVOList : " + signVOList);
			/*list->signVOList : [SignVO(docNo=1, docTitle=신입사원 입사 기념품, docContent=null, writeDate=2025-01-02, 
			empNo=6, appDocNo=0, appStatusCode=1, appStatusName=대기, appDocName=null, empName=양마강, postNo=0, 
			postName=과장, deptNo=0, deptName=개발부, rnum=1), */
			
			//페이지네이션
			ArticlePage<SignVO> articlePage = 
					new ArticlePage<SignVO>(total, currentPage, 5, signVOList, keyword);
			
			model.addAttribute("signVOList",signVOList);
			model.addAttribute("articlePage",articlePage);
			
			return "sign/reading";
		}
		
		// 비동기 열람/공람 리스트 조회
		@ResponseBody
		@PostMapping("/readingAjax")
		public ArticlePage<SignVO> readingAjax(@RequestBody Map<String, Object> map, Principal principal) {
			log.info("listAjax->map : " +map);
			
			//로그인 아이디
			String reappEmpId = principal.getName();
			
			map.put("reappEmpId", reappEmpId);
			//전체 행의 수
			int total = this.signService.getReadingTotal(map);
			
			List<SignVO> signVOList = this.signService.reading(map);
			
			int currentPage = Integer.parseInt(map.get("currentPage").toString());
			
			String keyword = "";
			
			if(map.get("keyword")!=null) {
				keyword = map.get("keyword").toString();
			}
			
			// 비동기 페이지 네이션 : ajax
			ArticlePage<SignVO> articlePage
				= new ArticlePage<SignVO>(total, currentPage, 5, signVOList, keyword, "ajax");
			
			return articlePage;
		}
		// 부서문서함 리스트 조회
		@GetMapping("/department")
		public String department(SignVO signVO,Model model,
			@RequestParam(value="currentPage",required=false,defaultValue="1")int currentPage,
			@RequestParam(value="keyword",required = false, defaultValue = "")String keyword
			,Principal principal) {

			//로그인 한 아이디
			String empNo = principal.getName();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("currentPage", currentPage);
			map.put("keyword", keyword);
			map.put("empNo", empNo);
			log.info("list->map:" + map);
			
			// 전체 행의 수
			int total = this.signService.getDepartmentTotal(map);
			log.info("list->total:" + total);
			
			//map{currentPage=1, keyword=}
			List<SignVO> signVOList = this.signService.department(map);
			log.info("list->signVOList : " + signVOList);
			/*list->signVOList : [SignVO(docNo=1, docTitle=신입사원 입사 기념품, docContent=null, writeDate=2025-01-02, 
			empNo=6, appDocNo=0, appStatusCode=1, appStatusName=대기, appDocName=null, empName=양마강, postNo=0, 
			postName=과장, deptNo=0, deptName=개발부, rnum=1), */
			
			//페이지네이션
			ArticlePage<SignVO> articlePage = 
					new ArticlePage<SignVO>(total, currentPage, 5, signVOList, keyword);
			
			model.addAttribute("signVOList",signVOList);
			model.addAttribute("articlePage",articlePage);
			
			return "sign/department";
		}
		
		// 비동기 부서문서함 리스트 조회
		@ResponseBody
		@PostMapping("/departmentAjax")
		public ArticlePage<SignVO> departmentAjax(@RequestBody Map<String, Object> map, Principal principal) {
			log.info("listAjax->map : " +map);
			
			//로그인 아이디
			String reappEmpId = principal.getName();
			
			map.put("reappEmpId", reappEmpId);
			
			//전체 행의 수
			int total = this.signService.getDepartmentTotal(map);
			
			List<SignVO> signVOList = this.signService.department(map);
			
			int currentPage = Integer.parseInt(map.get("currentPage").toString());
			
			String keyword = "";
			
			if(map.get("keyword")!=null) {
				keyword = map.get("keyword").toString();
			}
			
			// 비동기 페이지 네이션 : ajax
			ArticlePage<SignVO> articlePage
				= new ArticlePage<SignVO>(total, currentPage, 5, signVOList, keyword, "ajax");
			
			return articlePage;
		}
	
	@GetMapping("/signHome")
	public String signHome(SignVO signVO,Model model,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required = false, defaultValue = "") String keyword,
			Principal principal){
		
			//로그인 아이디
			String reappEmpId = principal.getName();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("currentPage", currentPage);
			map.put("keyword", keyword);
			map.put("reappEmpId", reappEmpId);
			log.info("list->map:" + map);
			
			// 전체 행의 수
			int total = this.signService.getTotal(map);
			log.info("list->total:" + total);
			
			//map{currentPage=1, keyword=}
			//대기
			List<SignVO> signVOList1 = this.signService.signList(map);
			//요청
			List<SignVO> signVOList2 = this.signService.request(map);
			//반려
			List<SignVO> signVOList3 = this.signService.collect(map);
			//종결
			List<SignVO> signVOList4 = this.signService.end(map);
			//부서
			List<SignVO> signVOList5 = this.signService.department(map);
			log.info("signHome ->signVOList5",signVOList5);
			//첨부
			List<SignVO> signVOList6 = this.signService.reading(map);
			
			//페이지네이션반
			ArticlePage<SignVO> articlePage = 
					new ArticlePage<SignVO>(total, currentPage, 5, signVOList5, keyword);
			
			model.addAttribute("signVOList1",signVOList1);
			model.addAttribute("signVOList2",signVOList2);
			model.addAttribute("signVOList3",signVOList3);
			model.addAttribute("signVOList4",signVOList4);
			model.addAttribute("signVOList5",signVOList5);
			model.addAttribute("signVOList6",signVOList6);
			model.addAttribute("articlePage",articlePage);
		
		return "sign/signHome";
	}
	
}
