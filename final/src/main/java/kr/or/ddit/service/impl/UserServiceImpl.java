package kr.or.ddit.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.mapper.UsersMapper;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.service.UserService;
import kr.or.ddit.upload.service.UploadService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UsersMapper usersMapper;

	@Autowired
	BCryptPasswordEncoder bCryptPasswordEncoder;

	@Autowired
	UploadService uploadController;

	// 회원 가입
	/*
	 * MemberVO(memId=u001, memName=성원태2, memPw=java, memEnable=false ,
	 * memRegdate=null,fileGroupNo=0, uploadFiles=파일객체들
	 */
	/*
	 * 트랜잭션 자동 처리 하나의 트랜잭션에 여러 개의 SQL이 처리됨 FILE_GROUP Insert -> FILE_DETAIL Insert
	 * -> TB_MEMBERS Insert -> TB_AUTHS Insert 성공 성공 성공 실패 취소 취소 취소 ROLLBACK
	 */
	@Transactional
	@Override
	public int save(MemberVO memberVO) {
		try {
			// 암호화(encrypt) 처리
			String password = memberVO.getEmpPw();
			password = this.bCryptPasswordEncoder.encode(password);
			log.info("save->password : " + password);
			memberVO.setEmpPw(password);
			// 1. 다중파일업로드
//      MultipartFile[] uploadFiles = memberVO.getUploadFiles();
//      if(uploadFiles!=null && uploadFiles[0].getOriginalFilename().length()>0) {
//         Long fileGroupNo = this.uploadController.multiImageUpload(uploadFiles);
//         //첨부파일이 있을 때
//         memberVO.setFileGroupNo(fileGroupNo);
//      }

			// 패스워드를 저장 시 시큐리티를 설정하며 패스워드 인코딩용으로 등록한 빈을
			// 사용해서 암호화한 후에 저장하자
			memberVO.setEmpPw(password);

			// 2. TB_MEMBERS 테이블에 insert
			int result = this.usersMapper.save(memberVO);

			// 3. TB_AUTHS 테이블에 insert
			result += this.usersMapper.saveAuths(memberVO);

			return result;
		} catch (Exception e) {
			log.error("Error while saving member data: ", e);
			throw new RuntimeException("Error occurred during member save process", e);
		}
	}
}
