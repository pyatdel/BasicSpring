<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
 <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />


<!--body 시작  -->
<!-- 헤더 include  -->
   <jsp:include page="../include/managerHeader.jsp"></jsp:include>
<!-- 헤더 include  -->
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
.bluBt{
background-color: #3676EB;
color:white;
outline: none;
border:none;
width: 70px;
height:36px; 
border-radius: 5px;

}
</style>
<!--body 시작  -->
 	
	<div class="bg-light rounded p-4 shadow-sm" style="max-width: 1300px; margin: 0 auto; border: 1px solid;">
    <h5 class="mb-4 text-center">직원 등록</h5>
    <form id="frm" action="/personnel/updatePost" method="post">
        <div class="mb-3">
            <label for="empId" class="form-label">사원번호</label>
            <div class="input-group">
                <input type="text" class="form-control" id="empId" placeholder="사원번호를 입력해주세요 ex)20241231001" />
                <button type="button" id="btnIdDupChk" class="btn btn-outline-primary">사원번호 중복 체크</button>
            </div>
        </div>

        <div class="mb-3">
            <label for="empPw" class="form-label">비밀번호</label>
            <input type="password" class="form-control" id="empPw" placeholder="비밀번호를 입력해주세요">
        </div>

        <div class="mb-3">
            <label for="empName" class="form-label">이름</label>
            <input type="text" class="form-control" id="empName" placeholder="이름을 입력해주세요">
        </div>

        <div class="mb-3">
            <label for="deptName" class="form-label">부서</label>
            <select class="form-select" id="deptName" name="deptName">
                <c:forEach var="departmentVO" items="${departmentVOList}">
                    <option value="${departmentVO.deptNo}" 
                        <c:if test="${departmentVO.deptNo eq employeeVO.deptNo}">selected</c:if>>
                        ${departmentVO.deptName}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="mb-3">
            <label for="postName" class="form-label">직급</label>
            <select class="form-select" id="postName" name="postName">
                <c:forEach var="positionVO" items="${positionVOList}">
                    <option value="${positionVO.postNo}" 
                        <c:if test="${positionVO.postNo == employeeVO.postNo}">selected</c:if>>
                        ${positionVO.postName}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="mb-3">
            <label for="empPhone" class="form-label">연락처</label>
            <input type="text" class="form-control" id="empPhone" placeholder="번호를 입력해주세요">
        </div>

        <div class="mb-3">
            <label for="empEmail" class="form-label">이메일</label>
            <input type="email" class="form-control" id="empEmail" placeholder="이메일을 입력해주세요">
        </div>

        <div class="mb-3">
            <label for="empSign" class="form-label">전자 서명 등록</label>
            <input class="form-control" type="file" id="empSign" name="empSign" multiple />
        </div>

        <div class="mb-4">
            <label class="form-label">사진 미리보기</label>
            <div id="divImage" class="image-preview-box border border-dashed p-2" style="min-height: 120px;"></div>
        </div>

        <div class="d-flex justify-content-between">
            <button  onclick="location.href='/personnel/list'" type="button" class="greenBt">
                   목록
            </button>
            <button type="button" id="btnSubmit" class="bluBt" disabled>등록</button>
        </div>
    </form>
