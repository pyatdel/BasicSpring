<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
  
<!-- 
../ : views폴더(부모)
 -->
<!--     <meta charset="utf-8">
    <title>기안작성</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
    <link rel="stylesheet" href="/dash/css/bootstrap.min.css" >
    <link rel="stylesheet" href="/dash/css/style.css" >
    <link href="img/favicon.ico" rel="icon">

    Google Web Fonts
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet"> -->
    
<style>
tr {
    flex-direction: row;
}

 .mgmodal {
    background-color: white;
    z-index: 100;
    width: 50% !important;
    height: 70%;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    border: 1px solid gray;
    border-radius: 20px;
    display: flex; /* left-menu와 main-content를 수평으로 배치 */
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
 position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.6);
    display: flex;
    align-items: center;
    justify-content: center;

}
.modal-header {
    background-color: #007bff;
    color: white;
    padding: 15px;
    font-size: 18px;
    font-weight: bold;
    text-align: center;
}
.modal-content {
    padding: 20px;
    display: flex;
    flex-direction: row;
    gap: 20px;
    min-height: 400px; /* 전체 높이 설정 */
}

.list-section, .search-results {
    width: 100%;
}

.delmodal{
position: absolute;
z-index:  9999;
font-size: 50px;
font-weight: normal;
cursor: pointer;

}

.left-menu {
    width: 21%;
    margin: 8 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 10px;
}

.left-menu ul {
    list-style: none;
    padding: 0;
}

.left-menu ul li {
    padding: 10px 5px;
   /*  border-bottom: 1px solid #ddd; */
    /* cursor: pointer; */ /* 실선 */
}

.approval-section {
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 10px;
    background-color: #f9f9f9; /* 결재선 배경색 */
   height:30vh;
    overflow-y: auto; /* 내용이 많을 경우 스크롤 */
    margin: 8 ;
    width: 280px;
}
.list-section {
    margin: 8 10px;
    border: 1px solid #ccc;
    border-radius: 5px; /* 모서리 둥글게 */
    padding: 10px;
    width: 35%;
}
.reference-section {
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 10px;
    background-color: #f9f9f9;
    overflow-y: auto;
    height: 30vh;
    margin: 8;
}
.list-section ul, .approval-section ul, .reference-section ul {
    list-style: none; /* li 표시 제거 */
}

.list-section ul li, .approval-section ul li, .reference-section ul li {
    margin: 5px 0;
}
.main-content,.select-box,.list-section{
    display: flex;
}
.buttons {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;
}
/* 결재선 버튼 사이즈 */
.move-right,.move-left {
   background: #007bff;
    color: white;
    border: none;
    padding: 8px 15px;
    border-radius: 5px;
    cursor: pointer;
    transition: background 0.3s;
}
/* 결재선 버튼 사이즈 */
.move-right2,.move-left2 {
   background: #4E8D86;
    color: white;
    border: none;
    padding: 8px 15px;
    border-radius: 5px;
    cursor: pointer;
    transition: background 0.3s;
}
.buttons button:hover {
    background-color: #0056b3;
}
.apvbtn{
text-align: center !important;
margin-top:10px;
}
.apvbtn > button {
background-color: #007bff !important;

} 
.btmg{
margin-top:480% !important;}
.buttons{
display: flex;
justify-content: center;
}
.buttons >button{

width: 45px !important;
}
.list-section {
    margin-top: 10px;
}

.search-results {
    margin-top: 10px;
}
.search{
width: 140px; /* 입력창의 가로 크기 */
height: 25px; /* 입력창의 세로 크기 */
}
.signList {
    height: 50vh;
    overflow-y: auto;  /* 세로 방향으로만 스크롤바 표시 */
}
#signForm{
justify-content: center;
display: flex;
}
input{

border: 1px solid gray !important;}

