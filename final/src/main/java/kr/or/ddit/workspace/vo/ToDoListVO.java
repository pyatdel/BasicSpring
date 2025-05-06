package kr.or.ddit.workspace.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ToDoListVO {
	private int todoNo; // 할일 고유 No
	private int empNo;	// 직원 번호
	private String todoTitle; // 할일 제목
	private String todoDescription; // 할일 메모
	private String todoStatus;	// 할일 상태
	private Date todoEd;	// 할일 마감기한
	private Date todoCons;	// 할일 생성일
	private Date todoUpd;	// 할일 수정일
	private int todoRank;	// 할일 우선순위
	private String todoEdc;
	private String todoConsc;
}
