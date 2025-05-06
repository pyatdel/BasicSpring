package kr.or.ddit.system.controller;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.system.service.ReportService;
import kr.or.ddit.system.vo.SystemReportVO;
import kr.or.ddit.util.ArticlePage;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/system")
@Controller
@Slf4j
public class ReportController {
	
	@Autowired
	ReportService reportService;
	

	//신고관리 페이지 리스트 불러오기
	@GetMapping("/report")
	public String report(SystemReportVO systemReportVO, Model model,
		@RequestParam(value="currentPage",required=false,defaultValue="1")int currentPage,
		@RequestParam(value="keyword", required = false, defaultValue="")String keyword) {
		
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("currentPage", currentPage);
		map.put("keyword",keyword);
		log.info("systemReportVO->map: " + map);
		
		// 전체 행의 수
		int total = this.reportService.getTotal(map);
		log.info("list->total : " +total);
		
		
		List<SystemReportVO> reportVOList = this.reportService.reportlist(map);
//		log.info("reportVOList : "+reportVOList);
		
		//게시판 타입 가져오기
		List<SystemReportVO> bodTypeNameList = this.reportService.bodTypeNameList();
		//신고 타입 가져오기
		List<SystemReportVO> repType = this.reportService.repType();
		
		
		// 페이지네이션
		ArticlePage<SystemReportVO> articlePage =
				new ArticlePage<SystemReportVO>(total, currentPage, 10, reportVOList, keyword);
		
		model.addAttribute("reportVOList",reportVOList);
		model.addAttribute("articlePage",articlePage);
		model.addAttribute("bodTypeNameList",bodTypeNameList);
		model.addAttribute("repType",repType);
		
		return "system/report";
	}
	@ResponseBody
	@PostMapping("/systemReportPost")
	public ArticlePage<SystemReportVO> systemReportVO(@RequestBody Map<String, Object> map){
		log.info("repostPost->map : " + map);
		
		// 전체 행의 수
		int total = this.reportService.getTotal(map);
		log.info("list->total : " +total);
		
		List<SystemReportVO> reportVOList = this.reportService.reportlist(map);
//		log.info("reportVOList : "+reportVOList);
		
		
		// 검색기능
		String keyword = ""; // 검색 처음에 아무것도 없음
		String bodTypeName = "";
		String repTypeName = "";
		
		if(map.get("keyword") != null) {
			// null .toString() 은 오류 발생
			keyword = map.get("keyword").toString(); // keyword에 값 넣기
		}
		if(map.get("bodTypeName") != null) {
			bodTypeName = map.get("bodTypeName").toString();
		}
		if(map.get("repTypeName") != null) {
			repTypeName = map.get("repTypeName").toString();
		}
		
		map.put("keyword", keyword);
		map.put("bodTypeName", bodTypeName);
		map.put("repTypeName", repTypeName);
		log.info("체킁체킁 map : " + map);
		
		int currentPage = Integer.parseInt(map.get("currentPage").toString());
		// 페이지네이션
		ArticlePage<SystemReportVO> articlePage =
				new ArticlePage<SystemReportVO>(total, currentPage, 10, reportVOList, keyword, "ajax");
//		log.info("reportPost->articlePage : " + articlePage);
		return articlePage;
	}
	
	// 신고 처리 하기(대기->완료)
	@ResponseBody
	@PostMapping("/reportUpdatePost")
	public int reportUpdatePost(@RequestBody SystemReportVO systemReportVO) {
		log.info("reportUpdatePost-> systemReportVO" + systemReportVO);
		
		int result = this.reportService.reportUpdatePost(systemReportVO);
		log.info("reportUpdatePost->result : " + result);
		
		return result;
	}
	
	
	//신고완료 페이지 리스트 불러오기
	@GetMapping("/reportEnd")
	public String reportEnd(SystemReportVO systemReportVO, Model model,
			@RequestParam(value="currentPage",required=false,defaultValue="1")int currentPage,
			@RequestParam(value="keyword", required = false, defaultValue="")String keyword) {
		
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("currentPage", currentPage);
		map.put("keyword",keyword);
		log.info("systemReportVO->map: " + map);
		
		// 전체 행의 수
		int reportEndtotal = this.reportService.getreportEndTotal(map);
		log.info("list->reportEndtotal : " +reportEndtotal);
		
		
		List<SystemReportVO> reportEndVOList = this.reportService.reportEndlist(map);
		log.info("reportEndVOList : "+reportEndVOList);
		
		//게시판 타입 가져오기
		List<SystemReportVO> bodTypeNameList = this.reportService.bodTypeNameList();
		//신고 타입 가져오기
		List<SystemReportVO> repType = this.reportService.repType();
		
		
		// 페이지네이션
		ArticlePage<SystemReportVO> articlePage = 
				new ArticlePage<SystemReportVO>(reportEndtotal, currentPage, 10, reportEndVOList, keyword);
		
		model.addAttribute("reportEndVOList",reportEndVOList);
		model.addAttribute("articlePage",articlePage);
		model.addAttribute("bodTypeNameList",bodTypeNameList);
		model.addAttribute("repType",repType);
		
		return "system/reportEnd";
	}
	@ResponseBody
	@PostMapping("/reportEndPost")
	public ArticlePage<SystemReportVO> systemReportEndVO(@RequestBody Map<String, Object> map){
		log.info("reportEndPost->map : " + map);
		
		// 전체 행의 수
		int reportEndtotal = this.reportService.getreportEndTotal(map);
		log.info("list->reportEndtotal : " +reportEndtotal);
		
		List<SystemReportVO> reportEndVOList = this.reportService.reportEndlist(map);
		log.info("reportEndVOList : "+reportEndVOList);
		
		int currentPage = Integer.parseInt(map.get("currentPage").toString());
		
		String keyword = ""; // 검색기능
		
		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString(); // keyword에 값 넣기
		}
		log.info("reportEndPost 검색어 :" + keyword);
		
		// 페이지네이션
		ArticlePage<SystemReportVO> articlePage =
				new ArticlePage<SystemReportVO>(reportEndtotal, currentPage, 10, reportEndVOList, keyword, "ajax");
		log.info("reportPost->articlePage : " + articlePage);
		
		return articlePage;
	}
}
