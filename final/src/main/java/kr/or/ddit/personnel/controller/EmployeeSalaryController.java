package kr.or.ddit.personnel.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.personnel.service.EmployeeListService;
import kr.or.ddit.personnel.service.EmployeeSalaryService;
import kr.or.ddit.personnel.vo.EmployeeSalaryVO;
import kr.or.ddit.personnel.vo.EmployeeVO;
import kr.or.ddit.system.vo.SystemReportVO;
import kr.or.ddit.util.ArticlePage;
import lombok.extern.slf4j.Slf4j;


@RequestMapping("/employeeSalary")
@Controller
@Slf4j
public class EmployeeSalaryController {
	
	
	 @Autowired 
	 EmployeeSalaryService employeeSalaryService;
	 
	 @Autowired
	 EmployeeListService employeeListService;
	
	//직원 급여 페이지 사원정보 가져오기(왼쪽)
	@GetMapping("/salaryList")
	public String salaryList(EmployeeSalaryVO employeeSalaryVO,Model model,
		@RequestParam(value="currentPage",required=false,defaultValue = "1")int currentPage,
		@RequestParam(value="keyword",required = false,defaultValue = "")String keyword,
		@RequestParam(value="year",required = false,defaultValue = "")String year,
		@RequestParam(value="month",required = false,defaultValue = "")String month,
		@RequestParam(value="empId",required = false, defaultValue="")String empId,
		@RequestParam(value="deptNo",required = false, defaultValue="")String deptNo
		) {
		
		if (month != null && !month.isEmpty()) {
	        month = String.format("%02d", Integer.parseInt(month)); // "01" 등으로 변경
	    }
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		map.put("year", year);
		map.put("month", month);
		//map{month=02, year=2025, currentPage=1, keyword=}
		log.info("salaryList->map:" + map);
		
		// 전체 행의 수
		int total = this.employeeSalaryService.getTotal(map);
		log.info("list->total : "+total);
		// 데이터 조회
		List<EmployeeSalaryVO> salaryVOList = this.employeeSalaryService.salaryList(map);
		
		//모달용-test
		List<EmployeeSalaryVO> modalList = this.employeeSalaryService.modalList(map);
		log.info("modalList size: " + (modalList != null ? modalList.size() : "null"));
		
		//페이지네이션
		ArticlePage<EmployeeSalaryVO> articlePage =
			new ArticlePage<EmployeeSalaryVO>(total, currentPage, 10, salaryVOList, keyword, map); //페이징 처리 이후 등록 버튼 클릭하면 에러 생김
		
		EmployeeSalaryVO select = null;
		for(EmployeeSalaryVO e : salaryVOList) {
			if(e.getEmpId().equals(empId)) select= e;
		}
		
		// salaryVOList를 Model에 추가하여 JSP로 전달
		model.addAttribute("year1", year);
	    model.addAttribute("month1", month);
		model.addAttribute("select", select);
		model.addAttribute("salaryVOList", salaryVOList);
		model.addAttribute("articlePage",articlePage);
		model.addAttribute("modalList",modalList);
		
		return "personnel/salaryList";
	}
	
