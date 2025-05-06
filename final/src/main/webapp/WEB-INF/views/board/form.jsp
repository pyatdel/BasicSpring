<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
<sec:authentication property="principal" var="user"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/adminlte/dist/css/adminlte.min.css" />
<!-- 섬머노트 에디터 스타일 -->
<!-- <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
 -->
<%@ include file="../include/header.jsp" %>

<style>
.container-fluid {
    padding: 30px;
}
.card {
    margin: 0;
    box-shadow: 0 0 20px rgba(0,0,0,0.1);
}
.card-body {
    padding: 2rem;
}
.form-group {
    margin-bottom: 1.5rem;
}
.form-control {
    padding: .75rem;
}
#bodCont {
    min-height: 400px;
}
.note-editor {
    margin-bottom: 0;
}
.custom-file-label::after {
    content: "찾아보기";
}
#divImage img {
    max-width: 200px;
    height: auto;
    margin: 10px;
    border-radius: 4px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}
.file-size {
    color: #6c757d;
    font-size: 0.875em;
    margin-left: 10px;
}
.boardSub {
display: block !important;
height: auto !important;
}
</style>
</head>
<!-- content 시작 -->
<div class="container-fluid">
  <div class="card">
    <div class="card-header">
        <h3 class="card-title">게시글 작성</h3>
    </div>

    <form id="boardForm" action="/board/insertPost" method="post" enctype="multipart/form-data">
        <div class="card-body">
            <!-- 게시판 선택 -->
            <div class="form-group">
                <div class="row">
                    <div class="col-md-6">
                        <label for="boardType">게시판 선택</label>
                        <select class="form-control" id="boardType" name="boardTypeVO.bodTypeNo" required>
                            <option value="">게시판을 선택하세요</option>
                            <c:forEach var="boardTypeVO" items="${boardTypeVOList}">
                                <option value="${boardTypeVO.bodTypeNo}">${boardTypeVO.bodTypeName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <!-- 공지사항 설정 (게시판이 공지사항일 때만 표시) -->
                    <div class="col-md-6" id="noticeOptions" style="display: none;">
                        <label class="col-form-label">긴급</label>
                        <div class="custom-control custom-switch">
                            <input type="checkbox" class="custom-control-input" id="noticeType" name="noticeType">
                            <label class="custom-control-label" for="noticeType"></label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 제목 입력 -->
            <div class="form-group">
                <label for="bodTitle">제목</label>
                <input type="text" class="form-control" id="bodTitle" name="bodTitle" 
                       placeholder="제목을 입력하세요" required>
            </div>

            <!-- 작성자 -->
            <div class="form-group">
			    <label for="bodWriter">작성자</label>
			    <input type="text" class="form-control" id="bodWriter" name="bodWriter" 
			           value="${user.member.empName}" readonly>
			    <input type="hidden" name="empNo" value="${user.member.empNo}">
    			<input type="hidden" name="postNo" value="${user.member.postNo}">
			</div>

            <!-- 내용 입력 (섬머노트 에디터) -->
            <div class="form-group">
                <label for="bodCont">내용</label>
                <textarea id="bodCont" name="bodCont" class="form-control" required></textarea>
            </div>

            <!-- 첨부파일 -->
            <div class="form-group">
                <label for="uploadFile">첨부파일</label>
                <div class="custom-file">
                    <input type="file" class="custom-file-input" id="uploadFile" name="uploadFile" multiple>
                    <label class="custom-file-label" for="uploadFile">파일 선택</label>
                </div>
                <small class="form-text text-muted">
                    최대 5개까지 파일을 첨부할 수 있습니다. (파일당 최대 10MB)
                </small>
                <div id="divImage" class="mt-2 row">
                    <!-- 선택된 파일 목록이 여기에 표시됩니다 -->
                </div>
            </div>
        </div>

        <div class="card-footer">
            <div class="float-right">
                <a href="/board/list" class="btn btn-secondary">취소</a>
                <button type="submit" class="btn btn-primary">등록</button>
            </div>
        </div>
    </form>
     <!-- ///// footer 시작 ///// -->
 <jsp:include page="../include/footer.jsp"></jsp:include>
 <!-- ///// footer 끝 ///// -->
</div>

<!-- 필요한 스크립트 -->
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script>

<script>
$(function() {
   // 섬머노트 에디터 초기화
   $('#bodCont').summernote({
       height: 400,
       lang: 'ko-KR',
       toolbar: [
           ['style', ['style']],
           ['font', ['bold', 'underline', 'clear']],
           ['color', ['color']],
           ['para', ['ul', 'ol', 'paragraph']],
           ['table', ['table']],
           ['insert', ['link', 'picture']],
           ['view', ['fullscreen', 'codeview', 'help']]
       ],
       callbacks: {
           onImageUpload: function(files) {
               for(let i = 0; i < files.length; i++) {
                   uploadImage(files[i]);
               }
           },
           onChange: function(contents) {
               $('textarea[name="bodCont"]').val(contents);
           }
       }
   });

   // 이미지 미리보기
   $("#uploadFile").on("change", handleImg);
   
   // 긴급 설정 체크박스 변경 감지 
   $("#noticeType").on("change", function() {
       console.log("체크박스 변경됨:", $(this).is(":checked"));
   });
   
   // 게시판 선택에 따른 제어
   $("#boardType").on("change", function() {
        const selectedBoardType = $(this).val();
        if(selectedBoardType === "1") {
            $("#noticeOptions").show();
        } else {
            $("#noticeOptions").hide();
            $("#noticeType").prop("checked", false);
        }
    });

    // 페이지 로드 시 권한 체크
    const postNo = $("input[name='postNo']").val();
	if(postNo > 3) {
	    $("#boardType option[value='1']").remove();
	}

   // form submit 처리
   $("#boardForm").on("submit", function(e) {
       e.preventDefault();

       if(!$("#bodTitle").val().trim()) {
           alert("제목을 입력해주세요.");
           $("#bodTitle").focus();
           return false;
       }

       const content = $('#bodCont').summernote('code');
       if(!content || content === '<p><br></p>') {
           alert("내용을 입력해주세요.");
           $('#bodCont').summernote('focus');
           return false;
       }
       $("#bodCont").val(content);
       
       console.log("Form submitted!");
       const checkboxState = $("#noticeType").is(":checked");
       
       $("#boardForm input[name='noticeType']").remove();
       
       const boardType = $("#boardType").val();
       if(boardType === "1") {
           $("<input>")
               .attr({
                   type: "hidden",
                   name: "noticeType",
                   value: checkboxState ? 1 : 2
               })
               .appendTo($("#boardForm"));
       } else {
           $("<input>")
               .attr({
                   type: "hidden",
                   name: "noticeType",
                   value: 3
               })
               .appendTo($("#boardForm"));
       }
       
       console.log("최종 제출 상태:", {
           boardType: boardType,
           isChecked: checkboxState,
           noticeTypeValue: $("input[name='noticeType']").val(),
           content: content
       });
       
       this.submit();
   });
});

function handleImg(e) {
   let files = e.target.files;
   let fileArr = Array.prototype.slice.call(files);
   
   $("#divImage").html("");
   
   fileArr.forEach(function(f) {
       if(!f.type.match("image.*")) {
           alert("이미지 확장자만 가능합니다");
           return;
       }
       
       let reader = new FileReader();
       reader.onload = function(e) {
           let img = "<img src='" + e.target.result + "' style='width:20%;' />";
           $("#divImage").append(img);
       }
       reader.readAsDataURL(f);
   });

   const fileCount = files.length;
   $('.custom-file-label').text(fileCount > 1 ? `${fileCount}개의 파일 선택됨` : files[0].name);
}

function uploadImage(file) {
   const formData = new FormData();
   formData.append('file', file);

   $.ajax({
       url: '/board/uploadImage',
       method: 'POST',
       data: formData,
       processData: false,
       contentType: false,
       success: function(url) {
           $('#bodCont').summernote('insertImage', url);
       },
       error: function() {
           alert('이미지 업로드에 실패했습니다.');
       }
   });
}
</script>

