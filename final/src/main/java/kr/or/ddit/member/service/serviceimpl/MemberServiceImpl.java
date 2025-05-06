package kr.or.ddit.member.service.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.member.mapper.MemberMapper;
import kr.or.ddit.member.service.MemberService;
import kr.or.ddit.member.vo.MemberVO;

@Service // 이 애노테이션이 반드시 필요합니다.
@Transactional
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper memberMapper;

	@Override
	public MemberVO Login(MemberVO memberVO) {
		return memberMapper.Login(memberVO);
	}

	@Override
	public MemberVO getMemberByUsername(String empId) {
		return memberMapper.getMemberByUsername(empId);
	}

	@Override
	public MemberVO read(MemberVO memberVO) {
		// TODO Auto-generated method stub
		return memberMapper.read(memberVO.getEmpId());
	}

	@Override
	public MemberVO getMemberById(String empId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(MemberVO memberVO) {
		int updatedRows = memberMapper.updateMember(memberVO);
		if (updatedRows == 0) {
			throw new RuntimeException("No rows updated. Check EMP_ID or input data.");
		}
		return updatedRows;
	}

	@Override
	public void updateProfileImage(MemberVO memberVO) {
		memberMapper.updateProfileImage(memberVO);
	}

	@Override
    public String getProfileImage(String empId) {
        String profileImagePath = memberMapper.readProfileImage(empId);
        if (profileImagePath == null || profileImagePath.isEmpty()) {
            return "/default-images/default-profile.jpg"; // 기본 이미지 경로 반환
        }
        return profileImagePath;
    }

	@Override
	public List<MemberVO> getInfo(MemberVO memberVO) {
		return this.memberMapper.getInfo(memberVO);
	}
	
	 @Override
	    public MemberVO getMemberByEmpNo(Long empNo) {
	        return memberMapper.readByEmpNo(empNo); // Mapper 호출
	    }
}