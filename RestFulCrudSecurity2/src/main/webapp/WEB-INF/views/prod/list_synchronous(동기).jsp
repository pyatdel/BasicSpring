<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
             <h3 class="card-title">[동기]</h3>
			<div class="card-tools">
			<!-- //// 검색 시작 //// 
            action 생략 : /member/list
            method 생략 : get
            요청파라미터 : keyword=개똥이 (왜냐하면 검색 후 currentPage는 1이기 때문에 생략 가능)
            -->
			<form>
				<div class="input-group input-group-sm" style="width: 150px;">
					<input type="text" name="keyword" value="" class="form-control float-right" placeholder="검색어 입력">

					<div class="input-group-append">
						<button type="submit" id="btnSearch" class="btn btn-default">
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
           <!-- 아이디로 오름차순 정렬 -->
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
               <c:forEach var="prodVO" items="${articlePage.content}" varStatus="stat">
                 <tr>
                   <td>${prodVO.rnum}</td>
                   <td><a href="/prod/detail?prodId=${prodVO.prodId}">${prodVO.prodId}</a></td>
                   <td>${prodVO.prodName}</td>
                   <td>${prodVO.prodLgu}</td>
                   <td>${prodVO.prodBuyer}</td>
                   <td><fmt:formatNumber pattern="#,###">${prodVO.prodSale}</fmt:formatNumber></td>
                   <td>${prodVO.prodOutline}</td>
                 </tr>
                 </c:forEach>
               </tbody>
             </table>
           </div>
           <!-- /.card-body -->
           <!-- card-footer 시작 -->
			<div "row justify-content-center" id="divPagination">
				${articlePage.pagingArea}
			</div>
			<!-- card-footer 끝 -->
         </div>
         <!-- /.card -->
       </div>
       <div class="col-12" style="justify-content: right; display: flex;">
		<a href="/prod/create" class="btn btn-primary">등록</a>
	   </div>
     </div>
    <!-- ///// content 끝 ///// -->
  </div><!-- /.container-fluid -->
</section>
<!-- /.content -->
<!-- ///// footer 시작 ///// -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  


