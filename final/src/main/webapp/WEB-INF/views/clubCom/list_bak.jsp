<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/adminlte/dist/css/adminlte.min.css" />
<script type="text/javascript" src="/resources/adminlte/dist/js/adminlte.js"></script>
<script type="text/javascript" src="/resources/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- header -->
<jsp:include page="../include/header.jsp"></jsp:include>

<div class="card card-primary">
 <div class="card-header">
   <div class="d-flex justify-content-between align-items-center">
     <h3 class="card-title">게시판</h3>
     <div>
       <a href="/board/form" class="btn btn-primary btn-sm">
         <i class="fas fa-plus"></i> 게시판 추가
       </a>
     </div>
   </div>
 </div>

 <!-- 탭 메뉴 -->
 <div class="nav nav-tabs custom-tabs">
   <a class="nav-link" href="#" data-type="2">부서게시판</a>
   <a class="nav-link" href="#" data-type="3">QnA게시판</a>
 </div>

 <!-- 검색창 -->
 <div class="search-box">
   <div class="input-group">
     <input type="text" name="keyword" value="${param.keyword}"
         class="form-control" placeholder="검색어 입력" />
     <div class="input-group-append">
       <button type="button" id="btnSearch" class="btn btn-default">
         <i class="fas fa-search"></i>
       </button>
     </div>
   </div>
 </div>

 <!-- 테이블 -->
 <div class="card-body table-responsive p-0">
   <table class="table table-hover text-nowrap">
     <thead>
       <tr>
         <th>글번호</th>
         <th>제목</th>
         <th>작성자</th>
         <th>작성일시</th>
         <th>조회수</th>
       </tr>
     </thead>
     <tbody id="tby">
     </tbody>
   </table>
 </div>
 
 <!-- 페이징 -->
 <div class="card-footer" id="divPagingArea"></div>
</div>

<style>
.card {
   margin: 0;
   border-radius: 0;
}

.card-header {
   padding: 1rem;
   background-color: #fff;
   border-bottom: 1px solid #dee2e6;
}

.card-title {
   margin: 0;
   font-size: 1.25rem;
}

.card-body {
   padding: 0;
}

.table {
   width: 100%;
   table-layout: fixed;
   margin-bottom: 0;
}

/* 테이블 컬럼 너비 조정 */
.table th:nth-child(1) { width: 8%; }  /* 글번호 */
.table th:nth-child(2) { width: 50%; } /* 제목 */
.table th:nth-child(3) { width: 15%; } /* 작성자 */
.table th:nth-child(4) { width: 17%; } /* 작성일시 */
.table th:nth-child(5) { width: 10%; } /* 조회수 */

/* 테이블 셀 내용 처리 */
.table td {
   white-space: nowrap;
   overflow: hidden;
   text-overflow: ellipsis;
}

.table td:nth-child(2) {
   text-align: left;
}

.board-category {
    padding: 4px 8px;
    border-radius: 4px;
    display: inline-block;
    font-weight: 500;
    min-width: 80px;
    text-align: center;
}

/* 확장/축소 버튼 스타일 */
.notice-header {
    background-color: #f8f9fa;
}

.toggle-notice {
    color: #666;
    font-size: 1.2em;
    padding: 0 8px;
}

.toggle-notice:hover {
    color: #007bff;
}

.notice-item {
    background-color: #fff3cd;
}

.d-none {
    display: none !important;
}
.notice {
    background-color: #f8d7da;  /* 연한 빨간색 배경 */
    color: #721c24;  /* 진한 빨간색 글자 */
}
.department {
    background-color: #d4edda;  /* 연한 초록색 배경 */
    color: #155724;  /* 진한 초록색 글자 */
}
.qna {
    background-color: #cce5ff;  /* 연한 파란색 배경 */
    color: #004085;  /* 진한 파란색 글자 */
}
.notice-emphasis {
    font-weight: bold;
    background-color: #fff3cd;  /* 연한 노란색 배경 */
}
.search-box {
   padding: 1rem;
   background-color: #fff;
   border-bottom: 1px solid #dee2e6;
}

