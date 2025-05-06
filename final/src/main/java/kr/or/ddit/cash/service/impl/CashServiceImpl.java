package kr.or.ddit.cash.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.cash.mapper.CashMapper;
import kr.or.ddit.cash.service.CashService;
import kr.or.ddit.cash.vo.ExpenseVO;
import kr.or.ddit.cash.vo.SaleVO;

@Service
public class CashServiceImpl implements CashService{
	
	@Autowired
	CashMapper cashMapper;

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.cashMapper.getTotal(map);
	}

	@Override
	public List<SaleVO> list(Map<String, Object> map) {
		return this.cashMapper.list(map);
	}

	@Override
	public List<SaleVO> getTest() {
		return this.cashMapper.getTest();
	}

	@Override
	public SaleVO cashDetail(int contractNo) {
		return this.cashMapper.cashDetail(contractNo);
	}

	@Override
	public List<SaleVO> expList(Map<String, Object> map) {
		return this.cashMapper.expList(map);
	}

	@Override
	public int getExpTotal(Map<String, Object> map) {
		return this.cashMapper.getExpTotal(map);
	}

	@Override
	public List<SaleVO> expenseStat() {
		return this.cashMapper.expenseStat();
	}

	@Override
	public List<SaleVO> budCateList() {
		return this.cashMapper.budCateList();
	}

	@Override
	public List<SaleVO> expDetailList(Map<String, Object> map) {
		return this.cashMapper.expDetailList(map);
	}

	@Override
	public List<SaleVO> getDetailsByExpNo(int expNo) {
		return this.cashMapper.getDetailByExpNo(expNo);
	}

	@Override
	public List<SaleVO> monthSaleStat() {
		return this.cashMapper.monthSaleStat();
	}

	@Override
	public List<SaleVO> quaterSaleStat() {
		return this.cashMapper.quaterSaleStat();
	}

	@Override
	public List<SaleVO> enterSaleStat() {
		return this.cashMapper.enterSaleStat();
	}
	
	/*지출상세내역
	/cash/budgetList 에서 modal에서 상세목록 보기
	<select id="budgetDetailList" parameterType="kr.or.ddit.cash.vo.ExpenseVO" resultType="kr.or.ddit.cash.vo.ExpenseVO">
	*/
	@Override
	public List<ExpenseVO> budgetDetailList(ExpenseVO expenseVO){
		return this.cashMapper.budgetDetailList(expenseVO);
	}

	//매출 현황 ********
	
	@Override
	public List<SaleVO> monthAvg() {
		return this.cashMapper.monthAvg();
	}

	@Override
	public List<SaleVO> totalSale() {
		return this.cashMapper.totalSale();
	}

	@Override
	public List<SaleVO> goalSale() {
		return this.cashMapper.goalSale();
	}

	@Override
	public List<SaleVO> confirmedSale() {
		return this.cashMapper.confirmedSale();
	}

	@Override
	public List<SaleVO> confirmedSalePer() {
		return this.cashMapper.confirmedSalePer();
	}

	@Override
	public List<SaleVO> entSale() {
		return this.cashMapper.entSale();
	}

	@Override
    public Map<String, Object> getFilteredTotalSale(String entName, String startDate, String endDate) {
        Map<String, Object> params = new HashMap<>();
        params.put("entName", entName);
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        return this.cashMapper.getFilteredTotalSale(params);
    }

    @Override
    public Map<String, Object> getFilteredMonthAvg(String entName, String startDate, String endDate) {
        Map<String, Object> params = new HashMap<>();
        params.put("entName", entName);
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        return cashMapper.getFilteredMonthAvg(params);
    }

    @Override
    public List<String> getFilteredMonthLabels(String startDate, String endDate) {
        Map<String, Object> params = new HashMap<>();
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        return cashMapper.getFilteredMonthLabels(params);
    }

    @Override
    public List<Map<String, Object>> getFilteredSalesData(String entName, String startDate, String endDate) {
        Map<String, Object> params = new HashMap<>();
        params.put("entName", entName);
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        return cashMapper.getFilteredSalesData(params);
    }

    @Override
    public List<String> getFilteredEnterSaleLabels(String startDate, String endDate) {
        Map<String, Object> params = new HashMap<>();
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        return cashMapper.getFilteredEnterSaleLabels(params);
    }

    @Override
    public List<Map<String, Object>> getFilteredEnterSaleStat(String startDate, String endDate) {
        Map<String, Object> params = new HashMap<>();
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        return cashMapper.getFilteredEnterSaleStat(params);
    }

	@Override
	public List<SaleVO> getMonthlySales(String year) {
		return cashMapper.getMonthlySales(year);
	}
}
