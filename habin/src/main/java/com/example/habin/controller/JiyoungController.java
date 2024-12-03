package com.example.habin.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
// @CrossOrigin("*") // 모든 origin에 허가하기
@CrossOrigin("http://localhost:5173, localhost:8888") // 5173, 8888만 허가하기
@RequestMapping("/habin")
public class JiyoungController {
	
	// DB 대신 잠깐 쓸 데이터 
	private static List<String> suminFriends = new ArrayList<>();
	
	@PostConstruct // 객체가 생성되면 자동으로 한번 실행됨. 보통 초기화 작업에 사용
	void hiphapMG() {
		for(int i=1; i<=10; i++) {
			suminFriends.add("수민 친구" + i);
		}
		log.info("스캔 {}", suminFriends);
	}
	
	@GetMapping("/friends") // 조회는 get
	public List<String> getSumin6(){
		return suminFriends;
	}
	
}
