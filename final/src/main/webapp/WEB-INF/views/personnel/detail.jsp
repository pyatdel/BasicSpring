<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
   
<style>
.image-preview-box {
    width: 300px; /* 네모 칸의 너비 */
    height: 300px; /* 네모 칸의 높이 */
    border: 2px solid #ccc; /* 테두리 */
    border-radius: 10px; /* 둥근 모서리 */
    overflow: hidden; /* 이미지가 칸을 벗어나지 않게 */
    display: flex; /* 이미지 정렬 */
    justify-content: center; /* 이미지 중앙 정렬 */
    align-items: center; /* 이미지 중앙 정렬 */
    background-color: #f9f9f9; /* 배경 색상 */
}
.image-preview-box img {
    max-width: 100%; /* 칸 안에 이미지를 맞춤 */
    max-height: 100%; /* 칸 안에 이미지를 맞춤 */
    object-fit: contain; /* 이미지 비율 유지하며 칸 안에 맞춤 */
}
 .content, .footerFlex {
    height: 120% !important;
}
.greenBt{
background-color: #278986;
color:white;
outline: none;
border:none;
width: 70px;
height:36px; 
border-radius: 5px;
}
</style>

 <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />


<!--body 시작  -->
<!-- 헤더 include  -->
   <jsp:include page="../include/managerHeader.jsp"></jsp:include>
