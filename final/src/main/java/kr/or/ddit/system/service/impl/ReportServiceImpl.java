package kr.or.ddit.system.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.system.mapper.ReportMapper;
import kr.or.ddit.system.service.ReportService;
import kr.or.ddit.system.vo.SystemReportVO;

@Service
public class ReportServiceImpl implements ReportService {
	
	
	@Autowired
	ReportMapper reportMapper;

	//신고관리 페이지 전체 개수 리스트 불러오기
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.reportMapper.getTotal(map);
	}

	//신고관리 페이지 리스트 불러오기
	@Override
	public List<SystemReportVO> reportlist(Map<String, Object> map) {
		return this.reportMapper.reportlist(map);
	}

	//게시판 타입 가져오기
	@Override
	public List<SystemReportVO> bodTypeNameList() {
		return this.reportMapper.bodTypeNameList();
	}

	//신고 타입 가져오기
	@Override
	public List<SystemReportVO> repType() {
		return this.reportMapper.repType();
	}

	//신고 완료 리스트 개수 전체 불러오기
	@Override
	public int getreportEndTotal(Map<String, Object> map) {
		return this.reportMapper.getreportEndTotal(map);
	}

	// 신고 완료 리스트 데이터 불러오기
	@Override
	public List<SystemReportVO> reportEndlist(Map<String, Object> map) {
		return this.reportMapper.reportEndlist(map);
	}

	//// 신고 처리 하기(대기->완료)
	@Override
	public int reportUpdatePost(SystemReportVO systemReportVO) {
		return this.reportMapper.reportUpdatePost(systemReportVO);
	}



}
