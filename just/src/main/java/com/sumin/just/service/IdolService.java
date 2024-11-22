package com.sumin.just.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.sumin.just.mapper.IdolMapper;
import com.sumin.just.vo.IdolVO;

// I/F 아니공 바로 class 보통 I/F를 만들면 구현체(class)는 impl을 붙임
// 서비스는 보통 비지니스 로직(업무규칙) 을 담는다
@Service
public class IdolService {

	@Autowired
	private IdolMapper idolMapper;
	
	
	public List<IdolVO> getIdols(){
		/* 추후 if문 등으로 업무 규칙이 오게 됨 */
		return idolMapper.getIdols();
	}
	
	public IdolVO getIdol(IdolVO idol) {
		return idolMapper.getIdol(idol);
	}
	
	public int insIdol(IdolVO idol) {
		return idolMapper.insIdol(idol);
	}
	
	public int updIdol(IdolVO idol) {
		return idolMapper.updIdol(idol);
	}
	
	public int delIdol(IdolVO idol) {
		return idolMapper.delIdol(idol);
	}
}

