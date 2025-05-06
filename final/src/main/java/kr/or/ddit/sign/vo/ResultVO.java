package kr.or.ddit.sign.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ResultVO {
	public static final String RESULT_CODE_200 = "200";
	public static final String RESULT_CODE_201 = "201";
	
	public static final String RESULT_MESSAGE_EXCEPTION = "시스템 오류가 발생했습니다. 관리자에게 문의하세요.";
	
	private String resultCode;
	private String resultMessage;
}
