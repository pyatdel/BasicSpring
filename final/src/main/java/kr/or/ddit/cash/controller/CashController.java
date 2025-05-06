package kr.or.ddit.cash.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.business.service.BusinessActService;
import kr.or.ddit.business.vo.BusinessActVO;
import kr.or.ddit.cash.service.CashService;
import kr.or.ddit.cash.vo.ExpenseVO;
import kr.or.ddit.cash.vo.SaleVO;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.CustInfoVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/cash")
public class CashController {
	
	@Autowired
	CashService cashService;
	
	@Autowired
	BusinessActService businessActService; 
	
	
	//순번, 계약명, 계약업체, 상태, 계약시작일, 계약종료일, 순이익
	@GetMapping("/cashList")
	public String list(
	        @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
	        @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
	        @RequestParam(value = "contractNo", required = false) Integer contractNo,
	        Model model) {

	    Map<String, Object> map = new HashMap<>();
	    map.put("currentPage", currentPage);
	    map.put("keyword", keyword);

	    List<SaleVO> saleVOList = this.cashService.list(map);
	    int total = this.cashService.getTotal(map);

	    ArticlePage<SaleVO> articlePage = 
	            new ArticlePage<>(total, currentPage, 10, saleVOList, keyword);

	    model.addAttribute("saleVOList", saleVOList);
	    model.addAttribute("articlePage", articlePage);

	    if (contractNo != null) {
	        SaleVO saleVO = this.cashService.cashDetail(contractNo);
	        model.addAttribute("saleVO", saleVO);
	    }

        List<SaleVO> statusData = cashService.getTest();
        model.addAttribute("statusData", statusData);
        
        //월별 매출 통계
        List<SaleVO> monthSaleStat = this.cashService.monthSaleStat();
        model.addAttribute("monthSaleStat",monthSaleStat);
        
        //분기별 매출 통계
        List<SaleVO> quaterSaleStat = this.cashService.quaterSaleStat();
        model.addAttribute("quaterSaleStat",quaterSaleStat);
        
        //기업별 매출 통계
        List<SaleVO> enterSaleStat = this.cashService.enterSaleStat();
        model.addAttribute("enterSaleStat",enterSaleStat);
        
        //기업 리스트
        List<BusinessActVO> entList = this.businessActService.getAllEntities(); 
        model.addAttribute("entList",entList);
        
        //월 평균 매출액
    	List<SaleVO> monthAvg = this.cashService.monthAvg();
    	model.addAttribute("monthAvg", monthAvg);
    	
    	//누적 매출액
    	List<SaleVO> totalSale = this.cashService.totalSale();
    	model.addAttribute("totalSale", totalSale);
    	
    	//목표
    	List<SaleVO> goalSale = this.cashService.goalSale();
    	model.addAttribute("goalSale", goalSale);
    	
    	//계약 체결수
    	List<SaleVO> confirmedSale = this.cashService.confirmedSale();
    	model.addAttribute("confirmedSale", confirmedSale);
    	
    	//계약 체결률
    	List<SaleVO> confirmedSalePer = this.cashService.confirmedSalePer();
    	model.addAttribute("confirmedSalePer", confirmedSalePer);
    	
    	//객단가
    	List<SaleVO> entSale = this.cashService.entSale();
    	model.addAttribute("entSale", entSale);
        
	    
	    return "cash/cashList";
	}
	
