package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

//자바빈 클래스
//1) 멤버변수(프로퍼티) 2) 기본생성자 3) getter/setter메소드
//골뱅이Data=> PoJo(Plain순수한 old Java object)에 위배
@Data
public class BookVO {
	private int bookId;
	private String title;
	private String category;
	private int price;
	private Date insertDate;
}
