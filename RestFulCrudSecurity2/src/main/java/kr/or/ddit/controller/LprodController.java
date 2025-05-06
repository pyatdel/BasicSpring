package kr.or.ddit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.LprodService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.LprodVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/lprod")
public class LprodController {
	
	@Autowired
	LprodService lprodService;
	
	
	/* 
	 골뱅이ModelAttribute : 동일한 클래스 내 모든 forwarding 시 주기적으로 추가됨
	 */
	@ModelAttribute
	public void title(Model model) {
	   model.addAttribute("title", "상품분류");
		
	}
	/*
	 요청URI : /lprod/create
	 요청파라미터 : 
	 요청방식 : get 
	 */
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String create() {
		// forwarding : jsp
		return "lprod/create";
	}
	
	/* 동기 방식
	 요청URI : /lprod/createPost
	 요청파라미터 : {lprodGu:P701, lprodNm=도서류}
	 요청방식 : post
	 
	  - LPROD 테이블에 insert
	  - LPROD_ID 컬럼을 1 자동증가 처리
	 */
	@RequestMapping(value = "/createPost", method = RequestMethod.POST)
	public String createPost(LprodVO lprodVO) {
		
		log.info("createPost -> lprodVO : " + lprodVO);
		
		// create : insert
		int result = this.lprodService.createPost(lprodVO);
		log.info("createPost -> result : " + result);
		
		// redirect : 새로운 URL 요청 -> 기능 구현이 들어갔을 때 사용 
		// forwarding : JSP로 이동 -> 단순 이동일 때 사용
		return "redirect:/lprod/detail?lprodId="+lprodVO.getLprodId();
	}
	
	/* 비동기 방식
	 요청URI : /lprod/createPostAjax
	 요청파라미터 : JSONString{lprodGu:P701, lprodNm=도서류}
	 요청방식 : post
	 
	 - RequestBody를 통해서 [Client]JSONString -> Deserialize(string를 object로 변환) -> LprodVO 타입[Server]
	 - ResponseBody를 통해서 [Server]LprodVO 타입 -> Serialize(object를 string로 변환) -> JSONString[Client]
	  
	  - LPROD 테이블에 insert
	  - LPROD_ID 컬럼을 1 자동증가 처리
	  - return lprodVO
	 */
	@ResponseBody
	@RequestMapping(value = "/createPostAjax", method = RequestMethod.POST)
	public LprodVO createPostAjax(@RequestBody LprodVO lprodVO) {
		
		log.info("createPost -> lprodVO : " + lprodVO);
		
		// create : insert
		int result = this.lprodService.createPost(lprodVO);
		log.info("createPost -> result : " + result);
		
		// redirect : 새로운 URL 요청 -> 기능 구현이 들어갔을 때 사용 
		// forwarding : JSP로 이동 -> 단순 이동일 때 사용
		return lprodVO;
	}
	
	
	/* 1) 동기
    요청URI : /lprod/detail?lprodId=10
    요청파라미터 : lprodId=10
    요청방식 : get
    */
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String detail(@RequestParam(value = "lprodId") int lprodId,
						@ModelAttribute LprodVO lprodVO // 원래는 ModelAttribute가 생략되어있음
						, Model model) {
		
		log.info("detail -> lprodId : " + lprodId);
		log.info("detail -> lprodVO(전) : " + lprodVO);
		
		// 방법 1
		lprodVO = this.lprodService.detail(lprodId);
		log.info("detail -> lprodVO(후) : " + lprodVO);
		
		// 방법 2
		// lprodVO = this.lprodService.detail(lprodVO);
		
		
		// 등록할 대상 상품 미리 준비해보기
		// 1. 상품 코드 : 상품분류에 해당하는 마지막 상품 코드 +1 가져옴
		String maxProdId = this.lprodService.getMaxProdId(lprodVO);
		// detail -> maxProdId : P12700001
		log.info("detail -> maxProdId : " + maxProdId);
		
		// 2. 거래처 코드 : select 태그 구성을 위해 상품분류에 해당하는 거래처 목록을 준비
		List<Map<String, Object>> buyerList=  this.lprodService.getBuyerList(lprodVO);
		log.info("detail -> buyerList : " + buyerList);
		
		// 1과 2를 묶어서 한번에 model로 보내기
		Map<String, Object> guMap = new HashMap<String, Object>();
		guMap.put("maxProdId", maxProdId);
		guMap.put("buyerList", buyerList);
		log.info("detail -> guMap : " + guMap);
		
		model.addAttribute("lprodVO", lprodVO);
		model.addAttribute("guMap", guMap);
		
		// forwarding : jsp
		return "lprod/detail";
	}
	
