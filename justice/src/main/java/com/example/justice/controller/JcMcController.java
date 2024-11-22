package com.example.justice.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/")
public class JcMcController {
	
	@ResponseBody
	@PostMapping("/flogin")
	public String fLogin(@RequestBody Map<String, String> jcmcMap
			,HttpSession session) {
		
		log.info("데이터 확인 {}", jcmcMap);
		log.info("스캔 {} {}",jcmcMap.get("loginId"),jcmcMap.get("smartIdol"));
		
		session.setAttribute("yjId", jcmcMap.get("loginId"));
		session.setAttribute("yjIdol", jcmcMap.get("smartIdol"));
		
		return jcmcMap.get("smartIdol");
	}
	
	
	
	
	
	
}
