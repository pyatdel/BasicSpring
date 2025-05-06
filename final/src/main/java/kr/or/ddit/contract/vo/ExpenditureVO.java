package kr.or.ddit.contract.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ExpenditureVO {
	private int rnum; // rownumber
	private Date expDate; // 지출일시
	private int expNo; // 지출번호
	private int cateNo; // 카테고리번호
	private String expObj; // 구매품목
	private int expQty; // 구매수량
	private String expReason; // 구매사유
	private int budgetNo; // 예산번호
	private int expPrice; // 지출금액
}