</div>

                
        <script type="text/javascript">
        //이미지 미리보기 기능
        $(document).ready(function(){
       	 
     	   $("#empSign").on("change",handleImg);
     	 if ($("#empSign").length > 0) {
     	    console.log("이벤트 연결 시작");
     	    $("#empSign").on("change", function() {
     	        console.log("이벤트가 정상적으로 호출됨");
     	    });
     	} else {
     	    console.error("#empSign 요소를 찾을 수 없습니다.");
     	}
     	   
     	   function handleImg(e){
     		   console.log("이미지 보일까?");
     		   let files = e.target.files;
     		   
     		   //이미지 오브젝트 배열
     		   let fileArr = Array.prototype.slice.call(files);
     		   
     		   //초기화
     		   $("#divImage").html("");
     		   
     		   fileArr.forEach(function(f){
     			   if(!f.type.match("image.*")){//
     					alert("이미지 확장자만 가능합니다.");
     			   return;
     			   }
     			   let reader = new FileReader();
     			   
     			   reader.onload = function(e){
     				   //e.target : 이미지 객체
     				   let img = "<img src ='"+e.target.result+"' style='width:80%;'/>";
     				   $("#divImage").append(img);
     			   }
     			   reader.readAsDataURL(f);
     		   })
     	   }
        }); //이미지 미리 보기 끝    
                  
                  
       $(function(){
       	//직원등록버튼
       	$("#btnSubmit").on("click",function(){
       		console.log("직원 등록 비동기 처리");
       		
       		//가상 폼
       		let formData = new FormData();
       		
       		/* EMP_ID, EMP_NAME, DEPT_NO, POST_NO, EMP_PHONE, EMP_EMAIL */
       		let empId = $("#empId").val();
       		let empPw = $("#empPw").val();
       		let empName = $("#empName").val();
       		let deptNo = $("#deptName").val();//없음
       		let postNo = $("#postName").val();//principal에서 옴. 단 J/S에서는 ""로 묶자
       		let empPhone = $("#empPhone").val();
       		let empEmail = $("#empEmail").val();
       		/* let empSign = $("#empSign").val(); */
       		
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
   		 	url:"/personnel/createPostAjax",
       		processData:false,
  			contentType:false,
   	    	data:formData,
   	    	type:"post",
   	    	dataType:"text",
   	    	success:function(result){
    		//return result : 1(업뎃 성공) or 0(업뎃 실패)
    		console.log("result : ", result);
	    		
    		//등록
    		if(result==1){//업뎃 성공
    			location.href="/personnel/detail?empId="+empId;
    		}
		}
	});
         		 	
        	});
          	
          	//사원번호 중복 체크
          	$("#btnIdDupChk").on("click",function(){
          		let empId = $.trim($("#empId").val());
          		console.log("empId : "+empId);
          		
          		/* <div class="alert alert-primary alert-dismissible fade show" role="alert">
                      <i class="fa fa-exclamation-circle me-2"></i>An icon &amp; dismissing primary alert—check it out!
                      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                  </div> */
          		if(empId==""){
          			var Toast = Swal.mixin({
          				toast: true, // 'toast' 모드를 활성화 (화면의 구석에 알림을 띄움)
          				position: 'top-end',   // 알림을 화면의 상단 오른쪽 구석에 띄움
          				showConfirmButton: false, // '확인' 버튼을 숨김
          				timer: 3000
          				});
          			
          			Toast.fire({
          				icon:'warning',
          				title:'사원번호를 입력해주세요'
          				});
          			
          			$("#empId").focus();
          			
          			return;
          		}
          		let data ={
          				"empId" : empId
          		}
          		console.log("data:",data);
          		
          		$.ajax({
          		url:"/personnel/idDupChk",
          		contentType:"application/json;charset=urf-8",
          		data:JSON.stringify(data),
          		type:"post",
          		dataType:"text",
          		success:function(result){
          			
          			if(result==1){
          				var Toast = Swal.mixin({
          					toast: true,
          					position:'top-end',
          					showConfirmButton : false,
          					timer:3000
          				})
          				Toast.fire({
          					icon:'warning',
          					title:"사원번호 중복"
          				});
          				
          				$("#empId").focus();
          				//등록 버튼 비활성화
          				$("#btnSubmit").attr("disabled",true);
          			}else{
          				var Toast = Swal.mixin({
          					toast: true,
          					position:'top-end',
          					showConfirmButton : false,
          					timer:3000 
			})
			Toast.fire({
				icon:'success',
				title:'사원번호 입력되었습니다.'
			});
			$("#btnSubmit").removeAttr("disabled");
	             			}
	             		}
	             	});
          		
             	})
             	
             });//end function
          
                
             
             
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