	@GetMapping("/cashDetail")
    @ResponseBody
    public SaleVO cashDetail(@RequestParam(value = "contractNo", required = false, defaultValue = "1") int contractNo) {
        SaleVO saleVO = cashService.cashDetail(contractNo); 
        
        return saleVO;
    }

	
	//매출 - 통계 및 분석
	 @GetMapping("/cashAnaly")
     public String showChart(Model model) {
         List<SaleVO> statusData = cashService.getTest();
         model.addAttribute("statusData", statusData);
         
         //월별 매출 통계
         List<SaleVO> monthSaleStat = this.cashService.monthSaleStat();
         model.addAttribute("monthSaleStat",monthSaleStat);
         
         //분기별 매출 통계
         List<SaleVO> quaterSaleStat = this.cashService.quaterSaleStat();
         model.addAttribute("quaterSaleStat",quaterSaleStat);
         
         //기업별 매출 통계
         List<SaleVO> enterSaleStat = this.cashService.enterSaleStat();
         model.addAttribute("enterSaleStat",enterSaleStat);
         
         //기업 리스트
         List<BusinessActVO> entList = this.businessActService.getAllEntities(); 
         model.addAttribute("entList",entList);
         
        //월 평균 매출액
     	List<SaleVO> monthAvg = this.cashService.monthAvg();
     	model.addAttribute("monthAvg", monthAvg);
     	
     	//누적 매출액
     	List<SaleVO> totalSale = this.cashService.totalSale();
     	model.addAttribute("totalSale", totalSale);
     	
     	//목표
     	List<SaleVO> goalSale = this.cashService.goalSale();
     	model.addAttribute("goalSale", goalSale);
     	
     	//계약 체결수
     	List<SaleVO> confirmedSale = this.cashService.confirmedSale();
     	model.addAttribute("confirmedSale", confirmedSale);
     	
     	//계약 체결률
     	List<SaleVO> confirmedSalePer = this.cashService.confirmedSalePer();
     	model.addAttribute("confirmedSalePer", confirmedSalePer);
     	
     	//객단가
     	List<SaleVO> entSale = this.cashService.entSale();
     	model.addAttribute("entSale", entSale);
     	
     	
         
         return "cash/cashAnaly";
     }
	 
	 
	 //매출 - 입금 / 지출 관리
     @GetMapping("/budgetList")
     public String budgetList(@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
				    	      @RequestParam(value = "keyword", defaultValue = "") String keyword,
				    	      Model model) {
    	 keyword = keyword.trim();
    	 
    	 Map<String, Object> map = new HashMap<>();
    	 map.put("currentPage", currentPage);
    	 map.put("keyword", keyword);
    	 
    	 ///cash/budgetList의 지출 내역 목록!
         List<SaleVO> saleInfoVOList = cashService.expList(map);
         log.info("saleInfoVOList: {}", saleInfoVOList);
         
         List<SaleVO> saleDetailVOList = cashService.expDetailList(map);
         log.info("saleDetailVOList: {}", saleDetailVOList);
         
         
         //지출 카테고리 분류
         List<SaleVO> budCateVOList = this.cashService.budCateList();
         log.info("budCateVOList : ",budCateVOList);
         

         int total = cashService.getExpTotal(map);
         ArticlePage<SaleVO> articlePage = 
        		 	new ArticlePage<>(total, currentPage, 10, saleInfoVOList, keyword);
         
         //월별 매출 통계
         List<SaleVO> monthSaleStat = this.cashService.monthSaleStat();
         
         //분기별 매출 통계
         List<SaleVO> quaterSaleStat = this.cashService.quaterSaleStat();
         
         //기업별 매출 통계
         List<SaleVO> enterSaleStat = this.cashService.enterSaleStat();
         
         //월별 지출액
         List<SaleVO> expenseVOList = this.cashService.expenseStat();
         
         model.addAttribute("saleInfoVOList", saleInfoVOList);
         model.addAttribute("articlePage", articlePage);
         model.addAttribute("expenseVOList",expenseVOList);
         model.addAttribute("budCateVOList",budCateVOList);
         model.addAttribute("monthSaleStat",monthSaleStat);
         model.addAttribute("quaterSaleStat",quaterSaleStat);
         model.addAttribute("enterSaleStat",enterSaleStat);
         
    	 return "cash/budgetList";
    	
    	 
    }
    // 동적 상세 데이터 요청
    @GetMapping("/getSaleDetail")
    public ResponseEntity<List<SaleVO>> getSaleDetail(@RequestParam("expNo") int expNo) {
        List<SaleVO> saleDetailVOList = cashService.getDetailsByExpNo(expNo);
        return ResponseEntity.ok(saleDetailVOList);
    }

    /*지출상세내역
	/cash/budgetList 에서 modal에서 상세목록 보기
	<select id="budgetDetailList" parameterType="kr.or.ddit.cash.vo.ExpenseVO" resultType="kr.or.ddit.cash.vo.ExpenseVO">
	*/
    @ResponseBody
    @PostMapping("/budgetDetailList")
    public List<ExpenseVO> budgetDetailList(@RequestBody ExpenseVO expenseVO){
    	log.info("budgetDetailList->expenseVO : " + expenseVO);
    	
    	List<ExpenseVO> expenseVOList = this.cashService.budgetDetailList(expenseVO);
    	log.info("budgetDetailList->expenseVOList : " + expenseVOList);
    	
    	return expenseVOList;
    }
    
