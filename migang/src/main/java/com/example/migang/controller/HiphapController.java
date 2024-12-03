package com.example.migang.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.migang.vo.Idol;

import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/mg")
@CrossOrigin("http://localhost:5173/")
public class HiphapController {
	
	private static int idNum = 1;
	// DB 안 쓰고 하려고..
	private static List<Idol> mgIdols = new ArrayList<>();
	
	@PostConstruct // 객체가 생성되고 나서 바로 실행되는 초기화 블록
	public void jinwooInit() {
		
		Idol mgIdol = null; // 선언만
		for(int i=0; i<=10; i++) {
			mgIdol = new Idol();
			mgIdol.setMgId(idNum);
			mgIdol.setMgName("힙합"+i);
			mgIdol.setMgAge(17+i);
			mgIdol.setMgSajin("https://api.dicebear.com/9.x/lorelei/svg?seed="+"미강"+i);
			mgIdols.add(mgIdol);
			idNum++;
			
		}
		
		log.debug("실행되었는지 눈으로 확인용 {}",mgIdols);
	}
	
	// 조회 리스트(여러개 리턴)
	@GetMapping("/idols")
	public List<Idol> mgIdols(){
		log.debug("get list 실행 {}", mgIdols);
		return mgIdols;
	}
	
	// 1개 return 
	@GetMapping("/idols/{mgId}")
	public Idol mgIdol(@PathVariable int mgId) {
		log.debug("get idol 1개");
		for (Idol idol : mgIdols) {
			if(idol.getMgId() == mgId) {
				return idol;
			}
		}
		return null; // 껍데기만 있는 idol을 new 해서 return할 수도 있지만, 좋지 않음
	}
	
	// insert (int)를 안써도 되지만, inser, update는 페이지 수를 참조하므로, 웬만하면 int를 쓰자
	// 일단 json문자열로 받는 거 먼저
	@PostMapping("/idols")
	public int insIdol(@RequestBody Idol mgIdol) {
		
		mgIdol.setMgId(idNum);
		idNum++;
		return mgIdols.add(mgIdol)?1:0;
	}
	
	// 수정
	@PutMapping("/idols/{mgId}")
	public int updIdol(@PathVariable int mgId
					 , @RequestBody Idol mgIdol) {
		log.info("체크 {} {}", mgIdol, mgId);
		for (Idol idol : mgIdols) {
			if(idol.getMgId() == mgId) {
				idol.setMgAge(mgIdol.getMgAge());
				idol.setMgName(mgIdol.getMgName());
				idol.setMgSajin(mgIdol.getMgSajin());
				return 1;
			}
		}
		return 0;
	}
	
	// 지우기
	@DeleteMapping("/idols/{mgId}")
	public int delIdol(@PathVariable int mgId) {
		for (Idol idol : mgIdols) {
			if(idol.getMgId() == mgId) {
				mgIdols.remove(idol);
				log.debug("체크 {}", mgIdols);
				return 1;
			}
		}
		return 0;
	}
	
}
