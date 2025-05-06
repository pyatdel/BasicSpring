package kr.or.ddit.workspace.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.file.vo.FileGroupVO;
import kr.or.ddit.member.vo.MemberVO;
import lombok.Data;

@Data
public class FileStorageVO {
	private int rnum;
	private Date fileSaveDatee;
	private MultipartFile[] uploadFiles;
	private long fileGroupNo;
	private int empNo;
	private int deptNo;
	
	
	private int fileStorageNo;
	private String fileType;
	private String empName;
	private String fileOrigiNalName;
	private Date fileRegDate;
	private int fileSn;
	private String fileOriginalName;
	private String fileSaveName;
	private String fileSaveLocate;
	private int fileSize;
	private String fileExt;
	private String fileMime;
	private String fileFancysize;
	private Date fileSaveDate;
	private int fileDowncount;
	// MEMBER : FILE_GROUP = 1 : 1 = association
	private FileGroupVO fileGroupVO;




}
