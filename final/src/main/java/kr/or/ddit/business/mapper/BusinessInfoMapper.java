package kr.or.ddit.business.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.business.vo.EnterpriceVO;
import kr.or.ddit.contract.vo.ContViewVO;
import kr.or.ddit.vo.ContractMasterVO;
import kr.or.ddit.vo.CustInfoVO;

@Mapper
public interface BusinessInfoMapper {

	//전체 행 수
	public int getTotal(Map<String, Object> map);

	//고객 리스트
	public List<CustInfoVO> list(Map<String, Object> map);
//	public List<EnterpriceVO> list(Map<String, Object> map);

	//고객 상세
	public CustInfoVO detail(int entNo);
	public List<CustInfoVO> detailList(int entNo);

	//고객 정보 수정
	public int update(ContViewVO contViewVO);

	//고객 정보 삭제
	public int delete(EnterpriceVO enterpriceVO);
	public int deleteMyEntNo(String entNo);
	public int deletePostAjax(CustInfoVO custInfoVO);

	//고객 등록
	public int createPost(CustInfoVO custInfoVO);

	//고객 수정
	public int updatePost(CustInfoVO custInfoVO);

	//기업번호 중복 체크
	public int idDupChk(CustInfoVO custInfoVO);


}
