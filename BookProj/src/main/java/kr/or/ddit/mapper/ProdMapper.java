package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.MemberReplyVO;
import kr.or.ddit.vo.ProdVO;

@Mapper
public interface ProdMapper {

	// 상품 업로드
	public int createPost(ProdVO prodVO);

	// 상품 상세
	public ProdVO detail(ProdVO prodVO);

	// 자동 고유번호 
	public String getMaxProdId(ProdVO prodVO);

	// 자동 거래처
	public List<Map<String, Object>> getBuyerList(ProdVO prodVO);

	// 상품분류 수정
	public int updatePost(ProdVO prodVO);

	// 총 페이지 수
	public int getTotal(Map<String, Object> map);

	// 상품 목록
	public List<ProdVO> list(Map<String, Object> map);
	
	// 댓글
	public int createReplyPost(MemberReplyVO memberReplyVO);

	// 상품 삭제
	public int deletePost(ProdVO prodVO);
}
