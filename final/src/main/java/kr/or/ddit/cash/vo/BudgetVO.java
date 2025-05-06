package kr.or.ddit.cash.vo;

import lombok.Data;

@Data
public class BudgetVO {
	private int budgetNo;
	private int budget;
	private int budDate;
	
	private int totalExpense;
}
