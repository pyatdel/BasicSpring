package kr.or.ddit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.MemberService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.MemberReplyVO;
import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/member")
@Slf4j 
@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService; 
	
	/*
	 요청URI : /member/list 또는 /member/list?currentPage=2&keyword=개똥이
	 요청파라미터 : 
	 요청방식 : get
	 
	 forwarding : jsp리턴
	 return "member/list";
	 */
	//RequestMapping(value="/list",method=RequestMethod.GET)
	@GetMapping("/list")
	public String list(
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			Model model) {
 		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		//map{currentPage=1&keyword=}
		log.info("list->map : " + map);
		
		List<MemberVO> memberVOList = this.memberService.list(map);
		log.info("list->memberVOList : " + memberVOList);
		
		//total, currentPage, size, content, keyword
		int total = this.memberService.getTotal(map);//map
		log.info("list->total : " + total);
		
		//페이지 객체 생성
		ArticlePage<MemberVO> articlePage = 
				new ArticlePage<MemberVO>(total, currentPage, 10, memberVOList, keyword);
		
		model.addAttribute("memberVOList", memberVOList);
		model.addAttribute("articlePage", articlePage);
		
		//forwarding : jsp리턴
		return "member/list";
	}
	
	/*
	 요청URI : /member/listAjax 또는 /member/listAjax
	 요청파라미터 : (Client : O->JSON.stringify->S -> Internet : S -> Server : O) 
	 		JSONString{"currentPage":1,"keyword":"길동"}
	 요청방식 : post
	 	 
	 //객체를 리턴 : (Server : O->ResponseBody->S -> Internet : S -> Client : O)
	 return memberVOList;
	 */
	@ResponseBody
	@PostMapping("/listAjax")
	public ArticlePage<MemberVO> listAjax(@RequestBody Map<String,Object> map,Model model) {
		//list->map : {currentPage=1, keyword=길동}
		log.info("list->map : " + map);
		
		List<MemberVO> memberVOList = this.memberService.list(map);
		log.info("list->memberVOList : " + memberVOList);
		
		//total, currentPage, size, content, keyword
		int total = this.memberService.getTotal(map);//map
		//list->total : 30
		log.info("list->total : " + total);
		
		//map : {currentPage=1, keyword=길동}
		//1. currentPage
		int currentPage = 1;//1페이지 
				
		//map.get("키") -> Object 리턴
		if(map.get("currentPage") != null) {
			//map.get("currentPage") -> null
			//							null.toString() -> 오류 발생
			currentPage = Integer.parseInt(map.get("currentPage").toString());
		}
		
		//2. keyword
		//map : {currentPage=1, keyword=길동}
		String keyword = "";//검색이 없는 것이 기본
		
		if(map.get("keyword") != null) {
			//map.get("keyword") -> null
			//						null.toString() -> 오류 발생
			keyword = map.get("keyword").toString();//길동
		}
		
		//페이지 객체 생성
		ArticlePage<MemberVO> articlePage = 
				new ArticlePage<MemberVO>(total, currentPage, 10, memberVOList
						, keyword, "ajax");
		
		//데이터 리턴 -> ResponseBody(Object->String)
		return articlePage;
	}
	
	/* 회원 상세
	 요청URI : /member/detail?memId=a001
	 요청파라미터 : request{memId=a001}
	 요청방식 : get
	 	
	 forwarding : jsp리턴
	 return "member/detail";
	 */
