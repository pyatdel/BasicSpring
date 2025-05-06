<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
    
    
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/adminlte/dist/css/adminlte.min.css" />

<!-- header -->
<jsp:include page="../include/header.jsp"></jsp:include>

<div class="container mt-4">
   <div class="row justify-content-center">
       <div class="col-lg-10">
           <div class="card">
               <div class="card-header bg-light">
                   <h3 class="card-title mb-0">게시글 작성</h3>
               </div>
               
               <form id="frm" action="/board/insertPost" method="post" enctype="multipart/form-data">
                   <div class="card-body">
                       <!-- 게시판 선택 -->
                       <div class="form-group row">
                           <label class="col-sm-2 col-form-label">게시판</label>
                           <div class="col-sm-4">
                               <select class="form-control" name="boardTypeVO.bodTypeNo">
                                   <c:forEach var="boardTypeVO" items="${boardTypeVOList}">
                                       <option value="${boardTypeVO.bodTypeNo}">${boardTypeVO.bodTypeName}</option>
                                   </c:forEach>
                               </select>
                           </div>
                       </div>

                       <!-- 제목 -->
                       <div class="form-group row">
                           <label for="bodTitle" class="col-sm-2 col-form-label">제목</label>
                           <div class="col-sm-10">
                               <input type="text" class="form-control" id="bodTitle" name="bodTitle" 
                                      placeholder="제목을 입력해주세요" required>
                           </div>
                       </div>

                       <!-- 작성자 -->
                       <div class="form-group row">
                           <label for="bodWriter" class="col-sm-2 col-form-label">작성자</label>
                           <div class="col-sm-4">
                               <input type="text" class="form-control" id="bodWriter" name="bodWriter" 
                                      value="늪고래" readonly>
                           </div>
                       </div>

                       <!-- 긴급 설정 (공지사항일 때만 표시) -->
                       <div class="form-group row notice-settings" style="display: none;">
                           <label class="col-sm-2 col-form-label">긴급 설정</label>
                           <div class="col-sm-10">
                               <div class="custom-control custom-switch">
                                   <input type="checkbox" class="custom-control-input" id="noticeType" name="noticeType">
                                   <label class="custom-control-label" for="noticeType">긴급</label>
                               </div>
                           </div>
                       </div>

                       <!-- 내용 -->
                       <div class="form-group">
                           <textarea id="bodCont" name="bodCont" class="form-control" rows="10"></textarea>
                       </div>

                       <!-- 파일 첨부 -->
                       <div class="form-group">
                           <label>첨부파일</label>
                           <div class="custom-file">
                               <input type="file" class="custom-file-input" id="uploadFile" name="uploadFile" multiple>
                               <label class="custom-file-label" for="uploadFile">파일을 선택하세요</label>
                           </div>
                           <div id="divImage" class="mt-3 row"></div>
                       </div>
                   </div>

                   <!-- 버튼 영역 -->
                   <div class="card-footer">
                       <div class="d-flex justify-content-end">
                           <button type="submit" class="btn btn-primary mr-2">
                               <i class="fas fa-check mr-1"></i>등록
                           </button>
                           <a href="/board/list" class="btn btn-secondary">
                               <i class="fas fa-list mr-1"></i>목록
                           </a>
                       </div>
                   </div>
               </form>
           </div>
       </div>
   </div>
</div>
<!-- footer -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<script type="text/javascript">
$(function(){
   // 이미지 미리보기
   $("#uploadFile").on("change",handleImg);
   
   $("#noticeType").on("change", function() {
       console.log("체크박스 변경됨:", $(this).is(":checked"));
   });
   
   function handleImg(e){
       let files = e.target.files;
       let fileArr = Array.prototype.slice.call(files);
       
       $("#divImage").html("");
       
       fileArr.forEach(function(f){
           if(!f.type.match("image.*")){
               alert("이미지 확장자만 가능합니다");
               return;
           }
           
           let reader = new FileReader();
           reader.onload = function(e){
               let img = "<img src='"+e.target.result+"' style='width:20%;' />";
               $("#divImage").append(img);
           }
           reader.readAsDataURL(f);
       });
   }
   
   // 게시판 선택에 따른 긴급설정 표시 제어
   $("select[name='boardTypeVO.bodTypeNo']").on("change", function() {
       const selectedBoardType = $(this).val();
       // 공지사항(1)일 때만 긴급설정 보이게 하기
       if(selectedBoardType === "1") {
           $(".notice-settings").show();
       } else {
           $(".notice-settings").hide();
           // 다른 게시판 선택시 긴급설정 체크 해제
           $("#noticeType").prop("checked", false);
       }
   });
   
   // 페이지 로드시 초기 설정
   const initialBoardType = $("select[name='boardTypeVO.bodTypeNo']").val();
   if(initialBoardType === "1") {
       $(".notice-settings").show();
   }
   
   // form submit 처리
   $("#frm").on("submit", function(e) {
    e.preventDefault(); 
    
    console.log("Form submitted!");
    const checkboxState = $("#noticeType").is(":checked");
    
    $("#frm input[name='noticeType']").remove();
    
    const boardType = $("select[name='boardTypeVO.bodTypeNo']").val();
    if(boardType === "1") {
        
        $("<input>")
            .attr({
                type: "hidden",
                name: "noticeType",
                value: checkboxState ? 1 : 2  
            })
            .appendTo($("#frm"));
    } else {
        $("<input>")
            .attr({
                type: "hidden",
                name: "noticeType",
                value: 3
            })
            .appendTo($("#frm"));
    }
    
    // 폼 제출 전에 상태 한 번 더 확인
    console.log("최종 제출 상태:", {
        boardType: boardType,
        isChecked: checkboxState,
        noticeTypeValue: $("input[name='noticeType']").val()
    });
    
    this.submit();
});
   
   // CKEDITOR 초기화
   CKEDITOR.replace("bodCont");
});
</script>


</html>
