package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MainVO {
    // contract_master 테이블 필드
    private String contractNo;       // 계약 번호
    private String contractNm;       // 계약 이름
    private String empNo;            // 직원 번호
    private String contractStatus;   // 계약 상태
    private Date fromDate;           // 계약 시작일
    private Date toDate;             // 계약 종료일
    private String contractPrice;    // 계약 금액 (문자열로 처리)
    private String entMemo;          // 기업 메모
    private String contractType;     // 계약 유형
    private int state;               // 진행 상태
    private Date approvalDate;       // 승인 날짜
    private String approvalEmp;      // 승인 담당자

    // enterprice 테이블 필드
    private int entNo;               // 기업 번호
    private String entName;          // 기업 이름
    private String busNo;            // 사업 번호
    private String entCust;          // 담당자 이름
    private String busAdd;           // 사업장 주소
    private Date entRegDate;         // 기업 등록일

    // employee 테이블 필드
    private String empName;          // 직원 이름

    // file_detail 테이블 필드
    private String fileGroupNo;      // 파일 그룹 번호

}
