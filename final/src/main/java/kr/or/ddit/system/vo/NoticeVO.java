package kr.or.ddit.system.vo;


import java.sql.Date;

import lombok.Data;


@Data
public class NoticeVO {
	// BOARD 테이블
	private int empNo;
	private int bodNo;
	private String bodTitle;
	private String bodCont;
	private Date bodCreDate;
	private int bodHit;
	private String bodState;
	private Date bodModiDate;
	private String bodWriter;
	private int fileGroupNo;
	private int repNo;
	private int noticeType;
	
	// rnum
	private int rnum;
	
	// BOARD_TYPE 테이블
	private int bodTypeNo;
	private String bodTypeName;
}
