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

import kr.or.ddit.mapper.BoardMapper;
import kr.or.ddit.service.BoardService;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.BoardVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardServiceImpl implements BoardService {

	//DI/IoC
	@Autowired
	BoardMapper boardMapper;
	
	@Autowired
	UploadController uploadController;
	
	/*
	BoardVO(boNo=0, boTitle=개똥이게임, boWriter=이정재, boContent=<p>개똥이게임2탄</p>
			  , boDate=null, boHit=0,uploadFile=파일객체들)
	 */
	@Override
	public int insertPost(BoardVO boardVO) {
		
		MultipartFile[] uploadFile = boardVO.getUploadFile();
									//		MultipartFile[] 
		long fileGroupNo = this.uploadController.multiImageUpload(uploadFile);
		//FILE_GROUP테이블과 FILE_DETAIL 테이블에 insert가 완료
		log.info("insertPost->fileGroupNo : " + fileGroupNo);
		
		//게시글에 파일그룹번호를 setting해줌
		boardVO.setFileGroupNo(fileGroupNo);
		
		/*
		BoardVO(boNo=0, boTitle=개똥이게임, boWriter=이정재, boContent=<p>개똥이게임2탄</p>
			  , boDate=null, boHit=0,uploadFile=파일객체들,fileGroupNo=20241121001)
		 */
		int result = this.boardMapper.insertPost(boardVO);
		
		return result;
	}

	//게시물 상세보기
	@Override
	public BoardVO detail(int boNo) {
		return this.boardMapper.detail(boNo);
	}

	//게시물 수정. 서비스레이어 호출->퍼시스턴스 레이어 호출->DB update 처리(매퍼xml)
	@Override
	public int updatePost(BoardVO boardVO) {
		return this.boardMapper.updatePost(boardVO);
	}

	//게시물 삭제
	@Override
	public int deletePost(BoardVO boardVO) {
		return this.boardMapper.deletePost(boardVO);
	}

	//게시물 목록
	@Override
	public List<BoardVO> list(Map<String, Object> map) {
		return this.boardMapper.list(map);
	}

	//전체 행의 수
	@Override
	public int getTotal() {
		return this.boardMapper.getTotal();
	}

	//년/월/일 폴더 생성
	public static String getFolder() {
		//2024-11-14 형식(format) 지정
		//간단한 날짜 형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		//날짜 객체 생성(java.util패키지)
		Date date = new Date();
		//2024-11-14
		String str = sdf.format(date);
		
		//File.separator : 윈도에서는 \\
		//2024-11-14 -> 2024\\11\\14
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
