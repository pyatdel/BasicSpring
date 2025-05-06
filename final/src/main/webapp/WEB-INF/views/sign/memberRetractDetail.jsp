<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<!-- 토글 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.5.0/dist/sweetalert2.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.5.0/dist/sweetalert2.min.css" rel="stylesheet">
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
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
     -->
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
.appButton{
    float: right;
    display: flex;
    flex-direction: column;
}
.deptName {
    cursor: pointer;
    padding: 10px;
    transition: background-color 0.3s ease;
  }

  .deptName:hover {
    background-color: #f0f0f0; /* 마우스 올리면 색 변경 */
  }
.modal_bgrd2 {
    display: flex;
    justify-content: center ;
    align-items: center;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
    z-index: 1050; /* 위에 표시 */
}

/* 모달 창 */
.mgmodal2 {
    background: white;
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
    width: 30%; /* 모달 너비 */
    animation: fadeIn 0.3s ease-in-out; /* 부드러운 등장 효과 */
    position: absolute;
    left: 30%;
 	top: 30%;
}

/* 텍스트 상자 */
.box-content {
    margin-bottom: 20px;
    text-align: left; /* 라벨 및 텍스트 정렬 */
}

/* 버튼 영역 */
.modal-buttons {
    display: flex;
    justify-content: space-around;
}

