package kr.or.ddit.sign.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.sign.mapper.SignMapper;
import kr.or.ddit.sign.service.MemberSignService;
import kr.or.ddit.sign.vo.SignVO;
import kr.or.ddit.upload.cotroller.UploadController;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberSignServiceImpl implements MemberSignService {

	@Autowired
	SignMapper signMapper;
	
	@Autowired
	UploadController uploadController;
	
	// 결재 대기 리스트
	@Override
	public List<SignVO> signList(Map<String, Object> map) {
		return this.signMapper.signList(map);
	}

	// 결재 대기 전체 행
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.signMapper.getTotal(map);
	}


	// 결재 올린거 내용 상세 보기
	@Override
	public SignVO detail(SignVO signVO) {
		return this.signMapper.detail(signVO);
	}

	//결재선 부서,직급 리스트
	@Override
	public List<SignVO> getSignLineList() {
		return this.signMapper.getSignLineList();
	}

	//결재선 부서
	@Override
	public List<SignVO> getDepartmentVOList() {
		return this.signMapper.getDepartmentVOList();
	}

	//결재선 해당 부서 직원 불려오기
	@Override
	public List<SignVO> signLinePost(Map<String, Object> map) {
		return this.signMapper.signLinePost(map);
	}

	//결재선 선택 -> 결재선 등록 -> 결재 폼에 보여야함
	@Override
	public int createPost(SignVO signVO) {
		int result = 0;
		
		// 결재 그룹 등록
		// this.signMapper.createGroupPost(signVO);
		result = this.signMapper.createGroupPost(signVO);
		
		//ex) 두 명 
		//empIds=[20241224002, 20241231003]
		String[] empIds = signVO.getEmpIds();
		String[] referenceEmpIds = signVO.getReferenceEmpIds();
		int counter = 1;
		
		//결재
		for(String empId : empIds) {
			//두 명이면 insert가 2 번 일어나야 함
			//목적 : empId, appOrder
			signVO.setEmpId(empId);
			signVO.setAppOrder(counter++);
			
			int insertResult = this.signMapper.createPost(signVO);
		    log.info("INSERT 결과: {}, empId: {}", insertResult, empId);

		    result += insertResult;
			
			/* result += this.signMapper.createPost(signVO); */
			log.info("결재선empId:", empId);
		}
		
		//참조
		for(String empId : referenceEmpIds) {
			signVO.setEmpId(empId);
			signVO.setAppOrder(counter++);
			
			int insertResult2 = this.signMapper.createPost2(signVO);
			log.info("insertResult2 결과: {}, empId: {}", insertResult2, empId);
			
			result += insertResult2;
			
			/* result += this.signMapper.createPost(signVO); */
			log.info("참조선empId:", empId);
		}
		
		return result;
	}

	//결재선 이름 가져오기
	@Override
	public List<SignVO> getAppListName() {
		return this.signMapper.getAppListName();
	}

	// 참조선 가져오기
	@Override
	public List<SignVO> getReferenceEmpIds() {
		return this.signMapper.getReferenceEmpIds();
	}


	@Override
	public int createFormPost(SignVO signVO) {// 파일 첨부
		MultipartFile[] uploadFile = signVO.getUploadFile();
		
		long fileGroupNo = this.uploadController.multiImageUpload(uploadFile);
		log.info("createFormPost->fileGroupNo : " + fileGroupNo);
		
		signVO.setFileGroupNo(fileGroupNo);
		
		int result = this.signMapper.createFormPost(signVO);
		return result;
	}

	// 삽입 작업 성공 시, 삽입된 데이터를 조회
	@Override
	public List<SignVO> getInsertedApprovalList(long appGroupCode) {
		return this.signMapper.getInsertedApprovalList(appGroupCode);
	}

	////선택된 결재 라인 보이게
	@Override
	public List<SignVO> getAppLineList(SignVO signVO) {
		return this.signMapper.getAppLineList(signVO);
	}

	//선택된 참조 라인 보이게
	@Override
	public List<SignVO> getAppLineList2(SignVO signVO) {
		return this.signMapper.getAppLineList2(signVO);
	}


	




	// 기안 작성 등록, 파일, 엑셀
//	@Override
//	public int createPost(SignVO signVO) {
//		return this.signMapper.createPost(signVO);
//	}



}
