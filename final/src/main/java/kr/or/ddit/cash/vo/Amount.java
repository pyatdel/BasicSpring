package kr.or.ddit.cash.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Amount {
    private int total;           // 총 결제 금액
    private int tax_free;        // 비과세 금액
    private int vat;            // 부가세 금액
}