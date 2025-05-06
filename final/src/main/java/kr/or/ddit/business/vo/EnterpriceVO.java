package kr.or.ddit.business.vo;

import java.util.Date;
import java.util.List;

import kr.or.ddit.business.vo.EnterpriceVO;
import lombok.Data;

@Data
public class EnterpriceVO {
	private int entNo;
	private String entName;
	private String busNo;
	private Date birDate;
	private String busAdd;
	private String repName;
	private String entType;
	private String entComment;
	private String entCust;
	private Date entRegDate;
	
	private int empNo;
	
	//계약명
	private String contractNm;
	
	private String contractPrice;
	
	//계약 상태
	private String stateDesc;
	private String state;//0:계약완료 1:진행중 2: 완료 3:취소 4.보류
	
	//취소 사유
	private String cancelContent;

	//계약 유형
	private String contractType;
	
	private String entTel;
	
	private String entCode;
	
	//계약등록일자
	private Date inputDatetime;
	
	//계약번호
	private long contractNo;
	
	//contract_master 테이블과 조인하기 위해
	private List<ContractMasterVO> ContractMasterVOList;
	
	
	private int businessState;
	
	private String businessCount;
	
//	private List<ContractMasterVO> contractList;
}