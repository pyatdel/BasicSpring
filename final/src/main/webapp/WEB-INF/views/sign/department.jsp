<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
<style>
.nav-tabs .nav-link{
color: black !important;
}

.nav-tabs .nav-link.active, .nav-tabs .nav-item.show .nav-link{

color:#3069CE !important;

}
.page-item.active .page-link{
background-color:#3069CE; 
}
.conte{

width: 90%;
margin: 0 auto;
margin-top:1%;

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
a:hover , a:active{
color:#3069CE !important;

}
.hdFlex{
display: flex;
align-items:center;
}
.mnsignSub{
display: block !important;
height: auto !important;
}
</style>    
<!-- 헤더 include  -->
   <jsp:include page="../include/managerHeader.jsp"></jsp:include>
<!-- 헤더 include  -->

	<div class="conte">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <div class="hdFlex">
                        	<h3 class=" contlist">전자결재관리</h3>
							<h5 class=" contlist"> &nbsp;> 부서함</h5>
						</div>
                        <!-- 검색시작  -->
                        <div class="input-group input-group-sm" style="width: 150px;">
                        	<input type="text" name="keyword" id="searchInput" value="${param.keyword}"
                        		class="form-control float-right" placeholder="검색어 입력"/> 
                        	<div class="input-group-append">
                        		<button type="button" id="btnSearch" class="btn btn-default">
                        			<i class="fas fa-search"></i>
                        		</button>
                        	</div>	
                        </div>
                        <!-- 검색 끝  -->
                    </div>
                    <div class="table-responsive">
                        <table class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-dark text-center">
                                     <th scope="col">번호</th>
                                    <th scope="col">제목</th>
                                    <th scope="col">기안일</th>
                                    <th scope="col">기안자</th>
                                    <th scope="col">부서</th>
                                    <th scope="col">결재상태</th>
                                </tr>
                            </thead>
                            <tbody id="tby">
                              <!--   <tr>
                                    <td>1</td>
                                    <td>계약서</td>
                                    <td>진행중</td>
                                    <td>2024-12-23</td>
                                    <td>인사부</td>
                                    <td>개똥이</td>
                                </tr> -->
                            </tbody>
                        </table>
                    </div>
                    <!-- 페이징 처리 번호 보이게 -->
                    <div class="" id="divPagingArea" style="width: 30%; margin: 0 auto; background-color:white;">
      						<div class="dataTables_info" id="example2_info" role="status" aria-live="polite"></div>
                    	<%-- <center>
							${articlePage.pagingArea} 
                    	</center> --%>
                    </div>
                    
                     <jsp:include page="../include/managerFooter.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  
 
                </div>
                
 	<script type="text/javascript">
 	//결재 대기 리스트
 	function selectSign(currentPage, keyword){
 		//매개변수를 반영
 		let data = {
 			"currentPage" : currentPage,
 			"keyword" : keyword
 		};
 		
 		//data
 		console.log("data : ", data);
 		
 		$.ajax({
 			url:"/sign/departmentAjax",
 			contentType:"application/json;charset=utf-8",
 			data:JSON.stringify(data),
 			type:"post",
 			dataType:"json",
 			success:function(result){
 				console.log("result : ",result.content);
 				
 				let str = "";
 				
 				$.each(result.content,function(idx, signVO){
	 				str += `<tr>
			 					<td class="text-center">\${signVO.rnum}</td>
						 		<td class="text-center"><a href="/sign/detail?appGroupCode=\${signVO.appGroupCode}">\${signVO.docTitle}</a></td>
						 		<td class="text-center">\${signVO.writeDate}</td>
						 		<td class="text-center">\${signVO.originalEmpName}</td>
						 		<td class="text-center">\${signVO.deptName}</td>
		                        <td class="text-center">완료</td>
				 			</uuuu
				 			>`;
	 			});
 				
 				console.log("str : ", str);
 				
 				$("#tby").html(str);
 				
 				//페이징 블록 처리
 				$("#divPagingArea").html(result.pagingArea);
 				
 			}
 		
 		});//end
 	
 	}
 	
 	$(function(){
 		console.log("체킁");
 		
 		//페이지 블록에서 특정 페이지 클릭 시 처리
 		//동적으로 만들어진 요소를 클릭 시 이렇게 쓰자
 		$(document).on("click",".clsPagingArea",function(){
 			//<a href="#" data-current-page="1" data-keyword="" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link clsPagingArea">1</a>
 			let currentPage = $(this).data("currentPage");
 			console.log("currentPage : ", currentPage);
 			
 			selectEmployeeList(currentPage, "");
 		});
 	
 		//검색
 		selectSign("1","");
			   
			   //검색 처리
			   $("#btnSearch").on("click",function(){
				   let keyword = $("input[name='keyword']").val();
				   console.log("keyword : "+keyword);
				   
				 //전역 함수 호출
				   selectSign("1","");
			   });
			// 엔터 키 입력 시 검색 처리
			    $("input[name='keyword']").on("keydown", function(e) {
			        if (e.key === "Enter") {  // Enter 키가 눌렸을 때
			            let keyword = $(this).val();
			            console.log("검색어 : " + keyword);
			            selectSign(1,keyword);  // 검색 실행
			        }
		    	});   
 		
 		//1. 페이지 로딩 시 함수 호출(처음)
 		selectSign(1, "");
 		
 	})
 	</script>
 
 

         <script src="/dash/lib/easing/easing.min.js"></script>
    <script src="/dash/lib/waypoints/waypoints.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/moment.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>
<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
    <!-- Template Javascript -->


