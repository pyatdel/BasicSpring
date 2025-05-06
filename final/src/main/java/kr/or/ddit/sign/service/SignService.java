package kr.or.ddit.sign.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sign.vo.SignVO;

public interface SignService {

	// 결재 대기 리스트
	public List<SignVO> signList(Map<String, Object> map);

	// 결재 대기 전체 행
	public int getTotal(Map<String, Object> map);


	// 결재 올린거 내용 상세 보기
	public SignVO detail(SignVO signVO);

	//반려버튼(retract) update로 처리 예정
	public int retract(SignVO signVO);

	// 결재 등록 폼
	public SignVO create(int empNo);

	// 결재 종류 가져오기
	public List<SignVO> getSignVOList();

	// 결재요청 전체 행 수
	public int getRequestTotal(Map<String, Object> map);

	// 결재요청 리스트
	public List<SignVO> request(Map<String, Object> map);

	//종결함 전체 행 수
	public int getEndTotal(Map<String, Object> map);

	// 종결함 리스트
	public List<SignVO> end(Map<String, Object> map);

	//반려함 전체 행 수
	public int getCollectTotal(Map<String, Object> map);

	// 반려함 리스트
	public List<SignVO> collect(Map<String, Object> map);

	//참조 전체 행 수
	public int getReadingTotal(Map<String, Object> map);

	// 참조 리스트
	public List<SignVO> reading(Map<String, Object> map);

	//부서 문서함 전체 행수
	public int getDepartmentTotal(Map<String, Object> map);

	// 부서 문서함 리스트
	public List<SignVO> department(Map<String, Object> map);

	//결재선 리스트
	public List<SignVO> getSignLineList();

	//결재선 부서
	public List<SignVO> getDepartmentVOList();

	//결재선 해당 부서 직원 불려오기
	public List<SignVO> signLinePost(Map<String, Object> map);

	//결재선 선택 -> 결재선 등록 -> 결재 폼에 보여야함
	public int createPost(SignVO signVO);

	//결재선 이름 가져오기
	public List<SignVO> getAppListName();

	//참조선 가져오기
	public List<SignVO> getReferenceEmpIds();

	//결재폼 등록
	public int createFormPost(SignVO signVO);

	// 삽입 작업 성공 시, 삽입된 데이터를 조회
	public List<SignVO> getInsertedApprovalList(long appGroupCode);

	//선택된 결재 라인 보이게
	public List<SignVO> getAppLineList(SignVO signVO);

	//선택된 참조 라인 보이게
	public List<SignVO> getAppLineList2(SignVO signVO);

	// 승인 버튼 클릭-> approval_hist 테이블에 insert
	public int approvalPost(SignVO signVO);

	//empId를 조건으로 하여 그 직원이 결재 완료 시 보여질 도장 이미지를 가져옴
	public String getFileSaveLocate(String empId);

	//그 결재문서가 종료됐다면 1
	public int getFinalCheckStatus(SignVO signVO);

	//반려 사유 가져오기
	public SignVO retractDetail(SignVO signVO);

	//main
	public List<SignVO> signListMain(Map<String, Object> map);


	
}
