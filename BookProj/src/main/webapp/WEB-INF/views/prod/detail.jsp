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
<script type="text/javascript" src="/js/jquery.min.js"></script>

<section class="content">
  <div class="container-fluid">
    <!-- ///// content 시작 ///// -->
    
    
    <h1>상품분류 상세</h1>
	<!-- mav.addObject("title", "도서생성"); -->
	<h5>${title}</h5>
	<!-- 
	요청URI : /lprod/createPost
	요청파라미터 : {lprodGu=P701, lprodNm=도서류}
	요청방식 : post
	
	model.addAttribute("lprodVO", lprodVO)
	-->

	<div class="row">
		<div class="col-md-12">
			<form id="frm" action="/prod/createPost" method="post">
   <!-- 폼데이터 -->
   <input type="text" name="prodId" value="${prodVO.prodId}" />
   <p>상품명 : <input class="form-control" type="text" name="prodName" 
        value="${prodVO.prodName}" required placeholder="상품명" readonly /></p>
   <p>상품 분류 코드 : 
    <select class="form-control" name="prodLgu" required>
        <c:forEach var="lprodVO" items="${lprodVOList}">
            <option value="${lprodVO.lprodGu}" 
                    ${prodVO.prodLgu eq lprodVO.lprodGu ? 'selected' : ''}>
                ${lprodVO.lprodNm}
            </option>
        </c:forEach>
    </select>
</p>
   <p>거래처 코드 : 
    <select class="form-control" name="prodBuyer" required>
        <c:forEach var="buyerVO" items="${buyerVOList}">
            <option value="${buyerVO.buyerId}" 
                    ${prodVO.prodBuyer eq buyerVO.buyerId ? 'selected' : ''}>
                ${buyerVO.buyerName}
            </option>
        </c:forEach>
    </select>
</p>
   <p>판매가 : <input type="text" class="form-control" name="prodSale" 
        value="${prodVO.prodSale}" required placeholder="판매가" readonly /></p>
   <p>설명 : <input type="text" class="form-control" name="prodOutline" 
        value="${prodVO.prodOutline}" required placeholder="설명" readonly /></p>
			   <!-- 일반모드 시작 -->
		        <span id="spn1" class="justify-between">
			        <p style="float:left;">
			          <button type="button" id="edit"  
			          	class="btn btn-primary btn-user" 
			          	style="float:left;">수정</button>&nbsp;
			          <button type="button" id="delete"  
			                	class="btn btn-primary btn-user">삭제</button>
			         </p>
			         <p style="float:right;">
			          <a href="/prod/list?currentPage=${param.currentPage}&keyword=${param.keyword}" class="btn btn-success btn-user">
			              	목록
			          </a>
			         </p>
		        </span>
		        <!-- 일반모드 끝 -->
		        <!-- 수정모드 시작 -->
		        <span id="spn2" class="justify-between" style="display:none;">
		         <span style="float:left;">
			         <button type="submit" class="btn btn-primary btn-user">
			             	확인
			         </button>
		         </span>
		         <span style="float:right;">
			         <a href="/prod/detail?prodId=${param.prodId}" 
			         	class="btn btn-success btn-user">
			             	취소
			         </a>
		         </span>
		        </span>
		        <!-- 수정모드 끝 -->
			</form>
		</div>
	</div>
	
	<!-- 
	요청URI : /lprod/createProdsPost
	요청파라미터 : request{prodVOList[0].prodId=P109000001,prodVOList[0].prodName=개똥이제과,
		prodVOList[0].prodLgu=P109,prodVOList[0].prodBuyer=P10901...}
	요청방식 : post
	 -->
	<form id="frmProd" name="frmProd" action="/prod/createProdsPost" method="post">
	<div class="row">
		<div class="col-md-12 justify-content-between">
			<div class="float-left">
				<div class='card-tools'>
				</div>
			</div>
			<div class="float-right">
			</div>
		</div>
	</div>
	</form>

    <!-- ///// content 끝 ///// -->
  </div><!-- /.container-fluid -->
</section>

<script type="text/javascript">
//CKEditor5 그리기
//<div id="prodOutline0"..
//window.editor를 통해 CKEditor 객체에 접근하겠음
ClassicEditor.create(document.querySelector('#prodOutline0'),{ckfinder:{uploadUrl:'/image/upload'}})
			 .then(editor=>{window.editor=editor;})
			 .catch(err=>{console.error(err.stack);});

</script>

<script type="text/javascript">
//$ is not defined -> jquery가 import 안 됨
//document 내의 모든 요소들이 로딩된 후에 실행.
$(function(){
	//CKEditor 값 복제
	$(".ck-blurred").keydown(function(){
		console.log("str : " + window.editor.getData());
		//ckeditor(window.editor) -> textarea
		$("#prodOutlineT0").val(window.editor.getData());
	});
	$(".ck-blurred").on("focusout",function(){
		//ckeditor(window.editor) -> textarea
		$("#prodOutlineT0").val(window.editor.getData());
	});
	
	
	//수정버튼 클릭 -> 수정모드로 전환
	$("#edit").on("click",function(){
		//수정영역 가려짐
		$("#spn1").css("display","none");
		//일반영역 보임
		$("#spn2").css("display","block");
		//1) 입력란 활성화(class="form-control") readonly 속성을 제거
		$(".form-control").removeAttr("readonly");
		
		//2) <form id="frm" select하여 오브젝트를 가져옴. action속성의 값을
		//		/lprod/updatePost로 변경
		$("#frm").attr("action","/prod/updatePost");
		
		//3) 확인 버튼 클릭 시 submit 되어 update 처리 후 
		//		/prod/detail?prodId=10 로 redirect
	});
	
	//삭제버튼 클릭 -> 삭제처리
	$("#delete").on("click",function(){
		//1) <form id="frm" select하여 오브젝트를 가져옴. action속성의 값을
		//		/lprod/deletePost로 변경
		$("#frm").attr("action","/prod/deletePost");
		
		let result = confirm("삭제하시겠습니까?");
		//true : 1, false : 0
		//result 확인
		if(result>0){//true
			//submit 처리
			$("#frm").submit();
			//LprodController의 deletePost 메소드에서
			// 삭제처리 완료 후 /lprod/list로 redirect 함
		}else{
			alert("삭제가 취소되었습니다");
		}
	});
	
});
</script>
<!-- /.content -->
    
<!-- ///// footer 시작 ///// -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  


