package com.sumin.just.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sumin.just.vo.IdolVO;

@Mapper
public interface IdolMapper {
	/* 시키지 않아도 5가지 만든다 */
	
	List<IdolVO> getIdols();
	
	// IdolVO getIdol(IdolVO idol); 이렇게 해도 되지만.. 
	IdolVO getIdol(IdolVO idol);
	
	int insIdol(IdolVO idol);
	
	int updIdol(IdolVO idol);
	
	int delIdol(IdolVO idol);
}
