package kr.or.ddit.contract.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.contract.service.TaxInvoiceService;
import kr.or.ddit.contract.vo.ContractDetailVO;
import kr.or.ddit.contract.vo.ContractMasterVO;
import kr.or.ddit.contract.vo.ContractObjectVO;
import kr.or.ddit.contract.vo.EnterPriceVO;
import kr.or.ddit.contract.vo.TaxinvoiceVO;
import kr.or.ddit.util.ArticlePage;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/taxin")
public class TaxinvoiceController {

	@Autowired
	TaxInvoiceService taxInvoiceService;
	
	// 세금계산서 리스트 조회
	@GetMapping("/list")
	public String list(Model model, @RequestParam(value="keyword" , required = false, defaultValue = "") String keyword,
			@RequestParam(value="currentPage",required = false,defaultValue = "1")int currentPage) {
		Map<String, Object> map = new HashMap<String, Object>();
		log.info("map",map);
		map.put("keyword" ,keyword);
		map.put("currentPage" ,currentPage);
		int total = this.taxInvoiceService.getTotal(map);
		List<TaxinvoiceVO> taxinvoiceVOList = this.taxInvoiceService.list(map);
		log.info("taxinvoiceVOList"+taxinvoiceVOList);
		model.addAttribute("taxinvoiceVOList",taxinvoiceVOList);
		model.addAttribute("articlePage",
				new ArticlePage<TaxinvoiceVO>(total, currentPage, 10,taxinvoiceVOList, keyword));
	
		return "contract/taxin/list";
		
		
	}
	
	// 세금계산서 상세 조회
	@RequestMapping(value="/detail",method = RequestMethod.GET)
	public String taxinDetail(ContractDetailVO contractDetailVO,ContractMasterVO contractMasterVO, TaxinvoiceVO taxinvoiceVO,ContractObjectVO contractObjectVO, Model model) {
	
		taxinvoiceVO = this.taxInvoiceService.taxinDetail(taxinvoiceVO);
		
		List<ContractObjectVO> contractObjectVOList = this.taxInvoiceService.objectDetail(contractObjectVO);
		
		model.addAttribute("contractObjectVOList",contractObjectVOList);
		model.addAttribute("contractDetailVO",contractDetailVO);
		model.addAttribute("taxinvoiceVO",taxinvoiceVO);
		log.info("taxinvoiceVO  => detail :"+taxinvoiceVO);
		log.info("contractDetailVO  => detail :"+contractDetailVO);
		log.info("contractMasterVO  => detail :"+contractMasterVO);
		
		return "contract/taxin/detail";
		
		
	}


//	public int taxinUp(TaxinvoiceVO taxInvoiceVO);

	
	// 세금계산서 등록
	@GetMapping("/create")
	public String taxinCreate(ContractObjectVO contractObjectVO, Model model) {
		
		List<ContractObjectVO> contractObjectVOList = this.taxInvoiceService.objectDetail(contractObjectVO);
		model.addAttribute("contractObjectVOList",contractObjectVOList);
		
		return "contract/taxin/create";
		
	}

	@PostMapping("/createPost")
	public String createPost(@ModelAttribute TaxinvoiceVO taxinvoiceVO) {
		
		log.info("taxinvoiceVO : " + taxinvoiceVO);
		
		int result = this.taxInvoiceService.taxinCreate(taxinvoiceVO);
		String tiCode  =taxinvoiceVO.getTiCode();
		
		log.info("result : "+result);
		
		
		return "redirect:/taxin/list";
		
		/* int result = this.taxInvoiceService.taxinCreate(taxinvoiceVO); */
		
		
	}
	

	@ResponseBody
	@PostMapping("/insertAll")
	public int insertDetailAll(@RequestBody List<ContractDetailVO> contractDetailList,String tiCode) {
	        log.info(" ContractDetailVO List: {}", contractDetailList);
	        
	        int result = 0;
	        for (ContractDetailVO contractDetail : contractDetailList) {
	        	result += taxInvoiceService.insertDetailAll(contractDetail);
			}
	        log.info("추가 결과(result) : " + result);
	        
	        // 결과를 모델에 추가하여 View로 전달
	        
	        // 필터링된 리스트를 model에 추가
	        return result;  // 처리 후 결과를 보여주는 페이지로 리다이렉트
    }
	
	
	// 세금계산서 리스트조회 비동기
	@ResponseBody
	@RequestMapping(value="/listAjax",method=RequestMethod.POST)
	public ArticlePage<TaxinvoiceVO> listAjax(@RequestBody Map<String,Object>map){
		
		
		int getTotal = this.taxInvoiceService.getTotal(map);
		
//		String contractNo = map.get("contractNo").toString();
	
		int currentPage = 1; 
		String entName = "";
		String tiTransdate = "";
		String tiIssuedate = "";
		String busNo = "";
		long contractNo = 1;
		if (map.get("currentPage") != null) {
			// null .toString() 은 오류 발생
			 currentPage = Integer.parseInt(map.get("currentPage").toString());
		}
		if (map.get("entName") != null) {
			// null .toString() 은 오류 발생
			 entName = map.get("entName").toString();
		}
		if (map.get("tiTransdate") != null) {
			// null .toString() 은 오류 발생
			 tiTransdate = map.get("tiTransdate").toString();
		}
		if (map.get("tiIssuedate") != null) {
			// null .toString() 은 오류 발생
			 tiIssuedate = map.get("tiIssuedate").toString();
		}
		if (map.get("busNo") != null) {
			// null .toString() 은 오류 발생
			 busNo = map.get("busNo").toString();
		}
		if (map.get("contractNo") != null ) {
			// null .toString() 은 오류 발생
			 contractNo =  (long) map.get("contractNo");
		}
		
		
		 
//		map.put("contractNo", contractNo);
	    map.put("entName", entName);
	    map.put("tiTransdate", tiTransdate);
	    map.put("tiIssuedate", tiIssuedate);
	    map.put("busNo", busNo);
	    map.put("currentPage", currentPage);
	    map.put("contractNo", contractNo);
		
	    log.info("map : " + map);
	    List<TaxinvoiceVO>taxinvoiceVOList = this.taxInvoiceService.list(map);
	    
	    ArticlePage<TaxinvoiceVO> articlePage = new ArticlePage<TaxinvoiceVO>(getTotal, currentPage, 10, taxinvoiceVOList, entName);
	    
		return articlePage;
		
	}
	
