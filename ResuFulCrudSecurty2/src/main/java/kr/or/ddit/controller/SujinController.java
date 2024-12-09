package kr.or.ddit.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.service.SujinService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.SujinVO;
import lombok.extern.slf4j.Slf4j;

/*
 1. Controller 애너테이션
   - forwarding, redirect, JSON data 리턴
 2. RestController 애너테이션
   - JSON data 리턴
   - API 서버 전용
 */

@RequestMapping("/sujin")
@Slf4j
@RestController
public class SujinController {
	
	/*
	 Inject 애너테이션 vs Autowired 애너테이션
	 -----------------------------------
	 Java에서 지원     |  Spring에서 지원
	 */
	
	@Autowired
	SujinService sujinService;
	
	@GetMapping(value="/listSujin",produces="application/json;charset=utf-8")
	public List<SujinVO> listSujin(
			Map<String,Object> map
			) {
		log.info("listSujin");
		
		map.put("currentPage", "1");
		map.put("keyword", "");
		
		return this.sujinService.listSujin(map);
	}
	
	/*
	 요청URI : /sujin/listSujinXhr
	 요청파라미터 : JSONstring{currentPage=1,keyword=}
	 			 JSONstring{currentPage=1,keyword=개똥이}
	 요청방식 : post
	 
	 골뱅이RestController 이므로 ResponseBody가 내장되어 있음
	 */
	@PostMapping(value="/listSujinXhr",produces="application/json;charset=utf-8")
	public ArticlePage<SujinVO> listSujinXhr(
			@RequestBody Map<String,Object> map
			) {
		//		  listSujinXhr->map : {currentPage=1, keyword=}
		log.info("listSujinXhr->map : " + map);
		
		int total = this.sujinService.getTotal(map);
		int currentPage = 1;
		
		if(map.get("currentPage")!=null) {
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		}
		
		List<SujinVO> sujinVOList = this.sujinService.listSujin(map);
		String keyword = "";
		
		if(map.get("keyword")!=null) {
			keyword = map.get("keyword").toString();
		}
		
		ArticlePage<SujinVO> articlePage =
				new ArticlePage<SujinVO>(total, currentPage, 10, sujinVOList
						, keyword, "ajax");
		log.info("listSujinXhr->articlePage : " + articlePage);
		
		return articlePage;
	}

	@GetMapping(value="/getSujin/{sujinNum}",produces="application/json;charset=utf-8")
	public SujinVO getSujin(SujinVO sujinVO,
			@PathVariable(value="sujinNum") int sujinNum) {
		log.info("getSujin->sujinVO : " + sujinVO);
		log.info("getSujin->sujinNum : " + sujinNum);
		return this.sujinService.getSujin(sujinVO);
	}
	
	/*
	 요청URI : /sujin/insertSujin
	 요청파라미터 : JSONstring{sujinContent:여행은 즐거워,sujinName:개똥이,sujinFile:}
	 요청방식 : post
	 */
	@PostMapping(value="/insertSujin",produces="application/json;charset=utf-8")
	public int insertSujin(@RequestBody SujinVO sujinVO) {
		//sujinVO{sujinNum=0,sujinContent=여행은 즐거워,sujinName=개똥이,sujinFile=null}
		log.info("insertSujin->sujinVO : " + sujinVO);
		return this.sujinService.insertSujin(sujinVO);
	}
	
	/*
	 요청URI : /sujin/insertSujin
	 요청파라미터 : request{sujinContent:여행은 즐거워,sujinName:개똥이,uploadFile=파일객체들}
	 요청방식 : post
	 */
	@PostMapping(value="/insertSujinFile",produces="application/json;charset=utf-8")
	public int insertSujinFile(SujinVO sujinVO) {
		//sujinVO{sujinNum=0,sujinContent=여행은 즐거워,sujinName=개똥이,sujinFile=null,
		//			uploadFile=파일객체}
		log.info("insertSujin->sujinVO : " + sujinVO);
		return this.sujinService.insertSujin(sujinVO);
	}

	/*
	 요청URI : /sujin/updateSujin
	 요청파라미터 : JSONstring{sujinNum:22,sujinName:개똥이22,sujinContent:즐거운여행22}
	 요청방식 : put
	 */
	@PutMapping(value="/updateSujin",produces="application/json;charset=utf-8")
	public int updateSujin(@RequestBody SujinVO sujinVO) {
		//sujinVO{sujinNum=22,sujinName=개똥이22,sujinContent=즐거운여행22,sujinFile=null}
		log.info("updateSujin->sujinVO : " + sujinVO);
		return this.sujinService.updateSujin(sujinVO);//1 또는 0
	}

	@DeleteMapping(value="/deleteSujin/{sujinNum}",produces="application/json;charset=utf-8")
	public int deleteSujin(SujinVO sujinVO,
			@PathVariable(value="sujinNum") int sujinNum) {
		log.info("deleteSujin->sujinVO : " + sujinVO);
		log.info("deleteSujin->sujinNum : " + sujinNum);
		return this.sujinService.deleteSujin(sujinVO);
	}
}
