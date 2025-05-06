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

import kr.or.ddit.system.service.NoticeService;
import kr.or.ddit.system.vo.NoticeVO;
import kr.or.ddit.util.ArticlePage;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/system")
@Controller
@Slf4j
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	// 공지사항 리스트 불려오기
	@GetMapping("/notice")
	public String noticeList(NoticeVO noticeVO,Model model,
		@RequestParam(value="currentPage",required=false,defaultValue = "1")int currentPage,
		@RequestParam(value="keyword",required = false,defaultValue = "")String keyword){
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		log.info("list->map:" + map);
		
		//전체 행의 수
		int total = this.noticeService.getTotal(map);
		log.info("noctice->total:" + total);
		
		List<NoticeVO> noticeVOList = this.noticeService.noticeList(map);
		
		//페이지네이션
		ArticlePage<NoticeVO> articlePage =
				new ArticlePage<NoticeVO>(total, currentPage, 10, noticeVOList, keyword);
		
		model.addAttribute("noticeVOList",noticeVOList);
		model.addAttribute("articlePage",articlePage);
				
		
		return "system/notice";
	}
	@ResponseBody
	@PostMapping("/noticePost")
	public ArticlePage<NoticeVO> noticePost(@RequestBody Map<String, Object> map){
		
		//전체 행의 수
		int total = this.noticeService.getTotal(map);
		log.info("noctice->total:" + total);
		
		List<NoticeVO> noticeVOList = this.noticeService.noticeList(map);
		
		int currentPage = Integer.parseInt(map.get("currentPage").toString());
		
		String keyword = "";//검색어가 없을 수 있으므로 처리

		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();// keyword에 값 넣기
		}	
		// 로그로 keyword 확인
	    log.info("검색어: " + keyword);
		
		//비동기 페이지네이션
		ArticlePage<NoticeVO> articlePage =
				new ArticlePage<NoticeVO>(total, currentPage, 10, noticeVOList, keyword, "ajax");
		log.info("noticePost->articlePage : " + articlePage);
		
		return articlePage;
	}
	
	//qna jsp 가져오기
	@GetMapping("/qna")
	public String qna(NoticeVO noticeVO,Model model,
		@RequestParam(value="currentPage",required=false,defaultValue = "1")int currentPage,
		@RequestParam(value="keyword",required = false,defaultValue = "")String keyword) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		log.info("list->map:" + map);
		
		//전체 행의 수
		int total = this.noticeService.getQnaTotal(map);
		log.info("noctice->total:" + total);
		
		List<NoticeVO> QnAVOList = this.noticeService.QnAList(map);
		
		//페이지네이션
		ArticlePage<NoticeVO> articlePage =
				new ArticlePage<NoticeVO>(total, currentPage, 10, QnAVOList, keyword);
		
		model.addAttribute("QnAVOList",QnAVOList);
		model.addAttribute("articlePage",articlePage);
		return "system/qna";
	}
	
	@ResponseBody
	@PostMapping("/qnaPost")
	public ArticlePage<NoticeVO> qnaPost(@RequestBody Map<String, Object> map){
		
		//전체 행의 수
		int total = this.noticeService.getQnaTotal(map);
		log.info("qnaPost->total:" + total);
		
		List<NoticeVO> QnAVOList = this.noticeService.QnAList(map);
		
		int currentPage = Integer.parseInt(map.get("currentPage").toString());
		
		String keyword = "";//검색어가 없을 수 있으므로 처리

		if(map.get("keyword") != null) {
			keyword = map.get("keyword").toString();// keyword에 값 넣기
		}	
		// 로그로 keyword 확인
	    log.info("검색어: " + keyword);
		
		//비동기 페이지네이션
		ArticlePage<NoticeVO> articlePage =
				new ArticlePage<NoticeVO>(total, currentPage, 10, QnAVOList, keyword, "ajax");
		
		return articlePage;
	}
	

}
