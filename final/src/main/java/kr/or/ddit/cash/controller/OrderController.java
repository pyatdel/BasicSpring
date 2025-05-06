package kr.or.ddit.cash.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.cash.service.KakaoPayService2;
import kr.or.ddit.cash.vo.ExpenseVO;
import kr.or.ddit.cash.vo.KakaoPayApprovalResponse;
import kr.or.ddit.cash.vo.KakaoPayReadyResponse;
import kr.or.ddit.cash.vo.OrderCreateForm;
import kr.or.ddit.util.SessionUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/order")
public class OrderController {
	
	private String name;//교통비,비품,식비
	private int    totalPrice;//400
	private ExpenseVO expenseVO;
	
	@Autowired
	KakaoPayService2 kakaoPayService;
    
	/*
	{
    "name": "교통비",
    "totalPrice": 356000,
    "expNo": 0,
    "cateNo": 2,
    "expObj": "교통비",
    "expQty": 4,
    "expReason": "교통비",
    "budgetNo": 13,
    "expPrice": 356000,
    "expDate": "2025-01-01"
}
	 */
    @PostMapping("/pay/ready")
    public @ResponseBody KakaoPayReadyResponse payReady(@RequestBody ExpenseVO expenseVO) {
        
        name = expenseVO.getName();
        totalPrice = expenseVO.getTotalPrice();
        
        log.info("주문 상품 이름: " + name);
        log.info("주문 금액: " + totalPrice);
        
        //전역 변수
        this.expenseVO = expenseVO;

        // 카카오 결제 준비하기
        KakaoPayReadyResponse readyResponse = kakaoPayService.payReady(name, totalPrice);
        //readyResponse : kr.or.ddit.cash.vo.KakaoPayReadyResponse@616f8440
        log.info("payReady에 왔다");
        // 세션에 결제 고유번호(tid) 저장
        SessionUtils.addAttribute("tid", readyResponse.getTid());
        //결제 고유번호 : T7885f8e222b2ae742cb
        log.info("결제 고유번호: " + readyResponse.getTid());

        return readyResponse;
    }

    //parameters.put("approval_url", "http://localhost:8020/order/pay/completed"); // 결제 성공 시 URL
    @GetMapping("/pay/completed")
    public String payCompleted(@RequestParam("pg_token") String pgToken) {
    
        String tid = SessionUtils.getStringAttributeValue("tid");
        //결제승인 요청을 인증하는 토큰: 5f0eac2b62dc28c3b889
        log.info("결제승인 요청을 인증하는 토큰: " + pgToken);
        //결제 고유번호: T7885f8e222b2ae742cb
        log.info("결제 고유번호: " + tid);
        
        //***** DB EXPENSE 테이블에 update 처리
        /* 1. ServiceImpl에서 해야 함 1) EXPENSE 테이블에 update 처리여부를 Y 업데이트 2) BUDGET_T에서 해당 연월의 예산을 차감 (BUDGET - 356000) update
        ExpenseVO(name=교통비, totalPrice=356000, expDate=Wed Jan 01 09:00:00 KST 2025, 
        expNo=0, cateNo=2, expObj=교통비, expQty=4, expReason=교통비, budgetNo=13, expPrice=356000)
         */
        log.info("전역변수로써 this.expenseVO : " + this.expenseVO);
        
        // 카카오 결제 요청하기
        KakaoPayApprovalResponse approveResponse = kakaoPayService.payApprove(tid, pgToken);

        return "redirect:/cash/budgetList";
    }
}