//	public String detail(String memId) {
//	public String detail(MemberVO memberVO) {
//	public String detail(@ModelAttribute MemberVO memberVO) {
	@GetMapping("/detail")
	public String detail(@RequestParam(value="memId") String memId,
			Model model) {
		log.info("detail->memId : " + memId);
		
		MemberVO memberVO = this.memberService.detail(memId);
		log.info("detail->memberVO : " + memberVO);
		
		//댓글 목록
		//memberVO{memId=u001}
		List<MemberReplyVO> memberReplyVOList = this.memberService.selectReply(memberVO);
		log.info("detail->memberReplyVOList : " + memberReplyVOList);
		
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("memberReplyVOList", memberReplyVOList);
		
		//forwarding : jsp리턴
		return "member/detail";
	}
	
	/** 회원 수정
	 요청URI : /member/updatePost
	 요청파라미터 : request{memId=t001, memPass=0506, memName=성원태2,
	 			memZip=306-702, 
				memAdd1=대전광역시 중구 유천동, memAdd2=한사랑아파트 302동 504호}
	 요청방식 : post
	*/
	@PostMapping("/updatePost")
	public String updatePost(@ModelAttribute MemberVO memberVO) {
		/*
		MemberVO(memId=t001, memPass=0506, memName=성원태2, 
		memRegno1=null, memRegno2=null, memBir=null, memZip=306-702, 
		memAdd1=대전광역시 중구 유천동, memAdd2=한사랑아파트 302동 504호, 
		memHometel=null, memComtel=null, memHp=null, memMail=null, 
		memJob=null, memLike=null, memMemorial=null, memMemorialday=null, 
		memMileage=0, memDelete=null, rnum=0)
		 */
		log.info("updatePost->memberVO : " + memberVO);
		
		int result = this.memberService.updatePost(memberVO);
		log.info("updatePost->result : " + result);
		
		//redirect : 새로운 URI를 재요청
		return "redirect:/member/detail?memId="+memberVO.getMemId();
	}
	
	/** 회원 등록 폼
	 요청URI : /member/create
	 요청파라미터 : 
	 요청방식 : get
	 
	 forwarding : jsp리턴
	 return "member/create";
	*/
	@GetMapping("/create")
	public String create() {
		//forwarding : jsp리턴
		return "member/create";
	}
	
	/** 회원 등록 실행
	요청URI : /member/createPost
        요청파라미터 : request{memId=t001, memPass=0506, memName=성원태2,
	 			memZip=306-702, 
				memAdd1=대전광역시 중구 유천동, memAdd2=한사랑아파트 302동 504호,
				memBir=2024-11-27,uploadFiles=파일객체}
		요청방식 : post
	 */
	@PostMapping("/createPost")
	public String createPost(MemberVO memberVO) {
		log.info("createPost->memberVO : " + memberVO);
		
		int result = this.memberService.createPost(memberVO);
		log.info("createPost->result : " + result);
		
		//redirect : 새로운 URI 재호출
		return "redirect:/member/detail?memId="+memberVO.getMemId();
	}
	
	/** 회원 등록 실행
		요청URI : /member/createPostAjax
        요청파라미터 : request{memId=t001, memPass=0506, memName=성원태2,
	 			memZip=306-702, 
				memAdd1=대전광역시 중구 유천동, memAdd2=한사랑아파트 302동 504호,
				memBir=2024-11-27,uploadFiles=파일객체}
		요청방식 : post
		
		RequestBody : JSONString -> deserialize -> MemberVO
	 */
	@ResponseBody
	@PostMapping("/createPostAjax")
	public int createPostAjax(MemberVO memberVO) {
		log.info("createPostAjax->memberVO : " + memberVO);
		
		int result = this.memberService.createPost(memberVO);
		log.info("createPostAjax->result : " + result);
		
		//동기 : forwarding(jsp경로) / redirect(redirect:/url)
		//비동기 : return 데이터
		return result;
	}
	
	/* 회원 가입 시 중복체크
	요청URI : /member/idDupChk
	요청파라미터 : JSONString{"memId":"a001"}
	요청방식 : post
	
	SELECT COUNT(*) FROM MEMBER WHERE MEM_ID = 'a001'
	return타입은 int타입 => 1) 1 : 중복됨 2) 0 : 중복안됨
	*/	
	@ResponseBody
	@PostMapping("/idDupChk")
	public int idDupChk(@RequestBody MemberVO memberVO) {
		//memberVO{memId=a001,memName=null,memBir=null..}
		log.info("idDupChk->memberVO : " + memberVO);
		
		int result = this.memberService.idDupChk(memberVO);
		log.info("idDupChk->result : " + result);
		
		//forwarding  : jsp주소(x)
		//redirect  : 새로운 URL(x)
		//데이터 (o)
		return result;
	}
	
	/*
	요청URI : /member/deletePostAjax
	요청파라미터 : JSONString{"memId":"a001"}
	요청방식 : delete
	
	리턴 : 1) 1 : 삭제 성공 2) 0 : 삭제 실패
	*/
	@ResponseBody
	@DeleteMapping("/deletePostAjax")
	public int deletePostAjax(@RequestBody MemberVO memberVO) {
		//memberVO{memId=a001,memName=null..}
		log.info("deletePostAjax->memberVO : " + memberVO);
		
		int result = this.memberService.deletePostAjax(memberVO);
		log.info("deletePostAjax->result : " + result);
			
		//		1 또는 0
		return result;
	}
	
	/*
	요청URI : /member/createReplyPost
	요청파라미터 : request{memId=u001,replyContent=댓글내용}
				request{memId=u001,parentIdx=8,replyContent=대댓글내용}
	요청방식 : post
	
	1. 골뱅이RequestParam(value="memId") String memId
	2. 골뱅이ModelAttribute MemberReplyVO memberReplyVO
	3. MemberReplyVO memberReplyVO
	4. Map<String,Object> map
	..
	
	크롬    					->			   서버                            ->          크롬
	JSON.stringify(data)             골뱅이RequestBody  골뱅이Responsebody          success(result)
	data                               x              골뱅이Responsebody          success(result)
	 */
	@PostMapping("/createReplyPost")
	public String createReplyPost(MemberReplyVO memberReplyVO) {
		/*
		MemberReplyVO(idx=0, memId=u001, userId=null, replyRegdate=null, parentIdx=0
		, replyContent=댓글입니다, replyStatus=null)
		 */
		log.info("createReplyPost->memberReplyVO : " + memberReplyVO);
		
		//1. MEMBER_REPLY 테이블에 insert
		int result = this.memberService.createReplyPost(memberReplyVO);
		log.info("createReplyPost->memberReplyVO : " + memberReplyVO);
		
		//2. 상세 페이지로 redirect
		return "redirect:/member/detail?memId="+memberReplyVO.getMemId();
	}
	
	/*
	요청URI : /member/createReplyPost
	요청파라미터 : request{memId=u001,replyContent=댓글내용}
				request{memId=u001,parentIdx=8,replyContent=대댓글내용}
	요청방식 : post
	
	1. 골뱅이RequestParam(value="memId") String memId
	2. 골뱅이ModelAttribute MemberReplyVO memberReplyVO
	3. MemberReplyVO memberReplyVO
	4. Map<String,Object> map
	..
	
	크롬    					->			   서버                            ->          크롬
	JSON.stringify(data)             골뱅이RequestBody  골뱅이Responsebody          success(result)
	data                               x              골뱅이Responsebody          success(result)
	 */
	@ResponseBody
	@PostMapping("/createReplyPostAjax")
	public int createReplyPostAjax(MemberReplyVO memberReplyVO) {
		/*
		MemberReplyVO(idx=0, memId=u001, userId=null, replyRegdate=null, parentIdx=6
		, replyContent=대댓글입니다, replyStatus=null)
		 */
		log.info("createReplyPost->memberReplyVO : " + memberReplyVO);
		
		//1. MEMBER_REPLY 테이블에 insert
		int result = this.memberService.createReplyPost(memberReplyVO);
		log.info("createReplyPost->memberReplyVO : " + memberReplyVO);
		
		//2. 데이터
		return result;
	}
	
	/*
	요청URI : /member/updateReplyPostAjax
	요청파라미터 : JSONstring{"replyContent":"네네","idx":9}
	요청방식 : post
	
	매개변수 : 골뱅이RequestBody MemberReplyVO memberReplyVO
	리턴타입 : MemberReplyVO(수정된 결과)
	골뱅이ResponseBody를 통해 serialize 처리
	 */
	@ResponseBody
	@PostMapping("/updateReplyPostAjax")
	public MemberReplyVO updateReplyPostAjax(@RequestBody MemberReplyVO memberReplyVO) {
		log.info("updateReplyPostAjax->memberReplyVO(전) : " + memberReplyVO);
		
		//update 실행. memberReplyVO{idx=9,..,replyContent=네네"...}
		int result = this.memberService.updateReplyPostAjax(memberReplyVO);
		log.info("updateReplyPostAjax->result : " + result);
		
		//변경된 그 행을 가져오자
		memberReplyVO = this.memberService.getMemberReply(memberReplyVO);
		log.info("updateReplyPostAjax->memberReplyVO(후) : " + memberReplyVO);
		
		//데이터
		return memberReplyVO;
	}
	
	/*
	요청URI : /member/updatePostAjax/9
	경로변수 : idx
	요청파라미터 : JSONstring{"idx":9}
	요청방식 : PUT
	 */
	@ResponseBody
	@PutMapping("/updatePostAjax/{idx}")
	public int updatePostAjax(@PathVariable(value="idx") int idx,
			@RequestBody MemberReplyVO memberReplyVO) {
		//updatePostAjax->idx : 8
		log.info("updatePostAjax->idx : " + idx);
		//memberReplyVO : MemberReplyVO(idx=8, memId=null..
		log.info("updatePostAjax->memberReplyVO : " + memberReplyVO);
		
		//MEMBER_REPLY 테이블의 REPLY_STATUS 컬럼의 값을 0으로 update
		int result = this.memberService.updatePostAjax(memberReplyVO);
		log.info("updatePostAjax->result : " + result);
		
		//데이터
		return result;
	}
	
}














