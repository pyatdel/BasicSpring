package kr.or.ddit.cash.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PaymentRequest {
    private String orderId;        // 주문번호
    private String userId;         // 사용자 ID
    private String itemName;       // 상품명
    private int quantity;          // 수량
    private int totalAmount;       // 총 금액
}
