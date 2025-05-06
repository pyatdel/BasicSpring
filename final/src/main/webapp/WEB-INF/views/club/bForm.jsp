<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authentication property="principal" var="user"/>

<!-- Bootstrap 4 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
<!-- 섬머노트 에디터 스타일 -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">

<%@ include file="../include/header.jsp" %>

    <div class="container-fluid">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">
                    <i class="fas fa-pen text-primary"></i> 게시글 작성
                </h3>
            </div>

            <form id="insertPost" action="/community/club/${clubNo}/insertPost" method="post" enctype="multipart/form-data">
		    	<div class="card-body">

                    <!-- 제목 입력 -->
                    <div class="form-group">
					    <label for="clubComTitle">제목</label>
					    <input type="text" class="form-control" id="clubComTitle" name="clubComTitle" 
					           placeholder="제목을 입력하세요" required>
					</div>
                    <div class="form-group">
					    <label for="clubComType">유형 선택</label>
					    <select class="form-control" id="clubComType" name="clubComTypeVO.clubComTypeNo" required>
					        <option value="">유형을 선택하세요</option>
					        <c:forEach var="clubComTypeVO" items="${clubComTypeVOList}">
					            <option value="${clubComTypeVO.clubComTypeNo}">${clubComTypeVO.clubComTypeName}</option>
					        </c:forEach>
					    </select>
					</div>

                    <!-- 작성자 정보 -->
                    <div class="form-group">
					    <label for="clubComWriter">작성자</label>
					    <input type="text" class="form-control" id="clubComWriter" name="clubComWriter" 
					           value="${user.member.empName}" readonly>
					</div>

                    <!-- 내용 입력 -->
                    <div class="form-group">
					    <label for="clubComCont">내용</label>
					    <textarea id="clubComCont" name="clubComCont" class="form-control" required></textarea>
					</div>

                    <!-- 첨부파일 -->
                    <div class="form-group">
                        <label>첨부파일</label>
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="files" name="files" 
                                   multiple accept="${param.type == 'photo' ? 'image/*' : '*'}">
                            <label class="custom-file-label" for="files">파일 선택</label>
                        </div>
                        <small class="form-text text-muted">
                            <c:choose>
                                <c:when test="${param.type == 'photo'}">
                                    이미지 파일만 업로드 가능합니다. (jpg, png, gif)
                                </c:when>
                                <c:otherwise>
                                    최대 5개까지 파일을 첨부할 수 있습니다. (파일당 최대 10MB)
                                </c:otherwise>
                            </c:choose>
                        </small>
                        <div id="filePreview" class="mt-3 row">
                            <!-- 파일 미리보기 영역 -->
                        </div>
                    </div>
                </div>

                <div class="card-footer">
                    <div class="float-right">
                        <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                        <button type="submit" class="btn btn-primary">등록</button>
                    </div>
                </div>
            </form>
        </div>
</div>

<style>
.community-write-wrapper {
    padding: 40px;
    background: #f8f9fa;
    min-height: calc(100vh - 60px);
}

.card {
    border: none;
    box-shadow: 0 0 20px rgba(0,0,0,0.1);
    border-radius: 0.5rem;
}

.card-header {
    background-color: #fff;
    border-bottom: 1px solid #eee;
    padding: 1.5rem;
}

.card-body {
    padding: 2rem;
}

.form-group {
    margin-bottom: 1.5rem;
}

.form-control {
    border-radius: 0.35rem;
    border: 1px solid #ddd;
    padding: 0.75rem;
}

.form-control:focus {
    border-color: #80bdff;
    box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
}

#content {
    min-height: 400px;
}

.note-editor {
    border-radius: 0.35rem;
    border-color: #ddd !important;
}

.custom-file-label {
    border-radius: 0.35rem;
    padding: 0.75rem;
}

.custom-file-label::after {
    content: "찾아보기";
    height: 100%;
    padding: 0.75rem;
    border-radius: 0 0.35rem 0.35rem 0;
}

#filePreview img {
    max-width: 150px;
    max-height: 150px;
    margin: 5px;
    border-radius: 0.35rem;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.btn {
    padding: 0.5rem 1.5rem;
    border-radius: 0.35rem;
    font-weight: 500;
}

.custom-switch {
    padding-left: 3.25rem;
}

.custom-control-label {
    padding-top: 2px;
}

/* 반응형 스타일 */
@media (max-width: 768px) {
    .community-write-wrapper {
        padding: 20px;
    }
    
    .card-body {
        padding: 1.5rem;
    }
    
    .form-control {
        font-size: 14px;
    }
}
</style>

<!-- 필요한 스크립트 -->
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script>

<script>
$(function() {
	console.log("clubNo: ", "${clubNo}");ooooo
    // 섬머노트 에디터 초기화
    $('#content').summernote({
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
                uploadImage(files[0]);
            }
        }
    });

    // 파일 선택 시 처리
    $('#files').on('change', function(e) {
    const files = e.target.files;
    const fileCount = files.length;
    
    // 파일명 표시
    $('.custom-file-label').text(fileCount > 1 ? `${fileCount}개 파일 선택됨` : files[0].name);
    
    // 미리보기 초기화
    $('#filePreview').empty();
    
    // 파일 타입 체크 및 미리보기
    Array.from(files).forEach(file => {
        if (file.type.startsWith('image/')) {
            const reader = new FileReader();
            reader.onload = function(e) {
                $('#filePreview').append(`
                    <div class="col-auto">
                        <img src="${e.target.result}" class="img-preview">
                    </div>
                `);
            }
            reader.readAsDataURL(file);
        } else {
            // formatFileSize를 직접 호출하도록 수정
            const fileSize = formatFileSize(file.size);
            $('#filePreview').append(`
                <div class="col-12">
                    <p class="mb-1">
                        <i class="fas fa-file mr-2"></i>${file.name}
                        <small class="text-muted">(${fileSize})</small>
                    </p>
                </div>
            `);
        }
    });
});

    // 폼 제출 전 유효성 검사
    $('#insertPost').on('submit', function(e) {
        e.preventDefault();
        
        if (!$('#title').val().trim()) {
            alert('제목을 입력해주세요.');
            $('#title').focus();
            return false;
        }
        
        const content = $('#content').summernote('code');
        if (!content || content === '<p><br></p>') {
            alert('내용을 입력해주세요.');
            $('#content').summernote('focus');
            return false;
        }

        // 사진게시판인 경우 이미지 필수 체크
        if ('${param.type}' === 'photo') {
            const files = $('#files')[0].files;
            let hasImage = false;
            
            for (let file of files) {
                if (file.type.startsWith('image/')) {
                    hasImage = true;
                    break;
                }
            }
            
            if (!hasImage) {
                alert('사진게시판에는 최소 1개 이상의 이미지를 첨부해야 합니다.');
                return false;
            }
        }

        this.submit();
    });
});

// 파일 크기 포맷팅
function formatFileSize(bytes) {
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
}

// 이미지 업로드 처리
function uploadImage(file) {
    const formData = new FormData();
    formData.append('file', file);

    $.ajax({
        url: '/community/uploadImage',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            $('#content').summernote('insertImage', response.url);
        },
        error: function() {
            alert('이미지 업로드에 실패했습니다.');
        }
    });
}
</script>

<%@ include file="../include/footer.jsp" %>