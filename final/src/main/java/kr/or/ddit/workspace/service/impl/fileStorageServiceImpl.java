package kr.or.ddit.workspace.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.upload.cotroller.UploadController;
import kr.or.ddit.workspace.mapper.FileStorageMapper;
import kr.or.ddit.workspace.service.fileStorageService;
import kr.or.ddit.workspace.vo.FileStorageVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class fileStorageServiceImpl implements fileStorageService {

	@Autowired
	FileStorageMapper fileStorageMapper;
	
	
	@Autowired
	UploadController uploadController;
	
	
	
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.fileStorageMapper.getTotal(map);
	}

	@Override
	public List<FileStorageVO> list(Map<String, Object> map) {
		return this.fileStorageMapper.list(map);
	}
	@Override
	public int insert(FileStorageVO fileStorageVO) {
		
		MultipartFile [] uploadFiles = fileStorageVO.getUploadFiles();
		
		
		if(uploadFiles != null && uploadFiles[0].getOriginalFilename().length()>0) {
			
			long fileGroupNo = this.uploadController.multiImageUpload(uploadFiles);
			fileStorageVO.setFileGroupNo(fileGroupNo);
		}
		
		int result =  this.fileStorageMapper.insert(fileStorageVO);
		return result;
		
	}

	@Override
	public ResponseEntity<Resource> downloadZip(long fileGroupNo) {
	return this.fileStorageMapper.downloadZip(fileGroupNo);
	}

	@Override
	public int myInsert(FileStorageVO fileStorageVO) {
		
		MultipartFile [] uploadFiles = fileStorageVO.getUploadFiles();
		log.info("uploadFiles" + uploadFiles);
		if(uploadFiles != null && uploadFiles[0].getOriginalFilename().length()>0) {
			long fileGroupNo = this.uploadController.multiImageUploadCloud(uploadFiles,fileStorageVO);
			
	        log.info("fileGroupNo가 왜 안넘어 올까?",fileGroupNo);
			fileStorageVO.setFileGroupNo(fileGroupNo);
			
			
		}
		int result = this.fileStorageMapper.myInsert(fileStorageVO);
		
		return result;
	}

	@Override
	public int myGetTotal(Map<String, Object> map) {
		return this.fileStorageMapper.meGetTotal(map);
	}

	@Override
	public List<FileStorageVO> myList(Map<String, Object> map) {
		return this.fileStorageMapper.myList(map);
	}

	@Override
	public int deptInsert(FileStorageVO fileStorageVO) {
		MultipartFile [] uploadFiles = fileStorageVO.getUploadFiles();
	
		log.info("uploadFiles" + uploadFiles);
		if(uploadFiles != null && uploadFiles[0].getOriginalFilename().length()>0) {
			long fileGroupNo = this.uploadController.multiImageUploadCloud(uploadFiles,fileStorageVO);
			
	        log.info("fileGroupNo가 왜 안넘어 올까?",fileGroupNo);
			fileStorageVO.setFileGroupNo(fileGroupNo);
			
			
		}
		int result = this.fileStorageMapper.deptInsert(fileStorageVO);
		
		return result;
	}

	@Override
	public List<FileStorageVO> deptFileVOList(Map<String, Object> map) {
		return this.fileStorageMapper.deptFileVOList(map);
	}

	@Override
	public int deptGetTotal(Map<String, Object> map) {
		return this.fileStorageMapper.deptGetTotal(map);
	}


}
