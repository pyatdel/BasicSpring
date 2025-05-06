package kr.or.ddit.cash.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ExpenseVO {
	private String name;
	private int  totalPrice;
	private Date expDate;
	private int expNo;
	private int cateNo;
	private String expObj;
	private int expQty;
	private String expReason;
	private int budgetNo;
	private int expPrice;
	private String KakaoYn;  //카카오페이 결재여부
	private int totalExpense;	//매출에서 차감하느 총지출액
}
