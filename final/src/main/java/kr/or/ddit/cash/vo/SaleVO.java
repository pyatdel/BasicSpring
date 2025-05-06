package kr.or.ddit.cash.vo;

import java.util.Date;

import lombok.Data;

@Data
public class SaleVO {
	private String seReason;
	private int seCode;
	private long contractNo;
	private int seDate;
	private String seIstaxinvoice;
	private int budgetNo;
	private long seAllPrice;
	
	//순번
	private int rnum;
	
	//test용 컬럼 추가
	private String type;
    private int cnt;
    private String month;
    private String totalSales;
    
    //계약 매출 리스트
    private String contractNm;
    private String entName;
    private String state;
    private Date fromDate;
    private Date toDate;
//    private String contractPrice;
    
    //입금 / 지출관리
    private String categoryName;
    private long totalExpense;
    private Date expDate;
    private int expNo;
    private String entType;
    private int cateNo;
    private String expObj;
    private int expQty;
    private String expReason;
    private int expPrice;
    private String expName;
    
    //월별 지출액 그래프
    private String expenseMonth;
//    private int totalExpense;
    
    //월별 메출 통계 그래프
//    private String month;
    private long totalPrice;
    private int changeRate;
    
    //분기별 매출 통계 그래프
    private Date quater;
    private String year;
    private long contractPrice;
    
    //기업별 매출 통계 그래프
    private String enterprice;
//    private int contractPrice;
    
    //목표
    private long actualSales;
    private long targetSales;
    private long achievementRate;
    private long confirmationRate;
    private String trend;
    
    //계약 체결수
    private long totalContracts;
    private long confirmedContracts;
}
