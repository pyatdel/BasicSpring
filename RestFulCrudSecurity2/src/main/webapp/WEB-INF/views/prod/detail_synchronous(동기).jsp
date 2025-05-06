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
        <h3 class="card-title">상품 상세</h3>
      </div>
      <!-- /.card-header -->
       <form id="frm" action="/prod/updatePost" method="post">
      <div class="card-body">
        <h4>상품 상세</h4>
        <div class="form-group">
          <label for="prodId">상품코드</label>
          <input type="text" class="form-control form-control-border" id="prodId" name="prodId"
          	value="${prodVO.prodId}" placeholder="상품코드" readonly />
        </div>
        <div class="form-group">
          <label for="prodName">상품명</label>
          <input type="text" class="form-control form-control-border" id="prodName" name="prodName"
          	value="${prodVO.prodName}" placeholder="상품명" readonly />
        </div>
        <div class="form-group">
          <label for="prodLgu">상품분류코드</label>
          <!-- !!!상품분류 추가!!! -->
          <select class="form-control" id="prodLgu" name="prodLgu" disabled >
	          <c:forEach var="lprodVO" items="${lprodVOList}">
	          	<option value="${lprodVO.lprodGu}"${lprodVO.lprodGu == prodVO.prodLgu ? 'selected' : ''}> 
	          		${lprodVO.lprodNm}
	          	</option>
	          </c:forEach>
          </select> 
          <!-- !!!상품분류 끝!!! -->
          <%-- <input type="text" class="form-control form-control-border" id="prodLgu" name="prodLgu"
          	value="${prodVO.prodLgu}" placeholder="상품분류코드" readonly />  --%>
        </div>
        <div class="form-group">
          <label for="prodBuyer">거래처코드</label>
          <!-- !!!거래처코드 추가!!! -->
          <select class="form-control" id="prodBuyer" name="prodBuyer" disabled>
	          <c:forEach var="buyerVO" items="${buyerVOList}">
	          	<option value="${buyerVO.buyerId}" ${buyerVO.buyerId == prodVO.prodBuyer ? 'selected' : ''}>
	          		${buyerVO.buyerName}</option>
	          </c:forEach>
          </select>
          <!-- !!!거래처코드 끝!!! -->
         <%--  <input type="text" class="form-control form-control-border" id="prodBuyer" name="prodBuyer"
          	value="${prodVO.prodBuyer}" placeholder="거래처코드" readonly /> --%> 
        </div>
        <div class="form-group">
          <label for="prodSale">판매가</label>
          <input type="text" class="form-control form-control-border" id="prodSale" name="prodSale"
          	value="${prodVO.prodSale}" placeholder="판매가" readonly />
        </div>
        <div class="form-group">
          <label for="prodOutline">판매가</label>
          <input type="text" class="form-control form-control-border" id="prodOutline" name="prodOutline"
          	value="${prodVO.prodOutline}" placeholder="설명" readonly />
        </div>
        <!-- 
        <div class="form-group">
          <label for="prodOutline">설명</label>
          <!-- CKEditor5가 그려짐 
          <div id="prodOutline0"></div> 
			<textarea rows="3" cols="50"
             id="prodOutlineT0" name="prodVOList[0].prodOutline" class="form-control form-control-border"
             placeholder="설명" readonly>
            </textarea>
        </div>
         -->
        
      </div>
     <!-- /.card-body -->
     
       <!-- 일반모드 시작 -->
        <div class="card footer">
        <span id="spn1" class="justify-between">
           <p style="float:left;">
             <button type="button" id="edit"  
                class="btn btn-primary btn-user" 
                style="float:left;">수정</button>&nbsp;
             <button type="button" id="delete"  
                      class="btn btn-primary btn-user">삭제</button>
            </p>
            <p style="float:right;">
             <a href="/prod/list" class="btn btn-success btn-user">
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
    <!-- ///// content 끝 ///// -->
  </div><!-- /.container-fluid -->
</section>
<!-- /.content -->
 <script type="text/javascript">
// CKEditor5 그리기
// <div id="prodOutline0"..>
// window.editor를 통해 CKEditor5 객체에 접근하겠다는 뜻 => window.editor 이게 제일 중요!!!
/* 
ClassicEditor.create(document.querySelector('#prodOutline0'),{ckfinder:{uploadUrl:'/image/upload'}})
			 .then(editor=>{window.editor=editor;})
			 .catch(err=>{console.error(err.stack);});
 */
</script>

<script type="text/javascript"> 
$(function(){
	
	
	// 수정버튼 클릭 -> 수정모드로 전환
	$("#edit").on("click", function() {
		// 수정영역 가려짐
		$("#spn1").css("display", "none");
		// 일반영역 보임
		$("#spn2").css("display", "block");

		// 1) 입력란 활성화(class="form-control") readonly, disabled 속성 제거
		$(".form-control").removeAttr("readonly");
		$(".form-control").removeAttr("disabled");
	
		$("#prodId").attr("readonly",true);
		// $("#prodLgu").attr("disabled",true);
		// $("#prodBuyer").attr("disabled",true);

		// 2) <form id="frm" select하여 오브젝트를 가져옴. 
		// action 속성의 값을 /lprod/updatePost로 변경
		$("#frm").attr("action", "/prod/updatePost");

		// 3) 확인 버튼 클릭 시 submit 되어 update 처리 후 
		// /lprod/detail?lprodId=10 로 redirect
	});
	 /**/
	// 회원 삭제 버튼 클릭
	$("#delete").on("click", function(){
		let prodId = $("#prodId").val();
		
		$("#frm").attr("action","/prod/deletePost");
		
		
		let result = confirm("삭제하시겠습니까?"); 
		console.log("result : ", result);
		
		if(result > 0){

			$("#frm").submit();	
		}else{
			var Toast = Swal.mixin({
			      toast: true,
			      position: 'top-end',
			      showConfirmButton: false,
			      timer: 3000
			    });
			
			Toast.fire({
				icon:'success',
				title:'삭제가 취소되었습니다.'
			});
		}
	});
		
});
</script>
<!-- ///// footer 시작 ///// -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  


