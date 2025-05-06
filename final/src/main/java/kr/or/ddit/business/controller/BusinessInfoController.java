package kr.or.ddit.business.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.business.service.BusinessInfoService;
import kr.or.ddit.business.vo.EnterpriceVO;
import kr.or.ddit.contract.vo.ContViewVO;
import kr.or.ddit.personnel.vo.EmployeeVO;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.CustInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/business")
public class BusinessInfoController {
	
	@Autowired
	BusinessInfoService businessInfoService;
	
	@GetMapping("/infoList")
    public String list(
        @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
        @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
        Model model) {
        
        Map<String, Object> params = new HashMap<>();
        params.put("currentPage", currentPage);
        params.put("keyword", keyword);

        List<CustInfoVO> custInfoVOList = businessInfoService.list(params);
        log.info("Retrieved customer info: {}", custInfoVOList);

        int total = businessInfoService.getTotal(params);
        ArticlePage<CustInfoVO> articlePage = new ArticlePage<>(total, currentPage, 10, custInfoVOList, keyword);
        
        model.addAttribute("custInfoVOList", custInfoVOList);
        model.addAttribute("articlePage", articlePage);
        
        return "business/infoList";
    }
	
	@ResponseBody
	@PostMapping("/listAjax")
	public ArticlePage<CustInfoVO> listAjax(@RequestBody Map<String, Object> map ,Model model) {
		//list->map : {currentPage=2, keyword=}
		log.info("list->map : " + map);
		
		//total, currentPage, size, content, keyword
		int total = this.businessInfoService.getTotal(map);
		log.info("list->total : " + total);
		
		List<CustInfoVO> custInfoVOList = this.businessInfoService.list(map);
		log.info("list->custInfoVOList : " + custInfoVOList);
		
		//1.currentPage
		//map.get("key") -> object 리턴
		int currentPage = 1; 
		//map.get("currentPage") -> null.toString () -> 오류 발생
		if(map.get("currentPage") != null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString()); 
		}
		
		//2. keyword
		String keyword ="";
		if(map.get("keyword") != null) {
			//map.get("keyword") -> null.toString () -> 오류 발생
			keyword = (map.get("keyword").toString());
		}
		
		//페이지 객체 "ajax" -> mode 파라미터를 추가하면서 오버로딩을 이용하여 동기, 비동기 분리
		ArticlePage<CustInfoVO> articlePage = 
				new ArticlePage<CustInfoVO>(total, currentPage, 10, custInfoVOList, keyword, "ajax");
				
		//데이터 리턴 -> ResponseBody(Object -> String)
		return articlePage;
	}
	
	
	@GetMapping("/detail")
	public String detail(@RequestParam(value = "entNo") int entNo, Model model) {
	    log.info("detail -> entNo :" + entNo);

	    CustInfoVO custInfoVO = this.businessInfoService.detail(entNo);
	    log.info("detail -> custInfoVO : " + custInfoVO);

//	    List<CustInfoVO> custInfoVOList = this.businessInfoService.detailList(entNo);
//	    log.info("detail -> custInfoVOList : " + custInfoVOList);

	    model.addAttribute("custInfoVO", custInfoVO);
//	    model.addAttribute("custInfoVOList", custInfoVOList);

	    return "business/detail"; // 뷰 이름 반환
//        return enterpriceVOList;
    }
	 
	//요청URI : /business/updatePost
	@PostMapping("/updatePost")
	public String updatePost(@ModelAttribute CustInfoVO custInfoVO) {
		log.info("updatePost->custInfoVO : " + custInfoVO);
		
		int result = this.businessInfoService.updatePost(custInfoVO);
		log.info("updatePost->result : " + result);
		
		//redirect : 새로운 URI를 재요청
//		return "redirect:/business/detail?entNo="+custInfoVO.getEntNo();
		return "redirect:/business/infoList";
	} 
	
	
	@ResponseBody
	@PutMapping("/updatePostAjax")
	public int updatePostAjax(@RequestBody CustInfoVO custInfoVO) {
		log.info("updatePostAjax->custInfoVO : " + custInfoVO);
		
		int result = this.businessInfoService.updatePost(custInfoVO);
		log.info("updatePostAjax->result : " + result);
		
		return result;
	}
	 
	 
	@ResponseBody
	@DeleteMapping("/deletePostAjax")
	public int deletePostAjax(@RequestBody CustInfoVO custInfoVO) {
		log.info("deletePostAjax -> custInfoVO : "+custInfoVO);
		
		int result = this.businessInfoService.deletePost(custInfoVO);
		log.info("deletePostAjax->result : " + result);
		
		return result;
		
	}

	 
	 @GetMapping("/create")
	 public String create(CustInfoVO custInfoVO) {
		 
		 return "business/create";
	 }
	 
	 //기업 번호 중복 체크
	 @ResponseBody
	 @PostMapping("/idDupChk")
	 public int idDupChk(@RequestBody CustInfoVO custInfoVO) {
		 log.info("idDupChk -> custInfoVO : "+ custInfoVO);
		
		 int result = this.businessInfoService.idDupChk(custInfoVO);
		 log.info("idDupChk -> result : "+ result);
		
		 return result;
	}
	 
		
	 @PostMapping("/createPost")
	 public String createPost(CustInfoVO custInfoVO) {
		 log.info("createPost -> custInfoVO :", custInfoVO);
		 
		 int result = this.businessInfoService.createPost(custInfoVO);
		 log.info("createPost -> result :", result);
		 
//		 return "/business/create";
		 return "redirect:/business/detail?entNo="+custInfoVO.getEntNo();
	 }
//	
//		@ResponseBody
//		@PostMapping("/createPostAjax")
//		public int createPostAjax(@RequestBody CustInfoVO custInfoVO) {
//			log.info("createPostAjax->custInfoVO : " + custInfoVO);
//			
//			int result = this.businessInfoService.createPost(custInfoVO);
//			log.info("createPostAjax -> result : " + result);
//			
//			return result;
//		}

}
