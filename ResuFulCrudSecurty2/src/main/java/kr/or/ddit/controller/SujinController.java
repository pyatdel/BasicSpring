package kr.or.ddit.controller;

import java.util.List;

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
	 ------------------------------------
	 Java에서 지원			|	Spring에서 지원
	 */
	 
	
	@Autowired
	SujinService sujinService;
	
	
	@GetMapping(value="/listSujin", produces="application/json;charset=utf-8")
	public List<SujinVO> listSujin() {
		log.info("listSujin");
		return this.sujinService.listSujin();
	}

	@GetMapping(value="/getSujin/{sujinNum}", produces="application/json;charset=utf-8")
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
	@PostMapping(value="/insertSujin", produces="application/json;charset=utf-8")
	public int insertSujin(@RequestBody SujinVO sujinVO) { // json으로 오니까 RequestBody
		//sujinVO{sujinNum=0,sujinContent=여행은 즐거워,sujinName=개똥이,sujinFile=null}
		log.info("getSujin->sujinVO : " + sujinVO);
		return this.sujinService.insertSujin(sujinVO);
	}

	@PutMapping(value="/updateSujin", produces="application/json;charset=utf-8")
	public int updateSujin(@RequestBody SujinVO sujinVO) { // json으로 오니까 RequestBody
		log.info("updateSujin->sujinVO : " + sujinVO);
		return this.sujinService.updateSujin(sujinVO);
	}

	@DeleteMapping(value="/deleteSujin/{sujinNum}", produces="application/json;charset=utf-8")
	public int deleteSujin(SujinVO sujinVO,
			@PathVariable(value="sujinNum") int sujinNum) {
		log.info("getSujin->sujinVO : " + sujinVO);
		log.info("getSujin->sujinNum : " + sujinNum);
		return this.sujinService.deleteSujin(sujinVO);
	}
}