    @GetMapping("/cashPercent") 
    	public String list(Model model) {
    	
    	//월 평균 매출액
    	List<SaleVO> monthAvg = this.cashService.monthAvg();
    	
    	//누적 매출액
    	List<SaleVO> totalSale = this.cashService.totalSale();
    	
    	//목표
    	List<SaleVO> goalSale = this.cashService.goalSale();
    	
    	//계약 체결수
    	List<SaleVO> confirmedSale = this.cashService.confirmedSale();
    	
    	//계약 체결률
    	List<SaleVO> confirmedSalePer = this.cashService.confirmedSalePer();
    	
    	//객단가
    	List<SaleVO> entSale = this.cashService.entSale();
    	
    	
    	model.addAttribute("monthAvg", monthAvg);
    	model.addAttribute("totalSale", totalSale);
    	model.addAttribute("goalSale", goalSale);
    	model.addAttribute("confirmedSale", confirmedSale);
    	model.addAttribute("confirmedSalePer", confirmedSalePer);
    	model.addAttribute("entSale", entSale);
    	
    	
    	return "cash/cashPercent";
    	
    }
    @PostMapping("/filterData")
    @ResponseBody
    public Map<String, Object> filterData(
        @RequestParam(required = false) String entName,
        @RequestParam String startDate,
        @RequestParam String endDate) {
        
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 서비스 호출하여 필터링된 데이터 조회
            result.put("totalSale", cashService.getFilteredTotalSale(entName, startDate, endDate));
            result.put("monthAvg", cashService.getFilteredMonthAvg(entName, startDate, endDate));
            result.put("monthLabels", cashService.getFilteredMonthLabels(startDate, endDate));
            result.put("salesData", cashService.getFilteredSalesData(entName, startDate, endDate));
            result.put("enterSaleLabels", cashService.getFilteredEnterSaleLabels(startDate, endDate));
            result.put("enterSaleStat", cashService.getFilteredEnterSaleStat(startDate, endDate));
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        return result;
    }
    
    @GetMapping("/cashCreate")
    public String cashCraete(@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
					  	      @RequestParam(value = "keyword", defaultValue = "") String keyword,
					  	      Model model) {
    	Map<String, Object> map = new HashMap<>();
   	 map.put("currentPage", currentPage);
   	 map.put("keyword", keyword);
   	 
   	 ///cash/budgetList의 지출 내역 목록!
        List<SaleVO> saleInfoVOList = cashService.expList(map);
        log.info("saleInfoVOList: {}", saleInfoVOList);
        
        List<SaleVO> saleDetailVOList = cashService.expDetailList(map);
        log.info("saleDetailVOList: {}", saleDetailVOList);
        
        
        //지출 카테고리 분류
        List<SaleVO> budCateVOList = this.cashService.budCateList();
        log.info("budCateVOList : ",budCateVOList);
        

        int total = cashService.getExpTotal(map);
        ArticlePage<SaleVO> articlePage = 
       		 	new ArticlePage<>(total, currentPage, 10, saleInfoVOList, keyword);
        
        //월별 매출 통계
        List<SaleVO> monthSaleStat = this.cashService.monthSaleStat();
        
        //분기별 매출 통계
        List<SaleVO> quaterSaleStat = this.cashService.quaterSaleStat();
        
        //기업별 매출 통계
        List<SaleVO> enterSaleStat = this.cashService.enterSaleStat();
        
        //월별 지출액
        List<SaleVO> expenseVOList = this.cashService.expenseStat();
        
        model.addAttribute("saleInfoVOList", saleInfoVOList);
        model.addAttribute("articlePage", articlePage);
        model.addAttribute("expenseVOList",expenseVOList);
        model.addAttribute("budCateVOList",budCateVOList);
        model.addAttribute("monthSaleStat",monthSaleStat);
        model.addAttribute("quaterSaleStat",quaterSaleStat);
        model.addAttribute("enterSaleStat",enterSaleStat);
        return "cash/cashCreate";
    }
    
    @GetMapping("/getMonthlySales")
    public List<SaleVO> getMonthlySales(@RequestParam String year) {
        return cashService.getMonthlySales(year);
    }
}




