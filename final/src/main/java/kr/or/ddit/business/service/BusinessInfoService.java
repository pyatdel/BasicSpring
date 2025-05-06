package kr.or.ddit.business.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.business.vo.EnterpriceVO;
import kr.or.ddit.contract.vo.ContViewVO;
import kr.or.ddit.vo.CustInfoVO;


public interface BusinessInfoService {

	//전체 행 수
	public int getTotal(Map<String, Object> map);

	//고객 리스트
	public List<CustInfoVO> list(Map<String, Object> map);

	//영업 고객 상세
	public CustInfoVO detail(int entNo);
	public List<CustInfoVO> detailList(int entNo);

	//고객 정보 수정
	public int update(ContViewVO contViewVO);

	//고객 정보 삭제
	public int delete(EnterpriceVO enterpriceVO);
	public int deleteByEntNo(String entNo);
	public int deletePost(CustInfoVO custInfoVO);


	//고객 등록
	public int createPost(CustInfoVO custInfoVO);

	//고객 수정
	public int updatePost(CustInfoVO custInfoVO);

	//기업번호 중복 체크
	public int idDupChk(CustInfoVO custInfoVO);





}
