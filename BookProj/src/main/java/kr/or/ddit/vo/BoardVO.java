package kr.or.ddit.vo;

import lombok.Data;

@Data
public class BoardVO {
	private int 	  boNo;         // 일반게시판번호
	   private String boTitle;      // 일반게시판제목
	   private String boWriter;   // 일반게시판작성자
	   private String boContent;   // 일반게시판내용
	   private String boDate;      // 일반게시판작성일
	   private int    boHit;         // 일반게시판조회수
}
