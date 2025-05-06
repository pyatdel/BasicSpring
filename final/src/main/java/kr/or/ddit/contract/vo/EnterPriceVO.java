package kr.or.ddit.contract.vo;

import lombok.Data;
import lombok.ToString;

@ToString
@Data
public class EnterPriceVO {
	private int entNo;
	private String entName;
	private String busNo;
	private String birDate;
	private String roadAdd;
	private String repName;
	private String entType;
	private String entComment;
	private String entCust;
	private String entRegDate;
	private String entEmail;
	private String detailAdd;
	private String entTel;
	
	private String entCode;
}
