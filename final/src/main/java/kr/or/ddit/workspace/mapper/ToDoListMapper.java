package kr.or.ddit.workspace.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.workspace.vo.ToDoListVO;

@Mapper
public interface ToDoListMapper {

	// todoList 리스트 조회
	public List<ToDoListVO> list(int empNo);

	// todoList 리스트 생성
	public int create(ToDoListVO toDoListVO);

	// todoList 상세 비동기 (axios)
	public ToDoListVO getTodo(ToDoListVO todo);

	// todoList 삭제 비동기 (axios)
	public int delete(ToDoListVO todo);

	// todo 상태 수정 비동기 (axios)
	public int upTodo(ToDoListVO todo);

}
