package kr.or.ddit.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.service.BlogService;
import kr.or.ddit.vo.ArticleVO;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@PreAuthorize("hasRole('ROLE_ALBA')")
@RequestMapping("/articles")
@Slf4j
@Controller
public class BlogViewController {
	
	@Autowired
	BlogService blogService;
	
	@ModelAttribute
	public void home(Model model) {
		model.addAttribute("mainTitle", "게시글 목록");
	}
	
	//게시글 목록
	@GetMapping("/list")
	public String getArticles(Model model) {
		List<ArticleVO> articleVOList = this.blogService.findAll();
		log.info("getArticles->articleVOList : " + articleVOList);
		
		//블로그 글 리스트 저장
		//addAttribute() 메서드를 사용해 모델에 값을 저장함.
		//	articlesVOList 키에 블로그 글들을, 즉, 글 리스트를 저장함
		model.addAttribute("articleVOList", articleVOList);
		
		//forwarding -> articleList.jsp라는 뷰 조회
		return "article/articleList";
	}
	
	//게시글 상세
	/*
	 요청URI : /articles/1
	 경로변수 : id
	 요청방식 : get
	 
	 경로변수 id -> 파라미터변수 id -> 매개변수 id
	 id에 URL로 넘어온 값을 받아 getArticle() 메서드를 호출하여
	 	글을 조회하고, 화면에서 사용할 모델에 데이터를 저장한 다음,
	 	보여줄 화면의 jsp 경로를 반환함
	 */
	@GetMapping("/{id}")
	public String getArticle(@PathVariable(value="id") Long id, Model model) {
		log.info("article->id : " + id);
		
		ArticleVO articleVO = this.blogService.getArticle(id);
		log.info("article->articleVO : " + articleVO);
		
		//model객체의 속성명인 articleVO에 articleVO 객체가 데이터로써 추가됨
		model.addAttribute("articleVO", articleVO);
		
		//article.jsp라는 뷰 조회
		return "article/article";
	}
	
	//게시글 수정/생성 기능
	//id 키를 가진 쿼리 파라미터의 값을 id 변수에 매핑(id는 없을 수도 있음)
	//쿼리 파라미터로 넘어온 id값은 newArticle() 메서드의 Long 타입의 id 인자에 매핑함
	//	id값은 없을 수도 있으므로, 즉, id가 있으면 수정 기능, 없으면 생성 기능	
	@GetMapping("/new-article")
	public String newArticle(@RequestParam(value="id", required=false) Long id,
			Model model) {
		
		if(id==null) {//id가 없으면 새 글 기능 실행
			//기본 생성자를 이용해 빈 ArticleVO 객체 생성
			model.addAttribute("articleVO", new ArticleVO(null, null));
		}else {//id가 있으면 수정 기능 실행. 기존 값을 가져오는 findById() 메서드를 호출함
			ArticleVO articleVO = this.blogService.findById(id);
			model.addAttribute("articleVO", articleVO);
		}
		
		return "article/newArticle";
	}
	
	@ResponseBody
	@PostMapping("/insertPost")
	public String insertPost(@RequestParam("uploadFile") MultipartFile[] uploadFile, ArticleVO articleVO) {
		log.info("insertPost->uploadFile : " + uploadFile);
		log.info("insertPost->articleVO : " + articleVO);
		
		//파일명 리스트
		List<String> strList = new ArrayList<String>(); 
		
		String uploadFolder 
			= "D:\\springboot\\jcupload";
		
		//make folder 시작 ---------------------------
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload Path : " + uploadPath);
		
		//만약 년/월/일 해당 폴더가 없다면 생성
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}
		//make folder 끝 ---------------------------
		
		//배열로부터 하나씩 파일을 꺼내오자
		for(MultipartFile multipartFile : uploadFile) {
			log.info("-----------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			
			//IE 처리 => 경로를 제외한 파일명만 추출 
			//c:\\upload\\image01.jpg => image01.jpg
			String uploadFileName = multipartFile.getOriginalFilename();
			uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			
			log.info("only file name : " + uploadFileName);
			
			//------------- 같은날 같은 이미지를 업로드 시 파일 중복 방지 시작 -------------
			//java.util.UUID => 랜덤값 생성
			UUID uuid = UUID.randomUUID(); //임의의 값을 생성
			//원래의 파일 이름과 구분하기 위해 _를 붙임
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			//------------- 같은날 같은 이미지를 업로드 시 파일 중복 방지 끝 -------------			
			
			//File 객체 설계(복사할 대상 경로 , 파일명)
//			File saveFile = new File(uploadFolder, uploadFileName);
			//uploadPath : D:\\A_TeachingMaterial\\06_spring\\springProj\\src\\
			//					main\\webapp\\resources\\upload\\2022\\07\\22
			File saveFile = new File(uploadPath, uploadFileName);
			
			try {
				//파일 복사가 일어남
				multipartFile.transferTo(saveFile);
				
				//이미지인지 체킹
				if(checkImageType(saveFile)) {	//이미지라면..
					FileOutputStream thumbnail = new FileOutputStream(
							new File(uploadPath, "s_" + uploadFileName)
							);
					//섬네일 생성
					Thumbnailator.createThumbnail(multipartFile.getInputStream(),thumbnail,100,100);
					thumbnail.close();
				}
				
				//4) productVO.setFilename(파일full경로+명);
//				String filename = "/" + getFolder().replaceAll("\\\\","/") + "/" + uploadFileName;
				
				//ATTACH 테이블에 반영
				/*
				 UPDATE ATTACH
				 SET    FILENAME = '/2022/11/16/ASDFLDAS_개똥이.JPG'
				 WHERE  USER_NO = 3 AND SEQ = 5
				 */
				/*
				 .replace("대상문자열(정규식불가)","바꿀문자")
				    replace("\\","/") : 역슬러시 두개를 슬러시로 바꿈
				 .replaceAll("대상문자열(정규식반영)","바꿀문자")
				 	replaceAll("\\","/") : 역슬러시 한개를 슬러시로 바꿈
				 	            \\  : escape 정규식 \
				 	            \" : "
				 */
				//								   .replaceAll("\\\\","/")
				String filename = "/" + getFolder().replace("\\", "/") + "/" + uploadFileName;
				log.info("filename : " + filename);
				
				strList.add(filename);
			} catch (IllegalStateException e) {
				log.error(e.getMessage());
			} catch (IOException e) {
				log.error(e.getMessage());
			}//tnd catch
		}//end for
		
		return "success";
	}
	

	//년/월/일 폴더 생성
	public static String getFolder() {
		//2022-07-22 형식(format) 지정
		//간단한 날짜 형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		//날짜 객체 생성(java.util패키지)
		Date date = new Date();
		//2022-07-22
		String str = sdf.format(date);
		
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





