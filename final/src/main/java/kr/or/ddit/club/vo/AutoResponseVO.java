package kr.or.ddit.club.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AutoResponseVO {

	private int 			autoNo;				// 자동답변번호
	private int 			reqNo;				// 가입신청번호
	private Date 			autoDate;			// 자동답변날짜
	private String 			autoCont;			// 자동답변내용
	
	// AUTO_RESPONSE
	private int 			autoType;			// 1.환영 2.안내 3.요청
	private AutoResponseVO	autoResponseVO;
	
	// AUTO_TEMPLATE
	private int 			tempNo;				// 템플릿번호
	private AutoTemplateVO 	autoTemplateVO;
}
