package kr.or.ddit.community.vo;

import lombok.Data;

@Data
public class CommunityStateTypeVO {

	private int			comStateTypeNo;			// 게시글 종류 번호
	private String		comStateTypeName;		// 1.일반 2.질문 3.정보 4.비밀
}
