package kr.or.ddit.upload.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.file.mapper.FileGroupMapper;
import kr.or.ddit.file.vo.FileDetailVO;
import kr.or.ddit.file.vo.FileGroupVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UploadServiceImpl implements UploadService {
	FileGroupMapper fileGroupMapper; 

	//파일이 업로드 될 대상 폴더
	//C:\\sts4-4.26.0\\workspace\\BookProj\\src\\main\\resources\\static\\resources\\upload
	String uploadPath = "D://resources/upload";
	
	
	/** 다중 이미지 업로드
	 *  파라미터 : 스프링 파일배열 타입 multipartFiles
	 *  return : 20241119001(FILE_GROUP테이블의 FILE_GROUP_NO)
	 */
	public long multiImageUpload(MultipartFile[] multipartFiles) {
		long fileGroupNo = 0L;
		int result = 0;
		//FILE_DETAIL테이블의 복합키(FILE_SN, FILE_GROUP_NO) 중 FILE_SN 컬럼을 위함
		/*
		 1	20241119001
		 2	20241119001
		 */
		int counter = 0; 
		
		//연월일 폴더 설정
		// C:\\sts4-4.26.0\\workspace\\BookProj\\src\\main\\resources\\static\\resources\\upload
		// + "\\" + 
		// 2024\\08\\08
		File uploadPath = new File(this.uploadPath, this.getFolder());
		
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}
		
		//원본 파일명
		String fileName = "";
		
		//MIME(Multipurpost Internet Mail Extension) 타입
		String contentType = "";
		
		//파일 크기
		long fileSize = 0L;
		
		//1) FILE_GROUP 테이블에 insert
		FileGroupVO fileGroupVO = new FileGroupVO();
		
		//실행전 FileGroupVO(fileGroupNo=0, fileRegdate=null, fileDetailVOList=null)
		log.info("multiImageUpload->fileGroupVO(전) : " + fileGroupVO);
		result += this.fileGroupMapper.insertFileGroup(fileGroupVO);
		//실행후 fileGroupVO{fileGroupNo=20241119004,fileRegdate=null}
		log.info("multiImageUpload->fileGroupVO(후) : " + fileGroupVO);
		
		//향상된 for문(multipartFiles : 파일들)
		//MultipartFile[] multipartFiles
		for(MultipartFile multipartFile : multipartFiles) {
			fileName = multipartFile.getOriginalFilename();//개똥이.jpg
			fileSize = multipartFile.getSize();//1234123bytes
			contentType = multipartFile.getContentType();//image/jpeg(MIME)
			
			//UUID_파일명
			UUID uuid = UUID.randomUUID();
			//			asdflkasdflsdfakas_개똥이.jpg
			fileName = uuid.toString() + "_" + fileName;
			
			//File객체 설계(복사할 대상 경로, 파일명)
			// C:\\sts4-4.26.0\\workspace\\BookProj\\src\\main\\resources\\static\\resources\\upload\\2024\\08\\08 + "\\" + asdfasdf_개똥이.jpg
			File saveFile = new File(uploadPath,fileName);
			
			try {
				//파일 복사 실행
				//파일객체.transferTo(설계)
				multipartFile.transferTo(saveFile);
				
				//2) FILE_DETAIL 테이블에 insert
				FileDetailVO fileDetailVO = new FileDetailVO();
				fileDetailVO.setFileSn(++counter);							//복합키(P.K). 1, 			2, 			 3..
				//FILE_GROUP 테이블에 insert 시 FileGroupvO의 fileGroupNo는 채워져있음
				fileDetailVO.setFileGroupNo(fileGroupVO.getFileGroupNo());	//복합키(P.K)  20241119004   20241119004   20241119004
				fileDetailVO.setFileOriginalName(multipartFile.getOriginalFilename());//개똥이.jpg
				fileDetailVO.setFileSaveName(fileName); //uuid_개똥이.jpg
				// /resources/upload/ == C:\\sts4-4.26.0\\workspace\\BookProj\\src\\main\\resources\\static\\resources\\upload\\ + 2024\\08\\08 + "\\" + asdfasdf_파일명.jpg
				///resources/upload/2024/11/19/93aa4106-6d19-40c6-90c8-bdee1efc73b3_111.jpg
				fileDetailVO.setFileSaveLocate("/resources/upload/" +
							this.getFolder().replace("\\", "/") + 
							"/" + fileName
						);//웹경로
				fileDetailVO.setFileSize(fileSize);//bytes
				fileDetailVO.setFileExt(
						fileName.substring(fileName.lastIndexOf(".")+1)
						);//jpg
				fileDetailVO.setFileMime(contentType);
				fileDetailVO.setFileFancysize(
							makeFancySize(String.valueOf(fileSize))
						);//bytes->Mb. public String makeFancySize(String bytes) {
				fileDetailVO.setFileSaveDate(null);
				fileDetailVO.setFileDowncount(0);		
				/*
				FileDetailVO(fileSn=1, fileGroupNo=20241119005, fileOriginalName=111.jpg, fileSaveName=f4139448-65fc-41b3-a4f6-baf719fb0a05_111.jpg, fileSaveLocate=/resources/upload/2024/11/19/f4139448-65fc-41b3-a4f6-baf719fb0a05_111.jpg, fileSize=306350, fileExt=jpg, fileMime=image/jpeg, fileFancysize=299.17 KB, fileSaveDate=null, fileDowncount=0)
				FileDetailVO(fileSn=2, fileGroupNo=20241119005, fileOriginalName=500.jpg, fileSaveName=26421f0c-c4bd-4eec-bfca-621ad04b339c_500.jpg, fileSaveLocate=/resources/upload/2024/11/19/26421f0c-c4bd-4eec-bfca-621ad04b339c_500.jpg, fileSize=21459, fileExt=jpg, fileMime=image/jpeg, fileFancysize=20.96 KB, fileSaveDate=null, fileDowncount=0)
				 */
				
				result += this.fileGroupMapper.insertFileDetail(fileDetailVO);
				
				//fileGroupNo : 20241119005
				log.info("result : " + result);
				log.info("fileDetailVO : " + fileDetailVO);
			
				fileGroupNo = fileGroupVO.getFileGroupNo();
			}catch (IllegalStateException | IOException e) {
				log.error(e.getMessage());
			}
		}
		
		//20240808001
		return fileGroupNo;
	}
	
	//연/월/일 폴더 생성
	public String getFolder() {
		//2022-11-16 형식(format) 지정
		//간단한 날짜 형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//날짜 객체 생성(java.util 패키지)
		Date date = new Date();
		//2024-11-19
		String str = sdf.format(date);
		//2024-11-19 -> 2024\\11\\19
		return str.replace("-", File.separator);
	}
	
	//이미지인지 판단. 썸네일은 이미지만 가능하므로..
	public boolean checkImageType(File file) {
		//MIME(Multipurpose Internet Mail Extensions) : 문서, 파일 또는 바이트 집합의 성격과 형식. 표준화
		//MIME 타입 알아냄. .jpeg / .jpg의 MIME타입 : image/jpeg
		String contentType;
		try {
			contentType = Files.probeContentType(file.toPath());
			log.info("contentType : " + contentType);
			//image/jpeg는 image로 시작함->true
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		//이 파일이 이미지가 아닐 경우
		return false;
	}
	
	//fancySize 리턴("1059000")	
	public String makeFancySize(String bytes) {
		log.info("bytes : " + bytes);
		String retFormat = "0";
		//숫자형문자->실수형으로 형변환(1059000)
		Double size = Double.parseDouble(bytes);
		
		String[] s = { "bytes", "KB", "MB", "GB", "TB", "PB" };
		
		if (bytes != "0") {
		  //bytes->KB
		  int idx = (int) Math.floor(Math.log(size) / Math.log(1024));
		  DecimalFormat df = new DecimalFormat("#,###.##");
		  double ret = ((size / Math.pow(1024, Math.floor(idx))));
		  retFormat = df.format(ret) + " " + s[idx];
		} else {
		  retFormat += " " + s[0];
		}
		
		return retFormat;
	}
}
