package kr.or.ddit.business.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.business.service.BusinessService;
import kr.or.ddit.vo.CustInfoVO;
import lombok.extern.slf4j.Slf4j;

@CrossOrigin("http://localhost:7921")
@RequestMapping("/business")
@Slf4j
@RestController
public class BusinessChartController {
	
    @Autowired
    BusinessService businessService;
    
    
	@GetMapping("/monthly-contracts")
    public List<CustInfoVO> getMonthlyContracts() {
        return this.businessService.busStat();
    }

    @GetMapping("/contract-state")
    public List<CustInfoVO> getContractState() {
        return this.businessService.conStat();
    }

    @GetMapping("/contract-by-category")
    public List<CustInfoVO> getContractByCategory() {
        return this.businessService.getContractByCategory();
    }

    @GetMapping("/contract-by-status")
    public List<CustInfoVO> getContractByStatus() {
        return this.businessService.getContractByStatus();
    }

    
    @GetMapping("/contract-by-enterprise")
    public List<CustInfoVO> getContractByEnterprise() {
        return this.businessService.getContractByEnterprise();
    }
}
