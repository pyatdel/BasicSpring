<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
th,td{
	width: 14.28%; /* 7개의 열이므로 각 열의 비율을 1/7로 설정 */
       text-align: center;
       border: 1px solid black;
}
tr {
    flex-direction: row;
}

td {
    height: 100px; /* 셀의 높이를 지정하여 정사각형으로 만듬 */
    width: 100px; /* 셀의 너비를 지정하여 정사각형으로 만듬 */
}
 .mgmodal {
    background-color: white;
    z-index: 100;
    width: 45% !important;
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
 background-color: rgba(0, 0, 0, 0.555);
top:0;
left: 0;
right: 0;
bottom: 0;

}
.delmodal{
position: absolute;
z-index:  9999;
font-size: 50px;
font-weight: normal;
cursor: pointer;

}

.left-menu {
    width: 25%;
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
}
.list-section {
    margin: 8 10px;
    border: 1px solid #ccc;
    border-radius: 5px; /* 모서리 둥글게 */
    padding: 10px;
    width: 25%;
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
    flex-direction: column; /* 수직 */
    align-items: center;
    margin: 5px 0;
}
/* 결재선 버튼 사이즈 */
.buttons button {
    margin: 0 5px;
    padding: 5px 10px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 3px;
    cursor: pointer;
}
.buttons button:hover {
    background-color: #0056b3;
}
.apvbtn{
text-align: center !important;
margin-top:20px;
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
    margin-top: 20px;
}

.search-results {
    margin-top: 10px;
}
.search{
width: 130px; /* 입력창의 가로 크기 */
height: 25px; /* 입력창의 세로 크기 */
}
.signList {
    max-height: 500px; /* 최대 높이를 설정하여 영역을 제한 */
    overflow-y: auto;  /* 세로 방향으로만 스크롤바 표시 */
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
     }

  .mgmodal2 {
  background-color: white;
  z-index: 100;
  width: 40% !important;
  height: 40%;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  border: 1px solid gray;
  border-radius: 20px;
    }
  #modalInput{
   width: 80% !important;
 	height: 80% !important;
 	align-items: center !important;
 	justify-content: center !important;
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


	<div class="bg-light rounded h-100 p-4">
      <h6 class="mb-4">기안 자세히 보기</h6>
		<form id="frm" action="/sign/retract" method="post">
            <input value="${signVO.docNo}" id="docNo" hidden >
            <button type="button" class="btn btn-outline-success m-2" style="float: right;" id="prev">결재선</button>
            
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th scope="col">기안자</th>
                        <th scope="col">과장</th>
                        <th scope="col">팀장</th>
                        <th scope="col">부장</th>
                        <th scope="col">이사장</th>
                        <th scope="col">이사장</th>
                    </tr>
                    
                    
                </thead>
                <tbody>
                    <tr>
                        <td>도장</td>
                        <td>2</td>
                        <td>3</td>
                        <td>4</td>
                        <td>5</td>
                        <td>6</td>
                    </tr>
                </tbody>
            </table>
			
			<div class="input-group mb-3">
                <span class="input-group-text" id="basic-addon3">기안자</span>
                <input type="text" class="form-control" id="empName" aria-describedby="basic-addon3"
                value="${signVO.empName}" readonly>
                <span class="input-group-text" id="basic-addon3">부서</span>
                <input type="text" class="form-control" id="deptName" aria-describedby="basic-addon3"
                value="${signVO.deptName}" readonly>
            </div>
			<div class="input-group mb-3">
                <span class="input-group-text" id="basic-addon3">기안일</span>
                <input type="text" class="form-control" id="writeDate" aria-describedby="basic-addon3"
                value="${signVO.writeDate}" readonly>
                <span class="input-group-text" id="basic-addon3">직급</span>
                <input type="text" class="form-control" id="postName" aria-describedby="basic-addon3"
                value="${signVO.postName}" readonly>
            </div>
			<select class="form-select form-select-sm mb-3" aria-label=".form-select-sm example">
                 <option value="${signVO.appDocName}" selected disabled>${signVO.appDocName}</option>
             </select>
           
             <div class="form-floating mb-3">
                <input type="text" class="form-control" id="floatingPassword" placeholder="text"
                value="${signVO.docTitle}" readonly>
                <label for="floatingPassword" onclick="event.preventDefault();" ></label>
            </div>
            <div class="form-floating">
                <input class="form-control" placeholder="Leave a comment here" id="floatingTextarea" style="height: 500px;"
                value="${signVO.docContent}" readonly>
                <label for="floatingTextarea" onclick="event.preventDefault();" ></label>
            </div>
            
            <div>
 			<input class="form-control form-control-sm" id="formFileSm" type="file">
 			</div>
 			
 			<button type="button" class="btn btn-outline-dark m-2" style="float: left;">
 			<a href="/sign/signList">목록</a></button>
 			<button type="button" class="btn btn-outline-danger m-2" style="float: right;" id="retract">반려</button>
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
			                    <h3>공람/열람</h3>
			                    <ul>
			                    
			                    </ul>
			                </div>
			                
		                <div class="apvbtn">
		                	<button type="button" id="delmodal" class="btn btn-secondary" data-bs-dismiss="modal_bgrd">닫기</button>
		                	<button type="button" class="btn btn-primary">등록</button>
		                </div>
		                </div>
		            </div>
		        </div>

           	</div>
		</div>



		<script type="text/javascript">
		
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
				},
				error: function(xhr, status,error){
					alert('사원 정보 불러오는 데 실패했습니다.')
				}
				// 부서 클릭 시
				/* function deptClick(deptName) {
		    	signLines(deptName, '');  */ // 초기 검색어 없이 부서명만 보냄
				
				
			}); 
			   
		   }//end signLines 
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
	            //공람/열람
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
	            item.checked = false;
	            
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
	            item.checked = false;
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
		
		
		   $(function() {
			   //반려
			   $("#retract").on("click",function(){
				 
				   let docNo = $("#docNo").val();
				   
				   let data = {
						"docNo" : docNo
				   }
				   console.log("반려 data : ", data);
				   
				   $.ajax({
					   url:"/sign/retract",
					   contentType:"application/json;charset=utf-8",
           	    	   data:JSON.stringify(data),
           	    	   type:"POST",
           	    	   success:function(result){
           	    		   console.log("result:",result);
           	    		   
           	    		   //반려
           	    		   if(result.resultCode==200){
           	    			   alert(result.resultMessage);
           	    			   location.href="http://localhost:8020/sign/signList";
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
		         
		      });// end
		
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
 <jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->