	/* 2) 비동기 방식 (select를 비동기로 받아오기)
    요청URI : /lprod/getGuMapAjax
    요청파라미터 : JSONString{lprodGu=P201} => deserialize (object로 바꿔야하기 때문) => LprodVO
    요청방식 : POST => body 사용하기 위해서 post로!
    */
	@ResponseBody
	@RequestMapping(value = "/getGuMapAjax", method = RequestMethod.POST)
	public Map<String, Object> getGuMapAjax(
			@RequestBody LprodVO lprodVO) {
		// lprodVO{lprodId=0,lprodGu=P201,lprodNm=null}
		log.info("getGuMapAjax -> LprodVO : " + lprodVO);
		
		// 등록할 대상 상품 미리 준비해보기
		// 1. 상품 코드 : 상품분류에 해당하는 마지막 상품 코드 +1 가져옴
		String maxProdId = this.lprodService.getMaxProdId(lprodVO);
		// detail -> maxProdId : P12700001
		log.info("detail -> maxProdId : " + maxProdId);
		
		// 2. 거래처 코드 : select 태그 구성을 위해 상품분류에 해당하는 거래처 목록을 준비
		List<Map<String, Object>> buyerList=  this.lprodService.getBuyerList(lprodVO);
		log.info("detail -> buyerList : " + buyerList);
		
		// 1과 2를 묶어서 한번에 보내기
		Map<String, Object> guMap = new HashMap<String, Object>();
		guMap.put("maxProdId", maxProdId);
		guMap.put("buyerList", buyerList);
		log.info("detail -> guMap : " + guMap);
		
		return guMap;
	}
	
	/*
	 요청URI : /lprod/updatePost
	 요청파라미터 : request{lprodId=3,lprodGu=P201,lprodNm=여성캐주얼}
	 요청방식 : POST
	 */
	@RequestMapping(value = "/updatePost", method = RequestMethod.POST)
	public String updatePost(LprodVO lprodVO) {
		
		int result = this.lprodService.updatePost(lprodVO);
		log.info("updatePost -> result : " + result);
		
		// 3) 확인 버튼 클릭 시 submit 되어 update 처리 후 
		// /lprod/detail?lprodId=10 로 redirect
		return "redirect:/lprod/detail?lprodId="+lprodVO.getLprodId();
	}
	
	/*
	 요청URI : /lprod/deletePost
	 요청파라미터 : request{lprodId=3,lprodGu=P201,lprodNm=여성캐주얼}
	 요청방식 : POST
	 */
	@RequestMapping(value = "/deletePost", method = RequestMethod.POST)
	public String deletePost(LprodVO lprodVO) {
		
		log.info("deletePost -> lprodVO : " + lprodVO);
		
		int result = this.lprodService.deletePost(lprodVO);
		log.info("deletePost -> result : " + result);
		
		// LprodController의 deletePost 메소드에서 
	    // 삭제처리 완료 후 /lprod/list로 redirect 함
		return "redirect:/lprod/list";
	}
	
