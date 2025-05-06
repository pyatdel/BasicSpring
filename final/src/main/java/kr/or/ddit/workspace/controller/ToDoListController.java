package kr.or.ddit.workspace.controller;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.workspace.service.ToDoListService;
import kr.or.ddit.workspace.vo.ToDoListVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/todo")
@Controller
public class ToDoListController {

	@Autowired
	ToDoListService toDoListService;

	// todoList 메인
	@GetMapping("/home")
	public String todoHome () {
		return "workspace/todoList/toDo";
	}

	// todo 조회
	@GetMapping("/list")
	public String todoList(
			Model model ,ToDoListVO toDoListVO) {
		
		//UserDetailServiceImpl->CustomUser
	      Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
	      CustomUser userDetails = (CustomUser)principal; 
	      log.info("commuteList->userDetails : " + userDetails.getMember());
	      MemberVO memberVO = userDetails.getMember();
	      int empNo = memberVO.getEmpNo();
	      log.info("commuteList->memberVO : " + memberVO);
	      log.info("empNo :" + empNo);
	      // 모든 컨트롤러에서 empNo찾기
		
	      List<ToDoListVO>toDoListVOList= this.toDoListService.list(empNo);
		
	      model.addAttribute("toDoListVOList",toDoListVOList);
		
		log.info("todoVO" + toDoListVO);
		
		return "workspace/todoList/toDo";
		
		
	}
	
	@ResponseBody
	@GetMapping("/listaxios")
	public List<ToDoListVO>list(){
		
		 Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
	      CustomUser userDetails = (CustomUser)principal; 
	      log.info("commuteList->userDetails : " + userDetails.getMember());
	      MemberVO memberVO = userDetails.getMember();
	      int empNo = memberVO.getEmpNo();
	      log.info("commuteList->memberVO : " + memberVO);
	      log.info("empNo :" + empNo);
	      
		return this.toDoListService.list(empNo);
		
	}
	
	
	// todolist 생성 비동기 (axios)
	@ResponseBody
	@PostMapping("/create")
	public int createTodo(@RequestBody ToDoListVO toDoListVO) {
		//UserDetailServiceImpl->CustomUser
	      Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
	      CustomUser userDetails = (CustomUser)principal; 
	      log.info("commuteList->userDetails : " + userDetails.getMember());
	      MemberVO memberVO = userDetails.getMember();
	      int empNo = memberVO.getEmpNo();
	      log.info("commuteList->memberVO : " + memberVO);
	      log.info("empNo :" + empNo);
	      
	      toDoListVO.setEmpNo(empNo);  
	      log.debug("체킁 {} " + toDoListVO);
		return this.toDoListService.create(toDoListVO);
		
	}
	
	
	@ResponseBody
	@GetMapping("/getTodo/{todoNo}")
	public ToDoListVO getTodo(@PathVariable int todoNo ) {
		ToDoListVO todo = new ToDoListVO();
		todo.setTodoNo(todoNo);
		log.debug("결과 체킁 {}" + todo);
		return this.toDoListService.getTodo(todo);
		
	}
	
	@ResponseBody
	@DeleteMapping("/delete/{todoNo}")
	public int delTodo(@PathVariable int todoNo) {
		ToDoListVO todo = new ToDoListVO();
		todo.setTodoNo(todoNo);
		log.debug("결과 체킁 {}" + todo);
		return this.toDoListService.delete(todo);
		
	}
	
	@ResponseBody
	@PutMapping("/updatestate/{todoNo}")
	public int upTodo(@PathVariable int todoNo) {
		ToDoListVO todo = new ToDoListVO();
		todo.setTodoNo(todoNo);
		log.debug("결과 체킁 {}" + todo);
		return this.toDoListService.upTodo(todo);
		
		
	}


}
