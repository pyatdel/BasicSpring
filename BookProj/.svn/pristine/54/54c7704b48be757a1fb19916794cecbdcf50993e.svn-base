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
    <div class="card card-info">
      <div class="card-header">
        <h3 class="card-title">Horizontal Form</h3>
      </div>
      <!-- /.card-header -->
      <!-- form start 
      요청URI : /stud/createPost
      요청파라미터 : request{email=test@test.com,password=java,
      						uploadFiles=파일객체들,rememberMe=}
      요청방식 : post
      -->
      <!-- model.addAttribute("studVO", studVO); -->
      <form class="form-horizontal" action="/stud/createPost" 
      	method="post" enctype="multipart/form-data">
        <div class="card-body">
          <div class="form-group row">
            <label for="email" class="col-sm-2 col-form-label">Email</label>
            <div class="col-sm-10">
              <input type="email" class="form-control" id="email"
              	name="email" placeholder="이메일주소"
              	value="${studVO.email}" required />
            </div>
          </div>
          <div class="form-group row">
            <label for="inputPassword3" class="col-sm-2 col-form-label">Password</label>
            <div class="col-sm-10">
              <input type="password" class="form-control" id="password"
              	name="password" placeholder="비밀번호"
              	value="${studVO.password}" required />
            </div>
          </div>
          <div class="form-group row">
            <label for="uploadFiles" class="col-sm-2 col-form-label">학생사진</label>
            <div class="col-sm-10">
              <!-- 첨부이미지 출력 시작 -->
              <div class="row">
              	<!-- 반복 시작 
              	studVO.fileGroupVO.fileDetailVOList : List<FileDetailVO>
              	-->
              	<c:forEach var="fileDetailVO" items="${studVO.fileGroupVO.fileDetailVOList}" varStatus="stat">
	                <div class="col-sm-3">
	                  <img class="img-fluid mb-3" src="${fileDetailVO.fileSaveLocate}" alt="Photo">
	                </div>
              	</c:forEach>
                <!-- 반복 끝 -->
                <!-- /.col -->
              </div>
              <!-- 첨부이미지 출력 끝 -->
            </div>
          </div>
          <div class="form-group row">
            <div class="offset-sm-2 col-sm-10">
              <div class="form-check">
              	<!-- 체크 : Y / 미체크 : null -->
                <input type="checkbox" class="form-check-input" id="remember_me"
                	name="rememberMe" value="Y"
                	<c:if test="${studVO.rememberMe=='Y'}"> 
                	checked
                	</c:if>
                	 />
                <label class="form-check-label" for="remember-me">자동로그인</label>
              </div>
            </div>
          </div>
        </div>
        <!-- /.card-body -->
        <div class="card-footer">
          <button type="submit" class="btn btn-info">Sign in</button>
          <button type="button" class="btn btn-default float-right">Cancel</button>
        </div>
        <!-- /.card-footer -->
      </form>
    </div>
    <!-- ///// content 끝 ///// -->
  </div><!-- /.container-fluid -->
</section>
<!-- /.content -->
    
<!-- ///// footer 시작 ///// -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  


