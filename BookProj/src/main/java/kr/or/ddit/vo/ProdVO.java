package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ProdVO {
	private String prodId;
	private String prodName;
	private String prodLgu;
	private String prodBuyer;
	private int prodSale;
	private String prodOutline;
	
	
	private LprodVO lprodVO;
	
    private BuyerVO buyerVO;
}
