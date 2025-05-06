package kr.or.ddit.contract.vo;

import java.util.List;

import lombok.Data;

@Data
public class ContractDetailVO {
	private int contractDetailNo;
	private long contractNo;
	private String itemCode;
	private int itemQty;
	private int itemPrice;
	private String tiCode;
	private ContractObjectVO contractObjectVO;
	private int tiVat;
	private int [] detailNos; 
	private int amt;
	private int vat;
}
