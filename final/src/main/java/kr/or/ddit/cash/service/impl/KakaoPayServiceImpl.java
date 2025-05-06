package kr.or.ddit.cash.service.impl;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import kr.or.ddit.cash.mapper.BudgetMapper;
import kr.or.ddit.cash.mapper.CashMapper;
import kr.or.ddit.cash.mapper.ExpenseMapper;
import kr.or.ddit.cash.service.KakaoPayService;
import kr.or.ddit.cash.vo.BudgetVO;
import kr.or.ddit.cash.vo.ExpenseVO;
import kr.or.ddit.cash.vo.KakaoPayApprovalResponse;
import kr.or.ddit.cash.vo.KakaoPayReadyResponse;
import kr.or.ddit.cash.vo.PaymentRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class KakaoPayServiceImpl implements KakaoPayService {
    
    private static final String HOST = "https://kapi.kakao.com";
    private final RestTemplate restTemplate;
//    private final ExpenseMapper expenseMapper;
//    private final BudgetMapper budgetMapper;
    private final CashMapper cashMapper;
    
    @Value("${kakao.admin.key}")
    private String kakaoAdminKey;

    @Override
    public String kakaoPayReady(PaymentRequest request) {
        HttpHeaders headers = getHeaders();
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        
        // 파라미터 설정
        setPaymentParams(params, request);
        
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<>(params, headers);
        
        try {
            KakaoPayReadyResponse response = restTemplate.postForObject(
                HOST + "/v1/payment/ready",
                body,
                KakaoPayReadyResponse.class);
                
            return response.getNext_redirect_pc_url();
        } catch (RestClientException e) {
            //throw new PaymentException("카카오페이 결제 준비 요청 실패");
        	throw e;
        }
    }

    @Override
    public KakaoPayApprovalResponse approvePayment(String pgToken, String tid) {
    	try {
            HttpHeaders headers = getHeaders();
            MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
            
            // 결제 승인 요청 파라미터 설정
            params.add("cid", "TC0ONETIME");
            params.add("tid", tid);
            params.add("partner_order_id", "KAO20230318001");
            params.add("partner_user_id", "kakaopayTest");
            params.add("pg_token", pgToken);
            
            HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<>(params, headers);
            
            // 카카오페이 결제 승인 요청
            KakaoPayApprovalResponse approvalResponse = restTemplate.postForObject(
                HOST + "/v1/payment/approve",
                body,
                KakaoPayApprovalResponse.class);
            
            // 결제 승인 후 데이터베이스 업데이트
            //updateDatabase(approvalResponse);
            
            return approvalResponse;
            
        } catch (RestClientException e) {
            log.error("카카오페이 결제 승인 요청 실패", e);
//            throw new PaymentException("카카오페이 결제 승인 요청 실패");
            throw e;
        }
    }

    private HttpHeaders getHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + kakaoAdminKey);
        headers.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
        return headers;
    }

    private void setPaymentParams(MultiValueMap<String, String> params, PaymentRequest request) {
        params.add("cid", "TC0ONETIME");
        params.add("partner_order_id", request.getOrderId());
        params.add("partner_user_id", request.getUserId());
        params.add("item_name", request.getItemName());
        params.add("quantity", String.valueOf(request.getQuantity()));
        params.add("total_amount", String.valueOf(request.getTotalAmount()));
        params.add("tax_free_amount", "0");
        params.add("approval_url", "http://localhost:8020/cash/success");
        params.add("cancel_url", "http://localhost:8020/cash/cancel");
        params.add("fail_url", "http://localhost:8020/cash/fail");
    }
    
    private void updateDatabase(ExpenseVO expenseVO) {
        try {
            // 1. EXPENSE 테이블 업데이트
            int expenseResult = cashMapper.updateExpenseProcess(expenseVO);
            log.info("EXPENSE 테이블 업데이트 결과: {}", expenseResult);
            
            // 2. BUDGET_T 테이블 예산 차감
            int budgetResult = cashMapper.updateBudgetAmount(expenseVO);
            log.info("BUDGET_T 테이블 업데이트 결과: {}", budgetResult);
            
        } catch (Exception e) {
            log.error("데이터베이스 업데이트 중 오류 발생", e);
//            throw new PaymentException("결제 처리 중 데이터베이스 오류가 발생했습니다.", e);
            throw e;
        }
    }
    
}

