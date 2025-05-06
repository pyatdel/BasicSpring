package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

//엔티티에 생성 시간과 수정 시간을 추가해 글이 언제 생성되었는지 뷰에서 확인해보자
@Data
public class ArticleVO {
	private Long id;
	private String title;
	private String content;
	private Date   createdAt;
	private MultipartFile[] uploadFile;
	
	public ArticleVO(String title, String content) {
		this.title = title;
		this.content = content;
	}
	
}