<!-- 헤더 include  -->
<!--body 시작  -->
 	
	<div class="bg-light rounded p-4 shadow-sm" style="max-width: 1300px; margin: 5px auto; border: 1px solid; height: 123vh;">
       <h6 class="mb-4">직원 수정</h6>
         <form id="frm" action="/personnel/updatePost" method="post">
          <div class="mb-3">
              <label for="exampleInputPassword1" class="form-label">사번</label>
              <input type="text" class="form-control" value="${employeeVO.empId}" id="empId"
              placeholder="사번를 입력해주세요" autocomplete="username" readonly>
          </div>
          <div class="mb-3">
              <label for="exampleInputPassword1" class="form-label">비밀번호</label>
              <input type="password" class="form-control" value="${employeeVO.empPw}" id="empPw"
              placeholder="비밀번호를 입력해주세요" autocomplete="current-password" readonly>
          </div>
           <div class="mb-3">
              <label for="exampleInputPassword1" class="form-label">이름</label>
              <input type="text" class="form-control" value="${employeeVO.empName}" id="empName"
              placeholder="이름를 입력해주세요" readonly>
          </div>
        <div class="mb-3">
           <label for="exampleInputPassword1" class="form-label" readonly>부서</label>
	           <select class="form-control" id="deptName" name="deptName" disabled>
	           	<!-- forwarding : model.addAttribute("departmentVOList", departmentVOList); 
	           	departmentVOList[DepartmentVO(deptNo=1, deptName=인사부), DepartmentVO(deptNo=2, deptName=영업부), DepartmentVO(deptNo=3, deptName=개발부), DepartmentVO(deptNo=4, deptName=행정부), DepartmentVO(deptNo=5, deptName=회계부)]
	           	-->
	           	<c:forEach var="departmentVO" items="${departmentVOList}">
	           		<option value="${departmentVO.deptNo}" 
	           			<c:if test="${departmentVO.deptNo eq employeeVO.deptNo}">selected</c:if>
	           		>
	           			${departmentVO.deptName}
	           		</option>
	           	</c:forEach>
               </select>
                   <%--  <input type="text" class="form-control" value="${departmentVO.deptName}" id="deptName" --%>
                </div>
                   <div class="mb-3">
                      <label for="exampleInputPassword1" class="form-label">직급</label>
                      <select class="form-control" id="postName" name="postName" disabled>
                      	<!-- forwarding : model.addAttribute("positionVOList", positionVOList); -->
                      	<c:forEach var="positionVO" items="${positionVOList}">
                      		<option value="${positionVO.postNo}" 
                      			<c:if test="${positionVO.postNo == employeeVO.postNo}">selected</c:if>
                      		>
                      			${positionVO.postName}
                      		</option>
                      	</c:forEach>
                      </select>
                      <%-- <input type="text" class="form-control" value="${positionVO.postName}" id="postName"
                      placeholder="직급을 입력해주세요"> --%>
                  </div>
                    <div class="mb-3">
                       <label for="exampleInputPassword1" class="form-label">연락처</label>
                       <input type="text" class="form-control" value="${employeeVO.empPhone}" id="empPhone"
                       placeholder="번호를 입력해주세요" readonly>
                   </div>
                   <div class="mb-3">
                       <label for="exampleInputEmail1" class="form-label">이메일</label>
                       <input type="email" class="form-control" value="${employeeVO.empEmail}" id="empEmail" aria-describedby="emailHelp"
                       placeholder="이메일을 입력해주세요" readonly>
                   </div>
                    <div class="mb-3">
                       <label for="formFile" class="form-label">전자 서명 등록</label>
                       <input class="form-control" type="file" id="empSign" value="${employeeVO.empSign}">
                   </div>
	              <div>
				    <table>
				        <tr>
				            <td>
				                <div id="divImage" class="image-preview-box">
				                	<img id="updateImage" 
				                	src="${employeeVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" />
				                </div>
				            </td>
				        </tr>
				    </table>    
				</div>
                  <!-- 일반모드 시작 -->
                  <span id="spn1" class="justify-between">
		              <p style="float:right;">
		                <button type="button" id="edit"  
		                   class="btn btn-primary btn-user" 
		                   style="float:left;">수정</button>&nbsp;
		                <button type="button" id="delete"  
		                         class="btn btn-primary btn-user">삭제</button>
		               </p>
		               <p style="float:left;">
		                <button  onclick="location.href='/personnel/list'" type="button" class="greenBt">
		                       목록
		                </button>
		               </p>
		           </span>
		            <!-- 일반모드 끝 -->
		            <!-- 수정모드 시작 -->
		           <span id="spn2" class="justify-between" style="display:none;">
		            <span style="float:left;">
		               <button  type="button" id="edit2" class="btn btn-primary btn-user">
		                     확인
		               </button>
		            </span>
		            <span style="float:right;">
		               <a href="/personnel/detail?empId=${param.empId}" 
		                  class="btn btn-success btn-user">
		                      취소
		               </a>
		            </span>
		           </span>
        						<!-- 수정모드 끝 -->
                         </form>
                     </div>
            <script type="text/javascript">
                  //이미지 미리보기 기능
               $(document).ready(function(){
              	 
            	   $("#empSign").on("change",function(event){
            		   let file = event.target.files[0]; //첫 번째 파일 가져오기
            		   
            		   if(!file) return; // 파일 선택 x 종료
            		   
            		   //이미지 파일인지 확인
            		   if(!file.type.match("image.*")){
            			   alert("이미지 파일만 업로드 가능합니다.");
            			   return;
            		   }
            		   let reader = new FileReader();
            		   
            		   reader.onload = function(e){
            			   $("#updateImage").attr("src",e.target.result);
            		   };
            		   reader.readAsDataURL(file);
            		   
            	   		}
					)
            	    });
            	 //이미지 미리 보기 끝   
                    
                    	//수정버튼
                    	$("#edit").on("click",function(){
                    		//수정 영역 가려짐
                    		$("#spn1").css("display","none");
                    		//일반 영역 보임
                    		$("#spn2").css("display","block");
                    		
                    		//1)입력란 활성화 form-control
                    		$(".form-control").removeAttr("readonly");
                    		$(".form-control").removeAttr("disabled");
                    		
                    		$("#empId").attr("readonly",true);
                    		
                    		/* EMP_ID, EMP_NAME, DEPT_NO, POST_NO, EMP_PHONE, EMP_EMAIL */
                    		let empId = $("#empId").val();
                    		let empName = $("#empName").val();
                    		let deptNo = $("#deptName").val();//없음
                    		let postNo = $("#postName").val();//principal에서 옴. 단 J/S에서는 ""로 묶자
                    		let empPhone = $("#empPhone").val();
                    		let empEmail = $("#empEmail").val();
                    		
                   		 	let data = {
                   		    		"empId":empId,
                   		    		"empName":empName,
                   		    		"deptNo":deptNo,
                   		    		"postNo":postNo,
                   		    		"empPhone":empPhone,
                   		    		"empEmail":empEmail,
                   		    }
                   		 	//비동기(수정버튼 클릭 시)
                   		 	/*JSONString {"empId": "20241224005","empName": "양2강","deptNo": "2","postNo": "2","empPhone": "010-5555-2722","empEmail": "test2@test.com"}
                    		*/
                   			console.log("data(수정버튼 클릭 시) : ", data);
                   		 	
                    		
                   	});
					
                    	//2. 확인 버튼 클릭 시 비동기 insert
                    	$("#edit2").on("click",function(){
                    		//수정 영역 가려짐
                    		$("#spn1").css("display","block");
                    		//일반 영역 보임
                    		$("#spn2").css("display","none");
                    		
                    		//1)입력란 활성화 form-control
                    		$(".form-control").removeAttr("disabled");
                    		$(".form-control").removeAttr("readonly");
                    		
                    		$("#empId").attr("readonly",true);
                    		let formData = new FormData();
                   			console.log("formData(담기 전) : ", formData);
                    		
                    		/* EMP_ID, EMP_NAME, DEPT_NO, POST_NO, EMP_PHONE, EMP_EMAIL */
                    		let empId = $("#empId").val();
                    		let empName = $("#empName").val();
                    		let deptNo = $("#deptName").val();//없음
                    		let postNo = $("#postName").val();//principal에서 옴. 단 J/S에서는 ""로 묶자
                    		let empPhone = $("#empPhone").val();
                    		let empEmail = $("#empEmail").val();
                    		console.log("체킁 : ", empId);
                    		console.log("체킁 : ", empEmail);
                    		
                    		// ajax 요청을 비동기적으로 서버에 전송 (새로고침 않고 제출 응답 받게 해줌)
                       		formData.append("empId",empId);
                       		formData.append("empPw",empPw);
                       		formData.append("empName",empName);
                       		formData.append("deptNo",deptNo);
                       		formData.append("postNo",postNo);
                       		formData.append("empPhone",empPhone);
                       		formData.append("empEmail",empEmail);
                       		/* formData.append("empSign",empSign); */
                       		

                   			console.log("formData(등록버튼 클릭 시) : ", formData);
                      		 	
                      		 	let inputFile = document.getElementById("empSign");
                      		 	let files = inputFile.files;
                      		 	for(let i = 0; i<files.length; i++){
                      		 		formData.append("uploadFile",files[i]);
                      		 	}
                   		 	
                   		 	$.ajax({
	                   		 	url:"/personnel/updatePostAjax",
	                   		 	processData:false,
		               			contentType:false,
	                	    	data:formData,
	                	    	type:"post",
	                	    	dataType:"text",
	                	    	success:function(result){
	                	    		//return result : 1(업뎃 성공) or 0(업뎃 실패)
	                	    		console.log("result : ", result);
	                	    		
	                	    		//수정
	                	    		if(result==1){//업뎃 성공
	                	    			location.href="/personnel/detail?empId="+empId;
	                	    		}
								},
							});
                    		
                    	});
                    	
                    	
                    	//회원 삭제
                    	$("#delete").on("click",function(){
                    		
                    		
							let empId = $("#empId").val();
                    		
                    		
                   		 	let data = {
                   		    		"empId":empId,
                   		    		
                   		    }
							console.log("삭제 data : ",data);

							$.ajax({
	                   		 	url:"/personnel/deletePostAjax",
	                	    	contentType:"application/json;charset=utf-8",
	                	    	data:JSON.stringify(data),
	                	    	type:"put",
	                	    	dataType:"text",
	                	    	success:function(result){
	                	    		//return result : 1(업뎃 성공) or 0(업뎃 실패)
	                	    		console.log("result : ", result);
	                	    		
	                	    		//삭제
	                	    		if(result==1){//업뎃 성공
	                	    			location.href="/personnel/list";
	                	    		}
										/* alert("삭제 실패"); */
								}
							});
                    	});
                    </script>    
                        
                        
                        
                
 
    <!-- ///// footer 시작 ///// -->
	 <jsp:include page="../include/managerFooter.jsp"></jsp:include>
	<!-- ///// footer 끝 ///// -->  
    <script src="/dash/lib/easing/easing.min.js"></script>
    <script src="/dash/lib/waypoints/waypoints.min.js"></script>
    <script src="/dash/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/moment.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>
	<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
    <!-- Template Javascript -->
    <script src="/dash/js/main.js"></script>


