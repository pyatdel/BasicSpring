package kr.or.ddit.workspace.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.contract.vo.ContractMasterVO;
import kr.or.ddit.file.vo.FileDetailVO;
import kr.or.ddit.file.vo.FileGroupVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.workspace.service.fileStorageService;
import kr.or.ddit.workspace.vo.FileStorageVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@RequestMapping("/file")
@Controller
public class FileStorageboxController {

	@Autowired
	fileStorageService fileStorageService;
	
	@GetMapping("/storage")
	public String filestorage() {
		return "workspace/filestorage/home";
		
	}
	@GetMapping("/list")
	public String fileList(Model model ,@RequestParam(value="keyword" , required = false, defaultValue = "") String keyword,
			@RequestParam(value="currentPage",required = false,defaultValue = "1")int currentPage,FileStorageVO fileStorageVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword" ,keyword);
		map.put("currentPage" ,currentPage);
		int total = this.fileStorageService.getTotal(map);
		List<FileStorageVO> fileStorageServiceList = this.fileStorageService.list(map);
		//log.info("contractMasterVOList"+contractMasterVOList);
		model.addAttribute("fileStorageServiceList",fileStorageServiceList);
		model.addAttribute("fileStorageVO",fileStorageVO);
		model.addAttribute("articlePage",
				new ArticlePage<FileStorageVO>(total, currentPage, 10,fileStorageServiceList, keyword));
		return "workspace/filestorage/home";	
		
		
		
		
	}
	@ResponseBody
	@PostMapping("/listAxios")
	public ArticlePage<FileStorageVO> listAxios(@RequestBody  Map<String,Object>map,FileStorageVO fileStorageVO, Model model){
		
		
		int total = this.fileStorageService.getTotal(map);

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
		List<FileStorageVO>fileVOList = this.fileStorageService.list(map);
		ArticlePage<FileStorageVO> articlePage = new ArticlePage<FileStorageVO>(total, currentPage, 10, fileVOList, keyword,"ajax");
		//log.debug("fileVOList {} "+fileVOList);

		model.addAttribute("fileStorageVO",fileStorageVO);
		// 데이터 리턴 -> ResponseBody(Object -> String ) = Serialize
		return articlePage;

	}
	
	@ResponseBody
	@PostMapping("/myListAxios")
	public ArticlePage<FileStorageVO> myListAxios(@RequestBody  Map<String,Object>map,FileStorageVO fileStorageVO, Model model){
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		CustomUser userDetails = (CustomUser)principal; 
		log.info("commuteList->userDetails : " + userDetails.getMember());
		
		MemberVO memberVO = userDetails.getMember();
		int empNo = memberVO.getEmpNo();
		String empName = memberVO.getEmpName();
		

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
	    map.put("empNo", empNo);
	    map.put("empName", empName);
	    
	    log.debug("map {}" + map);
	    
	    
	    int total = this.fileStorageService.myGetTotal(map);
		List<FileStorageVO>myFileVOList = this.fileStorageService.myList(map);
		ArticlePage<FileStorageVO> articlePage = new ArticlePage<FileStorageVO>(total, currentPage, 10, myFileVOList, keyword,"ajax");
		log.debug("myFileVOList 체킁 {} "+myFileVOList);
	    fileStorageVO.setEmpNo(empNo); // 로그인한 사용자 empNo
		
	    log.debug("articlePage {}"+articlePage);
	    
	    log.debug("Received List size: {}", myFileVOList.size());
		// 데이터 리턴 -> ResponseBody(Object -> String ) = Serialize
		return articlePage;

	}
	
