package kr.or.ddit.contract.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.contract.service.ExpenditureService;
import kr.or.ddit.contract.vo.ExpenditureVO;
import kr.or.ddit.contract.vo.TaxinvoiceVO;
import kr.or.ddit.util.ArticlePage;


@RequestMapping("/expdit")
@Controller
public class ExpenditureController {

	@Autowired
	ExpenditureService expenditureService;
	
	
	@GetMapping("/create")
	public String expendCreate() {
		return "contract/expdit/create";
		
	}
	@GetMapping("/list")
	public String expditList(Model model, @RequestParam(value="keyword" , required = false, defaultValue = "") String keyword,
			@RequestParam(value="currentPage",required = false,defaultValue = "1")int currentPage) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		
		List<ExpenditureVO>expenditureVOList = this.expenditureService.expditList(map);

		int total = this.expenditureService.getTotal(map);
		
		model.addAttribute("expenditureVOList",expenditureVOList);
		model.addAttribute("articlePage",
				new ArticlePage<ExpenditureVO>(total, currentPage, 10,expenditureVOList, keyword));
			
		return "contract/expdit/list";
		
		
	}
}