.search-box .input-group {
   max-width: 300px;
}

.custom-tabs {
   padding: 0.5rem 1rem;
   background-color: #fff;
   border-bottom: 1px solid #dee2e6;
}

.custom-tabs .nav-link {
   padding: 0.5rem 1rem;
   color: #6c757d;
   border-radius: 0;
}

.custom-tabs .nav-link:hover {
   color: #495057;
   background-color: #e9ecef;
}

.card-footer {
   padding: 1rem;
   background-color: #fff;
}

/* 반응형 처리 */
@media (max-width: 768px) {
   .table th:nth-child(4),
   .table td:nth-child(4) {
       display: none;
   }
   
   .table th:nth-child(5),
   .table td:nth-child(5) {
       display: none;
   }
}
</style>

<script type="text/javascript">
function nvl(expr1, expr2) {
    if (expr1 === undefined || expr1 == null || expr1 == "") {
        expr1 = expr2;
    }
    return expr1;
}

// 전역 변수로 bodType 선언
 let bodType = "1"; 

 function getList(currentPage, keyword, bodType) {
	    let data = {
	        "currentPage": nvl(currentPage,"1"),
	        "keyword": nvl(keyword,""),
	        "bodType": bodType
	    };
	    
	    console.log("data : ", data);
	    
	    $.ajax({
	        url:"/board/listAjax",
	        contentType:"application/json;charset=utf-8",
	        data:JSON.stringify(data),
	        type:"POST",
	        dataType:"json",
	        success: function(articlePage) {
	            console.log("articlePage : ", articlePage);
	            
	            // 게시물을 세 그룹으로 분류
	            let urgentNotices = articlePage.content.filter(item => 
	                item.boardTypeVO.bodTypeName === '공지사항' && item.noticeType === 1
	            );
	            let normalNotices = articlePage.content.filter(item => 
	                item.boardTypeVO.bodTypeName === '공지사항' && item.noticeType !== 1
	            );
	            let normalPosts = articlePage.content.filter(item => 
	                item.boardTypeVO.bodTypeName !== '공지사항'
	            );
	            
	            let str = "";
	            
	            // 1. 긴급 공지사항 섹션
	            if (urgentNotices.length > 0) {
	                str += '<tr class="notice-header bg-light">' +
	                       '<td colspan="5">' +
	                       '<div class="d-flex align-items-center">' +
	                       '<span class="toggle-notice me-2" data-section="urgent" style="cursor:pointer;">▾</span>' +
	                       '<strong>긴급 공지사항 (' + urgentNotices.length + ')</strong>' +
	                       '</div>' +
	                       '</td>' +
	                       '</tr>';

	                urgentNotices.forEach((boardVO, idx) => {
	                    str += '<tr class="notice-item urgent-notice' + (idx > 0 ? ' d-none' : '') + '">' +
	                        '<td>' + boardVO.bodNo + '</td>' +
	                        '<td>' +
	                        '<span class="board-category notice">' +
	                        '긴급공지' +
	                        '</span>' +
	                        '<a href="/board/detail/' + boardVO.bodNo + '" ' +
	                        'class="fw-bold text-danger">' + boardVO.bodTitle + '</a>' +
	                        '</td>' +
	                        '<td>' + nvl(boardVO.bodWriter, "") + '</td>' +
	                        '<td>' + nvl(boardVO.bodCreDate, "") + '</td>' +
	                        '<td>' + nvl(boardVO.bodHit, "") + '</td>' +
	                        '</tr>';
	                });
	            }
	            
	            // 2. 일반 공지사항 섹션
	            if (normalNotices.length > 0) {
	                str += '<tr class="notice-header bg-light">' +
	                       '<td colspan="5">' +
	                       '<div class="d-flex align-items-center">' +
	                       '<span class="toggle-notice me-2" data-section="normal" style="cursor:pointer;">▾</span>' +
	                       '<strong>공지사항 (' + normalNotices.length + ')</strong>' +
	                       '</div>' +
	                       '</td>' +
	                       '</tr>';

	                normalNotices.forEach((boardVO, idx) => {
	                    str += '<tr class="notice-item normal-notice' + (idx > 0 ? ' d-none' : '') + '">' +
	                        '<td>' + boardVO.bodNo + '</td>' +
	                        '<td>' +
	                        '<span class="board-category notice">' +
	                        boardVO.boardTypeVO.bodTypeName +
	                        '</span>' +
	                        '<a href="/board/detail/' + boardVO.bodNo + '" ' +
	                        'class="fw-bold">' + boardVO.bodTitle + '</a>' +
	                        '</td>' +
	                        '<td>' + nvl(boardVO.bodWriter, "") + '</td>' +
	                        '<td>' + nvl(boardVO.bodCreDate, "") + '</td>' +
	                        '<td>' + nvl(boardVO.bodHit, "") + '</td>' +
	                        '</tr>';
	                });
	            }

	            // 3. 일반 게시물 목록
	            normalPosts.forEach(boardVO => {
	                str += '<tr>' +
	                    '<td>' + boardVO.bodNo + '</td>' +
	                    '<td>' +
	                    '<span class="board-category ' + 
	                    (boardVO.boardTypeVO.bodTypeName === '부서게시판' ? 'department' : 'qna') + '">' +
	                    boardVO.boardTypeVO.bodTypeName +
	                    '</span>' +
	                    '<a href="/board/detail/' + boardVO.bodNo + '">' +
	                    boardVO.bodTitle + '</a>' +
	                    '</td>' +
	                    '<td>' + nvl(boardVO.bodWriter, "") + '</td>' +
	                    '<td>' + nvl(boardVO.bodCreDate, "") + '</td>' +
	                    '<td>' + nvl(boardVO.bodHit, "") + '</td>' +
	                    '</tr>';
	            });
	            
	            $("#tby").html(str);
	            $("#divPagingArea").html(articlePage.pagingArea);
	        }
	    });
	}

	// 문서 로딩 완료 후 실행되는 코드
	$(function(){
	    // 초기 목록 로드
	    getList("1", "", bodType);
	    
	    // 탭 클릭 이벤트
	    $(".nav-tabs .nav-link").on("click", function(e) {
	        e.preventDefault();
	        $(this).addClass('active').siblings().removeClass('active');
	        bodType = $(this).data('type');
	        getList("1", "", bodType);
	    });
	    
	    // 검색 버튼 클릭 이벤트
	    $("#btnSearch").on("click", function(){
	        let keyword = $("input[name='keyword']").val();
	        console.log("keyword : " + keyword);
	        getList("1", keyword, bodType);
	    });
	    
	    // 페이징 클릭 이벤트
	    $(document).on("click", ".clsPagingArea", function(){
	        let currentPage = $(this).data("currentPage");
	        let keyword = $(this).data("keyword");
	        console.log("페이지 클릭 처리->currentPage : " + currentPage);
	        console.log("페이지 클릭 처리->keyword : " + keyword);
	        getList(currentPage, keyword, bodType);
	    });
	    
	    // 공지사항 토글 이벤트 - 섹션별로 분리
	    $(document).on("click", ".toggle-notice", function() {
	        const $this = $(this);
	        const section = $this.data("section");
	        const $noticeItems = section === "urgent" 
	            ? $(".urgent-notice:not(:first-child)")
	            : $(".normal-notice:not(:first-child)");
	        
	        if ($this.text() === "▾") {  // 펼치기
	            $noticeItems.removeClass("d-none");
	            $this.text("▴");
	        } else {  // 접기
	            $noticeItems.addClass("d-none");
	            $this.text("▾");
	        }
	    });
	});
</script>

<!-- footer -->
<!-- ///// footer 시작 ///// -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  