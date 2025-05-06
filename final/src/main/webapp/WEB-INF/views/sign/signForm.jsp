<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
    width: 80% !important;
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
    width: 15%;
    margin: 0 10px;
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
    margin-top: 20px;
    background-color: #f9f9f9; /* 결재선 배경색 */
    max-height: 300px;
    overflow-y: auto; /* 내용이 많을 경우 스크롤 */
}
.list-section {
    margin: 0 10px;
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
    margin-top: 350px;
    max-height: 300px;
    overflow-y: auto;
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
            <h6 class="mb-4">승인함????</h6>
            
            <button type="button" class="btn btn-outline-success m-2" style="float: right;" id="prev">결재선</button>
            
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th scope="col">기안자</th>
                        <th scope="col">과장</th>
                        <th scope="col">팀장</th>
                        <th scope="col">부장</th>
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
                    </tr>
                </tbody>
            </table>

			<div class="input-group mb-3">
                <span class="input-group-text" id="basic-addon3">기안자</span>
                <input type="text" class="form-control" id="basic-url" aria-describedby="basic-addon3">
                <span class="input-group-text" id="basic-addon3">부서</span>
                <input type="text" class="form-control" id="basic-url" aria-describedby="basic-addon3">
            </div>
			<div class="input-group mb-3">
                <span class="input-group-text" id="basic-addon3">기안일</span>
                <input type="text" class="form-control" id="basic-url" aria-describedby="basic-addon3">
                <span class="input-group-text" id="basic-addon3">직급</span>
                <input type="text" class="form-control" id="basic-url" aria-describedby="basic-addon3">
            </div>
			<select class="form-select form-select-sm mb-3" aria-label=".form-select-sm example">
                 <option selected="">결재종류</option>
                 <option value="1">계약서</option>
                 <option value="2">지출결의서</option>
                 <option value="3">품의서</option>
             </select>
           
             <div class="form-floating mb-3">
                <input type="text" class="form-control" id="floatingPassword" placeholder="text">
                <label for="floatingPassword">제목</label>
            </div>
            <div class="form-floating">
                <textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea" style="height: 500px;"></textarea>
                <label for="floatingTextarea">내용</label>
            </div>
            
            <div>
 			<input class="form-control form-control-sm" id="formFileSm" type="file">
 			</div>
 			
 			<button type="button" class="btn btn-outline-dark m-2" style="float: right;">취소</button>
 			<button type="button" class="btn btn-outline-primary m-2" style="float: right;">등록</button>
        </div>			
 	
 	<!-- 모달 --> 	
          <div class="modal_bgrd" style="display: none;">
			    <div class="mgmodal">
			   <%--  <p>부서명: ${signVO.deptName}</p>
    			<p>결재자: ${signVO.approver}</p> --%>
			        <button class="btn btn-sm" id="delmodal"><i class="fa fa-times"></i></button>
					        <div class="left-menu">
					            <ul>
					        <%-- <c:forEach var="signVO" items="${approval}">
					                <li>${signVO.deptName}</li>
					        </c:forEach>     --%>
					            </ul>
					        </div>
					        <div class="main-content">
					            <div class="select-box">
					                <div class="list-section">
					                    <ul>
					                    <%-- <c:forEach var="signVO" items="${approval}">
					                        <li><input type="checkbox"> ${signVO.empId}, ${signVO.empName}, ${signVO.postName}</li>
					                     </c:forEach> --%>   
					                    </ul>
					                </div>
					                <div class="buttons">
					                    <button>&gt;</button>
					                    <!-- <button>&gt;&gt;</button>
					                    <button>&lt;&lt;</button> -->
					                    <button>&lt;</button>
					                </div>
					                <div class="approval-section">
					                    <h3>결재선</h3>
					                    <ul>
					                        <li><input type="checkbox"> 23081625 최강사 강사 운영팀</li>
					                        <li><input type="checkbox"> 23072817 장행정 팀장 행정팀</li>
					                        <li><input type="checkbox"> 23072819 김구디 사원 행정팀</li>
					                    </ul>
					                </div>
					                <div class="reference-section" >
					                    <h3>참조선</h3>
					                    <ul>
					                        <li><input type="checkbox"> 23072710 김사원 팀장 행정팀</li>
					                        <li><input type="checkbox"> 23081730 차은우 팀장 홍보1팀</li>
					                    </ul>
					                </div>
					            </div>
					        </div>

                  	</div>
			</div>
		<script>
		 /* 모달 */
		
		   $(function() {
		      //결재선 버튼 클릭
		      $("#prev").on("click",function(){
		         $(".modal_bgrd").css("display","block");
		         var imgSrc = $(".imgFileSaveLocate").attr("src");
		      });
		         
		         // 모달 닫기 버튼 클릭 시 모달 닫기
		         $("#delmodal").on("click", function() {
		             $(".modal_bgrd").css("display", "none"); // 모달 숨기기
		         });
		         
		      });
		
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


