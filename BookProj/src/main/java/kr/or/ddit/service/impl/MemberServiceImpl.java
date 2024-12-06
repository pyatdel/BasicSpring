package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.MemberMapper;
import kr.or.ddit.service.MemberService;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.MemberReplyVO;
import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {
	
	//UploadController DI,IoC
	@Autowired
	UploadController uploadController;
	
	//DI / IoC
	@Autowired
	MemberMapper memberMapper;
	
	//회원 목록
	@Override
	public List<MemberVO> list(Map<String, Object> map) {
		return this.memberMapper.list(map);
	}

	//회원 상세
	@Override
	public MemberVO detail(String memId) {
		return this.memberMapper.detail(memId);
	}

	//회원 수정
	@Override
	public int updatePost(MemberVO memberVO) {
		return this.memberMapper.updatePost(memberVO);
	}

	//회원 등록
	@Override
	public int createPost(MemberVO memberVO) {
		/*
		 memberVO{memId=t001, memPass=0506, memName=성원태2,
	 			memZip=306-702, 
				memAdd1=대전광역시 중구 유천동, memAdd2=한사랑아파트 302동 504호,
				memBir=2024-11-27,uploadFiles=파일객체}
		 */
		
		//1. 다중 파일업로드 처리(파일 + DB)
		MultipartFile[] uploadFiles = memberVO.getUploadFiles();
		
		//1-2. 파일이 있는 경우만 실행
		if(uploadFiles!=null && uploadFiles[0].getOriginalFilename().length()>0) {
			long fileGroupNo = this.uploadController.multiImageUpload(uploadFiles);
			log.info("createPost->fileGroupNo : " + fileGroupNo);
			
			//2. MEMBER 테이블에 insert
			memberVO.setFileGroupNo(fileGroupNo);
			log.info("createPost->memberVO : " + memberVO);
		}
		
		int result = this.memberMapper.createPost(memberVO);
		log.info("createPost->result : " + result);
		
		
		return result;
	}

	//회원 가입 시 중복체크
	@Override
	public int idDupChk(MemberVO memberVO) {
		return this.memberMapper.idDupChk(memberVO);
	}

	//회원 삭제
	@Override
	public int deletePostAjax(MemberVO memberVO) {
		return this.memberMapper.deletePostAjax(memberVO);
	}

	//전체 행의 수
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.memberMapper.getTotal(map);
	}

	//댓글 등록
	@Override
	public int createReplyPost(MemberReplyVO memberReplyVO) {
		return this.memberMapper.createReplyPost(memberReplyVO);
	}

	/*
	댓글 목록 
	<select id="selectReply" parameterType="kr.or.ddit.vo.MemberVO"
		resultType="kr.or.ddit.vo.MemberReplyVO">
	 */
	@Override
	public List<MemberReplyVO> selectReply(MemberVO memberVO){
		return this.memberMapper.selectReply(memberVO);
	}

	//update 실행. memberReplyVO{idx=9,..,replyContent=네네"...}
	@Override
	public int updateReplyPostAjax(MemberReplyVO memberReplyVO) {
		return this.memberMapper.updateReplyPostAjax(memberReplyVO);
	}
	
	/*댓글 1건 가져오기
	memberReplyVO{idx=9,..,replyContent=네네"...}
	<select id="getMemberReply" parameterType="kr.or.ddit.vo.MemberReplyVO"
		resultType="kr.or.ddit.vo.MemberReplyVO">
	 */
	@Override
	public MemberReplyVO getMemberReply(MemberReplyVO memberReplyVO) {
		return this.memberMapper.getMemberReply(memberReplyVO);
	}

	//MEMBER_REPLY 테이블의 REPLY_STATUS 컬럼의 값을 0으로 update
	@Override
	public int updatePostAjax(MemberReplyVO memberReplyVO) {
		return this.memberMapper.updatePostAjax(memberReplyVO);
	}
}