	/* 페이징 처리 - 동기
    요청URI : /lprod/list
    요청URI : /lprod/list?currentPage=1
    요청URI : /lprod/list?currentPage=1&keyword=개똥이
    요청파라미터 : 
    요청방식 : get
    
    [페이징처리 - 파라미터]
    1. currentPage -> 아주 중요!!! 최소 1이라도 있어야 함 
    2. keyword
    */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model,
				@RequestParam(value = "currentPage",required = false, defaultValue = "1") int currentPage,
				@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) {
		
		// currentPage 	파라미터는 없을 수도 있고 만약 없다면 currentPage 매개변수에 1이라도 할당
		// keyword 		파라미터는 없을 수도 있고 만약 없다면 keyword 매개변수에 ""(whitespace)라도 할당
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		log.info("list -> map : " + map);
		
		// 전체 행의 수 -> 아주 중요!!!!
		int total = this.lprodService.getTotal(map);
		log.info("list -> total : " + total);
		
		// map{currentPage=1, keyword=}
	    List<LprodVO> lprodVOList = this.lprodService.list(map);
	    log.info("list -> lprodVOList : " + lprodVOList);
		
	    
	    // 페이지네이션
	    ArticlePage<LprodVO> articlePage = new ArticlePage<LprodVO>(total, currentPage, 10, lprodVOList, keyword);
	    		
		model.addAttribute("lprodVOList", lprodVOList);
		model.addAttribute("articlePage", articlePage);
		
		// forwarding : jsp
		return "/lprod/list";
	}
	
	/* 페이징 처리 - 비동기 방식
    요청URI : /lprod/listAjax
    요청파라미터 : JSONString{"currentPage":"1","keyword"=""} 
    요청파라미터 : JSONString{"currentPage":"1","keyword"="도서"} 
    요청방식 : get
    
    return lprodVOList;
    
    		 	serialize							deserialize
    (List<LprodVO>)서버(JSONString) -> 인터넷 -> (JSONString)클라이언트(Object)
    
    오버로딩 : 동일한 클래스 내에 같은 이름의 메소드를 여러 번 사용 가능(파라미터 개수, 파라미터 타입이 다르게 처리)
    */
	@ResponseBody
	@RequestMapping(value = "/listAjax", method = RequestMethod.POST)
	public ArticlePage<LprodVO> listAjax(@RequestBody Map<String, Object> map) {
		
		// currentPage 	파라미터는 없을 수도 있고 만약 없다면 currentPage 매개변수에 1이라도 할당
		// keyword 		파라미터는 없을 수도 있고 만약 없다면 keyword 매개변수에 ""(whitespace)라도 할당
		// Map<String, Object> map = new HashMap<String, Object>();
		// map.put("currentPage", currentPage);
		// map.put("keyword", keyword);
		
		// map{"currentPage":"1","keyword"="도서"} 
		log.info("listAjax -> map : " + map);
		
		// 전체 행의 수 -> 아주 중요!!!!
		int total = this.lprodService.getTotal(map);
		log.info("list -> total : " + total);
		
		// map{currentPage=1, keyword=}
	    List<LprodVO> lprodVOList = this.lprodService.list(map);
	    log.info("list -> lprodVOList : " + lprodVOList);
		
	    // map.get("currentPage") : Object 타입
	    int currentPage = Integer.parseInt(map.get("currentPage").toString());		// Object->"1"->1
	    String keyword = "";
	    
	    // 검색어가 없을 수 있으므로 null 일 경우 처리해주기
	    if(map.get("keyword")!=null) {
	    	keyword = map.get("keyword").toString();	// "도서"
	    }
	    
	    // 페이지네이션
	    ArticlePage<LprodVO> articlePage = new ArticlePage<LprodVO>(total, currentPage, 10, lprodVOList, keyword);
	    		
		// forwarding : jsp
		return articlePage;
	}
	
	
	/*
	요청UIRI : /lprod/createProdsPost
	요청파라미터 : request{prodVOList[0].prodId=P109000001,prodVOList[0].prodName=개똥이제과,
  						prodVOList[0].prodLgu=P109,prodVOList[0].prodBuyer=P10901...}
	요청방식 : POST
	*/
	/* log 결과
	 LprodVO(lprodId=0, lprodGu=null, lprodNm=null, fileGroupNo=0, uploadFile=null, fileGroupVO=null
			, prodVOList=[
		 				ProdVO(prodId=P12700001, prodName=nct127 포토카드, prodLgu=P127, prodBuyer=P12701
		 						, prodCost=0, prodPrice=0, prodSale=25000, prodOutline=포토카드, ...
						]
			)			
	*/
	@RequestMapping(value = "/createProdsPost", method = RequestMethod.POST)
	public String createProdsPost(LprodVO lprodVO) {
		/* 
		 LprodVO(lprodId=3, lprodGu=P201, lprodNm=null, fileGroupNo=0, uploadFile=null, fileGroupVO=null,
		   prodVOList=[
						ProdVO(prodId=P201000022, prodName=떵개과자1, prodLgu=P201, prodBuyer=P20101, prodCost=0, prodPrice=0, prodSale=25000, prodOutline=<p>떵개1</p>, prodDetail=null, prodImg=null, prodTotalstock=0, prodInsdate=null, prodProperstock=0, prodSize=null, prodColor=null, prodDelivery=null, prodUnit=null, prodQtyin=0, prodQtysale=0, prodMileage=0), 
	 				    ProdVO(prodId=P201000022, prodName=떵개과자2, prodLgu=P201, prodBuyer=P20102, prodCost=0, prodPrice=0, prodSale=22000, prodOutline=떵개2, prodDetail=null, prodImg=null, prodTotalstock=0, prodInsdate=null, prodProperstock=0, prodSize=null, prodColor=null, prodDelivery=null, prodUnit=null, prodQtyin=0, prodQtysale=0, prodMileage=0)
	 				  ]
		    )
		*/
		log.info("createProdsPost -> lprodVO : " + lprodVO);
		
		int lprodId = lprodVO.getLprodId();
		log.info("createProdsPost -> lprodId : " + lprodId);
		
	 	int result =  this.lprodService.insertAllProd(lprodVO);
	 	log.info("createProdsPost -> result : " + result);
	 	
		// redirect : 새로운 URI 재요청
		return "redirect:/lprod/detail?lprodId="+lprodId;
	}
}
