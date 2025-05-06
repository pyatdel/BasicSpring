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
          <!-- !!!상품분류 추가!!! -->
          <select class="form-control" id="prodLgu" name="prodLgu">
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
          	value="${prodVO.prodOutline}" placeholder="설명"  />
        </div>
        <!-- 
        <div class="form-group">
          <label for="prodOutline">설명</label>
          <!-- CKEditor5가 그려짐 
          <div id="prodOutline0"></div> 
			<textarea rows="3" cols="50"
             id="prodOutlineT0" name="prodOutline" class="form-control form-control-border"
             placeholder="설명" readonly>
            </textarea>
        </div>
         -->
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
		     <a href="/member/list" class="btn btn-success btn-user">
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

<script type="text/javascript">
$(function(){
	
	// 상품 등록 비동기 처리
	$("#btnSubmit").on("click",function(e){
		e.preventDefault();
		console.log("상품 등록 비동기 처리");
		
		let prodId = $("#prodId").val();
	    let prodName = $("#prodName").val();
	    let prodLgu = $("#prodLgu").val();
	    let prodBuyer = $("#prodBuyer").val();
	    let prodSale = $("#prodSale").val();
	    let prodOutline = $("#prodOutline").val();
	    
	  // 1. 가상 폼(이미지 포함) <form></form>
	  let data = {
		"prodId":prodId,
		"prodName":prodName,
		"prodLgu":prodLgu,
		"prodBuyer":prodBuyer,
		"prodSale":prodSale,
		"prodOutline":prodOutline
	  };
	      
	  console.log("data : ", data);
	  
      // 3. 아작나써유.. 피씨다타써
      $.ajax({
    	  url:"/prod/createPostAjax",
    	  contentType:"application/json;charset=utf-8",
    	  data:JSON.stringify(data),
    	  type:"post",
    	  dataType:"text",
    	  success:function(result){
		      // 5. 결과 확인(1 또는 0)
    		  // 0 또는 1
    		  console.log("result : ", result);
		      
		      if(result==1){
		    	// sweetalert : success, error, warning, info, question
				var Toast = Swal.mixin({
					toast: true,
					position: 'top-end',
					showConfirmButton: false,
					timer: 3000
				});
				
				Toast.fire({
					icon:'success',
					title:'상품 등록 성공!'
				}); 
				setTimeout(function(){
				location.href="/prod/detail?prodId="+$("#prodId").val();
				},3000);
		      }else{
		    	// sweetalert : success, error, warning, info, question
					var Toast = Swal.mixin({
						toast: true,
						position: 'top-end',
						showConfirmButton: false,
						timer: 3000
					});
					
					Toast.fire({
						icon:'warning',
						title:'상품 등록 실패!'
					}); 
		      }
    	  }
      });
	});
	});
	
</script>    
<!-- ///// footer 시작 ///// -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  


