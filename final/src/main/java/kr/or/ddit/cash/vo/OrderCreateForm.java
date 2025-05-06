package kr.or.ddit.cash.vo;

import lombok.Data;

@Data
public class OrderCreateForm {
	private String name;
	private int    totalPrice;
}
