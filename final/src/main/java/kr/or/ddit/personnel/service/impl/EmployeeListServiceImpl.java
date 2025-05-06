package kr.or.ddit.personnel.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.personnel.mapper.EmployeeListMapper;
import kr.or.ddit.personnel.service.EmployeeListService;
import kr.or.ddit.personnel.vo.EmployeeVO;
import kr.or.ddit.upload.cotroller.UploadController;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EmployeeListServiceImpl implements EmployeeListService {

	@Autowired
	EmployeeListMapper employeeListMapper;
	
	@Autowired
	UploadController uploadController;
	
	// 전체 행의 수
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.employeeListMapper.getTotal(map);
	}

	// 직원 목록 전체 조회
	@Override
	public List<EmployeeVO> list(Map<String, Object> map) {
		return this.employeeListMapper.list(map);
	}

	//직원 목록 자세히 보기
	@Override
	public EmployeeVO detail(EmployeeVO employeeVO) {
		return this.employeeListMapper.detail(employeeVO);
	}

	// 직원 수정 페이지
	@Override
	public int updatePost(EmployeeVO employeeVO) {
		
		MultipartFile[] uploadFile = employeeVO.getUploadFile();
		
		long fileGroupNo = this.uploadController.multiImageUpload(uploadFile);
		log.info("updatePost->fileGroupNo:" + fileGroupNo);
		
		employeeVO.setFileGroupNo(fileGroupNo);
		
		int result = this.employeeListMapper.updatePost(employeeVO);
		
		return result;
	}

	// 직원 등록
	@Override
	public int createPost(EmployeeVO employeeVO) {
		/*
		 EmployeeVO(empNo=0, enabled=null, empId=20241231113, empPw=$2a$10$8sGhUYHlzSjwGTTIUW4gsOcfRUgFEIl2jYfsB8duUdSPzz/MFeifq, empName=근원근, empEmail=test7@test.com, 
		 empPhone=010-5555-7777, empZip=null, empStreet=null, empDetail=null, empSign=null, empAnnual=0, empIn=null, 
		 empOut=null, deptNo=3, postNo=0, rnum=0, residentNumber1=null, residentNumber2=null, deptName=null, postName=null, 
		 fileGroupVO=null, fileGroupNo=0, uploadFile=[org.springframework.web.multipart.support.StandardMultipart..)
		 */
		MultipartFile[] uploadFile = employeeVO.getUploadFile();
		
		long fileGroupNo = this.uploadController.multiImageUpload(uploadFile);
		log.info("insertPost->fileGroupNo : " + fileGroupNo);
		
		employeeVO.setFileGroupNo(fileGroupNo);
		
		int result = this.employeeListMapper.createPost(employeeVO);
		return result;
	}

	//직원 탈퇴 처리
	@Override
	public int delete(EmployeeVO employeeVO) {
		return this.employeeListMapper.delete(employeeVO);
	}

	//직원 사원번호 중복 체크
	@Override
	public int idDupChk(EmployeeVO employeeVO) {
		return this.employeeListMapper.idDupChk(employeeVO);
	}

	//퇴사자 리스트
	@Override
	public List<EmployeeVO> resign(Map<String, Object> map) {
		return this.employeeListMapper.resign(map);
	}

	//퇴사자 개수
	@Override
	public int getResignTotal(Map<String, Object> map) {
		return this.employeeListMapper.getResignTotal(map);
	}

	//입사,퇴사,총인원수
	@Override
	public List<EmployeeVO> chartList(Map<String, Object> map) {
		return this.employeeListMapper.chartList(map);
	}

	

}
