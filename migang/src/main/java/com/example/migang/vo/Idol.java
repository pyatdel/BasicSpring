package com.example.migang.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Idol {
	private int mgId;
	private String mgName;
	private int mgAge;
	private String mgSajin;
	private MultipartFile mgFile; // 이건 예비, 디비 컬럼과 상관없다
}
