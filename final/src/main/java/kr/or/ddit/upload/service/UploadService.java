package kr.or.ddit.upload.service;

import java.io.File;

import org.springframework.web.multipart.MultipartFile;

public interface UploadService {
	
	public long multiImageUpload(MultipartFile[] multipartFiles);
	public String getFolder();
	public boolean checkImageType(File file) ;
	public String makeFancySize(String bytes);
}