	@ResponseBody
	@PostMapping("/insert")
	public int fileInsert( FileStorageVO fileStorageVO) {
		//log.debug("insert {} ", fileStorageVO);
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		CustomUser userDetails = (CustomUser)principal; 
		log.info("commuteList->userDetails : " + userDetails.getMember());
		
		MemberVO memberVO = userDetails.getMember();
		int empNo = memberVO.getEmpNo();
		fileStorageVO.setFileType("com"); // "my"는 폴더 구분용
	    fileStorageVO.setEmpNo(empNo); // 로그인한 사용자 empNo
		int result = this.fileStorageService.insert(fileStorageVO); 
		
		return result;
		
	}
	@ResponseBody
	@PostMapping("/myInsert")
	public int myInsert(FileStorageVO fileStorageVO) {
		//UserDetailServiceImpl->CustomUser
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		CustomUser userDetails = (CustomUser)principal; 
		log.info("commuteList->userDetails : " + userDetails.getMember());
		
		MemberVO memberVO = userDetails.getMember();
		int empNo = memberVO.getEmpNo();
		
		log.info("commuteList->memberVO : " + memberVO);
		log.info("empNo :" + empNo);
		
		// FileStorageVO 객체에 type과 value 설정
	    fileStorageVO.setFileType("my"); // "my"는 폴더 구분용
	    fileStorageVO.setEmpNo(empNo); // 로그인한 사용자 empNo
		log.info("fileStorageVO 뜨냐" + fileStorageVO);
		int result = this.fileStorageService.myInsert(fileStorageVO);
		
		return result;                                        
		
	}
	
	@ResponseBody
	@PostMapping("/deptInsert")
	public int deptInsert(FileStorageVO fileStorageVO) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		CustomUser userDetails = (CustomUser)principal; 
		log.info("commuteList->userDetails : " + userDetails.getMember());
		
		MemberVO memberVO = userDetails.getMember();
		int empNo = memberVO.getEmpNo();
		int deptNo = memberVO.getDeptNo();

		log.info("commuteList->memberVO : " + memberVO);
		log.info("empNo :" + empNo);
		
		fileStorageVO.setFileType("dept");
		fileStorageVO.setEmpNo(empNo);
		fileStorageVO.setDeptNo(deptNo);

		log.info("fileStorageVO {}  " + fileStorageVO);
		int result = this.fileStorageService.deptInsert(fileStorageVO);
		
		log.info("result {}  " +result);
		return result;
		
		
		
	}

	@ResponseBody
	@PostMapping("/deptListAxios")
	public ArticlePage<FileStorageVO> deptListAxios(@RequestBody  Map<String,Object>map,FileStorageVO fileStorageVO, Model model){
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		CustomUser userDetails = (CustomUser)principal; 
		log.info("commuteList->userDetails : " + userDetails.getMember());
		
		MemberVO memberVO = userDetails.getMember();
		int empNo = memberVO.getEmpNo();
		String empName = memberVO.getEmpName();
		int deptNo = memberVO.getDeptNo();
		

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
	    map.put("empNo", empNo);
	    map.put("empName", empName);
	    map.put("deptNo", deptNo);
	    
	    log.debug("map {}" + map);
	    
	    
	    fileStorageVO.setEmpNo(empNo); // 로그인한 사용자 empNo
	    fileStorageVO.getDeptNo(); // 로그인한 사용자 empNo
	    
	    int total = this.fileStorageService.deptGetTotal(map);
		List<FileStorageVO>deptFileVOList = this.fileStorageService.deptFileVOList(map);
		ArticlePage<FileStorageVO> articlePage = new ArticlePage<FileStorageVO>(total, currentPage, 10, deptFileVOList, keyword,"ajax");
		log.debug("deptFileVOList 체킁 {} "+deptFileVOList);
	
	    log.debug("articlePage {}"+articlePage);
	    
	    log.debug("Received List size: {}", deptFileVOList.size());
		// 데이터 리턴 -> ResponseBody(Object -> String ) = Serialize
		return articlePage;

	}
	
	 // 파일 그룹 번호를 이용해 ZIP 파일을 다운로드
    @GetMapping("/download/zip/{fileGroupNo}")
    public ResponseEntity<Resource> downloadZip(@PathVariable long fileGroupNo) {
        return this.fileStorageService.downloadZip(fileGroupNo);
    }
		
}
