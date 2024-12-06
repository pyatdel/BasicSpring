package kr.or.ddit.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

//자바빈클래스(프로퍼티, 기본생성자, getter/getter메서드)
@Data
public class StudVO {
	private String email;
	private String password;
	private String rememberMe;
	private long fileGroupNo;
	//스프링 파일타입
	private MultipartFile[] uploadFiles;
	
	//학생 : 파일그룹 = 1 : 1
	private FileGroupVO fileGroupVO;
}
