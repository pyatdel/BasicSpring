package kr.or.ddit.board.vo;

import lombok.Data;

@Data
public class BoardTypeVO {

	private int		bodTypeNo;		// 게시판 타입번호
	private String	bodTypeName; 	// 1:공지 2:부서 3:QnA
}
