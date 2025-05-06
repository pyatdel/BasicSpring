package kr.or.ddit.upload.cotroller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.DecimalFormat;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.config.FileConfig;
import kr.or.ddit.file.mapper.FileGroupMapper;
import kr.or.ddit.file.vo.FileDetailVO;
import kr.or.ddit.file.vo.FileGroupVO;
import kr.or.ddit.workspace.vo.FileStorageVO;
import lombok.extern.slf4j.Slf4j;

//자바빈으로 등록
@Slf4j
@Controller
public class UploadController {
   
   //파일이 업로드 될 대상 폴더
   //C:\\sts4-4.26.0\\workspace\\BookProj\\src\\main\\resources\\static\\resources\\upload
   //String uploadPath = "D:\\A_TeachingMaterial\\src\\FINAL_PROJECT\\final\\upload";
   
   @Autowired
   FileGroupMapper fileGroupMapper; 
   
   /** 다중 이미지 업로드
    *  파라미터 : 스프링 파일배열 타입 multipartFiles
    *  return : 20241119001(FILE_GROUP테이블의 FILE_GROUP_NO)
    */
   public long multiImageUpload(MultipartFile[] multipartFiles) {
      long fileGroupNo = 0L;
      int result = 0;
      //FILE_DETAIL테이블의 복합키(FILE_SN, FILE_GROUP_NO) 중 FILE_SN 컬럼을 위함
      /*
       1   20241119001
       2   20241119001
       */
      int counter = 0; 
      
	//연월일 폴더 설정
      // C:\\sts4-4.26.0\\workspace\\BookProj\\src\\main\\resources\\static\\resources\\upload
      // + "\\" + 
      // 2024\\08\\08
      File uploadPath = new File(FileConfig.uploadPath, this.getFolder());
      
      
      
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
         //         asdflkasdflsdfakas_개똥이.jpg
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
            fileDetailVO.setFileSn(++counter);                     //복합키(P.K). 1,          2,           3..
            //FILE_GROUP 테이블에 insert 시 FileGroupvO의 fileGroupNo는 채워져있음
            fileDetailVO.setFileGroupNo(fileGroupVO.getFileGroupNo());   //복합키(P.K)  20241119004   20241119004   20241119004
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
   
   /** 다중 이미지 업로드
    *  파라미터 : 스프링 파일배열 타입 multipartFiles
    *  return : 20241119001(FILE_GROUP테이블의 FILE_GROUP_NO)
    */
   /*public long multiImageUploadCloud(MultipartFile[] multipartFiles, Map<String, String> map) {
	  
	  String type = map.get("type");
	  
	  String folder ="";
	  // if문 처리하기.
	  if(type.equals("common")) folder = getCompanyFolder(); 
	  if(type.equals("dept")) folder = getDeptFolder(map.get("value")); 
	  if(type.equals("my")) folder = getMyFolder(map.get("value")); 
	 */
   public long multiImageUploadCloud(MultipartFile[] multipartFiles, FileStorageVO fileStorageVO) {
	    // type과 value를 FileStorageVO에서 가져옴
	    String type = fileStorageVO.getFileType();
	    String folder = "";

	    // type에 따라 폴더 경로 설정
	    if (type.equals("common")) {
	        folder = getCompanyFolder();
	    } else if (type.equals("dept")) {
	        folder = getDeptFolder(fileStorageVO.getDeptNo());
	    } else if (type.equals("my")) {
	        folder = getMyFolder(fileStorageVO.getEmpNo());
	    }
      long fileGroupNo = 0L;
      int result = 0;
      //FILE_DETAIL테이블의 복합키(FILE_SN, FILE_GROUP_NO) 중 FILE_SN 컬럼을 위함
      /*
       1   20241119001
       2   20241119001
       */
      int counter = 0; 
      
      //연월일 폴더 설정
      File uploadPath = new File(FileConfig.uploadPath, folder);
      
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
         //         asdflkasdflsdfakas_개똥이.jpg
         fileName = uuid.toString() + "_" + fileName;
         
         //File객체 설계(복사할 대상 경로, 파일명)
         File saveFile = new File(uploadPath,fileName);
         
         try {
            //파일 복사 실행
            //파일객체.transferTo(설계)
            multipartFile.transferTo(saveFile);
            
            //2) FILE_DETAIL 테이블에 insert
            FileDetailVO fileDetailVO = new FileDetailVO();
            fileDetailVO.setFileSn(++counter);                     //복합키(P.K). 1,          2,           3..
            //FILE_GROUP 테이블에 insert 시 FileGroupvO의 fileGroupNo는 채워져있음
            fileDetailVO.setFileGroupNo(fileGroupVO.getFileGroupNo());   //복합키(P.K)  20241119004   20241119004   20241119004
            fileDetailVO.setFileOriginalName(multipartFile.getOriginalFilename());//개똥이.jpg
            fileDetailVO.setFileSaveName(fileName); //uuid_개똥이.jpg
            // /resources/upload/ == C:\\sts4-4.26.0\\workspace\\BookProj\\src\\main\\resources\\static\\resources\\upload\\ + 2024\\08\\08 + "\\" + asdfasdf_파일명.jpg
            ///resources/upload/2024/11/19/93aa4106-6d19-40c6-90c8-bdee1efc73b3_111.jpg
            fileDetailVO.setFileSaveLocate("/resources/upload/" +
            		folder + 
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
   
   // 공통(회사) 폴더 경로
   public String getCompanyFolder() {
	   String path = "common";
	   return path;
   }
   
   // 부서 폴더 경로
   public String getDeptFolder(int deptNo ) {
	   String path = "deptfolder/"+deptNo;
	   // 회원 아이디 가져오기.
	   
	   return path;
   }
   // 개인 폴더 경로
   public String getMyFolder(int empNo) {
	   String path = "myfolder/"+empNo;
	   // 회원 아이디 가져오기.
	   
	   return path;
   }
	/*
	 * public String getFolder(String company, String department, String person) {
	 * // 회사 폴더 생성 경로 String companyFolder = FileConfig.uploadPath + File.separator
	 * + "회사" + File.separator + company;
	 * 
	 * // 부서 폴더 생성 경로 String departmentFolder = FileConfig.uploadPath +
	 * File.separator + "부서" + File.separator + department;
	 * 
	 * // 개인 폴더 생성 경로 String personFolder = FileConfig.uploadPath + File.separator +
	 * "개인" + File.separator + person;
	 * 
	 * // 폴더 경로들을 반환 (예시: 회사/부서/개인) return companyFolder + File.separator +
	 * departmentFolder + File.separator + personFolder; }
	 */

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


   //파일 다운로드
   // localhost:8050/download?fileName=/resources/upload/2024/11/19/a8686d2b-1749-4a40-b592-2033534d3a92_111.jpg
  @ResponseBody
   @GetMapping("/download")
   public ResponseEntity<Resource> download(
         @RequestParam(value="fileName") String fileName){
      log.info("download->fileName : " + fileName);
      
      //resource : 다운로드 받을 파일(자원)
      Resource resource = new FileSystemResource(
         "D:\\"+fileName   
            );

      // "C:\\sts4-4.26.0\\workspace\\BookProj\\src\\main\\resources\\static"+fileName   
        
//      C:\\sts4-4.26.0\\workspace\\BookProj\\src\\main\\resources\\static
      //파일명(cd862ebd-10a2-4220-bbbb-5bbf8ffdadd7_phone01.jpg)
      String resourceName = resource.getFilename();
      
      //header : 인코딩 정보, 파일명 정보
      HttpHeaders headers = new HttpHeaders();
      try {
         //headers.add("헤더명",파일명 데이터)
         headers.add("Content-Disposition", "attachment;filename="+
               new String(resourceName.getBytes("UTF-8"),"ISO-8859-1"));
      }catch(UnsupportedEncodingException e) {
         log.error(e.getMessage());
      }
      
      //         ResponseEntity<보낼데이터의 타입>(데이터,헤더정보,HTTP상태코드)       
      //      HttpStatus.OK : 200(성공)
      return new ResponseEntity<Resource>(resource,headers,HttpStatus.OK);
   }

	// 다중 다운로드 (zip 파일 )
	@GetMapping("/downloadMulti")
	public ResponseEntity<Resource> downloadMultiple(@RequestParam(value = "fileNames") List<String> fileNames
	) throws IOException {

		// zip 파일의 이름 설정
		String zipFileName = "downloaded_files.zip";

		// FileUtils.forceMkdir(new File("D:\\resources\\upload\\test"));
		File tempZipFile = createZipFile(fileNames, zipFileName); // ZIP 파일 생성

		// zip 파일 리소스 생성
		Resource resource = new FileSystemResource(tempZipFile);

		// 헤더 설정
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Disposition",
				"attachment;filename=" + new String(zipFileName.getBytes("UTF-8"), "ISO-8859-1"));

		return new ResponseEntity<>(resource, headers, HttpStatus.OK);
	}

	/**
	 * 파일 목록을 받아서 파일을 1개의 압축 파일로 만드는 녀석
	 * 
	 * @param fileNames   압축을 할 파일 목록
	 * @param zipFileName 압축 파일명
	 * @return tempZipFile 서버에 저장될 임시 파일명
	 * @throws IOException
	 * 
	 */
	
	private File createZipFile(
			// 압축할 첨부파일 목록
			List<String> fileNames,

			// 첨부파일을 서버 임시 경로에 저장할 압축 파일명
			String zipFileName) throws IOException {

		// zip 다운받을 경로 (folder 이름 uuid 생성)
		String tempPath = MessageFormat.format("{0}{1}\\{2}", "D:\\upload\\", "temp", UUID.randomUUID().toString());

		// 해당하는 디렉토리가 없으면 디렉토리를 생성해줘..
		FileUtils.forceMkdir(new File(tempPath));

		// zip 파일 생성 로직
		// 나는 D:\\resources\\upload\\ 경로에 downloaded_files.zip 첨부파일을 만들꺼야...
		File tempZipFile = new File(tempPath, zipFileName);
		log.debug("tempZipFile : {}", tempZipFile.getAbsolutePath());
		log.debug("fileNames :{}", fileNames);

		try (ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(tempZipFile))) {

			for (String fileName : fileNames) {
				log.debug("fileName :{}", fileName);

				File file = new File("D:\\" + fileName);

				if (!file.isFile()) {
					log.error("파일이 존재하지 않음: {}", file.getAbsolutePath());
				}

				try (FileInputStream fis = new FileInputStream(file)) {
					zos.putNextEntry(new ZipEntry(file.getName()));
					byte[] buffer = new byte[1024];
					int length;
					while ((length = fis.read(buffer)) >= 0) {
						zos.write(buffer, 0, length);
					}
					zos.closeEntry();
				}
			}
		}

		return tempZipFile;
	}

}













