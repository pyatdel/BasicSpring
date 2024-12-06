<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="../include/header.jsp" %>

<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<!-- ///// content 시작 ///// -->

<h1>RESTFUL API 테스트</h1>

<div id="list"></div>
<div id="toolbar" class="col-md-12">
	<form name="sujinFrm">
		<table class="table" id="muTable">
			<tr>
				<td>번호</td>
				<td><input class="form-control" type="text" id="sujinNum" name="sujinNum" value="" 
					placeholder="번호" /></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input class="form-control" type="text" id="sujinName" name="sujinName" value=""
					placeholder="이름" required /></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea class="form-control" id="sujinContent" name="sujinContent"					
					placeholder="내용" required /></textarea></td>
			</tr>
			<tr>
				<td>파일</td>
				<td><input class="form-control" type="text" id="sujinFile" name="sujinFile" value=""
					placeholder="파일" /></td>
			</tr>
		</table>
	</form>
	<button class="btn btn-primary" type="button" onclick="fPostInput()">입력</button>
	<button class="btn btn-secondary" type="button" onclick="fPutUpdate()">수정</button>
	<button class="btn btn-warning" type="button" onclick="fDeleteDel()">삭제</button>
</div>

<script type="text/javascript">
	//<form> 페이지를 오브젝트로 가져옴
	//<form name="sujinFrm">
	const myForm = document.sujinFrm;
	//빈 <div>을 오브젝트로 가져옴 
	//<div id="list"></div>
	const myList = document.querySelector("#list");
	
	//기능 함수
	// 테이블 TR에 마우스를 올리면 색상 변경. 이런건 기본으로 제공하는 게 좋음
	//function(=>) fTrClickMouseOverOut(){
	const fTrClickMouseOverOut=()=>{
		let trs = document.querySelectorAll("tr");
		for(let i=0;i<trs.length;i++){
			console.log("trs : ", trs[i]);
			
			trs[i].addEventListener("mouseover",()=>{
				//<tr style="backgroundColor:black;"
				trs[i].style.backgroundColor = "black";
				//<tr style="backgroundColor:black;color:orange;"
				trs[i].style.color = "orange";
			});
			
			//function() : this(o)
			//()=>       : this(x)
			trs[i].addEventListener("mouseout",function(){
				//this : <tr..오브젝트 그 자신
				//<tr style="backgroundColor:white;"
				this.style.backgroundColor = "white";
				//<tr style="backgroundColor:white;color:black;"
				this.style.color = "black";
				//<tr style="backgroundColor:white;color:black;font-weight:normal;"
				this.style.fontWeight = "normal";
			});
		}
	}
	
	//테이블 만드는 함수
	//fMakeTable(sujinVOList)
	const fMakeTable=(sujinVOList)=>{
		let tableStr=`<table class="table" style="width:100%"><tbody>`;
		
		tableStr +=`<tr><th>Num</th><th>Name</th><th>Content</th><th>File</th></tr>`;
		
		for (let i=0 ; i<sujinVOList.length; i++){
			let sujinVO = sujinVOList[i];
			tableStr +=`<tr onclick="fGetOne(\${sujinVO.sujinNum})">`;
		    tableStr +=`<td>\${sujinVO.sujinNum}</td>`;		
		    tableStr +=`<td>\${sujinVO.sujinName}</td>`;		
		    tableStr +=`<td>\${sujinVO.sujinContent}</td>`;		
		    tableStr +=`<td>\${sujinVO.sujinFile}</td>`;		
			tableStr +=`</tr>`;
		}
		
		tableStr +=`</tbody></table>`;
		
		myList.innerHTML = tableStr;
		
		//테이블이 동적으로 새로 만들어지므로, TR이벤트도 그때마다 
		fTrClickMouseOverOut();
	}
	
	// 백엔드 Restful SujinController에 대응하는 함수들 
	// 1. get방식 으로 list(sujin)가져오기 시작 ///////////////////////
