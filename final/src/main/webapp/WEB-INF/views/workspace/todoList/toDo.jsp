<%@page import="java.util.Locale"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!-- 라이브러리 include  -->
   <jsp:include page="../../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
     <link href="https://fonts.googleapis.com/css2?family=Raleway&display=swap" rel="stylesheet">
    
    
<style>


.workMemo{
color:#3676EB !important;
font-weight: bold;

}
.workSubMenu{

display: block !important;
height: auto !important;

}
.workMenu {
color:#3676EB !important;
font-weight: bold;
}

:root {
--bg-color: #F1F3F8;
--line-color:#D6E0F0;
--font:'Raleway';
}

/*배경 및 body의 마진, 패딩 세팅*/
body {
    margin: 0;
    padding: 0;
    background-color: var(--bg-color);
    font-family: var(--font);
}
ul li {
margin: 0 ; 
padding: 0 ;}

/*주 제목*/
.mainTitle {
       display: flex
;
    font-size: 38px;
    font-weight: normal !important;
    padding-top: 30px;
    padding-bottom: 22px;
    margin: 12px 10%;
    color: black !important;
    font-family: "Noto Sans KR", serif !important;
}
:root {
    --line-color: black !important;
    --font: 'Raleway';
}
/*투두 리스트 입력칸*/
.addToDo {
    display: flex;
    justify-content: center;
    margin-top: 36px;
    margin-bottom: 48px;
    width: 100%;
}
.addToDoInfo {
    width: 70%;
    line-height: normal;
    padding: 4px;
    height: 50px !important;
    font-size: 24px;
    outline: none;
    border: none;
    background-color: #ededed;
    border-radius: 60px;
}
.addToDoInfo::placeholder {
    font-style: oblique;
    font-family: var(--font);
    color: white;
    margin: 2px;
}

/*투두 리스트*/
.list {
    display: flex;
    justify-content: space-around;
    width: 100%;
    margin: 0 auto;
}
.list .activeToDo, .list .doneToDo {
    display: flex;
    flex-direction: column;
    align-items: center;
}
.doneToDo{
 background-color: #fff4d4;
    /* border-radius: 40px; */
    height: 50vh;
    transform: rotate(11deg);
    box-shadow: 10px 10px 0px #00000091;
    left: 55%;
    position: absolute;
    top: 40%;
    width: 500px;
}
.list .activeTitle, .list .doneTitle {
	font-size:23px;
    padding: 6px;
    border-bottom: 4px solid #d4edeb !important;
}
.list ul {
    padding:0;
    margin: 24px;
}
.list li {
    display: flex;
    justify-content: space-between;
    text-align: center;
    width: auto;
    margin:8px;
    padding: 6px;
    border-bottom: 1px solid #6a6b6b ;
}
.list button {
    border: none;
    background-color: var(--line-color);
    font-family: var(--font);
    padding: 4px 6px;
    margin-left: 12px;
}
:root {
    --bg-color: #F1F3F8;
    --line-color:#D6E0F0;
    --font:'Raleway';
}
/*배경 및 body의 마진, 패딩 세팅*/
body {
    margin: 0;
    padding: 0;
    background-color: var(--bg-color);
    font-family: var(--font);
}

/*투두 리스트 입력칸*/
.addToDo {
    display: flex;
    justify-content: center;
    margin-top: 36px;
    margin-bottom: 48px;
    width: 100%;
}
.addToDoInfo::placeholder {
    font-style: oblique;
    font-family: var(--font);
    color: var(--line-color);
    margin: 2px;
}
.list{
}
.list li {
    display: flex;
    justify-content: space-between;
    text-align: center;
    width: 100%;
    margin:8px;
    padding: 6px;
    border-bottom: 1px solid #6a6b6b;
}
.list button {
    border: none;
    background-color: var(--line-color);
    font-family: var(--font);
    padding: 4px 6px;
    margin-left: 12px;
    border-radius: 3px;
}
.todocont{
width: 70%;
margin: 0 auto ;
height: 90vh;
border-radius: 20px;
background-color: white;

}
.content{
background-color: white;
margin-top:50px !important;
}

.mgmodal {
	 position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%); /* 화면 중앙 정렬 */
    background-color:white;
    padding: 20px;
    border-radius: 20px;
    width: 400px;
    box-shadow: 5px 4px 6px rgba(0, 0, 0, 0.543);
    text-align: center;
    height: 500px;
        z-index: 9999;
}