.input-group-text{

display: flex
;
    border: 1px solid gray !important;
    border-radius: 5px;
}
.form-select{
    border: 1px solid gray !important;
}
textarea{
    border: 1px solid gray !important;

}
.deptName {
    cursor: pointer;
    padding: 10px;
    transition: background-color 0.3s ease;
  }

  .deptName:hover {
    background-color: #f0f0f0; /* 마우스 올리면 색 변경 */
  }
  .greenBt{
	background-color: #278986;
	color:white;
	outline: none;
	border:none;
	width: 70px;
	height:36px; 
	border-radius: 5px;
	margin: 5px;
	}
	.bluBt{
	background-color: #3676EB;
	color:white;
	outline: none;
	border:none;
	width: 70px;
	height:36px; 
	border-radius: 5px;
	margin: 5px;
	}
.signSub {
display: block !important;
height: auto !important;
}	
	
</style>
    
    
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

	<!-- ///// sidebar 시작 ///// -->
	<jsp:include page="../include/header.jsp"></jsp:include> 
	<!-- ///// sidebar 끝 ///// -->


	<div class="bg-light rounded h-100 p-4" id="signForm">
		<form id="frm" action="/memberSign/createFormPost" method="post">
			<input value="${signVO.empNo}" id="empNo" hidden >
			<input value="${signVO.empId}" id="empId" hidden >
            <input value="${signVO.docNo}" id="docNo" name="docNo" hidden >
            <!-- 결재선 생각할 때 보기  -->
            <div id="appproveList">
            	<input type="hidden" name="app_list_codes" values="${appListCode}"/>
            	<input type="hidden" name="reapp_emp_ids" values="${reappEmpId}"/>
            	<input type="hidden" name="app_orders" values="${appOrder}"/>
            	<input type="hidden" name="appGroupCode" value="${signVO.appGroupCode}"/>
            </div>
            <%-- <p>appGroupCode: ${signVO.appGroupCode}</p> --%>
            <button 
		        type="button" 
		        class="btn btn-outline-success m-2" 
		        style="margin-bottom: 10px;float:left;" 
		        id="prev">
		        결재선
		    </button>
            <div class="appButton" style="float: right;" id="divTables">
		    
	            <table class="custom-table"  style="border-collapse: collapse; margin-bottom: 10px;float:left;">
	                <tbody class="col-12 col-md-4">
	                    <tr  id="approver-names">
	                     	<td style="height: 30px; width: 120px;  border: 1px solid #ced4da;" >${signVO.empName}${signVO.postName}</td>	
	                    </tr>
	                    <tr id="approver-signs">
	                     	<td style="height: 90px; width: 120px;  border: 1px solid #ced4da;">
	                     	<img src="${signVO.fileSaveLocate}" style="height: 80px;width:110px;" /></td>	
	                    </tr>
	                    <tr id="approver-dates">
	                     	<td style="height: 30px; width: 120px;  border: 1px solid #ced4da;">
	                     	<c:set var="today" value="<%=new Date()%>"></c:set>
	                     	<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" />
	                     	 </td>	
	                    </tr>
	                </tbody>
	            </table>
	            <table class="custom-table"  style="border-collapse: collapse; margin-bottom: 10px;float:left;" id="approvalTable">
	                <tbody class="col-12 col-md-4">
	                
	                </tbody>
	            </table>
            </div>
			<div class="input-group mb-3">
                 <span class="input-group-text" id="basic-addon3">참조</span>
                 <input type="text" class="form-control" id="basic-url" aria-describedby="basic-addon3"  value="${signVO.reappEmpId}" style="background-color : #fff " readonly>
             </div>
				<div class="input-group mb-3">
	                <span class="input-group-text" id="basic-addon3" >기안자</span>
		                <input type="text" class="form-control" id="empName" aria-describedby="basic-addon3"
		                value="${signVO.empName}" style="background-color : #fff " readonly>
	                <span class="input-group-text" id="basic-addon3 " >부서</span>
		                <input type="text" class="form-control" id="deptName" aria-describedby="basic-addon3"
		                value="${signVO.deptName}" style="background-color : #fff " readonly>
	            </div>
				<div class="input-group mb-3">
	                <span class="input-group-text" id="basic-addon3" >기안일</span>
		                <input type="text" class="form-control" id="writeDate" aria-describedby="basic-addon3"
		                value="${signVO.writeDate}" style="background-color : #fff " readonly>
	                <span class="input-group-text" id="basic-addon3" >직급</span>
		                <input type="text" class="form-control" id="postName" aria-describedby="basic-addon3"
		                value="${signVO.postName}" style="background-color : #fff " readonly>
	            </div>
			<select class="form-select form-select-sm mb-3" aria-label=".form-select-sm example" id="appDocName">
			 <option value="" selected disabled>결재 종류 선택</option> <!-- 첫 번째 옵션 -->
				<c:forEach var="signVO" items="${signVOList}">
                 <option value="${signVO.appDocName}">${signVO.appDocName}</option>
                </c:forEach> 
             </select>
           
             <div class="form-floating mb-3">
                <input type="text" class="form-control" id="docTitle" value="${signVO.docTitle}" placeholder="제목" style="color:#ccc;height: 30px; padding: 5px;">
                <label for="floatingInput" onclick="event.preventDefault();" ></label>
            </div>
            <div class="form-floating">
                <textarea  class="form-control" placeholder="Leave a comment here" id="docContent" style="height: 300px;"
                 placeholder="내용 입력" >${signVO.docContent}</textarea>
                <label for="floatingTextarea" onclick="event.preventDefault();" ></label>
            </div>
            
            <div>
            	<label for="fileGroupNo" >첨부파일</label>
 				<input class="form-control form-control-sm" id="fileGroupNo" name="uploadFile" type="file" multiple>
 			</div>
 			
 			<button type="button" class="greenBt" style="float: left;">
 			<a href="/memberSign/signHome">목록</a></button>
 			<button type="button" id="btnSubmit" class="bluBt" style="float: right;">등록</button>
        </div>			
 	</form>
 	
 	
 	<!-- 모달 --> 	
       <div class="modal_bgrd" style="display: none;">
		    <div class="mgmodal">
		        <div class="left-menu">
		            <ul>
		            <c:forEach var="signVO" items="${departmentVOList}">
             			<li class="deptName" onclick="signLines('${signVO.deptName}')" style="cursor:pointer;">
             			부서명 : ${signVO.deptName}
             			</li>
             		</c:forEach>	
		            </ul>
		        </div>
		        
		        <!-- 왼쪽 직원 리스트 -->
                <div class="list-section">
                	<!-- 직원 리스트 (검색 결과 표시 영역) -->
    				<div class="search-results">
    					<!-- 검색기능 -->
    					<div>
    					<input class="search" type="text" name="keyword" value="" class="form-control float-right" placeholder="검색어 입력">
    					<button type="button" id="btnSeach" class="btn btn-default">
                   			<i class="fas fa-search"></i>
                   		</button>
    					</div>
	                    <ul class="signList">
		                    <c:forEach var="signVO" items="${signLineList}">
		                        <input type="checkbox" class="signLine" value=" ${signVO.postName}">
		                     </c:forEach>   
	                    </ul>
                	</div>
                </div>
                
		        <div class="main-content">
		            <div class="select-box">
		        	
		                <div class="buttons">
		                    <button class="move-right">&gt;</button>
		                    <button class="move-left">&lt;</button>
		               		<br><br><br><br><br><br><br><br>
		                    <button class="move-right2">&gt;</button>
		                    <button class="move-left2">&lt;</button>
		                </div>
		                
		                <div class="approvalline">
		                	<!--오른쪽 직원 리스트 1 -->
			                <div class="approval-section">
			                    <h3>결재선</h3>
			                    <ul>
			                    
			                    </ul>
		                	</div>
			                <!--오른쪽 직원 리스트 2 -->
			                <div class="reference-section" >
			                    <h3>참조</h3>
			                    <ul>
			                    
			                    </ul>
			                </div>
			                
		                <div class="apvbtn">
		                	<button type="button" id="delmodal" class="btn btn-secondary" data-bs-dismiss="modal_bgrd">닫기</button>
		                	<button type="button" id="insertmodal" class="btn btn-primary">등록</button>
		                </div>
		                </div>
		            </div>
		        </div>

           	</div>
		</div>


 <jsp:include page="../include/footer.jsp"></jsp:include>

