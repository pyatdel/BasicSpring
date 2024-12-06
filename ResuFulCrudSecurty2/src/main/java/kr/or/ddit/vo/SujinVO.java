package kr.or.ddit.vo;

import lombok.Data;

// 자바빈 클래스(프로퍼티,기본생성자,getter/setter메서드)
// PoJo가 약해짐(lombok에 의존함)
@Data
public class SujinVO {

	private int sujinNum;
	private String sujinContent;
	private String sujinName;
	private String sujinFile;
}
