package kr.or.ddit.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.SujinMapper;
import kr.or.ddit.service.SujinService;
import kr.or.ddit.vo.SujinVO;

// 스프링 프레임워크에게 알려줌
// 자바빈 객체로 등록해줌
@Service
public class SujinServiceImpl implements SujinService{

	@Autowired
	SujinMapper sujinMapper;
	
	@Override
	public List<SujinVO> listSujin() {
		return this.sujinMapper.listSujin();
	}

	@Override
	public SujinVO getSujin(SujinVO sujinVO) {
		return this.sujinMapper.getSujin(sujinVO);
	}

	@Override
	public int insertSujin(SujinVO sujinVO) {
		return this.sujinMapper.insertSujin(sujinVO);
	}

	@Override
	public int updateSujin(SujinVO sujinVO) {
		return this.sujinMapper.updateSujin(sujinVO);
	}

	@Override
	public int deleteSujin(SujinVO sujinVO) {
		return this.sujinMapper.deleteSujin(sujinVO);
	}

}
