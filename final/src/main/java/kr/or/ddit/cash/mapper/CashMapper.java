package kr.or.ddit.cash.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.cash.vo.BudgetVO;
import kr.or.ddit.cash.vo.ExpenseVO;
import kr.or.ddit.cash.vo.SaleVO;

@Mapper
public interface CashMapper {

	//총 행 수
	public int getTotal(Map<String, Object> map);

	//계약 매출 리스트
	public List<SaleVO> list(Map<String, Object> map);
	
	//차트 테스트
	public List<SaleVO> getTest();

	//계약 매출 상세
	public SaleVO cashDetail(int contractNo);
	
	//입금/지출 관리 리스트
	public List<SaleVO> expList(Map<String, Object> map);

	//입금/지출 관리 총 행 수
	public int getExpTotal(Map<String, Object> map);

	//월별 지출액 그래프
	public List<SaleVO> expenseStat();

	//지출 카테고리 분류
	public List<SaleVO> budCateList();

	//입금/지출 관리 상세 리스트
	public List<SaleVO> expDetailList(Map<String, Object> map);

	//입금/지출 동적 상세 리스트
	public List<SaleVO> getDetailByExpNo(int expNo);
	
	//월별 매출 통계
	public List<SaleVO> monthSaleStat();

	//분기별 매출 통계
	public List<SaleVO> quaterSaleStat();

	//기업별 매출 통계
	public List<SaleVO> enterSaleStat();
	
	/*지출상세내역
	/cash/budgetList 에서 modal에서 상세목록 보기
	<select id="budgetDetailList" parameterType="kr.or.ddit.cash.vo.ExpenseVO" resultType="kr.or.ddit.cash.vo.ExpenseVO">
	*/
	public List<ExpenseVO> budgetDetailList(ExpenseVO expenseVO);
	
	//EXPENSE 테이블 지출 처리 여부 yn update
	public int updateExpenseProcess(ExpenseVO expenseVO);
	
	public int updateBudgetAmount(ExpenseVO expenseVO);

	
	//매출현황 *****
	//월 평균 매출액
	public List<SaleVO> monthAvg();

	//누적 매출액
	public List<SaleVO> totalSale();

	//목표
	public List<SaleVO> goalSale();

	//계약 체결수
	public List<SaleVO> confirmedSale();

	//계약 체결률
	public List<SaleVO> confirmedSalePer();

	//객단가
	public List<SaleVO> entSale();

	// 매출 통계 *****
	public Map<String, Object> getFilteredTotalSale(Map<String, Object> params);
	public Map<String, Object> getFilteredMonthAvg(Map<String, Object> params);
	public List<String> getFilteredMonthLabels(Map<String, Object> params);
	public List<Map<String, Object>> getFilteredSalesData(Map<String, Object> params);
	public List<String> getFilteredEnterSaleLabels(Map<String, Object> params);
	public List<Map<String, Object>> getFilteredEnterSaleStat(Map<String, Object> params);

	public List<SaleVO> getMonthlySales(String year);



	
}