	//요청URI : /employeeSalary/salaryListPost
	//요청파라미터 : JSONString{"year": "2024","month": "3"}
	@ResponseBody
	@PostMapping("/salaryListPost")
	public ArticlePage<EmployeeSalaryVO> salaryListPost(@RequestBody Map<String, Object> map) {
		//salaryListPost!->map : {year=2024, month=3}
		
		//map.put("currentPage", currentPage);//1페이지
		log.info("salaryListPost!->map : " + map);
		
		// 전체 행의 수
		int total = this.employeeSalaryService.getTotal(map);
		//list->total : 31
		log.info("salaryListPost!->total : "+total);
		// 데이터 조회(페이징, 키워드)
		List<EmployeeSalaryVO> salaryVOList = this.employeeSalaryService.salaryList(map);
//		salaryListPost!->salaryVOList : []
		log.info("salaryListPost!->salaryVOList : "+salaryVOList);
		
		String keyword = "";
		
		if(map.get("keyword") != null) {
			// null .toString() 은 오류 발생
			keyword = map.get("keyword").toString(); // keyword에 값 넣기
		}
		
		map.put("keyword", keyword);
//		salaryListPost! 체킁체킁 map : {year=, month=, keyword=}
		log.info("salaryListPost! 체킁체킁 map : " + map);
		
		int currentPage = Integer.parseInt(map.get("currentPage").toString());
		log.info("currentPage 너냐?",currentPage);
		// 페이지네이션
			ArticlePage<EmployeeSalaryVO> articlePage =
					new ArticlePage<EmployeeSalaryVO>(total, currentPage, 10, salaryVOList, keyword, "ajax");
		
		return articlePage;
	}
	
	
	// 급여 기록 불러오기
	@ResponseBody
	@PostMapping("/salaryPost")
	public EmployeeVO slaryPost(@RequestBody Map<String, Object> map) {
		//화긴!!{empId=20241226003}
		log.info("화긴!!"+map);
		String empId= map.get("empId").toString();
		
		EmployeeVO emp = this.employeeSalaryService.slaryPost(empId);
		log.info("화긴"+emp);
		return emp;
	}
	
	
	//formData2{"salary": "3000000","empId": "20241224004","foodExpense": "200000","papago": "2024-12-24"}
	//formData로 오면 RequestBody는 안 씀
	//달러("#btnSubmit").on("click",function(){ + 달러.ajax({ => 비동기 요청
	//급여 등록 페이지
	@ResponseBody
	@PostMapping("/salaryCreate")
	public int salaryCreate(EmployeeSalaryVO employeeSalaryVO) {
		/*
		EmployeeSalaryVO(empNo=0, enabled=null, empId=20161231004, modalEmpIds=null, empName=null, empZip=null, 
		empStreet=null, empDetail=null, empSign=null, empAnnual=0, empIn=null, empOut=null, deptNo=0, postNo=0, 
		rnum=0, residentNumber1=null, residentNumber2=null, salaryInputStatus=null, employeeCount=0, expDate=null, 
		expNo=0, deptName=null, postName=null, salaryNo=0, salary=6000000, foodExpense=200000, 
		papago=Wed Jan 01 00:00:00 KST 2025, payDay=0, addedHours=0, afterTax=0, 
		year=2025, 
		month=01, incomeTax=0, healthInsurance=0, nationalPension=0, 
		salaryIncomeTax=0, salaryHealthInsurance=0, salaryNationalPension=0, insurance=0, 
		difference=0, salaryTotal=0, totalSalary=0, totalFood=0, totalAddedHours=0)
		 */
		log.info("salaryCreate->employeeSalaryVO : " + employeeSalaryVO);
		
		int salaryDupChk = this.employeeSalaryService.salaryDupChk(employeeSalaryVO);
		log.info("salaryCreate->salaryDupChk : "+salaryDupChk);
		
		int result = 0;
		
		if(salaryDupChk>0) {//중복 됨
			
		}else {//중복 안 됨
			result = this.employeeSalaryService.salaryCreate(employeeSalaryVO);
			log.info("salaryCreate->result : "+result);
		}
		
		//비동기 요청에서는 redirect를 안 씀
//		return "redirect:/employeeSalary/salaryList?empNo="+employeeSalaryVO.getEmpNo();
		//비동기 요청에서는 데이터를 보냄
		return result;
	}
	
	@ResponseBody
	@PostMapping("/salaryCreateAjax")
	public int salaryCreateAjax(@RequestBody EmployeeSalaryVO employeeSalaryVO) {
		log.info("salaryCreateAjax->employeeSalaryVO:"+employeeSalaryVO);
		
		int result = this.employeeSalaryService.salaryCreate(employeeSalaryVO);
		log.info("salaryCreateAjax->result:"+result);
		return result;
	}
	
	// 일괄 지급 등록 (예산에서 지출)
	@PostMapping("/modalSalary")
	@ResponseBody
	public int modalSalary(@RequestBody  Map<String, Object> map, EmployeeSalaryVO employeeSalaryVO) {
		log.info("modalSalary->map : " + map);
		log.info("employeeSalaryVO->map : " + employeeSalaryVO);
		
		 // map에서 필요한 값 추출
		//List<String> empIdList= (List) map.get("empId");
		List<String> empIdList= (List) map.get("empId");
	    String expDate = (String) map.get("expDate");
	    String year = (String) map.get("year");
	    String month = (String) map.get("month");
		log.info("List(empIdList) : " + empIdList);
		log.info("expDate : " + expDate);
		log.info("year : " + year);
		log.info("month : " + month);
		
		if (month != null && !month.isEmpty()) {
			month = String.format("%02d", Integer.parseInt(month)); // "01" 등으로 변경
		}
		log.info("변환된 달(month) : " + month);
		int modalTotal = 0;
		
		map.put("expDate", expDate);
		map.put("year", year);
		map.put("month", month);
		for(String empId : empIdList) {
			Map queryMap = new HashMap();
			queryMap.put("empId", empId);
			queryMap.put("expDate", expDate);
			queryMap.put("year", year);
			queryMap.put("month", month);
			int modalList = this.employeeSalaryService.modalSalary(queryMap);
			modalTotal += modalList;
		}
			log.info("디비에 잘 들어갔니?(modalTotal) : "+modalTotal);
			
		for(String empId : empIdList) {
			Map queryMap = new HashMap();
			queryMap.put("empId", empId);
			queryMap.put("expDate", expDate);
			queryMap.put("year", year);
			queryMap.put("month", month);
			int modalList = this.employeeSalaryService.modalSalary2(queryMap);
			log.info("화긴 modalList"+modalList);
			
			modalTotal += modalList;
		}
		for(String empId : empIdList) {
			Map queryMap = new HashMap();
			queryMap.put("empId", empId);
			queryMap.put("expDate", expDate);
			queryMap.put("year", year);
			queryMap.put("month", month);
			int modalList = this.employeeSalaryService.modalSalary3(queryMap);
			log.info("화긴 modalList"+modalList);
			
			modalTotal += modalList;
		}
		
		
		
		return modalTotal;
	}
	
