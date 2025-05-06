<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
   
   
<style>
thead {
 background-color: #3676EB; 
  color: white;         
}
#divPagingArea .page-item.active .page-link {
  color: white;           /* 활성화된 페이지 글자 색상 */
  background-color:  #3676EB; /* 활성화된 페이지 배경색 */
  border-color:  #3676EB;    /* 테두리 색상 */
}
#divPagingArea .page-link:hover {
  color: white;           /* 호버 시 글자 색상 */
  background-color:  #3676EB; /* 호버 시 배경색 */
  border-color:  #3676EB;     /* 호버 시 테두리 색상 */
}
#divPagingArea .page-link {
  color: black;          /* 링크 글자 색상 */
  background-color: white; /* 링크 배경색 */
  border: 1px solid gray; /* 테두리 색상 */
}
  .grid-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr); /* 3개의 열로 나누기 */
    gap: 10px; /* 열과 열 사이 간격 */
    font-size: 14px;
  }
  .grid-item {
    background-color: #f8f9fa;
    padding: 10px;
    border-radius: 5px;
    text-align: center;
  } 
  #searchInput{
width:200px;
height: 40px;
position: relative;
}
.input-group{
display: flex;
width: 300px !important;
height:30px;
align-items: center;
}
.fa-search{
font-size: 1rem;

}
#btnSearch{
position: absolute;

    right: 0;
    top: 0.1%;
}
.hdFlex{
display: flex;
align-items:center;
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
	<div class="" tyle="font-size: 14px;">
		 <div class="hdFlex">
            <h3 class=" contlist">직원관리</h3>
			<h5 class=" contlist"> &nbsp;> 퇴사자관리</h5>
		</div>
       <div style="display: flex; align-items: start; gap: 60px; margin-left: 0px;">
	 	<%-- 써머리 --%>
	 	<div class="bg-white rounded shadow-sm p-4" style="font-size: 15px; margin: 0; padding: 0px; width: 35%;  margin: 20px; border:1px solid black;">
	           <table class="table table-hover text-center align-middle mb-0" style="font-size: 15px; margin: 0; padding: 0;">
	               <thead>
	                   <tr class="text-dark">
	                       <th scope="col">번호</th>
	                       <th scope="col">부서</th>
	                       <th scope="col">인원</th>
	                   </tr>
	               </thead>
	               <tbody>
	               	<c:forEach var="departmentVO" items="${departmentList}" varStatus="stat">
	                   <tr>
	                       <th scope="row">${departmentVO.rnum}</th>
	                       <td>${departmentVO.deptName}</td>
	                       <td>${departmentVO.employeeCount}명</td>
	                   </tr>
	                 </c:forEach>  
	               </tbody>
	           </table>
	       </div>
	   	<%-- 써머리 끝 --%>
	   	
           <!-- 차트 시작 -->
             <div style=" width: 32%;height:270px;border:1px solid black; margin: 20px;">
           		<canvas id="employeeChart"></canvas>
           </div>      
           <!-- 차트 끝 -->   
      </div>
       <div class="nav nav-tabs custom-tabs">
		   <a class="nav-link" href="/personnel/list">직원</a>
		   <a class="nav-link active" href="/personnel/resignList" id="tab-resignList">퇴사자</a>
		   <!-- 검색시작  -->
           <div class="input-group input-group-sm" id="searchInput" style="width: 300px; display: flex; border: 1px solid #ccc; border-radius: 4px; margin:5px;">
			    <input type="text" name="keyword" value="" class="form-control" placeholder="검색어 입력" style="border: none; flex: 1; padding: 5px;"/>
			    <button type="button" id="btnSeach" class="btn btn-default" style="border: none; background-color: transparent; padding: 5px;">
			        <i class="fas fa-search"></i>
			    </button>
			</div>
                  <!-- 검색 끝  -->
	 </div>
                   <div class="table-responsive">
                       <table class="table text-center">
                           <thead>
                               <tr class="text-dark">
                                   <th scope="col">번호</th>
                                   <th scope="col">사원번호</th>
                                   <th scope="col">이름</th>
                                   <th scope="col">부서</th>
                                   <th scope="col">직급</th>
                                   <th scope="col">연락처</th>
                                   <th scope="col">이메일</th>
                               </tr>
                           </thead>
                           <tbody id="tby">
                           </tbody>
                       </table>
                   </div>
                   <!-- 페이징 처리 번호 보이게 -->
                   <div class="" id="divPagingArea" style="width: 30%; margin: 0 auto;">
     						<div class="dataTables_info" id="example2_info" role="status" aria-live="polite"></div>
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
	 		url: "/personnel/resign",
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
							<td><a href="/personnel/detail?empId=\${employeeVO.empId}" style="color: #3676EB;">\${employeeVO.empId}</a></td>
					 		<td>\${employeeVO.empName}</td>
					 		<td>\${employeeVO.deptName}</td>
					 		<td>\${employeeVO.postName}</td>
							<td>\${employeeVO.empPhone}</td>
							<td>\${employeeVO.empEmail}</td>
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
 	
 	/* 차트 시작 */

			$.ajax({
		    url: '/personnel/chart',  // 차트 데이터를 가져오는 요청 URL
		    type: 'POST',
		    contentType: 'application/json',
		    data: JSON.stringify({}),  // 필요한 데이터가 없으면 빈 객체 전달
		    success: function(response) {
		        console.log("차트 데이터:", response.chartList);
		
		        var years = [];
		        var empInCounts = [];
		        var empOutCounts = [];
		        var empCounts = [];
		
		        // 차트 데이터를 배열에 저장
		        response.chartList.forEach(function(item) {
		            years.push(item.year);            // 연도
		            empInCounts.push(item.empInCount); // 입사자 수
		            empOutCounts.push(item.empOutCount); // 퇴사자 수
		            empCounts.push(item.empCount);     // 총 인원 수
		        });
				console.log("years",years,"empInCounts",empInCounts,"empOutCounts",empOutCounts,"empCounts",empCounts);
		        // 차트 그리기
		        var ctx = document.getElementById('employeeChart').getContext('2d');
		            new Chart(ctx, {
		                type: 'bar',  // 전체 차트 타입을 막대 차트로 설정
		                data: {
		                    labels: years,  // x축에 표시할 값 (연도)
		                    datasets: [
		                        {
		                            label: '입사자 수',
		                            data: empInCounts,  // 입사자 수 데이터
		                            backgroundColor: 'blue',  // 색상 설정
		                            borderColor: 'blue',
		                            borderWidth: 1,
		                            type: 'bar'  // 막대 그래프
		                        },
		                        {
		                            label: '퇴사자 수',
		                            data: empOutCounts,  // 퇴사자 수 데이터
		                            backgroundColor: 'red',
		                            borderColor: 'red',
		                            borderWidth: 1,
		                            type: 'bar'  // 막대 그래프
		                        },
		                        {
		                            label: '현재 총 인원 수',
		                            data: empCounts,  // 현재 총 인원 수 데이터
		                            borderColor: 'green',  // 선 색상
		                            fill: false,  // 선 차트는 채우지 않음
		                            type: 'line',  // 꺾은선 그래프
		                            tension: 0.1  // 꺾은선의 굴곡 정도
		                        }
		                    ]
		                },
		            options: {
		                responsive: true,  // 화면 크기 변화에 반응
		                scales: {
		                    x: { beginAtZero: true },
		                    y: { beginAtZero: true }
		                }
		            }
		        });
		    },
		    error: function(error) {
		        console.error("차트 데이터 로딩 실패:", error);
		    }
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


