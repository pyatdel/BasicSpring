package kr.or.ddit.service.impl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.BookMapper;
import kr.or.ddit.service.BookService;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.BookVO;
import lombok.extern.slf4j.Slf4j;

//서비스 클래스 : 비즈니스 로직
//스프링 MVC 구조에서 Controller와 DAO를 연결하는 역할
/*
스프링 프레임워크는 개발자가 직접 클래스를 생성하는 것을 지양하고,
* 프링은 인터페이스를 좋아해. 자꾸자꾸 좋아지면 Impl은 어떡해
인터페이스를 통해 접근하는 것을 권장하고 있기 때문.(확장성)
그래서 서비스 레이어는 인터페이스(BookService)와 클래스(BookServiceImpl)를 함께 사용함

Impl : implements의 약자
*/
//"프링아 이 클래스 서비스 클래스야"라고 알려주자. 프링이가 자바빈으로 등록해줌.
@Slf4j
@Service
public class BookServiceImpl implements BookService {

	//데이터베이스 접근을 위해 BookMapper 인스턴스를 주입받자
	//DI(Dependency Injection):의존성 주입
	//IoC(Inversion of Control):제어의 역전
	@Autowired
	BookMapper bookMapper;
	//파일업로드를 위해 DI
	@Autowired
	UploadController uploadController;
	
	//도서 등록
	//bookVO{bookId=0,title=총알탄 개똥이, category=소설
	//	, price="10000",insertDate=null, uploadFile=파일객체}
	@Override
	public int createPost(BookVO bookVO) {
		int result = 0;
		
		//다중 파일업로드
		MultipartFile[] uploadFile = bookVO.getUploadFile();
		log.info("createPost->uploadFile : " + uploadFile);
		
		//파일업로드 및 FILE_GROUP 테이블 및 FILE_DETAIL 테이블에 insert
		// FILE_GROUP 테이블의 기본키(자동생성된)인 fileGroupNo를 리턴
		long fileGroupNo = this.uploadController.multiImageUpload(uploadFile);
		log.info("createPost->fileGroupNo : " + fileGroupNo);
		
		bookVO.setFileGroupNo(fileGroupNo);
		
		//BOOK 테이블에 insert
		result += this.bookMapper.createPost(bookVO);
		
		return result;
	}

	//도서 상세
	@Override
	public BookVO detail(BookVO bookVO) {
		 return this.bookMapper.detail(bookVO);		 
	}

	//도서 수정
	@Override
	public int updatePost(BookVO bookVO) {
		return this.bookMapper.updatePost(bookVO);
	}

	//도서 삭제
	@Override
	public int deletePost(BookVO bookVO) {
		return this.bookMapper.deletePost(bookVO);
	}

	//도서 목록
	@Override
	public List<BookVO> list(Map<String, Object> map) {
		return this.bookMapper.list(map);
	}
	
	//년/월/일 폴더 생성
	public static String getFolder() {
		//2022-07-22 형식(format) 지정
		//간단한 날짜 형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		//날짜 객체 생성(java.util패키지)
		Date date = new Date();
		//2024-11-15
		String str = sdf.format(date);
		//2024\\11\\15
		return str.replace("-", File.separator);
	}
	
	//용량이 큰 파일을 섬네일 처리를 하지 않으면
	//모바일과 같은 환경에서 많은 데이터를 소비해야 하므로
	//이미지의 경우 특별한 경우가 아니면 섬네일을 제작해야 함.
	//섬네일은 이미지만 가능함.
	//이미지 파일의 판단
	public static boolean checkImageType(File file) {
		/*
		 .jpeg / .jpg(JPEG 이미지)의 MIME 타입 : image/jpeg
		 */
		//MIME 타입을 통해 이미지 여부 확인
		//file.toPath() : 파일 객체를 path객체로 변환
		try {
			String contentType = Files.probeContentType(file.toPath());
			log.info("contentType : " + contentType);
			//MIME 타입 정보가 image로 시작하는지 여부를 return
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		//이 파일이 이미지가 아닐 경우
		return false;
	}
	
}














