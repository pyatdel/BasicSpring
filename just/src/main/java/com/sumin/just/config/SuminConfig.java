package com.sumin.just.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration // 설정파일임을 표시
// 골뱅이EnableWebMvc
public class SuminConfig implements WebMvcConfigurer{

	@Value("${jinwo.memo}")
	private String jinMemo;
	
	@Value("${jinwo.age}")
	private int jinAge;

	/*	매칭만 정확히 이해하면 쓰는 데 전혀 문제가 없음
	 *  주소줄에 이렇게 쓰면 /jcmc/merong/aaa
	 *  C:/e7e/boot/jcupload/merong/aaa.jpg
	 */
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		log.debug("여기가 실행되었는지 check?");
		
		log.debug("이름 {}",jinMemo);
		log.debug("나이 {}", jinAge);
		registry.addResourceHandler("/sh/**", "/yj/**")             // 두 개를 만들 수 있다.
        .addResourceLocations("classpath:static/css/","classpath:static/css/yj/");  // 두 개를 만들 수 있다.
		
		registry.addResourceHandler("/jcmc/**")             // 웹 접근 경로 
		        .addResourceLocations("file:///C:/e7e/boot/jcupload/");  // 서버내 실제 경로
	}
}
