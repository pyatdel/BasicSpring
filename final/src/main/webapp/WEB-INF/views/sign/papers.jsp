<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<!-- 
../ : views폴더(부모)
 -->
 
<!--     <meta charset="utf-8">
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

	<!-- ///// sidebar 시작 ///// -->
	<jsp:include page="../include/mangerSidebar.jsp"></jsp:include> 
	<!-- ///// sidebar 끝 ///// -->

	<div>
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">문서관리</h6>
                        <!-- 검색시작  -->
                        <div class="input-group input-group-sm" style="width: 150px;">
                        	<input type="text" name="keyword" value="${param.keyword}"
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
                                <tr class="text-dark">
                                    <th scope="col">번호</th>
                                    <th scope="col">제목</th>
                                    <th scope="col">기안일</th>
                                    <th scope="col">부서</th>
                                    <th scope="col">직급</th>
                                    <th scope="col">기안자</th>
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
                    <div class="card-footer" id="divPagingArea" style="width: 30%; margin: 0 auto;">
      						<div class="dataTables_info" id="example2_info" role="status" aria-live="polite"></div>
                    	<%-- <center>
							${articlePage.pagingArea} 
                    	</center> --%>
                    </div>
                	<div class="col-12" style="justify-content:right;display:flex;">
         					<a href="#" class="btn btn-primary">등록</a>
      				</div>
      				 <jsp:include page="../include/footer.jsp"></jsp:include>
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
 			url:"/sign/listAjax",
 			contentType:"application/json;charset=utf-8",
 			data:JSON.stringify(data),
 			type:"post",
 			dataType:"json",
 			success:function(result){
 				console.log("result : ",result.content);
 				
 				let str = "";
 				
 				$.each(result.content,function(idx, signVO){
	 				str += `<tr>
						 		<td>\${signVO.rnum}</td>
						 		<td><a href="/sign/detail?docNo=\${signVO.docNo}">\${signVO.docTitle}</a></td>
						 		<td>\${signVO.writeDate}</td>
						 		<td>\${signVO.deptName}</td>
								<td>\${signVO.postName}</td>
					 			<td>\${signVO.empName}</td>
						 		<td>\${signVO.appStatusName}</td>
				 			</tr>`;
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
    <script src="/dash/js/main.js"></script>
<!-- ///// footer 시작 ///// -->

<!-- ///// footer 끝 ///// -->  


