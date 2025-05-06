<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="/css/bootstrap.min.css" />
<!-- 
../ : views폴더(부모)
 -->
<!-- ///// header 시작 ///// -->
<jsp:include page="../include/header.jsp"></jsp:include>
<!-- ///// header 끝 ///// -->

<!-- Main content -->
<section class="content">
	<div class="container-fluid">
		<!-- ///// content 시작 ///// -->
		<h3>상품목록</h3>

		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-header">
					<h3 class="card-title">[비동기]</h3>

					<div class="card-tools">
					<!-- //// 검색 시작 //// 
		             action 생략 : /member/list
		             method 생략 : get
		             요청파라미터 : keyword=개똥이 (왜냐하면 검색 후 currentPage는 1이기 때문에 생략 가능)
		             -->
					<form>
						<div class="input-group input-group-sm" style="width: 150px;">
							<input type="text" id="krd" name="keyword" value="${param.keyword}"
								class="form-control float-right" placeholder="검색어 입력" />
	
							<div class="input-group-append">
								<button type="button" id="btnSearch" class="btn btn-default">
									<i class="fas fa-search"></i>
								</button>
							</div>
						</div>
					</form>
							<!-- //// 검색 끝 //// -->
						</div>
					</div>
					<!-- /.card-header -->
					<div class="card-body table-responsive p-0">
						<!-- 성명으로 오름차순 정렬 -->
						<table class="table table-hover text-nowrap">
							<thead>
								<tr>
								   <th>순번</th>
				                   <th>상품코드</th>
				                   <th>상품명</th>
				                   <th>상품분류코드</th>
				                   <th>거래처코드</th>
				                   <th>판매가</th>
				                   <th>설명</th>
								</tr>
							</thead>
							<tbody id="tby">

							</tbody>
						</table>
					</div>
					<!-- /.card-body -->
					<!-- card-footer 시작 -->
					<div class="card-footer" id="divPagingArea"></div>
					<!-- card-footer 끝 -->
				</div>
				<!-- /.card -->
			</div>
			<div class="col-12" style="justify-content: right; display: flex;">
				<a href="/prod/create" class="btn btn-primary">등록</a>
			</div>
		</div>
		
		<!-- ///// content 끝 ///// -->
	</div>
	<!-- /.container-fluid -->
</section>
<script type="text/javascript">

function nvl(expr1, expr2) {
	   if (expr1 === undefined || expr1 == null || expr1 == "") {
	      expr1 = expr2;
	   }
	 return expr1;
	 }  

	 
// 상품 목록 출력 함수
function getList(currentPage, keyword){
		let data = {
				"currentPage":nvl(currentPage,"1"),
				"keyword":nvl(keyword,"")
		};
		
		console.log("data : ", data);
		
		// 아작나써유 (피)씨다타써 - (피)는 form 타입일 때만 사용
		$.ajax({
			url:"/prod/listAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			success:function(articlePage){	// result 대신 articlePage 사용 가능
				console.log("articlePage : ", articlePage);
			// 				  articlePage.content = List<MemberVO>
				console.log("articlePage.content : ", articlePage.content);
			
				let str = "";
				$.each(articlePage.content, function(idx,prodVO){
				  str += `<tr>
					<td>\${prodVO.rnum}</td>
					<td><a href="/prod/detail?prodId=\${prodVO.prodId}">\${prodVO.prodId}</a></td>
					<td>\${prodVO.prodName}</a></td>
					<td>\${prodVO.prodLgu}</td>
					<td>\${prodVO.prodBuyer}</td>
					<td>\${prodVO.prodSale}</td>
					<td>\${prodVO.prodOutline}</td>
		          </tr>`;
				});		// end each
				
				// element.append() : 누적 vs element.html() : 덮어쓰기
				$("#tby").html(str);
				// 페이징 처리
				$("#divPagingArea").html(articlePage.pagingArea);
			}
		});
}	// end getList()

//document.ready랑 같은 의미
//동일 jsp에서 1회 작성
$(function(){
	
	getList("1","");
	
	// 검색
	$("#btnSearch").on("click",function(){
		// <input type="text" name="keyword"..
		let keyword = $("#krd").val();	// 개똥
		console.log("keyword : " + keyword);
		
		// 전역 함수 호출
		getList("1", keyword);
		
	});
	
// 페이지 클릭 처리
// class="clsPagingArea" : 여러개(오브젝트 배열)
// 정적 요소 : 달러(".clsPagingArea").on("click",function){
// 동적 요소 : 
$(document).on("click",".clsPagingArea", function(){
   //클릭한 것은 하나
   // <a .. data-current-page="2" data-keyword="".. class="page-link clsPagingArea">2</a>
   let currentPage = $(this).data("currentPage");	// 2
   let keyword = $(this).data("keyword");
   
   console.log("페이지 클릭 처리 -> currentPage : ", currentPage);
   console.log("페이지 클릭 처리 -> keyword : ", keyword);
   
   // 회원 목록 호출
   getList(currentPage, keyword);
});
});
</script>

<!-- /.content -->
<!-- ///// footer 시작 ///// -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  


