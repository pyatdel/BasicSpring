<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  


<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
<!-- <script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
Include summernote css/js
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
 -->
<style>
    .category-badge {
        font-size: 1.1rem;
        padding: 0.7rem 1.5rem;
        border-radius: 30px;
        transition: all 0.2s ease;
        cursor: pointer;
        font-weight: normal;
        background-color: #f1f3f5;
        color: #495057;
    }
    
    .category-badge:hover, .category-badge.active {
        background-color: #4263eb;
        color: white;
    }
    
    .form-section {
        background: white;
        border-radius: 10px;
        padding: 2rem;
        box-shadow: 0 0 20px rgba(0,0,0,0.05);
    }
</style>

</head>


<!-- 헤더 include  -->
   <jsp:include page="../include/header.jsp"></jsp:include>
<!-- 헤더 include  -->
    
<!-- ///// content 시작 ///// -->
<div class="container-fluid mt-4 px-5">
    <!-- 페이지 헤더 -->
    <div class="row align-items-center mb-4">
        <div class="col">
            <h2 class="fw-bold">새 글 작성</h2>
            <p class="text-muted mb-0">커뮤니티에 새로운 글을 작성합니다</p>
        </div>
    </div>

    <form id="communityForm" method="post" action="/community/insertPost" enctype="multipart/form-data">
    <input type="hidden" name="empNo" value="${userInfo.empNo}">
        <div class="form-section mb-4">
	        <div class="col-md-6">
	            <label for="communityType">커뮤니티 선택</label>
	            <select class="form-control" id="communityType" name="communityTypeVO.comTypeNo" required>
	                <option value="">커뮤니티을 선택하세요</option>
	                <c:forEach var="communityTypeVO" items="${communityTypeVOList}">
	                    <option value="${communityTypeVO.comTypeNo}">${communityTypeVO.comTypeName}</option>
	                </c:forEach>
	            </select>
	        </div>
	                    
	        <!-- 작성자 표시 -->
            <div class="form-group">
			    <label for="empNo">작성자번호</label>
			    <input type="text" class="form-control" id="empNo" name="empNo"
			           value="${userInfo.empNo}" readonly>
			</div>
		    
            <!-- 작성자 표시 -->
            <div class="form-group">
			    <label for="comWriter">작성자</label>
			    <input type="text" class="form-control" id="comWriter" name="comWriter"
			           value="${userInfo.empName}" readonly>
			</div>
						
            <!-- 게시글 종류 선택 -->
            <div class="col-md-6">
                <label for="communityStateType">게시글 종류 선택</label>
                <select class="form-control" id="communityStateType" name="communityStateTypeVO.comStateTypeNo" required>
                    <option value="">게시글 종류을 선택하세요</option>
                    <c:forEach var="communityStateTypeVO" items="${communityStateTypeVOList}">
					    <option value="${communityStateTypeVO.comStateTypeNo}">${communityStateTypeVO.comStateTypeName}</option>
					</c:forEach>
                </select>
            </div>
            
            <!-- 부서명 표시 -->
            <div class="form-group">
                <label for="comWriter">부서명</label>
                <input type="text" class="form-control" id="deptName" name="deptName"
                       value="${departmentVO.deptName}" readonly>
            </div>

            <!-- 제목 입력 -->
            <div class="mb-4">
			    <label for="comTitle" class="form-label fw-bold">제목</label>
			    <input type="text" class="form-control form-control-lg" id="comTitle" name="comTitle" 
			           placeholder="제목을 입력하세요">
			</div>

            <!-- 내용 입력 -->
            <div class="mb-4">
			    <label for="comCont" class="form-label fw-bold">내용</label>
			    <textarea id="comCont" name="comCont" class="form-control"></textarea>
			</div>

            <!-- 익명 설정 -->
            <div class="mb-4">
                <div class="d-flex align-items-center">
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="anonymousCheck" name="isAnonymous">
                        <label class="form-check-label fw-bold" for="anonymousCheck">익명으로 작성</label>
                    </div>
                    <small class="text-muted ms-3">
                        * 익명 작성 시 작성자 정보가 표시되지 않습니다
                    </small>
                </div>
            </div>

            <!-- 첨부파일 -->
            <div class="mb-4">
                <label class="form-label fw-bold">첨부파일</label>
                <div class="input-group">
                    <input type="file" class="form-control" id="files" multiple>
                </div>
            </div>
        </div>

        <!-- 버튼 영역 -->
        <div class="d-flex gap-2 justify-content-end">
            <button type="button" class="btn btn-secondary px-4" onclick="history.back()">취소</button>
            <button type="submit" class="btn btn-primary px-4">등록</button>
        </div>
    </form>
    <!-- 푸터 include  -->
   
   <jsp:include page="../include/footer.jsp"></jsp:include>
<!-- 푸터 include  -->
    
</div>

<script>
// 전역 변수로 이벤트 핸들러 함수 정의
function handleAnonymousCheck(e) {
    console.log("체크박스 변경 감지");
    const isAnonymous = $(this).is(":checked");
    console.log("익명 상태:", isAnonymous);

    const $writerField = $('#writerName');
    const $deptField = $('#deptName');

    if (isAnonymous) {
        if (confirm('익명으로 작성하시겠습니까?\n(작성자 정보는 관리자만 확인할 수 있습니다)')) {
            $writerField
                .data("original-value", $writerField.val())
                .val("***");
            
            $deptField
                .data("original-value", $deptField.val())
                .val("***");
        } else {
            $(this).prop('checked', false);
        }
    } else {
        $writerField.val($writerField.data("original-value"));
        $deptField.val($deptField.data("original-value"));
    }
}

$(document).ready(function() {
    console.log("페이지 로드됨");
    console.log("작성자 필드 존재:", $('#writerName').length);
    console.log("부서명 필드 존재:", $('#deptName').length);
    console.log("체크박스 존재:", $('#anonymousCheck').length);

    // Summernote 에디터 초기화
    $('#content').summernote({
        height: 400,
        toolbar: [
            ['style', ['bold', 'italic', 'underline', 'clear']],
            ['font', ['strikethrough']],
            ['color', ['color']],
            ['para', ['ul', 'ol', 'paragraph']],
            ['table', ['table']],
            ['insert', ['link', 'picture']],
            ['view', ['fullscreen', 'codeview']]
        ]
    });

    // 게시글 종류 선택 (이전과 동일)
    $(document).on('click', '.category-badge[data-type]', function() {
        $('.category-badge[data-type]').removeClass('active');
        $(this).addClass('active');
        $('#postType').val($(this).data('type'));
        $('#comStateType').val($(this).data('state'));
    });
    
    $('.category-badge[data-type="normal"]').click();

    // 부서 선택 (이전과 동일)
    $(document).on('click', '.category-badge[data-dept]', function() {
        $('.category-badge[data-dept]').removeClass('active');
        $(this).addClass('active');
        $('#department').val($(this).data('dept'));
    });

    // 체크박스 이벤트를 여러 방식으로 바인딩
    $('#anonymousCheck').on('change', handleAnonymousCheck);
    $(document).on('change', '#anonymousCheck', handleAnonymousCheck);
    
    // 추가 디버깅을 위한 클릭 이벤트
    $('#anonymousCheck').on('click', function() {
        console.log("체크박스 직접 클릭됨");
    });
});
</script>

</html>