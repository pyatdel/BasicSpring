package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.SujinMapper;
import kr.or.ddit.service.SujinService;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.SujinVO;
import lombok.extern.slf4j.Slf4j;

//스프링 프레임워크에게 알려줌
//	자바빈 객체로 등록해줌
@Slf4j
@Service
public class SujinServiceImpl implements SujinService {

	@Autowired
	SujinMapper sujinMapper;
	//DI/IoC
	@Autowired
	UploadController uploadController;
	
	@Override
	public List<SujinVO> listSujin(Map<String, Object> map) {
		return this.sujinMapper.listSujin(map);
	}

	@Override
	public SujinVO getSujin(SujinVO sujinVO) {
		return this.sujinMapper.getSujin(sujinVO);
	}

	@Override
	public int insertSujin(SujinVO sujinVO) {
		
		MultipartFile[] multipartFiles = sujinVO.getUploadFile();
		log.info("insertSujin->multipartFiles : " + multipartFiles);
		
		//가) 파일이 있을 때
		if(multipartFiles!=null && multipartFiles[0].getOriginalFilename().length()>0) {
			//1. 다중 파일 업로드 처리 + FILE_GROUP + FILE_DETAIL 테이블에 insert
			Long fileGroupNo = this.uploadController.multiImageUpload(multipartFiles);
			log.info("insertSujin->fileGroupNo : " + fileGroupNo);
			//2. Long fileGroupNo를 sujinVO의 sujinFile를 넣기
			//(전)sujinVO{sujinNum=0,sujinContent=여행은 즐거워,sujinName=개똥이,sujinFile=null,
			//			uploadFile=파일객체}
			//private long fileGroupNo
			sujinVO.setSujinFile(Long.toString(fileGroupNo));
			//sujinVO.setSujinFile(String.valueOf(fileGroupNo));
			//(후)sujinVO{sujinNum=0,sujinContent=여행은 즐거워,sujinName=개똥이,sujinFile=20241209001,
			//			uploadFile=파일객체}
		}
		//나) 파일이 없을 때
		//(후)sujinVO{sujinNum=0,sujinContent=여행은 즐거워,sujinName=개똥이,sujinFile=null,
		//			uploadFile=파일객체}
		return this.sujinMapper.insertSujin(sujinVO);
	}

	@Override
	public int updateSujin(SujinVO sujinVO) {
		return this.sujinMapper.updateSujin(sujinVO);
	}

	@Override
	public int deleteSujin(SujinVO sujinVO) {
		return this.sujinMapper.deleteSujin(sujinVO);
	}

	//전체 행의 수
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.sujinMapper.getTotal(map);
	}

}




