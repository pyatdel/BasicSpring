package kr.or.ddit.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardVO {
	private int    rnum;		//행번호
	private int    boNo;			// 일반게시판번호
	private String boTitle;		// 일반게시판제목
	private String boWriter;	// 일반게시판작성자
	private String boContent;	// 일반게시판내용
	private String boDate;		// 일반게시판작성일
	private int    boHit;			// 일반게시판조회수
	
	private long fileGroupNo;	//파일그룹번호
	
	//게시글 : 파일그룹 = 1 : 1
	private FileGroupVO fileGroupVO;
	
	//<input type="file" class="custom-file-input" 
 	//		id="uploadFile" name="uploadFile" />
	//MultipartFile : 스프링에서 제공해주는 파일 객체 타입
	//{boTitle=개똥이게임,boWriter=이정재
	//	,boContent=개똥이게임2탄,uploadFile=파일객체들}
	private MultipartFile[] uploadFile;	//첨부파일 객체
}
