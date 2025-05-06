package kr.or.ddit.cash.mapper;

import kr.or.ddit.cash.vo.ExpenseVO;

public interface ExpenseMapper {

	//expense 테이블의 매출 처리여부 업데이트
	public int updateExpenseProcess(ExpenseVO expenseVO);
	
}
