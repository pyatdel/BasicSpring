package kr.or.ddit.system.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.board.vo.BoardTypeVO;
import kr.or.ddit.system.vo.SystemReportVO;

public interface ReportService {

	//신고관리 페이지 리스트 전체 개수 불러오기
	public int getTotal(Map<String, Object> map);

	//신고관리 페이지 리스트 불러오기
	public List<SystemReportVO> reportlist(Map<String, Object> map);

	//게시판 타입 가져오기
	public List<SystemReportVO> bodTypeNameList();

	//신고 타입 가져오기
	public List<SystemReportVO> repType();

	//신고 완료 페이지 전체 개수 불러오기
	public int getreportEndTotal(Map<String, Object> map);

	//신고 완료 페이지 리스트 불러오기
	public List<SystemReportVO> reportEndlist(Map<String, Object> map);

	// 신고 처리 하기(대기->완료)
	public int reportUpdatePost(SystemReportVO systemReportVO);

	
}
