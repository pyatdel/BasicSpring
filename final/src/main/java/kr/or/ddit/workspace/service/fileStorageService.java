package kr.or.ddit.workspace.service;

import java.util.List;
import java.util.Map;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;

import kr.or.ddit.workspace.vo.FileStorageVO;

public interface fileStorageService {

	public int getTotal(Map<String, Object> map);

	public List<FileStorageVO> list(Map<String, Object> map);

	public int insert(FileStorageVO fileStorageVO);

	public ResponseEntity<Resource> downloadZip(long fileGroupNo);

	public int myInsert(FileStorageVO fileStorageVO);

	public int myGetTotal(Map<String, Object> map);

	public List<FileStorageVO> myList(Map<String, Object> map);

	public int deptInsert(FileStorageVO fileStorageVO);

	public List<FileStorageVO> deptFileVOList(Map<String, Object> map);

	public int deptGetTotal(Map<String, Object> map);



}
