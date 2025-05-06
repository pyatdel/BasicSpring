<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<!-- 
../ : views폴더(부모)
 -->
 
    <meta charset="utf-8">
    <title>직원목록</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
    <link rel="stylesheet" href="/dash/css/bootstrap.min.css" >
    <link rel="stylesheet" href="/dash/css/style.css" >
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

	<!-- ///// sidebar 시작 ///// -->
	<jsp:include page="../include/mangerSidebar.jsp"></jsp:include> 
	<!-- ///// sidebar 끝 ///// -->

<!--body 시작  -->
	<div class="bg-light text-center rounded p-4" tyle="font-size: 14px; padding: 0;">
		<h6 class="mb-0">직원목록</h6>
                    <!-- 검색시작  -->
                    <div class="input-group input-group-sm" style="width: 300px;">
                    	<input type="text" name="keyword" value=""
                    		class="form-control float-right" placeholder="검색어 입력"/> 
                    	<div class="input-group-append">
                    		<button type="button" id="btnSeach" class="btn btn-default">
                    			<i class="fas fa-search"></i>
                    		</button>
                    	</div>	
                    </div>
                    <!-- 검색 끝  -->
                   <div class="table-responsive">
                       <table class="table text-start align-middle table-bordered table-hover mb-0">
                           <thead>
                               <tr class="text-dark">
                                   <th scope="col">번호</th>
                                   <th scope="col">사원번호</th>
                                   <th scope="col">이름</th>
                                   <th scope="col">부서</th>
                                   <th scope="col">직급</th>
                                   <th scope="col">권한설정</th>
                               </tr>
                           </thead>
                           <tbody id="tby">
                           	<!-- 
                           	EmployeeVO(empNo=0, enabled=null, empId=null, empPw=null, empName=양마강, empEmail=test6@test.com
                           	, empPhone=010-5555-5555, empZip=null, empStreet=null, empDetail=null, empSign=null, empAnnual=0
                           	, empIn=null, empOut=null, deptNo=0, postNo=0, rnum=1, deptName=회계부, postName=직원)
                           	 --><!-- 동기방식  -->
<%--                             	<c:forEach var="employeeVO" items="${employeeVOList}" varStatus="stat"> --%>
<!-- 	                            	<tr> -->
<%-- 	                            		<td>${employeeVO.rnum}</td> --%>
<%-- 	                            		<td>${employeeVO.empNo}</td> --%>
<%-- 	                            		<td>${employeeVO.empName}</td> --%>
<%-- 	                            		<td>${employeeVO.deptName}</td> --%>
<%-- 	                            		<td>${employeeVO.postName}</td> --%>
<%-- 	                            		<td>${employeeVO.empPhone}</td> --%>
<%-- 	                            		<td>${employeeVO.empEmail}</td> --%>
<!-- 	                            	</tr> -->
<%--                             	</c:forEach> --%>
                           </tbody>
                       </table>
                   </div>
                   <!-- 페이징 처리 번호 보이게 -->
                   <div class="card-footer" id="divPagingArea" style="width: 30%; margin: 0 auto;">
     						<div class="dataTables_info" id="example2_info" role="status" aria-live="polite"></div>
                   	<%-- <center>
						${articlePage.pagingArea} 
                   	</center> --%>
                   </div>
                   	<div class="col-12" style="justify-content:right;display:flex;">
        				<a href="/personnel/create" class="btn btn-primary">등록</a>
     				</div>
               </div>
                
 
 	<script type = "text/javascript">
 	//직원 목록 조회
 	function selectEmployeeList(currentPage, keyword){
 		//매개변수를 반영
 		let data = {
 		 "currentPage" : currentPage,
 		 "keyword" : keyword || "" //빈 문자열 처리
 		};
 		
 		console.log("data : ", data);
 	
 		//아작나써유..(피)씨다타써
	 	$.ajax({
	 		url: "/personnel/listAjax",
	 		contentType:"application/json;charset=utf-8",
	 		data:JSON.stringify(data),
	 		type:"POST",
	 		dataType:"json",
	 		success:function(articlePage){
	 			console.log("articlePage : ",articlePage);
	 			
	 			let str = "";
	 			//result : ArticlePage<EmployeeVO>
	 			//result.content : List<EmployeeVO> employeeVOList
	 			//		List를                 0    vo 1개
	 			//		List를				  1    vo 1개
	 			$.each(articlePage.content,function(idx, employeeVO){
	 				str += `<tr>
					 		<td>\${employeeVO.rnum}</td>
							<td><a href="/personnel/detail?empId=\${employeeVO.empId}">\${employeeVO.empId}</a></td>
					 		<td>\${employeeVO.empName}</td>
					 		<td>\${employeeVO.deptName}</td>
					 		<td>\${employeeVO.postName}</td>
							<td>\${employeeVO.empPhone}</td>
						 </tr>`;
	 			});
	 			
	 			console.log("str : ", str);
	 			//<tbody id="employeeTbody">내용</tbody>
				//부모요소.append(자식요소) : 부모의 마지막 자식 요소로 추가(누적)
				//부모요소.html(자식요소) : 부모의 자식 요소를 덮어씀(새로고침)
				//객체.append : 누적, .html : 새로고침, innerHTML : J/S
	 			$("#tby").html(str);
	 			
	 			//페이징 블록 처리
				$("#divPagingArea").html(articlePage.pagingArea);
				
				
	 		}
	 		
	 	});//end ajax
	 	
 	}
 	
 	$(function(){
 		selectEmployeeList("1","");
 		console.log("개똥이");
 		
 		//페이지 블록에서 특정 페이지 클릭 시 처리
 		//동적으로 만들어진 요소를 클릭 시 이렇게 쓰자
 		$(document).on("click",".clsPagingArea",function(){
 			//<a href="#" data-current-page="1" data-keyword="대리" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link clsPagingArea">1</a>
 			let currentPage = $(this).data("currentPage");//2
 			let keyword = $(this).data("keyword");//대리
 			console.log("currentPage : ", currentPage);
 			console.log("keyword : ", keyword);
 			
 			selectEmployeeList(currentPage, keyword);
 		});
 	
 		//검색 처리
		   $("#btnSeach").on("click",function(){
			   let keyword = $("input[name='keyword']").val();
			   console.log("keyword : "+keyword);
			   
			 //전역 함수 호출
			   selectEmployeeList("1",keyword);
		   });
		// 엔터 키 입력 시 검색 처리
		    $("input[name='keyword']").on("keydown", function(e) {
		        if (e.key === "Enter") {  // Enter 키가 눌렸을 때
		            let keyword = $(this).val();
		            console.log("검색어 : " + keyword);
		            selectEmployeeList("1",keyword);  // 검색 실행
		        }
	    	});   
 		
 		//1. 페이지 로딩 시 함수 호출(처음)
 		selectEmployeeList(1, "");
 	
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


