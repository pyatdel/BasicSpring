package kr.or.ddit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.service.isBoardService;
import kr.or.ddit.vo.SboardVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/sboard")
@RestController
public class SboardController {

	@Autowired
	private isBoardService sboardService;
	
	@GetMapping
	public ResponseEntity<List<SboardVO>> getList(){
		
		List<SboardVO> sboards = sboardService.getList();
		
		return ResponseEntity.ok(sboards);
	}
}