	//모달
//	@ResponseBody
//	@PostMapping("/modalListPost")
//	public ArticlePage<EmployeeSalaryVO> modalListPost(@RequestBody Map<String, Object> map) {
//		//modalListPost!->map : {}
//		log.info("modalListPost!->map : " + map);
//		
//		int currentPage = 1; //기본값
//		String keyword = "";
//		
//		if(map.get("currentPage")!=null) {
//			currentPage = Integer.parseInt(map.get("currentPage").toString());
//		}
//		
//		if(map.get("keyword") != null) {
//			// null .toString() 은 오류 발생
//			keyword = map.get("keyword").toString(); // keyword에 값 넣기
//		}
//		
//		map.put("currentPage", currentPage);
//		map.put("keyword", keyword);
//		
//		//체킁체킁 모달 map : {currentPage=1, keyword=}
//		log.info("modalListPost 체킁체킁 모달 map : " + map);
//		
//		// 전체 행의 수
//		int total = this.employeeSalaryService.getModalTotal(map);
//		//modalListPost->total : 31
//		log.info("modalListPost!->total : "+total);
//		// 데이터 조회(페이징, 키워드)
////		List<EmployeeSalaryVO> salaryVOList = this.employeeSalaryService.salaryList(map);
////		log.info("modalListPost!->salaryVOList : "+salaryVOList);
//		
//		
//		map.put(keyword, modalList);
//		
//		// 페이지네이션(모달용)
//			ArticlePage<EmployeeSalaryVO> modalArticlePage =
//					new ArticlePage<EmployeeSalaryVO>(total, 1, 8, modalList, keyword, 1);
//		log.info("modalArticlePage->pagingArea : " + modalArticlePage.getPagingArea());
//		
//		return modalArticlePage;
//	}
	@ResponseBody
	@PostMapping("/modalListPost")
	public List<EmployeeSalaryVO> modalListPost(@RequestBody EmployeeSalaryVO employeeSalaryVO) {
		
		//modalListPost!->map : {}
		log.info("modalListPost!->employeeSalaryVO : " + employeeSalaryVO);
		String keyword = "";
		String year = employeeSalaryVO.getYear();
		String month = employeeSalaryVO.getMonth();
		if (month != null && !month.isEmpty()) {
			month = String.format("%02d", Integer.parseInt(month)); // "01" 등으로 변경
		};
		Map<String, Object> map = new HashMap<>();
	    
		 if(map.get("keyword") != null) {
				// null .toString() 은 오류 발생
				keyword = map.get("keyword").toString(); // keyword에 값 넣기
			}
		map.put("keyword", keyword);
		map.put("year", year);
		map.put("month", month);
		log.info("Year: " + year);
		log.info("Month: " + month);
		log.info("Keyword: " + keyword);
		log.info("Map Contents: " + map);
		
		// 모달 리스트 불러오기
		List<EmployeeSalaryVO> modalListPost = this.employeeSalaryService.modalList(map);
		log.info("modalList size: " + (modalListPost != null ? modalListPost.size() : "null"));
		log.info("데이터데이터",modalListPost);
		
		
		return modalListPost;
	}
	
	//급여 중복 등록 체크
	@ResponseBody
	@PostMapping("/salaryDupChk")
	public int salaryDupChk(@RequestBody EmployeeSalaryVO employeeSalaryVO) {
		
		int result = this.employeeSalaryService.salaryDupChk(employeeSalaryVO);
		
		return result;
	}
	//급여 명세서
	@ResponseBody
	@GetMapping("/paystub")
	public String paystub(@RequestBody EmployeeSalaryVO employeeSalaryVO,Model model,
			Principal principal
			) {
			
			//로그인 한 아이디
			String empNo = principal.getName();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("empNo", empNo);
			
			// 데이터 조회
			List<EmployeeSalaryVO> paystubList = this.employeeSalaryService.paystubList(map);
			log.info("paystubList->map:" + map);
			
			// salaryVOList를 Model에 추가하여 JSP로 전달
		    model.addAttribute("empNo",empNo);
			model.addAttribute("paystubList", paystubList);
			
			return "personnel/paystub";
		}
	
}
