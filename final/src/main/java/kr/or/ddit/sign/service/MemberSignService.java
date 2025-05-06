package kr.or.ddit.sign.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sign.vo.SignVO;

public interface MemberSignService {

	// 결재 대기 리스트
	public List<SignVO> signList(Map<String, Object> map);

	// 결재 대기 전체 행
	public int getTotal(Map<String, Object> map);

	// 결재 올린거 내용 상세 보기
	public SignVO detail(SignVO signVO);

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




	

	// 기안 작성 등록, 파일, 엑셀
//	public int createPost(SignVO signVO);





}
