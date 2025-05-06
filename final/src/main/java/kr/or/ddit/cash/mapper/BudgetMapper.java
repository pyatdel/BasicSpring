package kr.or.ddit.cash.mapper;

import kr.or.ddit.cash.vo.BudgetVO;

public interface BudgetMapper {
	
	//BEDGET 테이블 매출 계산 (예산액 - 지출액)
	public int updateBudgetAmount(BudgetVO budgetVO);
}
