package kr.or.ddit.personnel.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.ui.Model;

import kr.or.ddit.personnel.service.DepartmentService;
import kr.or.ddit.personnel.service.EmployeeListService;
import kr.or.ddit.personnel.service.PositionService;
import kr.or.ddit.personnel.vo.DepartmentVO;
import kr.or.ddit.personnel.vo.EmployeeVO;
import kr.or.ddit.personnel.vo.PositionVO;
import kr.or.ddit.util.ArticlePage;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/personnel")
@Controller
@Slf4j
public class EmployeeListController {
	
	@Autowired
	PasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	EmployeeListService employeeListService;
	
	@Autowired
	DepartmentService departmentService;
	
	@Autowired
	PositionService positionService;

	
	//직원 차트
	@PostMapping("/chart")
	@ResponseBody
	public Map<String, Object> chartList(@RequestBody Map<String, Object> map) {
	    // 연도별 입사자, 퇴사자, 총인원수 가져오기
	    List<EmployeeVO> chartList = this.employeeListService.chartList(map);
	    log.info("listAjax->chartList : " + chartList);

	    // 데이터 확인
	    if (chartList == null || chartList.isEmpty()) {
	        log.error("차트 데이터가 비어있습니다.");
	    } else {
	        log.info("차트 데이터: " + chartList);
	    }
	    
	    Map<String, Object> response = new HashMap<>();
	    response.put("chartList", chartList);  // 차트 데이터만 반환

	    return response;
	}
	
	// 직원목록 조회
	@GetMapping("/list")
	public String list(EmployeeVO employeeVO,Model model,
			@RequestParam(value="currentPage",required=false,defaultValue = "1")int currentPage,
			@RequestParam(value="keyword",required = false,defaultValue = "")String keyword) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		log.info("list->map:" + map);

		// 전체 행의 수
		int total = this.employeeListService.getTotal(map);
		log.info("list->total : "+total);
		
		//직원 리스트
		List<EmployeeVO> employeeVOList = this.employeeListService.list(map);
		log.info("list->employeeVOList : " + employeeVOList);
		
		//부서
		List<DepartmentVO> departmentList = this.departmentService.getDepartmentList();
		
		//페이지네이션
		ArticlePage<EmployeeVO> articlePage =
				new ArticlePage<EmployeeVO>(total, currentPage,10, employeeVOList, keyword);
		
		model.addAttribute("departmentList",departmentList);
		model.addAttribute("employeeVOList",employeeVOList);
		model.addAttribute("articlePage",articlePage);
		