// 	function fGetList(){
	const fGetList=()=>{
		//Http(Hypertext(연결됨) transport(전송) protocol(약속)) : 요청
		/*
		XMLHttpRequest (XHR) 객체는 서버와 상호작용할 때 사용합니다. 
		XHR을 사용하면 페이지의 새로고침 없이도 URL에서 JSON 데이터를 가져올 수 있습니다. 
		이를 활용하면 사용자의 작업을 방해하지 않고 페이지의 일부를 업데이트할 수 있습니다.
		XMLHttpRequest는 AJAX 프로그래밍에 많이 사용됩니다.
		*/
		let xhr = new XMLHttpRequest();
		
		/* 웹 서버에 요청 전송
		- open() : 요청의 초기화. 3개의 인자값을 가진다.
			인자1 : GET / POST / HEAD 중 하나의 방식설정
			인자2 : 접속할 URL
			인자3 : 동기/비동기 설정 (true의 경우 비동기)
		*/
		xhr.open("get","/sujin/listSujin",true);
		//HTTP Status : 200(성공), 404(페이지 없음), 500(개발자 오류)
		xhr.onreadystatechange=()=>{
			//xhr.readyState==4 는 서버로부터 데이터가 모두 왔다면
			//xhr.status==200 는 서버로부터 응답된 HTTP Status. 200은 성공
			if(xhr.readyState==4 && xhr.status==200){
				console.log("xhr.responseText : ", xhr.responseText);
				//xhr.responseText : JSONstring -> JSON오브젝트(deserialize)
				let sujinVOList = JSON.parse(xhr.responseText);
				console.log("sujinVOList : ", sujinVOList);
				/*
				let tableStr=`<table class="table" style="width:100%"><tbody>`;
				
				$.each(sujinVOList,function(idx,sujinVO){
					tableStr +=`<tr onclick="fGetOne(\${sujinVO.sujinNum})">`;
				    tableStr +=`<td>\${sujinVO.sujinNum}</td>`;		
				    tableStr +=`<td>\${sujinVO.sujinName}</td>`;		
				    tableStr +=`<td>\${sujinVO.sujinContent}</td>`;		
				    tableStr +=`<td>\${sujinVO.sujinFile}</td>`;		
					tableStr +=`</tr>`;
				});
				
				tableStr +=`</tbody></table>`;
				
				myList.innerHTML = tableStr;
				*/
				fMakeTable(sujinVOList);
			}
		}//end onreadystatechange
		xhr.send();
	}//end fGetList
	// 1. get방식 으로 list(sujin)가져오기 끝 ///////////////////////
	
	// 2. get으로 1개 row(sujin) 가져오기 시작 //////////////// 
	//function fGetOne(sujinNum){
	const fGetOne=(sujinNum)=>{
		let xhr = new XMLHttpRequest();
		//		  방식 ,       URL,					비동기
		xhr.open("get","/sujin/getSujin/"+sujinNum,true);
		xhr.onreadystatechange=()=>{
			//		데이터 성공    	HTTP Status 성공
			if(xhr.readyState==4 && xhr.status==200){
				console.log("xhr.responseText : ", xhr.responseText);
			}
		}
		xhr.send();
	}//end fGetOne
	// 2. get으로 1개 row(sujin) 가져오기 끝 ////////////////
	
	// 3. post로 insert 1개 row(sujin) 시작 /////////////
	
	//function fPostInput(){
	//<button class="btn btn-primary" type="button" onclick="fPostInput()">입력</button>
	//핸들러함수에 의해 입력 버튼을 클릭 시 함수 호출
	const fPostInput=()=>{
		let sujinContent = myForm.sujinContent.value;
		let sujinName = myForm.sujinName.value;
		
		//JSON 오브젝트
		let data = {
			"sujinContent":sujinContent,
			"sujinName":sujinName,
			"sujinFile":""
		}
		console.log("data : ", data);
		
		//JSON오브젝트 -> JSONstring(serialize)
		let sujinVO = JSON.stringify(data);
		console.log("sujinVO : ", sujinVO);
		
		let xhr = new XMLHttpRequest();
		xhr.open("post","/sujin/insertSujin",true);//방식,URL,비동기
		xhr.setRequestHeader("Content-Type","application/json;charset=utf-8");//post,put방식일 때
		xhr.onreadystatechange=()=>{
			if(xhr.readyState==4 && xhr.status==200){
				//insert된 1 또는 0
				console.log("xhr.responseText : ", xhr.responseText);
			}
		}
		xhr.send(sujinVO);
		
	}//end fPostInput
	// 3. post로 insert 1개 row(sujin) 끝 ///////////// 
	
	//함수 호출
	fTrClickMouseOverOut();
	//SUJIN 테이블 목록 호출
	fGetList();
	//SUJIN 테이블의 1행 호출
	fGetOne(1);
</script>

<!-- ///// content 끝 ///// -->

<%@ include file="../include/footer.jsp" %>   







