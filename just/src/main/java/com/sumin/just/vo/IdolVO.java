package com.sumin.just.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
// 되도록이면, @Data를 사용하지 말고, @Getter, @Setter를 사용하자
@Getter
@Setter
@ToString // 디버깅용
public class IdolVO {
	private int idolId;
	private String idolName;
	private int idolAge;
	private String idolSajin;
	private List<MultipartFile> idolFiles; // 이건 db에 저장하지 않고, 순수하게 잠깐 파일만 전달받기 위해 사용
}