/* 애니메이션 */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: scale(0.9);
    }
    to {
        opacity: 1;
        transform: scale(1);
    }
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
	<jsp:include page="../include/mangerSidebar.jsp"></jsp:include> 
	<!-- ///// sidebar 끝 ///// -->


	<div class="bg-light rounded h-100 p-4" id="signForm">
      <h6 class="mb-4">기안 자세히 보기</h6>
		<form id="frm" action="/memberSign/createFormPost" method="post">
			<input value="${signVO.empNo}" id="empNo" hidden >
			<input value="${signVO.empId}" id="empId" hidden >
            <input value="${signVO.docNo}" id="docNo" hidden >
            <!-- 결재선 생각할 때 보기  -->
            <div id="appproveList">
            	<input type="hidden" name="app_list_codes" values="${appListCode}"/>
            	<input type="hidden" name="reapp_emp_ids" values="${reappEmpId}"/>
            	<input type="hidden" name="app_orders" values="${appOrder}"/>
           <%--  <p>appGroupCode: ${signVO.appGroupCode}</p>
            <p>docNo: ${signVO.docNo}</p> --%>
            <input type="hidden" name="appGroupCode" value="${signVO.appGroupCode}"/>
            </div>
            <div  style="float: right;" id="divTables">
            <button 
		        type="button" 
		        class="btn btn-outline-success m-2" 
		        style="margin-bottom: 10px;float:left;" 
		        id="prev">
		        결재선
		    </button>
		    
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
	                     	${signVO.writeDate}
	                     	 </td>	
	                    </tr>
	                </tbody>
	            </table>
                <c:forEach var="line" items="${appLineList}">
	                <table class="custom-table" style="border-collapse: collapse; margin-bottom: 10px;float:left;" id="approvalTable">
		                <tbody class="col-12 col-md-4">
							 <tr  id="approver-names">
	                     	<td style="height: 30px; width: 120px;  border: 1px solid #ced4da;" >${line.empName}</td>	
		                    </tr>
		                    <tr id="approver-signs">
		                     	<td style="height: 90px; width: 120px;  border: 1px solid #ced4da;" class="approval-cell" id="td${line.empId}">
		                     		<c:if test="${line.appTypeId eq 2}">
			                     		<img src="${line.fileSaveLocate}" style="height: 80px;width:110px;" />
		                     		</c:if>
		                     	</td>
		                    </tr>
		                    <tr id="approver-dates">
		                     	<td style="height: 30px; width: 120px;  border: 1px solid #ced4da;">${line.postName}</td>	
		                    </tr>
	                    </tbody>
                    </table>
                  </c:forEach>  
            </div>
            <div class="input-group mb-3">
                <span class="input-group-text" style="background-color: orange; color: black">반려 사유</span>
                <textarea class="form-control" aria-label="With textarea" style="background-color : #fff" disabled>${signVO.rejectStatus}</textarea>
            </div>
			<div class="input-group mb-3">
                 <span class="input-group-text" id="basic-addon3">참조</span>
                 <c:forEach var="appLineList2" items="${appLineList2}" >
                 <input type="text" class="form-control" id="basic-url" aria-describedby="basic-addon3"  
                 value="${appLineList2.empName}${appLineList2.postName} " disabled>
                 </c:forEach>
             </div>
				<div class="input-group mb-3">
	                <span class="input-group-text" id="basic-addon3">기안자</span>
		                <input type="text" class="form-control" id="empName" aria-describedby="basic-addon3"
		                value="${signVO.empName}" style="background-color : #fff" readonly>
	                <span class="input-group-text" id="basic-addon3">부서</span>
		                <input type="text" class="form-control" id="deptName" aria-describedby="basic-addon3"
		                value="${signVO.deptName}" style="background-color : #fff" readonly>
	            </div>
				<div class="input-group mb-3">
	                <span class="input-group-text" id="basic-addon3">기안일</span>
		                <input type="text" class="form-control" id="writeDate" aria-describedby="basic-addon3"
		                value="${signVO.writeDate}" style="background-color : #fff" readonly>
	                <span class="input-group-text" id="basic-addon3">직급</span>
		                <input type="text" class="form-control" id="postName" aria-describedby="basic-addon3"
		                value="${signVO.postName}" style="background-color : #fff" readonly>
	            </div>
			<select class="form-select form-select-sm mb-3" aria-label=".form-select-sm example" id="appDocName" disabled >
			 <option value="" selected disabled>${signVO.appDocName}</option> <!-- 첫 번째 옵션 -->
				<c:forEach var="signVO" items="${signVOList}">
                 <option value="${signVO.appDocName}">${signVO.appDocName}</option>
                </c:forEach> 
             </select>
           
             <div class="form-floating mb-3">
                <input type="text" class="form-control" id="docTitle" value="${signVO.docTitle}" placeholder="제목" style="color:#757575;height: 30px; background-color : #fff; padding: 5px; " disabled >
                <label for="floatingInput" onclick="event.preventDefault();" ></label>
            </div>
            <div class="form-floating">
                <textarea  class="form-control" placeholder="Leave a comment here" id="docContent" style="height: 300px;"
                 placeholder="내용 입력"  disabled >${signVO.docContent}</textarea>
                <label for="floatingTextarea" onclick="event.preventDefault();" ></label>
            </div>
            
            <div>
            	<label for="fileGroupNo" >첨부파일</label>
 				<!-- 첨부된 파일 목록 표시 -->
 				<div class="p-2 mb-2 bg-body text-dark" style="border: 1px solid #000; border-radius: 5px;">
				    <c:if test="${not empty signVO.fileGroupVO.fileDetailVOList}">
				            <c:forEach var="fileDetail" items="${signVO.fileGroupVO.fileDetailVOList}">
				            	<!-- <input class="form-control" id="fileGroupNo" name="uploadFile" type="file" multiple> -->
				                <a href="${fileDetail.fileSaveLocate}" download="${fileDetail.fileOriginalName}">
    							${fileDetail.fileOriginalName} 다운로드
								</a>
				            </c:forEach>
				    </c:if>
				</div>    
 			</div>
 			
 			<button type="button" class="btn btn-outline-dark m-2" style="float: left;">
 			<a href="/memberSign/signList">목록</a></button>
 			<c:if test="${finalCheckStatus==1}">
 				<c:set var="disabled" value="disabled" />
 			</c:if>
 			<button type="button" id="retractButton2" class="btn btn-outline-danger m-2 retractButton" style="float: right;" ${disabled}>반려</button>
 			<button type="button" id="approveButton" class="btn btn-outline-primary m-2" style="float: right;" ${disabled}>승인</button>
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
		                    <button class="move-right2">&gt;&gt;</button>
		                    <button class="move-left2">&lt;&lt;</button>
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

	<!-- 반려모달 --> 	
       <div class="modal_bgrd2" style="display: none;">
		    <div class="mgmodal2">
		        <!-- 모달 내용 -->
		        <div class="form-floating box-content">
		            <input class="form-control" placeholder="반려 사유 입력" id="rejectStatus" 
		            value ="${signVO.rejectStatus}"
		            style="height: 150px;">
		            <label for="floatingTextarea">반려 사유 입력</label>
		        </div>
		        <!-- 버튼 영역 -->
		        <div class="modal-buttons">
		            <button type="button" class="btn btn-dark m-2" id="retractButton">확인</button>
		            <button type="button" class="btn btn-warning m-2" id="delretract">취소</button>
		        </div>
		    </div>
		</div>

		<script type="text/javascript">
		
		
		
		// [2] : 반려 버튼 클릭 시 이미지 URL을 넣는 함수***
	    document.getElementById('#retractButton').addEventListener('click', function() {
	        // 이미지 URL (실제 URL로 교체해야 합니다)
	        //{docNo}, {appTypeId}
			let docNo = "${signVO.docNo}";
			let appTypeId = 1;
	    });
		
		
		let currentDeptName = ''; // 전역 변수로 부서명 저장
		 //부서 클릭 시 해당 직원 보이게 하기
		   function signLines(deptName,keyword=""){
			if(!currentDeptName){ // 만약 부서명이 없으면
				currentDeptName = deptName; // 부서명을 저장
			}
			
			   let data = { deptName: deptName, keyword: keyword }; 
			   console.log("체킁signLines",data);
			   
			$.ajax({
				url: '/memberSign/signLinePost', // 해당 부서 사원 정보 가져오기
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
                    `<li><input type="checkbox" class="signLine" value="\${signVO.empId}"> \${signVO.empId} \${signVO.empName} \${signVO.postName}</li>`
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
		
            signLines("","");
		</script> 	
<script type="text/javascript">

//기안 폼
$(function() {
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
    console.log("formattedDate : ", formattedDate);

    // writeDate input에 현재 날짜 넣기
    $("#writeDate").val(formattedDate);
    
    
	// [1] : 승인 버튼 클릭 시 이미지 URL을 넣는 함수***
    $("#approveButton").on("click",function(){
    	
    	console.log("개동이");
    	// 이미지 URL (실제 URL로 교체해야 합니다)
        //{docNo}, {appTypeId}
		let docNo = $("#docNo").val();
		let appTypeId = 2;
		   
	   let data = {
			"docNo":docNo,
			"appTypeId":appTypeId,
	   }
	   //data{"docNo":10,"appTypeId":2}
	   console.log("승인 data : ", data);
	   
	   $.ajax({
		   url:"/memberSign/approvalPost",
		   contentType:"application/json;charset=utf-8",
	    	   data:JSON.stringify(data),
	    	   type:"POST",
	    	   success:function(signVO){
	    		   //result : signVO{docNo=10,appTypeId=2,empId=20241226123,fileSaveLocate=이미지경로}
	    		   console.log("signVO:",signVO);
	    		   
	    		   let str = "<img src='"+signVO.fileSaveLocate+"' style='height: 80px;width:110px;' />";
	    		   
	    		   //승인완료
	    		   $("#td"+signVO.empId).html(str);
	    		   
	    		   //승인/반려 버튼 비활성화
	    		   $("#retractButton2").css("display","none");  // 버튼을 숨깁니다
	    		   $("#approveButton").css("display","none");
      		}
	   });
    });
	
    //반려
	   $("#retractButton").on("click",function(){
		   $("#retractButton2").css("display","none");  // 버튼을 숨깁니다
		   console.log("반려??????");
		   let docNo = $("#docNo").val();
		   let appTypeId = 1; //반려
		   let rejectStatus = $("#rejectStatus").val();
		   
		   let data = {
				"docNo" : docNo,
				"appTypeId":appTypeId,
				"rejectStatus":rejectStatus
		   }
		   console.log("반려 data : ", data);
		   
		   $.ajax({
			   url:"/memberSign/retract",
			   contentType:"application/json;charset=utf-8",
    	    	   data:JSON.stringify(data),
    	    	   type:"POST",
    	    	   success:function(result){
    	    		   console.log("result:",result);
    	    		   
 	    			  console.log("체킁체킁","#td" + result.empId);

 	    			 $(".approval-cell").html("X");
    	    		   //반려
    	    		   if(result.resultCode==200){
    	    			  /*  alert(result.resultMessage); */
    		    		   
    		    		   $("#retractButton2").css("display","none");  // 버튼을 숨깁니다
    		    		   $("#approveButton").css("display","none");  // 버튼을 숨깁니다
    		    		   $(".modal_bgrd2").css("display", "none");
    	    			   
    	    			   location.href="/memberSign/retractDetail?appGroupCode="+appGroupCode;
    	    			   
    	    		   }else{
   	    				alert(result.resultMessage);
    	    	   	}
             }
		   });
	   });
   
      //결재선 버튼 클릭
      $("#prev").on("click",function(){
         $(".modal_bgrd").css("display","block");
         var imgSrc = $(".imgFileSaveLocate").attr("src");
      });
     
     // 모달 닫기 버튼 클릭 시 모달 닫기
     $("#delmodal").on("click", function() {
         $(".modal_bgrd").css("display", "none"); // 모달 숨기기
     });
     
	   
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
});//end 달러function

	//반려 모달 창 열기
	$("#retractButton2").on("click",function(){
		$(".modal_bgrd2").css("display","block");
		
	})
	// 모달 닫기 버튼 클릭 시 모달 닫기
	 	$("#delretract").on("click", function() {
	     $(".modal_bgrd2").css("display", "none"); // 모달 숨기기
	 });
</script>
 
 

    <script src="/dash/lib/easing/easing.min.js"></script>
    <script src="/dash/lib/waypoints/waypoints.min.js"></script>
    <script src="/dash/lib/chart/owlcarousel/owl.carousel.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/moment.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>
<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
    <!-- Template Javascript -->
    <script src="/dash/js/main.js"></script>
<!-- ///// footer 시작 ///// -->
 <jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->