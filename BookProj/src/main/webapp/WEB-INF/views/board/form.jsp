<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<!-- 
page	scope->		pageContext
request	scope->		request	
session	scope->		Scope
application scope->	application
 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/adminlte/dist/css/adminlte.min.css" />
<script type="text/javascript" src="/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/resources/adminlte/dist/js/adminlte.js"></script>
<script type="text/javascript" src="/resources/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<title>일반게시판 등록/수정</title>
<style>
	.bi {
	   vertical-align: -.125em;
	   fill: currentColor;
	}
</style>
</head>
<body>
 	<div class="card card-primary">
        <div class="card-header">
          <h3 class="card-title">일반게시판</h3>
        </div>
        <!-- /.card-header -->
        <!-- form start -->
        <!-- 
        요청 URI : /board/insertPost
        요청 파라미터 : request{boTitle=개똥이게임,boWriter=이정재,boContent=개똥이게임2탄}
        요청 방식 : post	
         -->
        <form id="frm" action="/board/insertPost" method="post">
          <div class="card-body">
            <div class="form-group">
              <label for="boTitle">제목</label>
              <input type="text" class="form-control" 
              	id="boTitle" name="boTitle" placeholder="제목">
            </div>
            <div class="form-group">
              <label for="boWriter">작성자</label>
              <input type="text" class="form-control" 
              	id="boWriter"  name="boWriter" placeholder="작성자">
            </div>
            <div class="form-group">
              <label for="boContent">내용</label>
              	<textarea rows="3" cols="30" class="form-control" 
              	id="boContent" name="boContent" placeholder="내용"></textarea>
            </div>
           </div>
          <!-- /.card-body -->
          <div class="card-footer">
            <button type="submit" class="btn btn-primary">등록</button>
          </div>
        </form>
      </div>
<script type="text/javascript">
	CKEDITOR.replace("boContent");
</script>
</body>
</html>