		return "personnel/list";
	}
	
	
	// 직원목록 조회
	/*
	 요청URI : /personnel/listAjax
	 요청파라미터 : JSONstring -> data{"currentPage": "1","keyword": ""}
	 요청방식 : post
	 */
	@ResponseBody
	@PostMapping("/listAjax")
	public ArticlePage<EmployeeVO> listAjax(@RequestBody Map<String, Object> map){
		//넘어옴 : data{"currentPage": "1","keyword": ""}
		//매핑됨 : map{"currentPage": "1","keyword": ""}
		//listAjax->map : {currentPage=1, keyword=대리}
		log.info("listAjax->map : " + map);
		
		//전체 행의 수
		int total = this.employeeListService.getTotal(map);
		log.info("list->total : " + total);
		
		//map{currentPage =1 ,keyword=}
		List<EmployeeVO> employeeVOList = this.employeeListService.list(map);
		log.info("list->employeeVOList : " + employeeVOList);
		
		// map.get(currentPage") : Object 타입
		int currentPage = Integer.parseInt(map.get("currentPage").toString());
		
		String keyword = "";//검색어가 없을 수 있으므로 처리

		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();// keyword에 값 넣기
		}	
		// 로그로 keyword 확인
	    log.info("검색어: " + keyword);
		
		//비동기 페이지네이션 : "ajax"
		ArticlePage<EmployeeVO> articlePage
			= new ArticlePage<EmployeeVO>(total, currentPage, 10, employeeVOList, keyword, "ajax");
		log.info("list->articlePage : " + articlePage);
		
		return articlePage;
	}
	
	// 퇴사자 조회
	@GetMapping("/resignList")
	public String resignList(EmployeeVO employeeVO,Model model,
		@RequestParam(value="currentPage",required=false,defaultValue = "1")int currentPage,
		@RequestParam(value="keyword",required = false,defaultValue = "")String keyword) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		log.info("resignList->map:" + map);

		// 전체 행의 수
		int total = this.employeeListService.getResignTotal(map);
		log.info("resignList->total : "+total);
		
		//직원 리스트
		List<EmployeeVO> resignVOList = this.employeeListService.resign(map);
		log.info("resignList->resignVOList : " + resignVOList);
		
		//부서
		List<DepartmentVO> departmentList = this.departmentService.getDepartmentList();
		
		//페이지네이션
		ArticlePage<EmployeeVO> articlePage =
				new ArticlePage<EmployeeVO>(total, currentPage,10, resignVOList, keyword);
		
		model.addAttribute("departmentList",departmentList);
		model.addAttribute("resignVOList",resignVOList);
		model.addAttribute("articlePage",articlePage);
		
		
		return "personnel/resign";
	}
		
	//퇴직자 조회
	@ResponseBody
	@PostMapping("/resign")
	public ArticlePage<EmployeeVO> resign(@RequestBody Map<String, Object> map){
		log.info("resign->map : " + map);
		
		//전체 행의 수
		int total = this.employeeListService.getResignTotal(map);
		log.info("list->total : " + total);
		
		//map{currentPage =1 ,keyword=}
		List<EmployeeVO> resignVOList = this.employeeListService.resign(map);
		log.info("resign->resignVOList : " + resignVOList);
		
		// map.get(currentPage") : Object 타입
		int currentPage = Integer.parseInt(map.get("currentPage").toString());
		
		String keyword = "";//검색어가 없을 수 있으므로 처리

		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();// keyword에 값 넣기
		}	
		// 로그로 keyword 확인
	    log.info("검색어: " + keyword);
		
		//비동기 페이지네이션 : "ajax"
		ArticlePage<EmployeeVO> articlePage
			= new ArticlePage<EmployeeVO>(total, currentPage, 10, resignVOList, keyword, "ajax");
		log.info("list->articlePage : " + articlePage);
		
		return articlePage;
	}
	
	
	// 직원 조회 페이지
	@GetMapping("/detail")
	public String detail(EmployeeVO employeeVO, Model model) {
		
		//부서
		List<DepartmentVO> departmentVOList = this.departmentService.getDepartmentList();
		//[DepartmentVO(deptNo=1, deptName=인사부), DepartmentVO(deptNo=2, deptName=영업부), DepartmentVO(deptNo=3, deptName=개발부), DepartmentVO(deptNo=4, deptName=행정부), DepartmentVO(deptNo=5, deptName=회계부)]
		log.info("detail -> departmentVOList : " + departmentVOList);
		//직급
		List<PositionVO> positionVOList = this.positionService.getPositionList();
		log.info("detail -> positionVOList : " + positionVOList);
		
		model.addAttribute("departmentVOList", departmentVOList);
		model.addAttribute("positionVOList", positionVOList);
		
		employeeVO = this.employeeListService.detail(employeeVO);
		/*
		EmployeeVO(empNo=0, enabled=null, empId=20241226123, empPw=null, empName=윤근원, empEmail=test25@test.com, empPhone=010-6666-6666, empZip=null, empStreet=null, 
		empDetail=null, empSign=20250117015, empAnnual=0, empIn=null, empOut=null, deptNo=1, postNo=4,
		 rnum=0, residentNumber1=null, residentNumber2=null, deptName=null, postName=null, 
		 fileGroupVO=FileGroupVO(fileGroupNo=0, fileRegDate=null, 
		 fileDetailVOList=[FileDetailVO(fileSn=1, fileGroupNo=0, fileOriginalName=sign02.png, 
		 fileSaveName=8f0566f6-0d38-4805-b737-20872739487e_sign02.png, 
		 fileSaveLocate=/resources/upload/2025/01/17/8f0566f6-0d38-4805-b737-20872739487e_sign02.png, 
		 fileSize=4333, fileExt=png, fileMime=image/png, fileFancysize=4.23 KB, fileSaveDate=Fri Jan 17 20:59:47 KST 2025, fileDowncount=0)]), 
		 fileGroupNo=0, uploadFile=null)
		 */
		log.info("detail -> employeeVO : " + employeeVO);
		
		model.addAttribute("employeeVO",employeeVO);
		
		return "personnel/detail";
	}
	
	// 직원 수정 페이지
	@PostMapping("/updatePost")
	public String updatePost(EmployeeVO employeeVO) {
		
		//비밀번호 암호화 처리
		employeeVO.setEmpPw(this.bCryptPasswordEncoder.encode(employeeVO.getEmpPw()));
		log.info("updatePost->employeeVO : " + employeeVO);
		
		int result = this.employeeListService.updatePost(employeeVO);
		log.info("updatePost->result : " + result);
		
		return "redirect:/personnel/detail?empId="+employeeVO.getEmpId();
	}
	
	//JSONString {"empId": "20241224005","empName": "양2강","deptNo": "2","postNo": "2","empPhone": "010-5555-2722","empEmail": "test2@test.com"}
	@ResponseBody
	@PostMapping("/updatePostAjax")
	public int updatePostAjax(EmployeeVO employeeVO) {
		//employeeVO{"empId": "20241224005","empName": "양2강","deptNo": "2","postNo": "2","empPhone": "010-5555-2722","empEmail": "test2@test.com"}
		log.info("updatePostAjax->employeeVO : " + employeeVO);
		
		employeeVO.setEmpPw(this.bCryptPasswordEncoder.encode(employeeVO.getEmpPw()));
		
		int result = this.employeeListService.updatePost(employeeVO);
		log.info("updatePostAjax->result : " + result);
		
		return result;
	}
	
	
	
	// 직원 등록
	@GetMapping("/create")
	public String create(Model model) {
		
		//부서
		List<DepartmentVO> departmentVOList = this.departmentService.getDepartmentList();
		log.info("create -> departmentVOList : " + departmentVOList);
		
		//직급
		List<PositionVO> positionVOList = this.positionService.getPositionList();
		log.info("create -> positionVOList : " + positionVOList);
		
		model.addAttribute("departmentVOList", departmentVOList);
		model.addAttribute("positionVOList", positionVOList);
		
		return "personnel/create";
	}
	
	@PostMapping("/createPost")
	public String createPost(EmployeeVO employeeVO) {
		
		employeeVO.setEmpPw(this.bCryptPasswordEncoder.encode(employeeVO.getEmpPw()));
		log.info("createPost->employeeVO : " + employeeVO);
		
		int result = this.employeeListService.createPost(employeeVO);
		
		return "redirect:/personnel/detail?empId="+employeeVO.getEmpId(); //redirect 다른 URI로 보낸다는 뜻
	}
	
	@ResponseBody
	@PostMapping("/createPostAjax")
	public int createPostAjax(EmployeeVO employeeVO) {
		/*
		 EmployeeVO(empNo=0, enabled=null, empId=20241231113, empPw=1111, empName=근원근, empEmail=test7@test.com, 
		 empPhone=010-5555-7777, empZip=null, empStreet=null, empDetail=null, empSign=null, empAnnual=0, empIn=null, 
		 empOut=null, deptNo=3, postNo=0, rnum=0, residentNumber1=null, residentNumber2=null, deptName=null, postName=null, 
		 fileGroupVO=null, fileGroupNo=0, uploadFile=[org.springframework.web.multipart.support.StandardMultipart..)
		 */
		log.info("createPostAjax->employeeVO:"+employeeVO);
		
		employeeVO.setEmpPw(this.bCryptPasswordEncoder.encode(employeeVO.getEmpPw()));
		/*
		 EmployeeVO(empNo=0, enabled=null, empId=20241231113, empPw=$2a$10$8sGhUYHlzSjwGTTIUW4gsOcfRUgFEIl2jYfsB8duUdSPzz/MFeifq, empName=근원근, empEmail=test7@test.com, 
		 empPhone=010-5555-7777, empZip=null, empStreet=null, empDetail=null, empSign=null, empAnnual=0, empIn=null, 
		 empOut=null, deptNo=3, postNo=0, rnum=0, residentNumber1=null, residentNumber2=null, deptName=null, postName=null, 
		 fileGroupVO=null, fileGroupNo=0, uploadFile=[org.springframework.web.multipart.support.StandardMultipart..)
		 */
		log.info("createPost->employeeVO : " + employeeVO);
		
		int result = this.employeeListService.createPost(employeeVO);
		log.info("createPostAjax->result :"+result);
		
		return result;
	}
	
	// 직원 삭제( 데이터에서 변경 처리)
	@PostMapping("/delete")
	public String delete(EmployeeVO employeeVO) {
		
		int result = this.employeeListService.delete(employeeVO);
		log.info("delete->result : "+result);
		
		return "redirect:/personnel/list";
	}
	
	@ResponseBody
	@PutMapping("/deletePostAjax")
	public int deletePostAjax(@RequestBody EmployeeVO employeeVO) {
		log.info("deletePostAjax->employeeVO : " + employeeVO);
		
		int result = this.employeeListService.delete(employeeVO);
		log.info("deletePostAjax->result : " + result);
		
		return result;
	}
	
	//직원 사원번호 중복 체크
	@ResponseBody
	@PostMapping("/idDupChk")
	public int idDupChk(@RequestBody EmployeeVO employeeVO) {
		
		int result = this.employeeListService.idDupChk(employeeVO);
		
		return result;
	}
	
}
