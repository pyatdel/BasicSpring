package kr.or.ddit.workspace.vo;

import java.util.Date;

import lombok.Data;

@Data
public class GantVO {
	private String taskId; // 작업 아이디
	private String taskName; // 작업 이름
	private String startDate; // 작업 시작일
	private String endDate; // 작업 종료일
	private Date progressDate; // 작업 지속 기간 
	private int duration; // 작업 상태 
	private int taskRanking; // 작업 우선순위 
	private String taskEpns; // 작업 설명
	private int empNo; // 작업 담당자 
}
