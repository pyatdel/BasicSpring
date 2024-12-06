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
    
    
    <h1>상품분류 등록</h1>
	<!-- mav.addObject("title", "도서생성"); -->
	<h5>${title}</h5>
	<!-- 
	요청URI : /lprod/createPost
	요청파라미터 : {lprodGu=P701, lprodNm=도서류}
	요청방식 : post
	-->
	<form id="frm" action="/lprod/createPost" method="post">
	   <!-- 폼데이터 -->
	   <p>상품분류코드 : <input type="text" name="lprodGu" required placeholder="상품분류코드" /></p>
	   <p>상품분류명 : <input type="text" name="lprodNm" required placeholder="상품분류명" /></p>
	   <p>
	      <input type="submit" id="btnSave" value="저장" />
	   </p>
	</form>


    <!-- ///// content 끝 ///// -->
  </div><!-- /.container-fluid -->
</section>
<!-- /.content -->
    
<!-- ///// footer 시작 ///// -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  


