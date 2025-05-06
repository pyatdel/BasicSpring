package kr.or.ddit.contract.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ContractObjectVO {
	private String itemCode;
	private String itemName;
	private String spec;
	private String unit;
	private int amt;
	private String remark;
	private Date inputDatetime;
	private int itemDvs;
	private int entNo;
	private int itemQty; // 품목수량 
	private int itemPrice;
	private int result;
	private long contractNo;
}