<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

		<script type="text/javascript">
		
		
		// 기안 폼
		$(document).ready(function() {
		    // 현재 날짜 가져오기
		    let today = new Date();

		    // 날짜 포맷을 YYYY-MM-DD 형식으로 변환
		    let year = today.getFullYear();
		    let month = today.getMonth() + 1; // getMonth()는 0부터 시작하므로 1을 더해줍니다.
		    let day = today.getDate();

		    // 월과 일이 10보다 작으면 앞에 0을 추가하여 두 자리로 맞추기
		    if (month < 10) {
		        month = '0' + month;
		    }
		    if (day < 10) {
		        day = '0' + day;
		    }

		    let formattedDate = year + '-' + month + '-' + day;

		    // writeDate input에 현재 날짜 넣기
		    $("#writeDate").val(formattedDate);
		});
		
		// id = insertmodal 모달 등록 버튼  순서 어떻게 등록하지?
		//결재선 등록(전자서명자, 참조자)
	 	$(function(){
			//결재선 .approval-section 여기로 이동 된 애들 데이터 가져오는 방법
			//공람/열람 .reference-section
			$("#insertmodal").on("click",function(){
				console.log("결재선 등록 비동기 처리")
				

				//1.가상 폼
				let formData = new FormData();
				
				// 2. 체크박스로 선택된 직원들의 empId를 배열에 담기
				let selectedEmpIds = [];
				
				$(".approval-section .signLine:checked").each(function(){
					let empId = $(this).val();// 체크된 항목의 empId 값
					console.log("empId:", empId);
					selectedEmpIds.push(empId);//배열에추가
				});
				
				// 참조 데이터
				let referenceEmpIds=[];
				 $(".reference-section .signLine:checked").each(function () {
			            let empId = $(this).val(); // 체크된 항목의 empId 값
			            console.log("참조 empId:", empId);
			            referenceEmpIds.push(empId); // 배열에 추가
			        });
				
				// 배열이 비어있는지 확인
				if (selectedEmpIds.length == 0) {
        			alert("배열이 비어있다.....");
        			return;
    			}
				selectedEmpIds.forEach((empId) => {
			            formData.append("empIds", empId); // 결재선
			        });

				referenceEmpIds.forEach((empId) => {
		            formData.append("referenceEmpIds", empId); // 참조
		        });
				
				 formData.forEach((value, key) => {
				    console.log("FormData key: 체킨", key, "FormData value:", value);
				});  
				
				
				
				
				//4.ajax
				$.ajax({
					url:"/sign/createPostAjax",
					processData:false,
					contentType:false,
					data:formData,
					type:"post",
					dataType:"json",
					success:function(result){
						//결과 확인
						//result :  1) result, 2) approvalList
						console.log("result : ", result);
						
						if(result != ""){
							console.log("결재선 등록 성공");
						
							// 결재 폼에 데이터 추가
							$("#approvalTable tbody").empty();
							let str = "";
							let str2 = "";//참조자
							let sign = "";
							let appGroupCode = "";
							
							/* result.approvalList
							[
								SignVO(docNo=0, docTitle=null, docContent=null, writeDate=null, empNo=0, appDocNo=0, appStatusCode=0, fileGroupNo=0, appGroupCode=41, appStatusName=null, appDocName=null, empName=김철수, empId=null, empSign=20250116004, fileSaveLocate=null, empIds=null, postNo=0, postName=부장, deptNo=0, deptName=null, rnum=0, signDetailVOList=null, fileGroupVO=null, uploadFiles=null, referenceEmpIds=null, appListCode=1, appListName=결재자, appNo=0, reappEmpId=1, appOrder=1, appDate=null, appIdx=0, appTypeId=0, appTypeName=null, uploadFile=null), 
								SignVO(docNo=0, docTitle=null, docContent=null, writeDate=null, empNo=0, appDocNo=0, appStatusCode=0, fileGroupNo=0, appGroupCode=41, appStatusName=null, appDocName=null, empName=윤근원, empId=null, empSign=20250117015, fileSaveLocate=null, empIds=null, postNo=0, postName=차장, deptNo=0, deptName=null, rnum=0, signDetailVOList=null, fileGroupVO=null, uploadFiles=null, referenceEmpIds=null, appListCode=1, appListName=결재자, appNo=0, reappEmpId=37, appOrder=2, appDate=null, appIdx=0, appTypeId=0, appTypeName=null, uploadFile=null), 
								SignVO(docNo=0, docTitle=null, docContent=null, writeDate=null, empNo=0, appDocNo=0, appStatusCode=0, fileGroupNo=0, appGroupCode=41, appStatusName=null, appDocName=null, empName=박철수, empId=null, empSign=20250117011, fileSaveLocate=null, empIds=null, postNo=0, postName=부장, deptNo=0, deptName=null, rnum=0, signDetailVOList=null, fileGroupVO=null, uploadFiles=null, referenceEmpIds=null, appListCode=2, appListName=참조자, appNo=0, reappEmpId=15, appOrder=3, appDate=null, appIdx=0, appTypeId=0, appTypeName=null, uploadFile=null)
							]
							*/
							result.approvalList.forEach(item=>{
								console.log("item.appListName : ", item.appListName);
								sign = "";
								//똑같은 값(41)이 3회 들어옴
								let appGroupCode = parseInt(item.appGroupCode, 10);
								$("input[name='appGroupCode']").val(appGroupCode);
								$("input[name='appGroupCode']").next().html("appGroupCode: "+appGroupCode);
								
								if(item.appListName=="결재자"){
									if(item.empSign!=null){//싸인 null처리
										sign = item.empSign;
									}
									str += `
										<table class="custom-table" style="border-collapse: collapse; margin-bottom: 10px;float:left;" id="approvalTable">
							                <tbody class="col-12 col-md-4">
												 <tr  id="approver-names">
						                     	<td style="height: 30px; width: 120px;  border: 1px solid #ced4da;" >\${item.empName}</td>	
							                    </tr>
							                    <tr id="approver-signs">
							                     	<td style="height: 90px; width: 120px;  border: 1px solid #ced4da;"></td>	
							                    </tr>
							                    <tr id="approver-dates">
							                     	<td style="height: 30px; width: 120px;  border: 1px solid #ced4da;">\${item.postName}</td>	
							                    </tr>
						                    </tbody>
					                    </table>
				                    `;
								}else{
									str2 += `\${item.empName} \${item.postName}, `;
								}
							});
							
							console.log("str : ", str);
							console.log("str2 : ", str2);
							
							$("#divTables").append(str);
							$("#basic-url").val(str2);
							
							$(".modal_bgrd").hide(); // 모달 숨기기
							
						}else {
								console.error("결재선 데이터가 없습니다.");
						}
					}
				})// ajax 

			})//end insertmodal
		});//end 달러 function
		
			let currentDeptName = ''; // 전역 변수로 부서명 저장
		 //부서 클릭 시 해당 직원 보이게 하기
		   function signLines(deptName,keyword=""){
			if(!currentDeptName){ // 만약 부서명이 없으면
				currentDeptName = deptName; // 부서명을 저장
			}
			
			   let data = { deptName: deptName, keyword: keyword }; 
			   console.log("체킁signLines",data);
			   
			$.ajax({
				url: '/sign/signLinePost', // 해당 부서 사원 정보 가져오기
				type : 'post',
				data:JSON.stringify(data),
				contentType:"application/json",
				dataType:"json",
				success: function(response){
					console.log("response:", response);
					
                // 기존 목록 초기화
                $('.list-section ul').empty();
    
                // 직원 목록 채우기
                response.forEach(function(signVO) {
                $('.list-section ul').append(
                    `<li><input type="checkbox" class="signLine" value="\${signVO.empId}">\${signVO.empName} \${signVO.postName}(\${signVO.deptName})</li>`
                        );
				    });
                
                //선택된 데이터 전송
                $('#submitBtn').click(function(){
                	var formData = new FormData();
                	$('.signLine:checked').each(function(){
                		formData.append('empIds',$(this).val());
                	});
                
                });
				},
				error: function(xhr, status,error){
					alert('사원 정보 불러오는 데 실패했습니다.')
				}
				
			}); 
			   
		   }//end signLines 

		
		//검색
		 $(function(){
			   signLines("","");
			   
			   //검색 처리
			   $("#btnSeach").on("click",function(){
				   let keyword = $("input[name='keyword']").val();
				   console.log("keyword : "+keyword);
				   
				   //전역 함수 호출
				   signLines(currentDeptName,keyword);
				   
			   });
			// 엔터 키 입력 시 검색 처리
			    $("input[name='keyword']").on("keydown", function(e) {
			        if (e.key === "Enter") {  // Enter 키가 눌렸을 때
			            let keyword = $(this).val();
			            console.log("검색어 : " + keyword);
			            signLines(currentDeptName, keyword);  // 검색 실행
			        }
		    	});   
			   
		   });// end signLines

		   document.addEventListener("DOMContentLoaded", function(){
				//DOM 요소 가져오기, 결재선
				const moveRightBtn = document.querySelector(".move-right");// 오른쪽으로 이동 버튼
				const moveLeftBtn = document.querySelector(".move-left"); // 왼쪽으로 이동 버튼
	            const leftList = document.querySelector(".list-section ul"); // 왼쪽 리스트
	            const rightList = document.querySelector(".approval-section ul") // 오른쪽 리스트
	            //참조
	            const moveRightBtn2 = document.querySelector(".move-right2");// 오른쪽으로 이동 버튼
				const moveLeftBtn2 = document.querySelector(".move-left2"); // 왼쪽으로 이동 버튼
				const leftList2 = document.querySelector(".list-section ul"); // 왼쪽 리스트
				const rightList2 = document.querySelector(".reference-section ul") // 오른쪽 리스트
				
	             // 오른쪽으로 이동
	            moveRightBtn.addEventListener("click", function () {
	            // 왼쪽 리스트에서 선택된 항목 가져오기
	            const selectedItems = leftList.querySelectorAll("input:checked");
	            selectedItems.forEach((item) => {
	            // li 요소 가져오기
	            const li = item.closest("li");
	            // 오른쪽 리스트로 이동
	            rightList.appendChild(li);
	            // 체크 해제
	            /* item.checked = false; */
	            
	            // 오른쪽으로 이동 2
	            moveRightBtn2.addEventListener("click", function () {
	            // 왼쪽 리스트에서 선택된 항목 가져오기
	            const selectedItems = leftList2.querySelectorAll("input:checked");
	            selectedItems.forEach((item) => {
	            // li 요소 가져오기
	            const li2 = item.closest("li");
	            // 오른쪽 리스트로 이동
	            rightList2.appendChild(li2);
	            // 체크 해제
	            /* item.checked = false; */
	                });
	            });
	        });

	            // 왼쪽으로 이동
	            moveLeftBtn.addEventListener("click", function () {
	                // 오른쪽 리스트에서 선택된 항목 가져오기
	                const selectedItems = rightList.querySelectorAll("input:checked");
	                selectedItems.forEach((item) => {
	                    // li 요소 가져오기
	                    const li = item.closest("li");
	                    // 왼쪽 리스트로 이동
	                    leftList.appendChild(li);
	                    // 체크 해제
	                    item.checked = false;
	                });
	            });

                //왼쪽으로 이동 2
                moveLeftBtn2.addEventListener("click", function(){
                    //오른쪽 리스트에서 선택된 항목 가져오기
                    const selectedItems2 = rightList2.querySelectorAll("input:checked");
                    selectedItems2.forEach((item) =>{
                        //li 요소 가져오기
                        const li2 = item.closest("li");
                        //왼쪽 리스트로 이동
                        leftList.appendChild(li2);
                        //체크 해제
                        item.checked = false;
                    	});
                	});
	            });
            });//document end
		
		
	      //결재선 버튼 클릭
	      $("#prev").on("click",function(){
	         $(".modal_bgrd").css("display","block");
	         console.log($(".modal_bgrd").css("display"));
	         var imgSrc = $(".imgFileSaveLocate").attr("src");
	      });
		         
         // 모달 닫기 버튼 클릭 시 모달 닫기
         $("#delmodal").on("click", function() {
             $(".modal_bgrd").css("display", "none"); // 모달 숨기기
         });
		         
     	//결재폼 등록
 		$(function(){
 			$("#btnSubmit").on("click",function(){
 				console.log("결재폼 등록 처리")
 				
 				//가상 폼
 				let formData = new FormData();
 				
 				//DOC_NO , DOC_TITLE , DOC_CONTENT , WRITE_DATE(SYSDATE) , EMP_NO , APP_DOC_NO , APP_LIST_CODE
 				let docNo = $("#docNo").val();
 				let docTitle = $("#docTitle").val();
 				let docContent = $("#docContent").val();
 				let empNo = $("#empNo").val();
 				let appDocName = $("#appDocName").val();
 				let appGroupCode = $("input[name='appGroupCode").val();
 				
 				console.log("docTitle",docTitle);
 				console.log("docContent",docContent);
 				console.log("empNo",empNo);
 				console.log("appDocName",appDocName);
 				console.log("appGroupCode",appGroupCode);
 				
 				
 				formData.append("docNo",docNo);
 				formData.append("docTitle",docTitle);
 				formData.append("docContent",docContent);
 				formData.append("empNo",empNo);
 				formData.append("appDocName",appDocName);
 				formData.append("appGroupCode",appGroupCode);
 				
 				console.log("formData(등록버튼 클릭 시) : ", formData);
 				
 				let inputFile = document.getElementById("fileGroupNo");
 				let files = inputFile.files;
 				console.log("Selected files: ", files);
 				if(files.length > 0){
 				for(let i = 0; i<files.length; i++){
 					formData.append("uploadFile",files[i]);
 					}
 				}
 				$.ajax({
 					url:"/sign/createFormPost",
 		       		processData:false,
 		  			contentType:false,
 		   	    	data:formData,
 		   	    	type:"post",
 		   	    	dataType:"text",
 		   	    	success:function(result){
 						console.log("result : ", result);
 						// 등록
 							location.href="/memberSign/detail?appGroupCode="+appGroupCode;
 		   	    	}
 				});
 				
 			});
 		}); //결재폼 등록 end
		</script> 	
 
 
 

    <script src="/dash/lib/easing/easing.min.js"></script>
    <script src="/dash/lib/waypoints/waypoints.min.js"></script>
    <script src="/dash/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/moment.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>
<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
    <!-- Template Javascript -->
    <script src="/dash/js/main.js"></script>
<!-- ///// footer 시작 ///// -->
<!-- ///// footer 끝 ///// -->