	// 거래처 리스트 비동기
	@ResponseBody
	@RequestMapping(value="/entListAjax",method=RequestMethod.POST)
	public ArticlePage<EnterPriceVO> entListAjax(@RequestBody Map<String,Object>map,EnterPriceVO enterPriceVO, Model model){
		int getTotal = this.taxInvoiceService.getEntsTotal(map);

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
		
	    log.info("map : " + map);
	    List<EnterPriceVO>enterPriceVOList = this.taxInvoiceService.getEnpList(map);
	    
	    ArticlePage<EnterPriceVO> articlePage = new ArticlePage<EnterPriceVO>(getTotal, currentPage, 10, enterPriceVOList, keyword,"ajax");
	    log.info("enterpriceVOList" + enterPriceVOList);
	    log.info("enterPriceVO"+ enterPriceVO);
		return articlePage;
	
	
	}
	
	@PostMapping("/delete")
	public String deleteTaxin(TaxinvoiceVO taxinvoiceVO) {
		int result = this.taxInvoiceService.deleteTaxin(taxinvoiceVO);
		
		
		return "redirect:/taxin/list";
		
	}
/*	
	@PostMapping("/insertAll")
	public String insertDetailAll(@RequestParam(value = "contractDetailNo[]", required = false) int[] detailNos,
	                              ContractDetailVO contractDetailVO) {
	    // detailNos가 null이 아니고 비어있지 않으면
	    if (detailNos != null && detailNos.length > 0) {
	        contractDetailVO.setDetailNos(detailNos);
	    } else {
	        // error handling (optional)
	        log.error("contractDetailNo 배열이 null이거나 비어 있습니다.");
	        return "errorPage"; // 오류 처리 페이지
	    }

	    log.info("detailVO 넘어오니" + contractDetailVO);
	    
	    int result = this.taxInvoiceService.insertDetailAll(contractDetailVO);
	    
	    return "taxin/list"; // 성공적인 결과 페이지로 리다이렉트
	}
*/
	/*
	@PostMapping("/insertAll")
	public String insertDetailAll(@ModelAttribute("contractDetailList") List<ContractDetailVO> contractDetailList, Model model) {
	    log.info("Received ContractDetailVO List: {}", contractDetailList);
	    
	    // 비즈니스 로직 수행 (필터링 또는 DB에 삽입 등)
	    contractDetailList = contractDetailList.stream()
	            .filter(detail -> detail.getItemCode() != null && !detail.getItemCode().isEmpty())
	            .filter(detail -> detail.getItemQty() > 0)
	            .filter(detail -> detail.getItemPrice() > 0)
	            .filter(detail -> detail.getContractDetailNo() > 0)
	            .filter(detail -> detail.getTiVat() > 0)
	            .collect(Collectors.toList());
	    
	    // 처리 결과를 모델에 추가
	    model.addAttribute("contractDetailList", contractDetailList);
	    
	    // 서비스 호출
	    int result = taxInvoiceService.insertDetailAll(contractDetailList);
	    
	    return "taxin/list";  // 처리 후 결과 페이지로 리다이렉트
	}*/
	/*
	@PostMapping("/insertAll")//@RequestParam(value="contractDetailList[]",required = false)
	public String insertDetailAll(@ModelAttribute  List<ContractDetailVO> contractDetailList, Model model) {
	        log.info("Received ContractDetailVO List: {}", contractDetailList);
	        
	        // contractDetailList가 null이면 빈 리스트로 초기화
	        if (contractDetailList == null) {
	            contractDetailList = new ArrayList<>();
	        }

	        
	        contractDetailList = contractDetailList.stream()
		            .filter(detail -> detail.getItemCode() != null && !detail.getItemCode().isEmpty())
		            .filter(detail -> detail.getItemQty() > 0)
		            .filter(detail -> detail.getItemPrice() > 0)
		            .filter(detail -> detail.getContractDetailNo() > 0)
		            .filter(detail -> detail.getTiVat() > 0)
		            .collect(Collectors.toList());
	        // 리스트를 통해 insertDetailAll 호출
	        int result = taxInvoiceService.insertDetailAll(contractDetailList);

	        // 결과를 모델에 추가하여 View로 전달
	        
	        // 필터링된 리스트를 model에 추가
	        model.addAttribute("contractDetailList", contractDetailList);
	        return "taxin/list";  // 처리 후 결과를 보여주는 페이지로 리다이렉트
	    }
*/
	
	

}
