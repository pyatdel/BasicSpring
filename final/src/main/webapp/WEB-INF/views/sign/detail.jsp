<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<!-- 토글 -->
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
    

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.5.0/dist/sweetalert2.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.5.0/dist/sweetalert2.min.css" rel="stylesheet">
<!-- 
../ : views폴더(부모)
 -->
   <!--  <meta charset="utf-8">
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

#frm {
    width: 100%;
    max-width: 800px;
    margin: 0 auto;
    display: block;
    white-space: normal; /* 띄어쓰기 정상 처리 */
    word-break: break-word; /* 긴 단어 줄바꿈 */
}

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
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.6);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 9999;
}

.mgmodal2 {
    background-color: white;
    z-index: 100;
    width: 25%;
    height: 40%;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    border: 1px solid gray;
    border-radius: 10px;
    padding: 20px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

.form-floating {
    margin-bottom: 20px;
}

textarea {
    width: 100%;
    height: 150px;
    padding: 10px;
    border-radius: 5px;
    border: 1px solid #ccc;
    resize: none;
}

label {
    margin-top: -10px;
    font-size: 14px;
}

.modal-buttons {
    display: flex;
    justify-content: flex-end;
}

.modal-buttons button {
    margin-left: 10px;
}

.modal-buttons button:first-child {
    margin-left: 0;
}
.mnsignSub{
display: block !important;
height: auto !important;
}
</style>
    
    <!-- 헤더 include  -->
   <jsp:include page="../include/managerHeader.jsp"></jsp:include>
<!-- 헤더 include  -->
    


	<div class="bg-light rounded h-100 p-4" id="signForm">
		<form id="frm" action="/sign/createFormPost" method="post">
			<input value="${signVO.empNo}" id="empNo" hidden >
			<input value="${signVO.empId}" id="empId" hidden >
            <input value="${signVO.docNo}" id="docNo" hidden >
            <!-- 결재선 생각할 때 보기  -->
            <div id="appproveList">
            	<input type="hidden" name="app_list_codes" values="${appListCode}"/>
            	<input type="hidden" name="reapp_emp_ids" values="${reappEmpId}"/>
            	<input type="hidden" name="app_orders" values="${appOrder}"/>
            	
            </div>
            <input type="hidden" name="appGroupCode" value="${signVO.appGroupCode}"/>
           <%--  <p>appGroupCode: ${signVO.appGroupCode}</p>
            <p>docNo: ${signVO.docNo}</p> --%>
<!--             <button  -->
<!-- 		        type="button"  -->
<!-- 		        class="btn btn-outline-success m-2"  -->
<!-- 		        style="margin-bottom: 10px;float:left;"  -->
<!-- 		        id="prev"> -->
<!-- 		        결재선 -->
<!-- 		    </button> -->
		    <input type="text" class="border-0" value="${signVO.appDocName}" style="border: white; outline: none; background: transparent; border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;
				 font-size: 30px; font-weight: bold; color: #333;" readonly>
            <div  style="float: right;" id="divTables">
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
<!--             <div class="input-group mb-3"> -->
<%-- 			    <input type="text" class="border-0" value="${signVO.appDocName}" style="border: white; outline: none; background: transparent; border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px; --%>
<!-- 				 font-size: 30px; font-weight: bold; color: #333;" readonly> -->
<!-- 			</div> -->
			<div class="input-group mb-3">
                 <span class="input-group-text" id="basic-addon3">참조</span>
                 <c:forEach var="appLineList2" items="${appLineList2}" >
                 <input type="text" class="form-control" id="basic-url" aria-describedby="basic-addon3"  value="${appLineList2.empName}${appLineList2.postName}" style="background-color : #fff" readonly>
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
			<select class="form-select form-select-sm mb-3" aria-label=".form-select-sm example" id="appDocName" style="background-color : #fff" disabled >
			 <option value="" selected disabled>${signVO.appDocName}</option> <!-- 첫 번째 옵션 -->
				<c:forEach var="signVO" items="${signVOList}">
                 <option value="${signVO.appDocName}">${signVO.appDocName}</option>
                </c:forEach> 
             </select>
           
             <div class="form-floating mb-3">
                <div id="docTitle" class="form-control"
			         style="color:#757575; height: 30px; background-color: #fff;
			                border: 1px solid #ced4da; padding: 5px;">
			        ${signVO.docTitle}
			    </div>
    	<label for="floatingInput" onclick="event.preventDefault();" ></label>
            </div>
            <div class="form-floating">
                <div  class="form-control" placeholder="Leave a comment here" id="docContent" style="height: 300px; background-color : #fff; white-space: pre-wrap;  border: 1px solid #ced4da; padding: 10px;""
                 placeholder="내용 입력"  disabled >${signVO.docContent}</div>
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
 			<a href="/sign/signHome">목록</a></button>
 			<c:if test="${finalCheckStatus==1}">
 				<c:set var="disabled" value="disabled" />
 			</c:if>
 			<button type="button" id="retractButton2" class="btn btn-outline-danger m-2 retractButton" style="float: right;" ${disabled}>반려</button>
 			<button type="button" id="approveButton" class="btn btn-outline-primary m-2" style="float: right;" ${disabled}>승인</button>
 			<button type="button" id="approveButton3" onclick="downloadPDF()" class="btn btn-outline-success m-2" style="float: right;">저장</button>
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
		    	<h5>반려 사유</h5>
		        <!-- 모달 내용 -->
		        <div class="form-floating box-content">
		            <input class="form-control" placeholder="반려 사유 입력" id="rejectStatus" 
		            value ="${signVO.rejectStatus}"
		            style="height: 220px;">
		            <label for="floatingTextarea">반려 사유 입력</label>
		        </div>
		        <!-- 버튼 영역 -->
		        <div class="modal-buttons">
		            <button type="button" class="btn btn-warning m-2" id="delretract">취소</button>
		            <button type="button" class="btn btn-dark m-2" id="retractButton">확인</button>
		        </div>
		    </div>
		     <jsp:include page="../include/managerFooter.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  
 
		</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
		<script type="text/javascript">
		
		// PDF 다운로드
	    function downloadPDF() {
		    const activeTab = document.querySelector("#signForm");
		    const docContent = document.querySelector("#docContent");
		    const buttons = activeTab.querySelectorAll("button"); // 버튼 전체 선택
		
		    
		  // 버튼 숨기기
		    buttons.forEach(btn => btn.style.display = "none");
		    
		 	// textarea 내용을 div에 복사
		    if (docContent) {
// 		        const textValue = docContent.value.replace(/\n/g, "<br>"); // 줄바꿈을 <br>로 변환
// 		        const tempDiv = document.createElement("div");
// 		        tempDiv.innerHTML = textValue;
		        docContent.style.border = "1px solid #ced4da"; // 테두리 유지
		        docContent.style.padding = "10px"; // 내부 여백 추가
		        docContent.style.whiteSpace = "pre-wrap"; // 줄바꿈 유지
		        docContent.style.wordBreak = "break-word"; // 긴 단어 줄바꿈
// 		        docContent.parentNode.replaceChild(tempDiv, docContent);
// 		        tempDiv.id = "docContent"; // id 유지
		    }
		    
		    if (activeTab) {
		        // 스타일 초기화
		        activeTab.style.transform = "none";
		        activeTab.style.position = "static";
		
		        html2pdf(activeTab, {
		            margin: 10,
		            filename: "결재승인문서.pdf",
		            html2canvas: { scale: 2, useCORS: true, letterRendering: true },
		            jsPDF: { unit: "mm", format: "a4", orientation: "portrait" }
		        }).save().then(() => {
		            // 원래 스타일로 복구
		            activeTab.style.transform = "";
		            activeTab.style.position = "";
		            //버튼 다시 보이게
		            buttons.forEach(btn => btn.style.display = "block");
		        });
		    } else {
		        console.error("태그를 찾을 수 없습니다.");
		    }
		}


	    // 버튼에 이벤트 리스너 추가
// 	    document.querySelector('.btn-primary').addEventListener('click', downloadPDF);
		
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
		   url:"/sign/approvalPost",
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
			   url:"/sign/retract",
			   contentType:"application/json;charset=utf-8",
    	    	   data:JSON.stringify(data),
    	    	   type:"POST",
    	    	   success:function(result){
    	    		   console.log("result:",result);
    	    		   
 	    			  console.log("체킁체킁","#td" + result.empId);

    	    		   //반려
    	    		   if(result.resultCode==200){
    	    			  /*  alert(result.resultMessage); */
    		    		   var Toast = Swal.mixin({
		          				toast: true, // 'toast' 모드를 활성화 (화면의 구석에 알림을 띄움)
		          				position: 'top-end',   // 알림을 화면의 상단 오른쪽 구석에 띄움
		          				showConfirmButton: false, // '확인' 버튼을 숨김
		          				timer: 3000
    		    		   });
    		    		   Toast.fire({
    		    			    icon: "success",
    		    			    title: "반려되었습니다.",
    		    			  });
    		    		   $("#retractButton2").css("display","none");  // 버튼을 숨깁니다
    		    		   $("#approveButton").css("display","none");  // 버튼을 숨깁니다
    		    		   $(".modal_bgrd2").css("display", "none");
    		    		   setTimeout(() => {
    	    			   location.href="/sign/signHome"
    		    		   }, 500);
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
