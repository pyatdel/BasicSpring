package kr.or.ddit.workspace.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;

import kr.or.ddit.workspace.vo.FileStorageVO;

@Mapper
public interface FileStorageMapper {

	

	public List<FileStorageVO> list(Map<String, Object> map);

	public int getTotal(Map<String, Object> map);

	public int insert(FileStorageVO fileStorageVO);

	public ResponseEntity<Resource> downloadZip(long fileGroupNo);

	public int typeInsert(FileStorageVO fileStorageVO, Map<String, String> map);

	public int myInsert(FileStorageVO fileStorageVO);

	public int meGetTotal(Map<String, Object> map);

	public List<FileStorageVO> myList(Map<String, Object> map);

	public int deptInsert(FileStorageVO fileStorageVO);

	public List<FileStorageVO> deptFileVOList(Map<String, Object> map);
	
	public int deptGetTotal(Map<String, Object> map);

}
