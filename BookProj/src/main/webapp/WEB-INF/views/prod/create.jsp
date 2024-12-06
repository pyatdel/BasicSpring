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
    <div class="card card-primary">
      <div class="card-header">
        <h3 class="card-title">상품 등록</h3>
      </div>
      <!-- /.card-header -->
       <form id="frm" action="/prod/createPost" method="post">
      <div class="card-body">
        <h4>상품 등록</h4>
        <div class="form-group">
          <label for="prodId">상품코드</label>
          <input type="text" class="form-control form-control-border" id="prodId" name="prodId"
          	value="" placeholder="상품코드" required/>
        </div>
        <div class="form-group">
          <label for="prodName">상품명</label>
          <input type="text" class="form-control form-control-border" id="prodName" name="prodName"
          	value="" placeholder="상품명" required/>
        </div>
        <div class="form-group">
          <label for="prodLgu">상품분류코드</label>
          <select class="form-control" id="prodLgu" name="prodLgu">
          <!-- !!!상품분류 추가!!! -->
	          <c:forEach var="lprodVO" items="${lprodVOList}">
	          	<option value="${lprodVO.lprodGu}">${lprodVO.lprodNm}</option>
	          </c:forEach>
          </select>
          <!-- !!!상품분류 끝!!! -->
<!--           <input type="text" class="form-control form-control-border" id="prodLgu" name="prodLgu" -->
<!--           	value="" placeholder="상품분류코드" required/> -->
        </div>
        <div class="form-group">
          <label for="prodBuyer">거래처코드</label>
          <!-- !!!거래처코드 추가!!! -->
          <select class="form-control" id="prodBuyer" name="prodBuyer">
	          <c:forEach var="buyerVO" items="${buyerVOList}">
	          	<option value="${buyerVO.buyerId}">${buyerVO.buyerName}</option>
	          </c:forEach>
          </select>
          <!-- !!!거래처코드 끝!!! -->
<!--           <input type="text" class="form-control form-control-border" id="prodBuyer" name="prodBuyer" -->
<!--           	value="" placeholder="거래처코드" required/> -->
        </div>
        <div class="form-group">
          <label for="prodSale">판매가</label>
          <input type="text" class="form-control form-control-border" id="prodSale" name="prodSale"
          	value="" placeholder="판매가" required/>
        </div>
        <div class="form-group">
          <label for="prodOutline">설명</label>
          <input type="text" class="form-control form-control-border" id="prodOutline" name="prodOutline"
          	value="" placeholder="설명" required/>
        </div>
      </div>
     <!-- /.card-body -->
     
       <div class="card-footer">
		<span id="spn1" class="justify-between">
		   <p style="float:left;">
		    <button type="submit" id="btnSubmit"
		       class="btn btn-primary btn-user" 
		       style="float:left;" >등록</button>&nbsp;
		   </p>
		   <p style="float:right;">
		     <a href="/prod/list" class="btn btn-success btn-user">
		            목록
		     </a>
		    </p>
		</span>
		</div>
	<!-- 일반모드 끝 -->
	</form>
    </div>
    <!-- ///// content 끝 ///// -->
  </div><!-- /.container-fluid -->
</section>
<!-- /.content -->
    
<!-- ///// footer 시작 ///// -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  