.mdimg {
position: relative;
	display: block !important;
	margin: 0 auto !important;
 overflow: auto;
	
}
.mdimg>img{
align-items: center;
display: block !important;
width: 100% !important;
height: 100%;
object-fit: contain;
 overflow: auto;
}
.modal_bgrd{
   display: none; /* 기본적으로 숨김 */
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.435); /* 배경 어두운 반투명 색 */
    z-index: 1000;

}
.delmodal{
   position: absolute;
    top: 10px;
    right: 10px;
    font-size: 30px;
    font-weight: bold;
    color: #333;
    cursor: pointer;

}
.todomodal{
margin: 0 !important;
padding: 0 !important;
}
h3{
color:#3676EB !important;
font-style:italic;
text-align: center;
font-weight: normal !important;
}
.todocon{
width: 100%;
height:30vh;
text-align: left;
border-top: 1px solid gray;
border-bottom: 1px solid gray;
padding: 20px;
margin-top:25px;
}
.todoend{
text-align: right;

}
.doneBtn{
background-color:#232323 !important;
color:white; 

}
.deleteBtn{
background-color:#3f66af !important;
color:white; 

}
.listActive{

}
.dateab{
position: absolute;
margin:40px;
}
.tododate{
text-align: center;
font-size: 15px;

}
.datacont{
display: flex;
    justify-content: flex-end;
}
.todotime{
text-align: center;
font-size: 25px;

}
.bt{
font-size: 18px;
color:#3c3a3a;

}
.activeToDo {
    background-color: #dcfaff;
    /* border-radius: 40px; */
    height: 50vh;
    transform: rotate(357deg);
    box-shadow: 10px 10px 0px #00000091;
    left: 25%;
    position: absolute;
    width: 500px;
    top: 40%;

}
      </style>
      </head>
 <!--주 제목-->
 <%@ include file="../../include/header.jsp"%>
<div class="todocont" >
 <div class="datacont">
 <div class="dateab">
	    <div class="tododate">
	    
	    <%
	    // 현재 날짜 가져오기
	    Date currentDate = new Date();
	    
	    // 원하는 형식 지정
	    SimpleDateFormat formatter = new SimpleDateFormat("EEEE dd MMMM yyyy", Locale.ENGLISH);
	    SimpleDateFormat formatter2 = new SimpleDateFormat("HH:mm:ss", Locale.ENGLISH);
	    
	    // 날짜를 원하는 형식으로 변환
	    String formattedDate = formatter.format(currentDate);
	    String formattedDate2 = formatter2.format(currentDate);
	    out.println(formattedDate);
	    %>
   		 </div>
	    <div class="todotime">
	    <%
	    out.println(formattedDate2);
	    
	    %>
	    </div>
 </div>
 </div>
    <div class="mainTitle">업무 메모함</div>

    <!--할일 정보 입력하는 곳-->
    <form action="#" class="addToDo" onsubmit="return addActiveList();">
      <input type="text" class="addToDoInfo" placeholder="Enter your to-do">
    </form>
    <!--투두리스트-->
    <div class="div"></div>
    <div class="list">
      <!--투두리스트Active-->
      <div class="activeToDo">
        <div class="activeTitle">Active</div><%-- 
      <c:forEach var="toDoListVO" items="${toDoListVOList}"
						varStatus="stat"> --%>
							
		        <ul type="block" class="listActive">
		        	<li>
		        	</li>
		        </ul>
			<%-- 
        </c:forEach> --%>
      </div>
           <div class="doneToDo">
        <div class="doneTitle">Done</div>
        <ul type="block" class="listDone">
        </ul>
      </div>
    </div>
 </div>
 <div class="modal_bgrd"  style="display: none;" onclick="modelOff()">
								<div class="mgmodal">
									<div class="delmodal" onclick="modelOff()">&times;</div>
									<ul class="todomodal">
									<h3 class="todoTitle">º</h3>
										<div class="todocon" ></div>
										<div class="todoend"> </div>
										<div class="todoend"> </div>
										
									</ul>
								</div>
								<%@ include file="../../include/footer.jsp"%>
								</div>
   <script type="text/javascript" src="todo.js"></script> 
 <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.7.7/axios.min.js"></script>
    <script>
    document.addEventListener('DOMContentLoaded', function() {
    	getList(); // 페이지가 로드되면 자동으로 리스트를 불러옴
    });
