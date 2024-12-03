package kr.or.ddit.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class SboardVO {

	private int boNo;
	private String boTitle;
	private String boWriter;
	private String boContent;
	private String boDate;
	private int boHit;
	
	// 파일 그룹
	private int fileGroupNo;
	
	// 첨부파일
	private MultipartFile[] uploadFile;
}
