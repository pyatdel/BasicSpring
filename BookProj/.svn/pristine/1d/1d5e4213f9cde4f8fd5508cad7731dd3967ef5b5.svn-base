<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 
page Scope -> pageContext
request Scope -> request
session Scope -> session
application Scope -> application
 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/adminlte/dist/css/adminlte.min.css" />
<script type="text/javascript" src="/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/resources/adminlte/dist/js/adminlte.js"></script>
<script type="text/javascript" src="/resources/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- ///// header 시작 ///// -->
<jsp:include page="../include/header.jsp"></jsp:include>
<!-- ///// header 끝 ///// -->

<script type="text/javascript">
//e : 변경 이벤트 오브젝트
function handleImg(e){
	console.log("개똥이");
	
	//이미지 오브젝트 들
	let files = e.target.files;
	
	//이미지 오브젝트 배열(a.jpgb.jpgc.jpg)
	let fileArr = Array.prototype.slice.call(files);
	
	//미리보기 영역 초기화
	$("#divImage").html("");
	
	fileArr.forEach(function(f){
		if(!f.type.match("image.*")){
			alert("이미지 확장자만 가능합니다");
			return;//함수 종료
		}
		//이미지 읽기
		let reader = new FileReader();
		//e : 읽는 이벤트
		reader.onload = function(e){
			let img = "<img src='" + e.target.result + "' style='width:20%;' />";
			//누적 : append(), 덮어쓰기 : html()
			$("#divImage").append(img);
		}
		reader.readAsDataURL(f);
	});
	
}

$(function(){
	$("#uploadFile").on("change",handleImg);
});
</script>


	<!-- 폼페이지
	요청URI : /createPost
	요청파라미터(HTTP파라미터, QueryString) : 
		request{title=개똥이의 모험, category=소설, price=12000
			, uploadFile=파일객체들}
	요청방식 : post
	
	get방식 : 주소표시줄에 요청파라미터가 노출됨
	post방식 : 주소표시줄에 요청파라미터가 노출되지 않음. 주소창에 변화 없이
				데이터만 서버로 전달 됨
	-->
	<form action="/createPost" method="post"
		enctype="multipart/form-data">
	   <!-- 폼데이터 -->
	   <p>제목 : <input type="text" name="title" required placeholder="제목" /></p>
	   <p>카테고리 : <input type="text" name="category" required placeholder="카테고리" /></p>
	   <p>가격 : <input type="number" name="price" required placeholder="가격" /></p>
	   <div class="form-group">
         <label for="uploadFile">첨부파일</label>
       	 <div class="input-group">
           <div class="custom-file">
             <input type="file" class="custom-file-input" 
             	id="uploadFile" name="uploadFile" multiple />
             <label class="custom-file-label" for="uploadFile">Choose file</label>
           </div>
         </div>
         <div id="divImage"></div>
       </div>
	   <p>
	      <!-- <form>~</form> 태그 안에 내용이 서버로 전송됨
	            서버로 전달되는 항목들은 form 태그 안에 존재해야 함.
	            name 속성은 key로, value 속성을 value로 판단함
	          -->
	      <input type="submit" value="저장" />
	      <input type="button" value="목록" onclick="javascript:location.href='/list'" />
	   </p>
	</form>

<!-- ///// footer 시작 ///// -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  


