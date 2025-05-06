package kr.or.ddit.board.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.board.mapper.iBoardMapper;
import kr.or.ddit.board.service.iBoardService;
import kr.or.ddit.board.vo.BoardReplyVO;
import kr.or.ddit.board.vo.BoardTypeVO;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.ReportVO;
import kr.or.ddit.file.vo.FileGroupVO;
import kr.or.ddit.upload.service.UploadService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardServiceImpl implements iBoardService {
	
	@Autowired
	iBoardMapper iboardMapper;
	
	@Autowired
	UploadService uploadController;
	

	@Override
	public List<BoardVO> list(Map<String, Object> map) {
	    return this.iboardMapper.list(map);
	}

	@Override
	public BoardVO detail(int bodNo) {
		return this.iboardMapper.detail(bodNo);
	}

	@Override
	public int updatePost(BoardVO boardVO) {
	    // 게시글 정보 조회
	    BoardVO board = iboardMapper.detail(boardVO.getBodNo());
	    
	    // 현재 사용자의 postNo 조회
	    int postNo = iboardMapper.getEmpNo(boardVO.getEmpNo());

	    // 공지사항(bodType=1) 수정 권한 체크
	    if(board.getBoardTypeVO().getBodTypeNo() == 1) {
	        if(postNo > 3) {
	            throw new AccessDeniedException("공지사항 수정 권한이 없습니다");
	        }
	    }
	    
	    // QnA 게시물(bodType=3) 수정 권한 체크 
	    if(board.getBoardTypeVO().getBodTypeNo() == 3) {
	        if(postNo > 3) {
	            throw new AccessDeniedException("QnA 게시물 수정 권한이 없습니다");
	        }
	    }

	    return iboardMapper.updatePost(boardVO);
	}

	@Override
	public int deletePost(BoardVO boardVO) {
	    // 게시글 정보 조회
	    BoardVO board = iboardMapper.detail(boardVO.getBodNo());
	    
	    // 현재 사용자의 postNo 조회
	    int postNo = iboardMapper.getEmpNo(boardVO.getEmpNo());

	    // 공지사항(bodType=1) 삭제 권한 체크
	    if(board.getBoardTypeVO().getBodTypeNo() == 1) {
	        if(postNo > 3) {
	            throw new AccessDeniedException("공지사항 삭제 권한이 없습니다");
	        }
	    }
	    
	    // QnA 게시물(bodType=3) 삭제 권한 체크 
	    if(board.getBoardTypeVO().getBodTypeNo() == 3) {
	        if(postNo > 3) {
	            throw new AccessDeniedException("QnA 게시물 삭제 권한이 없습니다");
	        }
	    }

	    return iboardMapper.deletePost(boardVO);
	}

	@Override
    public int insertPost(BoardVO boardVO) {
	
   	 // 공지사항 작성 권한 체크
	 if(boardVO.getBoardTypeVO().getBodTypeNo() == 1) {
		     int postNo = iboardMapper.getEmpNo(boardVO.getEmpNo());
		     if(postNo > 3) {
		         throw new AccessDeniedException("공지사항 작성 권한이 없습니다");
		     }
		 }

        // 파일 업로드 처리
        MultipartFile[] uploadFiles = boardVO.getUploadFile();
        if(uploadFiles!=null && uploadFiles[0].getOriginalFilename().length()>0) {
            long fileGroupNo = this.uploadController.multiImageUpload(uploadFiles);
            FileGroupVO fileGroupVO = new FileGroupVO();
            fileGroupVO.setFileGroupNo(fileGroupNo);
            boardVO.setFileGroupVO(fileGroupVO);
        }

        return iboardMapper.insertPost(boardVO);
    }


	@Override
	public int updateHit(BoardVO boardVO) {
		return this.iboardMapper.updateHit(boardVO);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.iboardMapper.getTotal(map);
	}

	@Override
	public List<BoardTypeVO> bodListAll() {
		return this.iboardMapper.bodListAll();
	}


	@Override
	public int updateReplyPostAjax(BoardReplyVO boardReplyVO) {
		return this.iboardMapper.updateReplyPostAjax(boardReplyVO);
	}

	@Override
	public BoardReplyVO getBoardReply(BoardReplyVO boardReplyVO) {
		return this.iboardMapper.getBoardReply(boardReplyVO);
	}

	@Override
	public int createReplyPost(BoardReplyVO boardReplyVO) {
	    BoardVO boardVO = this.detail(boardReplyVO.getBodNo());
	    if(boardVO.getBoardTypeVO().getBodTypeNo() == 1) {
	        throw new AccessDeniedException("공지사항에는 댓글을 작성할 수 없습니다.");
	    }
	    return iboardMapper.createReplyPost(boardReplyVO);
	}

	@Override
	public List<BoardReplyVO> selectReply(BoardVO boardVO) {
		return this.iboardMapper.selectReply(boardVO);
	}

	@Override
	public int reportReplyPost(ReportVO reportVO) {
	    // 1. 게시글 번호로 해당 게시글의 댓글들을 조회
//	    BoardVO boardVO = new BoardVO();
//	    boardVO.setBodNo(reportVO.getBodNo());
//	    List<BoardReplyVO> replyList = this.iboardMapper.selectReply(boardVO);

	    // 2. 댓글 목록에서 bodIdx 값은 이미 reportVO에 설정되어 있으므로
	    // 추가적인 설정이 필요 없습니다.

	    // 3. 신고 정보 저장
	    return this.iboardMapper.reportReplyPost(reportVO);
	}

//	@Override
//	public int updatePostAjax(BoardReplyVO boardReplyVO) {
//		return this.iboardMapper.updatePostAjax(boardReplyVO);
//	}

	@Override
	public int getReTotal(Map<String, Object> map) {
		return this.iboardMapper.getReTotal(map);
	}

	@Override
	public List<BoardReplyVO> reList(Map<String, Object> map) {
		return this.iboardMapper.reList(map);
	}

	@Override
	public int deleteReplyPost(BoardReplyVO boardReplyVO) {
		return this.iboardMapper.deleteReplyPost(boardReplyVO);
	}

	@Override
	public void deleteAllReply(int bodNo) {
		this.iboardMapper.deleteAllReply(bodNo);
		
	}

	@Override
	public int updateRead(BoardVO boardVO) {
		return this.iboardMapper.updateRead(boardVO);
	}





}
