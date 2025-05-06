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
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
    
    

 <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<style>
body{

}
* {
	margin: 0 ; 
	padding: 0 ; 
}
ul li {
margin:0;
padding:0 ; 
list-style: none;

}
h5, h6, h {
	padding-top: 10px;
	font-weight: normal !important;
	display: block !important;
	width: 100%;
}
h3{
	font-weight: normal !important;

}
h5{
height: 50px;
padding:15px;
}
.projcon {
	
}
.container-w {
	display: flex;
	width: 100%;
	flex-wrap: wrap;
	justify-content: center;
}

.container-w>div {
	width: 48%;
	height: 40vh;
	background-color :white;
	margin: 10px;
	border-radius: 20px;
	     box-shadow:0 2px 10px rgb(0 0 0 / 58%);
}

.table{
text-align: center;
}

h6{
padding:10px;

}
.tflex{
display: flex;
flex-direction: column;
}
.projcnt{
text-align: right;

}
h2{

font-weight: normal !important;
padding:20px;
color:#41424e !important;

}
.pj{
background-color: white !important;

}
.projNav{
display: flex
;
    margin: 0 !important;
    padding: 0 !important;
    justify-content: space-around;
    border: 1px solid gray;
    border-radius: 5px;
    height: 40px;
    align-items: center;
}
.projNav > li {
display:flex;
   height: 40px;
border-right: 1px solid gray;
width: 100%;
text-align: center;
margin:0 auto;
justify-content: center;
align-items: center;
    background-color: #e7efef;
}
.ulFlex{
list-style: none;
    display: flex;
    justify-content: space-between;
    padding: 0;
    width: 90%;
    margin: 0 auto;

}
.liDate{
    margin-left: 43%;

}
.liMagin{
margin:20px 10px 10px 10px;

}
.ulDisplay{
display: none;
}
.nav.active,.nav2.active2{
background-color: #3069CE !important;
color:white;
}
.fa-3x {
font-size: 2em !important;
padding-right:10px;
}
.table{
text-align: center;
}
tbody:hover{
background-color: #f1f1f1;

}
.telft{
text-align: left;
font-weight:bold;
cursor: pointer;
width: 200px;
}
.fa-solid{
padding:10px;
color:green;
font-size: 1.5em;
}
.fa-file-pdf{

color:#db5353;
}
.fa-file-zipper{
color:orange;
}
.icon{
color:#3069CE !important;
font-size: 1.5em;
margin-right: 18px;
}
.iconc{
margin-right: 28px;

}
.iconh{
margin-right: 26px;

}
.fa-download{
color:gray;

}
.fileHeader{
display: flex;
justify-content: space-between;

}
.mnsignSub{
display: block !important;
height: auto !important;
}
.projBtn{

background-color: #3069CE !important;

}
</style>

<!-- 메인 컨텐츠 영역 시작 -->
<%-- <p>${contractMasterVOList}</p> --%>
<!-- 헤더 include  -->
   <jsp:include page="../include/managerHeader.jsp"></jsp:include>
<!-- 헤더 include  -->

