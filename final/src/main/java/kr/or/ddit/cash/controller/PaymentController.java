package kr.or.ddit.cash.controller;



import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.cash.service.KakaoPayService;
import kr.or.ddit.cash.vo.KakaoPayReadyVO;
import kr.or.ddit.cash.vo.PaymentRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/cash")
@RequiredArgsConstructor
public class PaymentController {

    private final KakaoPayService kakaoPayService;

    @PostMapping("/budgetList")
    public ResponseEntity<String> readyToKakaoPay(@RequestBody PaymentRequest request) {
        String redirectUrl = kakaoPayService.kakaoPayReady(request);
        return ResponseEntity.ok(redirectUrl);
    }
    
    
    //카카오페이 결제 api
    @GetMapping("/success")
    public ResponseEntity<String> paymentSuccess(@RequestParam("pg_token") String pgToken) {
        // 결제 승인 처리
        return ResponseEntity.ok("결제 성공");
    }
    
    @GetMapping("/cancel")
    public ResponseEntity<String> paymentCancel() {
        return ResponseEntity.ok("결제 취소");
    }
    
    @GetMapping("/fail")
    public ResponseEntity<String> paymentFail() {
        return ResponseEntity.ok("결제 실패");
    }
    
    // 결제 버튼 클릭 시 호출
    @GetMapping("/ready")
    public @ResponseBody KakaoPayReadyVO kakaoPay(@RequestParam Map<String, Object> params){
        KakaoPayReadyVO res = KakaoPayService.kakaoPay(params);
        log.info(res.toString());
        return res;
    }
    
    
}