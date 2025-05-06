package kr.or.ddit.cash.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class KakaoPayApprovalResponse {
    private String aid;                  // 요청 고유 번호
    private String tid;                  // 결제 고유 번호
    private String cid;                  // 가맹점 코드
    private String partner_order_id;     // 가맹점 주문번호
    private String partner_user_id;      // 가맹점 회원 ID
    private String payment_method_type;  // 결제 수단
    private String item_name;            // 상품명
    private String item_code;           // 상품 코드
    private String created_at;           // 결제 준비 요청 시간
    private String approved_at;          // 결제 승인 시간
    private String payload;             // 결제 승인 요청에 대해 저장한 값, 요청 시 전달된 내용
    private Amount amount;               // 결제 금액 정보
}
