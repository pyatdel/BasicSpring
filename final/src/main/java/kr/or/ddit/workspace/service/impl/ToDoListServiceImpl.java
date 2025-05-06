package kr.or.ddit.workspace.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.workspace.mapper.ToDoListMapper;
import kr.or.ddit.workspace.service.ToDoListService;
import kr.or.ddit.workspace.vo.ToDoListVO;

@Service
public class ToDoListServiceImpl implements ToDoListService {
	
	@Autowired
	ToDoListMapper toDoListMapper;

	// todoList 리스트 조회
	@Override
	public List<ToDoListVO> list(int empNo) {
		return this.toDoListMapper.list(empNo);
	}

	// todoList 리스트 생성
	@Override
	public int create(ToDoListVO toDoListVO) {
		return this.toDoListMapper.create(toDoListVO);
	}

	// todoList 상세 비동기 (axios)
	@Override
	public ToDoListVO getTodo(ToDoListVO todo) {
		return this.toDoListMapper.getTodo(todo);
	}

	// todoList 삭제 비동기 (axios)
	@Override
	public int delete(ToDoListVO todo) {
		return this.toDoListMapper.delete(todo);
	}
	
	// todo 상태 수정 비동기 (axios)
	@Override
	public int upTodo(ToDoListVO todo) {
		return this.toDoListMapper.upTodo(todo);
	}
	
	
}
