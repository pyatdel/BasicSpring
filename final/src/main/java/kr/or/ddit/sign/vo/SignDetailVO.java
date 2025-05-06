package kr.or.ddit.sign.vo;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class SignDetailVO {
	private int appGroupCode;
	private Date appGroupDate;
	
	// 파일그룹번호 : 결재폼 상세내용 = 1 : N
	private List<SignVO> signVOList;
}
