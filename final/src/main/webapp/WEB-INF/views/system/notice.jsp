<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
    
<!-- 
../ : views폴더(부모)
 -->
 
   <!--  <meta charset="utf-8">
    <title>DASHMIN - Bootstrap Admin Template</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
    <link rel="stylesheet" href="/dash/css/bootstrap.min.css" >
    <link rel="stylesheet" href="/dash/css/style.css" >
    <link href="img/favicon.ico" rel="icon">

    Google Web Fonts
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    

    
    
    
    Icon Font Stylesheet
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    Libraries Stylesheet
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" /> -->


<style>
thead {
  background-color: #3676EB; 
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
.mnboardSub {
display: block !important;
height: auto !important;
}
</style>
<!-- 헤더 include  -->
   <jsp:include page="../include/managerHeader.jsp"></jsp:include>
<!-- 헤더 include  -->


	<div class="row">
        <div class="col-md-12">
            <div class="page-header clearfix">
                <h3 class="pull-left">공지사항</h3>
                <div class="pull-right">
                    
                </div>
            </div>
        </div>
    </div>

	<div class="row">
        <div class="col-md-12">
            <div class="card">
               <div class="card">
    			<div class="card-header d-flex justify-content-between align-items-center" style="background-color: #f8f9fa; border-bottom: none;">
                    <h3 class="card-title">
                        <i class="fas fa-bullhorn"></i> 공지사항
                    </h3>
               </div>     
                    <div class="card-body" style="background-color: #f8f9fa;">
                    <!-- 검색시작  -->
	                     <div class="d-flex justify-content-between w-100" id="searchInput">
	                         <div class="input-group input-group-sm" style="width: 300px;">
							    <input type="text" name="keyword" value="" class="form-control" placeholder="검색어 입력"/>
							    <div class="input-group-append">
							        <button type="button" id="btnSeach" class="btn btn-default">
							            <i class="fas fa-search"></i>
							        </button>
							    </div>
							</div>
	                        <!-- 검색 끝  -->
		                    <a href="/board/form" class="btn btn-primary">
		                      <i class="fas fa-edit"></i> 글쓰기 
		                    </a>
               			</div>
               		</div>   
              
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table text-center">
                            <thead>
                                <tr>
                                    <th width="10%">번호</th>
                                    <th>제목</th>
                                    <th width="15%">작성일</th>
                                    <th width="15%">작성자</th>
                                    <th width="10%">종류</th>
                                </tr>
                            </thead>
                            <tbody id="tby">
                           <%--  <c:forEach var="noticeVO" items="${noticeVOList}" varStatus="stat">
							    <tr>
							        <td>${noticeVO.rnum}</td>
							        <td>
							            <a href="/board/detail/${noticeVO.bodNo}" class="text-reset">
							               ${noticeVO.bodTitle}
							            </a>
							        </td>
							        	<td>${noticeVO.bodCreDate}</td>
								        <td>${noticeVO.bodWriter}</td>
								    <td>
				                    	<span class="badge bg-danger text-white">${noticeVO.noticeType} 1=긴급, 2=일반</span>
							        </td>    
							    </tr>
							</c:forEach>     --%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- 페이징 처리 번호 보이게 -->
              <div class="" id="divPagingArea" style="width: 30%; margin: 0 auto;">
				<div class="dataTables_info" id="example2_info" role="status" aria-live="polite"></div>
	      			<center>
						${articlePage.pagingArea} 
	             	</center>
              </div>
               <jsp:include page="../include/managerFooter.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  
 
    </div>
    
    <script>
    function noticeVOList(currentPage, keyword){
    	
    	let data = {
 	 		 "currentPage" : currentPage,
 	 		 "keyword" : keyword || "" //빈 문자열 처리
 	 		};
    	 		
    	 		console.log("data : ", data);
    	 		
    	 		
    	 		$.ajax({
    		 		url: "/system/noticePost",
    		 		contentType:"application/json;charset=utf-8",
    		 		data:JSON.stringify(data),
    		 		type:"post",
    		 		dataType:"json",
    		 		success:function(articlePage){
    		 			console.log("articlePage : ",articlePage);
    		 			
    		 			let str = "";
    		 			
    		 			console.log("str : ", str);
    		 			
    		 			$.each(articlePage.content,function(idx, noticeVO){
    		 				
    		 				// 긴급 일반 표시 하는 함수
    		 				let noticeTypeBadge;
    		 	            if (noticeVO.noticeType === 1) {
    		 	                noticeTypeBadge = '<span class="badge bg-danger text-white">긴급</span>';
    		 	            } else if (noticeVO.noticeType === 2) {
    		 	                noticeTypeBadge = '<span class="badge bg-primary text-white">일반</span>';
    		 	            } else {
    		 	                noticeTypeBadge = '<span class="badge bg-secondary text-white">알 수 없음</span>';
    		 	            }
    		 				
    		 				str += `<tr>
    						 		<td>\${noticeVO.rnum}</td>
    								<td style="text-align: left; color: #3676EB;" ><a href="/board/detail/\${noticeVO.bodNo}" >\${noticeVO.bodTitle}</a></td>
    						 		<td>\${noticeVO.bodCreDate}</td>
    						 		<td>\${noticeVO.bodWriter}</td>
    						 		<td>\${noticeTypeBadge}</td>
    							 </tr>`;
    							 
    							 
    		 			});
    		 			//바디
    		 			$("#tby").html(str);
    		 			
    		 			//페이징 블록 처리
    					$("#divPagingArea").html(articlePage.pagingArea);
    					
    					
    		 		}
    		 		
    		 	});//end ajax	 
    }//end 	
    	
    $(function(){
    	noticeVOList("1","");
 		console.log("개똥이");
 		
 		//페이지 블록에서 특정 페이지 클릭 시 처리
 		//동적으로 만들어진 요소를 클릭 시 이렇게 쓰자
 		$(document).on("click",".clsPagingArea",function(){
 			//<a href="#" data-current-page="1" data-keyword="" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link clsPagingArea">1</a>
 			let currentPage = $(this).data("currentPage");
 			let keyword = $(this).data("keyword");
 			console.log("currentPage : ", currentPage);
 			console.log("keyword : ", keyword);
 			
 			noticeVOList(currentPage, keyword);
 		});
 	
 		//검색 처리
		   $("#btnSeach").on("click",function(){
			   let keyword = $("input[name='keyword']").val();
			   console.log("keyword : "+keyword);
			   
			 //전역 함수 호출
			   noticeVOList("1",keyword);
		   });
		// 엔터 키 입력 시 검색 처리
		    $("input[name='keyword']").on("keydown", function(e) {
		        if (e.key === "Enter") {  // Enter 키가 눌렸을 때
		            let keyword = $(this).val();
		            console.log("검색어 : " + keyword);
		            noticeVOList("1",keyword);  // 검색 실행
		        }
	    	});   
 		
 		//1. 페이지 로딩 시 함수 호출(처음)
 		noticeVOList(1, "");
 	
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


</html>

