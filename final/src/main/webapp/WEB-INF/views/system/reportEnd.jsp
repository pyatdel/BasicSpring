<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->

<style>
thead {
  background-color: #3676EB;  /* 연두색 배경 */
  color: white;           /* 흰색 텍스트 */
}
#divPagingArea .page-item.active .page-link {
  color: white;           /* 활성화된 페이지 글자 색상 */
  background-color: #3676EB; /* 활성화된 페이지 배경색 */
  border-color: #3676EB;    /* 테두리 색상 */
}
#divPagingArea .page-link:hover {
  color: white;           /* 호버 시 글자 색상 */
  background-color: #3676EB; /* 호버 시 배경색 */
  border-color: #3676EB;     /* 호버 시 테두리 색상 */
}
#divPagingArea .page-link {
  color: black;          /* 링크 글자 색상 */
  background-color: white; /* 링크 배경색 */
  border: 1px solid gray; /* 테두리 색상 */
}
</style>
<!-- 헤더 include  -->
   <jsp:include page="../include/managerHeader.jsp"></jsp:include>
<!-- 헤더 include  -->

	<div class="bg-light text-center rounded p-4">
	
		  <div class="container">
        <div class="hdFlex">
	         <h3 class=" contlist">신고완료</h3>
	      </div>
        <!-- 검색 폼 -->
        <form action="/system/reportEndPost" method="post" class="search-form">
        
	        <div class="nav nav-tabs custom-tabs">
			   <a class="nav-link" href="/system/report">신고대기</a>
			   <a class="nav-link" href="/system/reportEnd">신고완료</a>
			 </div>
              <table class="table text-center">
                  <thead>
                      <tr>
                          <th style="color:black;"><label for="reportCategory">게시판 타입</label></th>
                          <th>
                          <div class="form-row">
				                <div class="form-group">
				                    <select name="reportCategory1" id="reportCategory1" class="form-control">
				                    <option value="">게시판 종류 선택하세요</option>
				                    <c:forEach var="reportEnd" items="${bodTypeNameList}">
				                       <option value="${reportEnd.bodTypeName}">${reportEnd.bodTypeName}</option>
				                    </c:forEach>   
				                    </select>
				                </div>
			               </div>
                          <th style="color:black;"><label for="reportCategory">신고 타입</label></th>
                          <th>
                          <div class="form-row">
				                <div class="form-group">
				                    <select name="reportCategory2" id="reportCategory2" class="form-control">
				                    	<option value="">신고 종류 선택하세요</option>
				                        <c:forEach var="systemReportVO" items="${repType}">
				                       		<option value="${systemReportVO.repTypeName}">${systemReportVO.repTypeName}</option>
				                    	</c:forEach>
				                    </select>
				                </div>
			               </div>
                  </tbody>
              </table>
              <div class="d-flex mb-2">
              	<input class="form-control bg-transparent" type="text" placeholder="검색하세요">
              	<button type="button" class="btn btn-primary ms-2" id="btnSearch">검색</button>
              </div>
         </form>
        
					<input id="repNo" value="${systemReportVO.repNo}" hidden></input>
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <a href=""></a>
                    </div>
                    <div class="table-responsive">
                        <table class="table text-center">
                            <thead>
                                <tr class="text-dark">
                                    <th scope="col">번호</th>
                                    <th scope="col">게시판 종류</th>
                                    <th scope="col">신고 종류</th>
                                    <th scope="col">신고 게시판 제목</th>
                                    <th scope="col">신고사유</th>
                                    <th scope="col">신고자</th>
                                    <th scope="col">작성자</th>
                                    <th scope="col">신고날짜</th>
                                    <th scope="col">처리여부</th>
                                </tr>
                            </thead>
                            <tbody id="tby">
                         <%--   <c:forEach var="systemReportVO" items="${reportVOList}" varStatus="stat">
                                <tr>
                                    <td>${systemReportVO.rnum}</td>
                                    <td>${systemReportVO.repType}</td>
                                    <td>${systemReportVO.bod}</td>
                                    <td>${systemReportVO.bodTitle}</td>
                                    <td>${systemReportVO.repReason}</td>
                                    <td>${systemReportVO.repWriter}</td>
                                    <td>${systemReportVO.rnum}</td>
                                    <td>${systemReportVO.repDate}</td>
                                    <td>${systemReportVO.rnum}</td>
                                </tr>
                             </c:forEach>   --%>
                            </tbody>
                        </table>
                    </div>
                    <div class="" id="divPagingArea" style="width: 30%; margin: 0 auto;">
      						<div class="dataTables_info" id="example2_info" role="status" aria-live="polite"></div>
                    </div>
                     <jsp:include page="../include/managerFooter.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  
 
                </div>
     <script type = "text/javascript">
 	//신고 완료  목록 조회
 	function reportEndList(currentPage,bodTypeName,repTypeName,keyword){
 		console.log(currentPage,bodTypeName,repTypeName,keyword);
 		//매개변수를 반영
 		let data = {
				 "currentPage" : currentPage,
		 		 "keyword" : keyword,//빈 문자열 처리
		 		 "bodTypeName": bodTypeName,
		 	     "repTypeName": repTypeName
 		};
 		
 		console.log("data : ", data);
 	
 		//아작나써유..(피)씨다타써
	 	$.ajax({
	 		url: "/system/reportEndPost",
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
	 			$.each(articlePage.content,function(idx, systemReportEndVO){
	 				str += `<tr>
			 					<td>\${systemReportEndVO.rnum}</td>
		                        <td>\${systemReportEndVO.bodTypeName}</td>
		                        <td>\${systemReportEndVO.repTypeName}</td>
		                        <td style="text-align: left; color: #3676EB;"><a href="/board/detail/\${systemReportEndVO.bodNo}">\${systemReportEndVO.bodTitle}</a></td>
		                        <td>\${systemReportEndVO.repReason}</td>
		                        <td>\${systemReportEndVO.repWriter}</td>
		                        <td>\${systemReportEndVO.bodWriter}</td>
		                        <td>\${systemReportEndVO.repDate}</td>
		                        <td>
			                        <span id="spn2-\${systemReportEndVO.repNo}" class="justify-between">
				                        <button 
				                        	class="btn btn-dark m-2"  
			                        		data-rep-no="\${systemReportEndVO.repNo}"
					                        id="edit2-\${systemReportEndVO.repNo}"
					                         >
				                        완료
				                    	</button>
			                        </span>     
		                        </td>
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
 			reportEndList("1","","","");
	 		console.log("개똥이");
	 		
	 	
	 		//검색
 	 		$("#btnSearch").on("click",function(){
 	 			
 	 			let bodTypeName = $("#reportCategory1").val();
 	 			let repTypeName = $("#reportCategory2").val();
 	 			let keyword = $("input[name='keyword']").val();
 	 			console.log("체킨 bodTypeName repTypeName keyword ",bodTypeName, repTypeName, keyword );
 	 			
 	 			reportEndList("1",bodTypeName,repTypeName,keyword);
 	 		});
 	 		
 	 		// 엔터 키 입력 시 검색 처리
		    $("input[name='keyword']").on("keydown",function(event){
		    	
		    	if(event.key=="Enter"){
		    		event.preventDefault(); // 기본적으로 enter 키를 누르면 해당 폼을 보내게 되어있다

	    			let bodTypeName = $("#reportCategory1").val();
	 	 			let repTypeName = $("#reportCategory2").val();
	 	 			let keyword = $("input[name='keyword']").val();
	 	 			console.log("bodTypeName repTypeName keyword ",bodTypeName, repTypeName, keyword );
	 	 			
	 	 			reportEndList("1",bodTypeName,repTypeName,keyword);
					}
		    }); 
	 		
	 		//1. 페이지 로딩 시 함수 호출(처음)
	 		reportEndList("","","", "");
	 	
	 		//페이지 블록에서 특정 페이지 클릭 시 처리
 	 		//동적으로 만들어진 요소를 클릭 시 이렇게 쓰자
 	 		$(document).on("click",".clsPagingArea",function(){
 	 			//<a href="#" data-current-page="1" data-keyword="" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link clsPagingArea">1</a>
 	 			let currentPage = $(this).data("currentPage");
 	 			let bodTypeName = $(this).data("bodTypeName");
				let repTypeName = $(this).data("repTypeName");
				let keyword = $(this).data("keyword");
 	 			/* console.log("페이지 클릭 currentPage : "+ currentPage); */
 	 			console.log("페이지 클릭 currentPage,bodTypeName,repTypeName,keyword : "+ currentPage,bodTypeName,repTypeName,keyword);
 	 			
 	 			// 데이터가 없으면 기본값 1로 처리
 	 			currentPage = currentPage || 1;
 	 			bodTypeName = bodTypeName || "";
 	 			repTypeName = repTypeName || ""; 
				// 필요한 매개변수 값들 가져오기
				

 	 			reportList(currentPage,bodTypeName, repTypeName, keyword);
 	 		});
	 		
	 	}); 
 	
 // 현재 URL 가져오기
 	const currentPath = window.location.pathname;

 	// 모든 탭 요소 가져오기
 	const navLinks = document.querySelectorAll('.nav-link');

 	// 현재 경로와 href가 일치하는 탭에 active 클래스 추가
 	navLinks.forEach(link => {
 	    if (link.getAttribute('href') === currentPath) {
 	        link.classList.add('active'); // Bootstrap의 기본 스타일을 활용
 	    }
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


