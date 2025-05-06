package kr.or.ddit.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

//자바빈 클래스(프로퍼티,기본생성자,getter/setter메서드)
//PoJo가 약해짐
@Data
public class SujinVO {
	private int sujinNum;
	private String sujinContent;
	private String sujinName;
	private String sujinFile;
	//<input type="file" name="uploadFile" 파일객체 />
	private MultipartFile[] uploadFile;
	//행번호
	private int rnum;
}
