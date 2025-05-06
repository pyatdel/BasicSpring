package kr.or.ddit.contract.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class TaxinvoiceVO {
	private int rnum;
	private String tiCode; // 세금계산서코드
	private int appDocNo; // 결제문서양식번호
	private String tiTransdate; // 작성일
	private String tiIssuedate; // 발급일
	private int tiIssuedvs; // 발생구분
	private int tiBilldvs; // 계산서구분
	private int tiSupplyprice; //공급가액
	private int tiVat; // 부가가치세
	private String tiRmrk; // 비고 
	private String state;
	private int totalAmount;
	
	private ContractMasterVO contractMasterVO;
	private long contractNo; // 계약코드
	private String entCust; // 거래처계약담당자(성명)
	private String entName; // 거래처상호명
	private String busNo; // 사업장번호
	private String entType; // 사업타입
	private String entEmail; // 이메일
	private String detailAdd;
	private EnterPriceVO enterPriceVO;
	
	private String itemCode; // 품목코드
	private String itemName; // 품목명
	private String spec; // 사양
	private String unit; // 단위
	private int amt; // 단가
	private String remark; // 품목메모
	private Date inputDatetime; // 입력일시
	private int itemDvs; // 품목구분
	private int entNo; // 기업번호 
	
	private int contractDetailNo; // 계약상세일련번호
	private String itemNm; // 품목코드 
	private int itemQty; // 품목수량 
	private int itemPrice; // 품목총금액
	
	private List<ContractDetailVO> contractDetailVOList;
	
	private ContractObjectVO contractObjectVO;
	
}