<div class="sign">
	<div class="container-w">
		<div class="">
			<h5><a href="/sign/signList">대기/요청함</a></h5>
		<ul class="projNav">
			<li class="projBtn nav active" data-nav="expected">
				대기함</li>
			<li class="projBtn nav " data-nav="inprogress">
				요청함</li>
		</ul>
			<div class="table-responsive" id="expected"ㅋ>
	             <table class="table table-hover">
	                 <thead>
	                     <tr>
	                         <th>번호</th>
	                         <th>제목</th>
	                         <th>기안자</th>
	                         <th>부서</th>
	                         <th>기안일</th>
	                     </tr>
	                 </thead>
	                 <tbody>
	                 	<c:forEach var="signVO" items="${signVOList1}" varStatus="stat">
	                      <tr>
	                         <td>${signVO.rnum}</td>
	                         <td><a href="/sign/detail?appGroupCode=${signVO.appGroupCode}">${signVO.docTitle}</a></td>
	                         <td>${signVO.originalEmpName}</td>
	                         <td>${signVO.originalDeptName}</td>
	                         <td>${signVO.writeDate}</td>
	                     </tr>
	                     </c:forEach>
	                 </tbody>
	             </table>
	         </div>
	         
			<div class="table-responsive ulDisplay" id="inprogress">
	             <table class="table table-hover">
	                 <thead>
	                     <tr>
	                         <th>번호</th>
	                         <th>제목</th>
	                         <th>기안자</th>
	                         <th>부서</th>
	                         <th>기안일</th>
	                     </tr>
	                 </thead>
	                 <tbody>
	                 	<c:forEach var="signVO" items="${signVOList2}" varStatus="stat">
	                      <tr>
	                         <td>${signVO.rnum}</td>
	                         <td><a href="/sign/detail?appGroupCode=${signVO.appGroupCode}">${signVO.docTitle}</a></td>
	                         <td>${signVO.originalEmpName}</td>
	                         <td>${signVO.originalDeptName}</td>
	                         <td>${signVO.writeDate}</td>
	                     </tr>
	                     </c:forEach>
	                 </tbody>
	             </table>
	         </div>
		</div>
		
		
		
		<div class="">
			<h5><a href="/sign/collect">반려/종결함</a></h5>
			<ul class="projNav">
				<li class="projBtn nav2 active2" data-nav2="expected2">
					반려함</li>
				<li class="projBtn nav2 " data-nav2="inprogress2">
					종결함</li>
			</ul>
			<div class="table-responsive2" id="expected2">
	             <table class="table table-hover">
	                 <thead>
	                     <tr>
	                         <th>번호</th>
	                         <th>제목</th>
	                         <th>기안자</th>
	                         <th>부서</th>
	                         <th>기안일</th>
	                     </tr>
	                 </thead>
	                 <tbody>
	                 	<c:forEach var="signVO" items="${signVOList3}" varStatus="stat">
	                      <tr>
	                         <td>${signVO.rnum}</td>
	                         <td><a href="/sign/retractDetail?appGroupCode=${signVO.appGroupCode}">${signVO.docTitle}</a></td>
	                         <td>${signVO.originalEmpName}</td>
	                         <td>${signVO.originalDeptName}</td>
	                         <td>${signVO.writeDate}</td>
	                     </tr>
	                     </c:forEach>
	                 </tbody>
	             </table>
	         </div>
	         
		<div class="table-responsive2" id="inprogress2">
             <table class="table table-hover">
                 <thead>
                     <tr>
                         <th>번호</th>
                         <th>제목</th>
                         <th>기안자</th>
                         <th>부서</th>
                         <th>기안일</th>
                     </tr>
                 </thead>
                 <tbody>
                 	<c:forEach var="signVO" items="${signVOList4}" varStatus="stat">
                      <tr>
                         <td>${signVO.rnum}</td>
                         <td><a href="/sign/detail?appGroupCode=${signVO.appGroupCode}">${signVO.docTitle}</a></td>
                         <td>${signVO.originalEmpName}</td>
                         <td>${signVO.originalDeptName}</td>
                         <td>${signVO.writeDate}</td>
                     </tr>
                     </c:forEach>
                 </tbody>
             </table>
         </div>
		</div>
		
		<div class="">
			<h5><a href="/sign/department">부서함</a></h5>
		<div class="">
             <table class="table table-hover">
                 <thead>
                     <tr>
                         <th>번호</th>
                         <th>제목</th>
                         <th>기안자</th>
                         <th>부서</th>
                         <th>기안일</th>
                     </tr>
                 </thead>
                 <tbody>
                 	<c:forEach var="signVO" items="${signVOList5}" varStatus="stat">
                      <tr>
                         <td>${signVO.rnum}</td>
                         <td><a href="/sign/detail?appGroupCode=${signVO.appGroupCode}">${signVO.docTitle}</a></td>
                         <td>${signVO.originalEmpName}</td>
                         <td>${signVO.originalDeptName}</td>
                         <td>${signVO.writeDate}</td>
                     </tr>
                     </c:forEach>
                 </tbody>
             </table>
         </div>
		</div>
		
		<div class="">
			<h5><a href="/sign/reading">참조함</a></h5>
		<div class="">
             <table class="table table-hover">
                 <thead>
                     <tr>
                         <th>번호</th>
                         <th>제목</th>
                         <th>기안자</th>
                         <th>부서</th>
                         <th>기안일</th>
                     </tr>
                 </thead>
                 <tbody>
                 	<c:forEach var="signVO" items="${signVOList6}" varStatus="stat">
                      <tr>
                         <td>${signVO.rnum}</td>
                         <td><a href="/sign/detail?appGroupCode=${signVO.appGroupCode}">${signVO.docTitle}</a></td>
                         <td>${signVO.originalEmpName}</td>
                         <td>${signVO.originalDeptName}</td>
                         <td>${signVO.writeDate}</td>
                     </tr>
                     </c:forEach>
                 </tbody>
             </table>
         </div>
		</div>
	</div>
<%@ include file="../include/managerFooter.jsp"%>


</div>

<script>
	document.addEventListener("DOMContentLoaded", function () {
	    // 첫 번째 네비게이션 (대기/요청)
	    const navButtons1 = document.querySelectorAll(".projBtn.nav");
	    const tables1 = document.querySelectorAll(".table-responsive");
	
	    navButtons1.forEach(button => {
	        button.addEventListener("click", function () {
	            // 모든 버튼에서 active 클래스 제거
	            navButtons1.forEach(btn => btn.classList.remove("active"));
	            // 클릭한 버튼에 active 클래스 추가
	            this.classList.add("active");
	
	            // 모든 테이블 숨기기
	            tables1.forEach(table => table.style.display = "none");
	
	            // 클릭한 버튼의 data-nav 값을 가져와서 해당 테이블만 표시
	            const targetTableId = this.getAttribute("data-nav");
	            document.getElementById(targetTableId).style.display = "block";
	        });
	    });
	
	    // 기본적으로 "대기함"만 보이도록 설정
	    document.getElementById("expected").style.display = "block";
	    document.getElementById("inprogress").style.display = "none";
	
	    
	    // 두 번째 네비게이션 (반려/종결)
	    const navButtons2 = document.querySelectorAll(".projBtn.nav2");
	    const tables2 = document.querySelectorAll(".table-responsive2");
	
	    navButtons2.forEach(button => {
	        button.addEventListener("click", function () {
	            // 모든 버튼에서 active2 클래스 제거
	            navButtons2.forEach(btn => btn.classList.remove("active2"));
	            // 클릭한 버튼에 active2 클래스 추가
	            this.classList.add("active2");
	
	            // 모든 테이블 숨기기
	            tables2.forEach(table => table.style.display = "none");
	
	            // 클릭한 버튼의 data-nav2 값을 가져와서 해당 테이블만 표시
	            const targetTableId = this.getAttribute("data-nav2");
	            document.getElementById(targetTableId).style.display = "block";
	        });
	    });
	
	    // 기본적으로 "반려함"만 보이도록 설정
	    document.getElementById("expected2").style.display = "block";
	    document.getElementById("inprogress2").style.display = "none";
	});
</script>


<script src="/dash/js/main.js"></script>
<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<!-- 메인 컨텐츠 영역 끝 -->