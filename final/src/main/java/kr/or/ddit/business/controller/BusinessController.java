package kr.or.ddit.business.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.business.service.BusinessService;
import kr.or.ddit.vo.CustInfoVO;
import kr.or.ddit.vo.EnterpriceVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/business")
@Slf4j
@Controller
public class BusinessController {
    
    @Autowired
    BusinessService businessService;
    
    @GetMapping("/custManage")
    public String custBusiness(Model model) {
        Map<String, Object> map = new HashMap<>();
        
        List<EnterpriceVO> enterpriceVOList = this.businessService.getTotal(map);
//        log.info("custManage -> map : {}", enterpriceVOList);
        
//        List<EnterpriceVO> enterpriceList = this.businessService.getPagedCustList(map);
        List<EnterpriceVO> custVOList = this.businessService.waitCustList(map);
        List<EnterpriceVO> delCustVOList = this.businessService.delCustList(map);
        
        // 모델에 리스트 추가
        model.addAttribute("enterpriceVOList", enterpriceVOList);
//        model.addAttribute("enterpriceList", enterpriceList);
        model.addAttribute("custVOList", custVOList);
        model.addAttribute("delCustVOList", delCustVOList);

        return "business/custManage";
    }


    
    @GetMapping("/getTotal")
    @ResponseBody
    public List<EnterpriceVO> getTotal() {
        Map<String, Object> map = new HashMap<>();
        List<EnterpriceVO> enterpriceVOList = this.businessService.getPagedCustList(map);
        log.info("Paged total customer list: {}", enterpriceVOList);
        return enterpriceVOList;
    }
    
    
    
    @GetMapping("/getWaiting")
    @ResponseBody
    public List<EnterpriceVO> getWaiting() {
        Map<String, Object> map = new HashMap<>();
        List<EnterpriceVO> custVOList = this.businessService.waitCustList(map);
        log.info("Retrieved waiting customer list: {}", custVOList);
        return custVOList; // JSON 형식으로 반환
    }

    
    @GetMapping("/getCanceled")
    @ResponseBody
    public List<EnterpriceVO> getCanceled() {
        Map<String, Object> map = new HashMap<>();
        List<EnterpriceVO> delCustVOList = this.businessService.delCustList(map);
        log.info("delCustVOList: {}", delCustVOList);
        return delCustVOList; // JSON 형식으로 반환
    }


    @GetMapping("/busStat")
    public String busStat(Model model) {
    	
    	//월별 계약 체결 수
    	List<CustInfoVO> custInfoVOList = this.businessService.busStat();
    	model.addAttribute("custInfoVOList", custInfoVOList);
    	
    	//전체 계약 체결률
    	List<CustInfoVO> contractState = this.businessService.conStat();
    	model.addAttribute("contractState", contractState);
    	
    	//카테고리별 계약 체결률
    	List<CustInfoVO> getContractByCategory = this.businessService.getContractByCategory();
    	model.addAttribute("getContractByCategory",getContractByCategory);
    	
    	//계약상태별 계약 체결률
    	List<CustInfoVO> getContractByStatus = this.businessService.getContractByStatus();
    	model.addAttribute("getContractByStatus",getContractByStatus);
    	
    	//기업별 계약 체결률
    	List<CustInfoVO> getContractByEnterprise = this.businessService.getContractByEnterprise();
    	model.addAttribute("getContractByEnterprise",getContractByEnterprise);
    	
    	
    	return "business/busStat";
    }
    
    
}

