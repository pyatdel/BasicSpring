package kr.or.ddit.contract.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.contract.service.ContractMasterService;
import kr.or.ddit.contract.vo.ContViewVO;
import kr.or.ddit.contract.vo.ContractMasterVO;
import kr.or.ddit.contract.vo.EnterPriceVO;
import kr.or.ddit.contract.vo.TaxinvoiceVO;
import kr.or.ddit.util.ArticlePage;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/contract")
@Controller
public class ContractController {
	
	@Autowired
	ContractMasterService conMasterService;
	
	// 계약 리스트 동기
	@GetMapping("/list")
	public String contractList( Model model, @RequestParam(value="keyword" , required = false, defaultValue = "") String keyword,
			@RequestParam(value="currentPage",required = false,defaultValue = "1")int currentPage) {
		Map<String, Object> map = new HashMap<String, Object>();
		log.info("map",map);
		map.put("keyword" ,keyword);
		map.put("currentPage" ,currentPage);
		int total = this.conMasterService.getTotal(map);
		List<ContractMasterVO> contractMasterVOList = this.conMasterService.list(map);
		log.info("contractMasterVOList"+contractMasterVOList);
		model.addAttribute("contractMasterVOList",contractMasterVOList);
		model.addAttribute("articlePage",
				new ArticlePage<ContractMasterVO>(total, currentPage, 10,contractMasterVOList, keyword));
		return "contract/list";	
	}
	
	// 계약 리스트 비동기
	@ResponseBody
	@RequestMapping(value="/listAjax",method=RequestMethod.POST)
	public ArticlePage<ContractMasterVO> listAjax(@RequestBody Map<String,Object>map){
		int getTotal = this.conMasterService.getTotal(map);
		int currentPage = 1; 
		String entName = "";
		String contractNm = "";
		long contractNo = 1;
		String sort = "price"; // 기본 정렬 기준 (가격)
		String sortDirection = "DESC"; // 기본 정렬 방향 (내림차순)
		if (map.get("currentPage") != null) {
			// null .toString() 은 오류 발생
			 currentPage = Integer.parseInt(map.get("currentPage").toString());
		}
		if (map.get("entName") != null) {
			// null .toString() 은 오류 발생
			 entName = map.get("entName").toString();
		}
		if (map.get("contractNm") != null) {
			// null .toString() 은 오류 발생
			contractNm = map.get("contractNm").toString();
		}
		if (map.get("contractNo") != null ) {
			// null .toString() 은 오류 발생
			 contractNo =  (long) map.get("contractNo");
		}
		
		
		 
//		map.put("contractNo", contractNo);
	    map.put("entName", entName);
	    map.put("contractNm", contractNm);
	    map.put("currentPage", currentPage);
	    map.put("contractNo", contractNo);
		
	    log.info("map : " + map);
	    List<ContractMasterVO>contractMasterVOList = this.conMasterService.list(map);
	    
	    ArticlePage<ContractMasterVO> articlePage = new ArticlePage<ContractMasterVO>(getTotal, currentPage, 10, contractMasterVOList, entName);
	    
		return articlePage;
	
	
	}
	@ResponseBody
	@RequestMapping(value="/listAjaxSort",method=RequestMethod.POST)
	public ArticlePage<ContractMasterVO> listAjaxSort(@RequestBody Map<String,Object> map){
		
		
		log.debug("미강 : {} " , map);
		int getTotal = this.conMasterService.getTotal(map);
		int currentPage = 1; 
		String entName = "";
		String contractNm = "";
		String sort = "date"; // 기본 정렬 기준 (계약날짜)
		String direction = "DESC"; // 기본 정렬 방향 (내림차순)
		String state = "";
		
		if (map.get("currentPage") != null) {
			// null .toString() 은 오류 발생
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		}
		if (map.get("entName") != null) {
			// null .toString() 은 오류 발생
			entName = map.get("entName").toString();
		}
		if (map.get("contractNm") != null) {
			// null .toString() 은 오류 발생
			contractNm = map.get("contractNm").toString();
		}
	    if (map.get("sort") != null) {
//	        sort = map.get("sort").toString();  // 정렬 기준 (price, date 등)
	    	sort = (String) map.get("sort");
	        log.info("sort" + sort);
	    }
	    if (map.get("direction") != null) {
	  //      direction = map.get("direction").toString();  // 정렬 방향 (ASC, DESC)
	        direction = (String) map.get("direction");
	    }
	    if (map.get("state") != null) {
	  //      direction = map.get("direction").toString();  // 정렬 방향 (ASC, DESC)
	    	state = (String) map.get("state");
	    }
		
//		map.put("contractNo", contractNo);
		map.put("entName", entName);
		map.put("contractNm", contractNm);
		map.put("currentPage", currentPage);
	    map.put("sort", sort);  // 정렬 기준 추가
	    map.put("direction", direction);  // 정렬 기준 추가
	    map.put("state", state);  // 정렬 기준 추가
	    
		log.info("map : " + map);
		List<ContractMasterVO>contractMasterVOList = this.conMasterService.listPriceSort(map);
		
		ArticlePage<ContractMasterVO> articlePage = new ArticlePage<ContractMasterVO>(getTotal, currentPage, 10, contractMasterVOList, entName,"ajax");
		
		return articlePage;
		
		
	}
	
	// 계약 상세 
	@RequestMapping(value="/detail",method = RequestMethod.GET)
	public String detail(ContViewVO contViewVO,Model model) {
		contViewVO = this.conMasterService.detail(contViewVO);
		
		
		model.addAttribute("contViewVO",contViewVO);
		log.info("contViewVO  => detail :"+contViewVO);
		
		return "contract/detail";
		
		
	}
	// 계약 거래처 리스트 조회
	@GetMapping("/create")
	public String getEnpList(EnterPriceVO enterPriceVO,Model model) {
		
		
		List<EnterPriceVO>enterPriceVOList = this.conMasterService.getEnpList(enterPriceVO);
		List<ContViewVO>contViewVOList = this.conMasterService.getStatus();
		model.addAttribute("enterPriceVOList",enterPriceVOList);
		model.addAttribute("contViewVOList",contViewVOList);
		return "contract/create";
		
	}
	// 계약 수정 
	@PostMapping("/update")
	public String updateCm(ContViewVO contViewVO) {
		
		log.info("contView" +contViewVO);
		int result =this.conMasterService.updateCm(contViewVO);
		log.info("resutl " + result);
		return "redirect:/contract/detail?contractNo=" +contViewVO.getContractNo();
		
		
	}
	
	// 계약 삭제
	@PostMapping("/delete")
	public String deleteCm(ContViewVO contViewVO) {

		log.debug("contView : {}" + contViewVO);
		int result = this.conMasterService.deleteCm(contViewVO);
		
		log.info("result : " + result);
		
		return "redirect:/contract/list";
	}
	
	// 계약 등록 
	@PostMapping("/createPost")
	public String createCm(ContractMasterVO contractMasterVO,ContViewVO contViewVO,Model model) {

		
		int result = this.conMasterService.createCm(contractMasterVO);
		
		log.debug("contractMasterVO"+contractMasterVO);		
		return "redirect:/contract/detail?contractNo="+contractMasterVO.getContractNo();
		
		
		
	}
	
	@ResponseBody
	@GetMapping("/chartdata")
	public List<ContractMasterVO> chartContractData() {
		
		return this.conMasterService.chartData();
		
	}
	@ResponseBody
	@GetMapping("/yeardata")
	public List<ContractMasterVO> chartYearContractData() {
		
		return this.conMasterService.chartYearData();
		
	}
	
}