let i = j = 0;
const div = document.querySelector(".listActive")
const div2 = document.querySelector(".listDone")
function getList(){
	
	 axios.get('http://localhost:8020/todo/listaxios')
     .then(res => {
    	 let content =res.data
    	 let tblStr ="";
    	 let tblStr2 ="";
    	  for(let i =0; i<content.length;i++){
	    	 let todo = content[i]; 
	     	 console.log(todo)
	     	 if(todo.todoStatus == "1"){
	    		 tblStr += `
	   			 <ul type="block" class="listActive">
		    		 <li>
			        	<input type="hidden" value='\${todo.todoNo}'>
			        	<div onclick='modelOn(this)' class="bt">\${todo.todoTitle}</div>
			        	<button class="doneBtn" onclick='doneActive(event)'>Done</button>
		        	</li>
	        	</ul>
	    	 	`
	     	 }
	     	 if(todo.todoStatus == "2"){
	    		 tblStr2 += `
	   			 <ul type="block" class="listDone">
		    		 <li>
			        	<input type="hidden" value='\${todo.todoNo}'>
			        	<div onclick='modelOn(this)' class="bt">\${todo.todoTitle}</div>
			        	<button class="deleteBtn" onclick='deleteDone()'>delete</button>
		        	</li>
	        	</ul>
	    	 	`
	     	 }
    	 }
					div.innerHTML = tblStr;
					div2.innerHTML = tblStr2;
     })
     .catch(err => {
         console.log("리스트 불러오기 실패", err);
     });
	
	
}    
function addActiveList() {
    let todovalue = document.querySelector(".addToDoInfo").value;
   
    let formData = new FormData();  // 아작스로 파일을 보내려면 무조건!!!
    formData.append("todoTitle", todovalue);
	console.log(todovalue);
	axios.post('http://localhost:8020/todo/create', formData, {
	    headers: { 
	        'Content-Type': 'application/json' // JSON 데이터 전송 시 Content-Type 설정
	    }
	})
	    .then((res) => {
	         // 입력 필드 초기화
	         document.querySelector(".addToDoInfo").value = '';
	         location.reload(true);
	         alert("업로드 성공!");
	    })
	    .catch(function (error) {
	       alert("실패");
	    });

    document.querySelector(".addToDoInfo").value = '';
    i++;
    return false;
}
function doneActive(event) {
    let data = event.currentTarget;  // 클릭된 버튼을 가져옴
    console.log("클릭된 버튼:", data);

    // todoNo 가져오기
    let todoNo = $(data).siblings('input').val();  // 숨겨진 input에서 todoNo 값 가져오기
    let todoURL = "http://localhost:8020/todo/updatestate/" + todoNo;

    // 상태 변경을 위한 PUT 요청
    axios.put(todoURL)
        .then(res => {
            let updatedTodo = res.data;  // 서버에서 응답 받은 업데이트된 todo
            console.log("상태 업데이트 성공!");

            // 화면에서 상태 변경 반영
            getList()
        })
        .catch(err => {
            console.log("상태 업데이트 실패", err);
        });
}
/* 
// 화면에서 todo 항목의 상태를 업데이트하는 함수
function updateTodoStateInDOM(updatedTodo) {
    // 업데이트된 todo 항목을 화면에서 찾아서 상태를 변경
    let todoItem = document.querySelector(`#todo-item-${updatedTodo.todoNo}`);
    
    if (todoItem) {
        // 상태 텍스트를 '완료'로 변경
        let statusText = todoItem.querySelector('.status');
        if (statusText) {
            statusText.textContent = updatedTodo.todoStatus === 1 ? '완료' : '진행 중';
        }

        // 'Done' 버튼을 'Undo' 버튼으로 변경 (예시)
        let button = todoItem.querySelector('.doneBtn');
        if (button) {
            button.textContent = updatedTodo.todoStatus === 1 ? 'Undo' : 'Done';
            button.classList.toggle('doneBtn', updatedTodo.todoStatus !== 1);  // 상태에 따라 버튼 스타일 변경
        }
    }
}
 */
function deleteDone() {
   /*  this.parentNode.parentNode.removeChild(this.parentNode); */
    let data= event.currentTarget;
   console.log("data", data)
	let todoNo = $(data).siblings('input').val();
	let todoURL = "http://localhost:8020/todo/delete/" + todoNo;
    axios.delete(todoURL).then(res =>{
			console.log("다지웠슈")
			/*  location.reload(true); */
			    let todoItem = $(data).closest('li');  // 해당 todo의 <li> 요소 찾기
            	todoItem.remove();  // 해당 <li> 요소를 DOM에서 삭제
    }).catch(err=>{
			console.log("에렁",err);
	});   
}
function modelOn(){
	const modal = document.querySelector('.modal_bgrd');
	modal.style.display = 'block';
	let data= event.currentTarget;
	let todoNo = $(data).siblings('input').val();
	let todoURL = "http://localhost:8020/todo/getTodo/" + todoNo;
	console.log("찾았니 ", todoNo);
 	  axios.get(todoURL).then(res =>{
		let content =res.data;
		console.log(content);
	/* 	let todo = todoTitle.text(res.data); */
		document.querySelector('.todoTitle').textContent = content.todoTitle;
		document.querySelector('.todocon').textContent = content.todoDescription;
		document.querySelector('.todoend').textContent = '마감기한 : '+content.todoEdc;
 	 
 	  }).catch(err=>{
	console.log("에렁",err);
	});   
	
}
function modelOff(){
	const modal = document.querySelector('.modal_bgrd');
	modal.style.display = 'none';
	
}
</script>


</html>