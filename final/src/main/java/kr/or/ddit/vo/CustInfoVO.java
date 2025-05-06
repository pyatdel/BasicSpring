package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CustInfoVO {
	private int entNo;
	private String contractNm;
	private String stateDesc;
	
	//계약번호
	private long contractNo;
	private long contractPrice;
	
	private String entName;
	private String businessCount;
	private String entType;
	private String businessState;
	private String cancelContent;
	//<input type="date" class="form-control rounded" id="entRegDate" name="entRegDate" value="2024-12-24" placeholder="등록일자">
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date entRegDate;
	
	private int rnum;
	
//	private String busAdd; 
	private String roadAdd; 
	private String detailAdd; 
	private String repName;
	private String entCust;
	private String entTel;
	private Date birDate;
	private String entComment;
	private String entCode;
	
	//영업 통계 및 분석 그래프를 그리기 위한 컬럼 추가
	//월별 계약 체결 수
	private String month; 
	private int count;
	
	//전체 계약 체결률
	private int totalContracts;
	private int confirmedContracts;
	
	//카테고리별 계약 체결률
	private String type;
	private int totalTypes;
	private int confirmedTypes;
	
	//계약상태별 계약 체결률
	private String state;
	private int totalStates;
	private int confirmedStates;
	
	//기업별 계약 체결률
	private String enter;
	private int totalEnters;
	private int confirmedEnters;
	
	
}
