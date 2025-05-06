<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
    
<!-- Bootstrap 4 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<style>
/* 기존 스타일 유지 */
.community-board-wrapper {
    padding: 40px;
    background: #f8f9fa;
    min-height: calc(100vh - 60px);
}

/* 공지사항 전용 스타일 */
.table-warning {
    background-color: #fff8e6;
}

.table-warning:hover {
    background-color: #fff3d6 !important;
}

.badge-danger {
    font-weight: normal;
    font-size: 85%;
}

/* 테이블 스타일 */
.table {
    font-size: 16px;
    margin-bottom: 0;
    text-align: center; /* 전체 테이블 가운데 정렬 */
}

.table thead th {
    text-align: center; /* 헤더 가운데 정렬 */
    border-top: 2px solid #dee2e6;
    border-bottom: 2px solid #dee2e6;
    background-color: #f8f9fa;
    font-weight: 600;
    padding: 15px;
}

.table td {
    text-align: center; /* 셀 가운데 정렬 */
    padding: 15px;
    vertical-align: middle;
    border-bottom: 1px solid #dee2e6;
}

/* 제목 좌측 정렬 유지 */
.table td:nth-child(2) {
    text-align: left;
}

.table tr:hover {
    background-color: #f8f9fa;
}

/* 페이지네이션 */
.pagination .page-link {
    padding: 8px 16px;
    color: #495057;
}

.pagination .page-item.active .page-link {
    background-color: #dc3545;
    border-color: #dc3545;
}

/* 반응형 스타일 */
@media (max-width: 768px) {
    .community-board-wrapper {
        padding: 20px;
    }

    .table {
        font-size: 14px;
    }

    .table td, .table th {
        padding: 10px;
    }

    .badge {
        font-size: 75%;
    }
}
</style>
 </head>
<!-- 헤더 include  -->
   <jsp:include page="../include/header.jsp"></jsp:include>
<!-- 헤더 include  -->


    <div class="container-fluid">
        <!-- 상단 정보 카드 -->
        <div class="card mb-4">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h2 class="mb-1">
                            <i class="fas fa-bullhorn text-danger"></i> 공지사항
                        </h2>
                        <p class="text-muted mb-0">연못에</p>
                    </div>
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
                        <div>
                            <button class="btn btn-danger" onclick="location.href='notice-write.jsp'">
                                <i class="fas fa-pen"></i> 공지작성
                            </button>
                        </div>
                    </sec:authorize>
                </div>
            </div>
        </div>

        <!-- 게시글 목록 -->
		<div class="card">
		    <div class="card-body">
		        <!-- 검색 필터 -->
		        <div class="row mb-3">
		            <div class="col-md-6">
		                <div class="d-flex">
		                    <select class="form-control w-auto mr-2" name="size" id="size">
		                        <option value="10" ${param.size == '10' ? 'selected' : ''}>10개씩 보기</option>
		                        <option value="20" ${param.size == '20' ? 'selected' : ''}>20개씩 보기</option>
		                        <option value="30" ${param.size == '30' ? 'selected' : ''}>30개씩 보기</option>
		                    </select>
		                </div>
		            </div>
		            <div class="col-md-6">
		                <form action="/notice/list" method="get" id="searchForm">
		                    <div class="input-group">
		                        <select class="form-control w-auto" name="searchType">
		                            <option value="all" ${param.searchType == 'all' ? 'selected' : ''}>전체</option>
		                            <option value="title" ${param.searchType == 'title' ? 'selected' : ''}>제목</option>
		                            <option value="content" ${param.searchType == 'content' ? 'selected' : ''}>내용</option>
		                        </select>
		                        <input type="text" class="form-control" name="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요">
		                        <div class="input-group-append">
		                            <button class="btn btn-outline-secondary" type="submit">
		                                <i class="fas fa-search"></i>
		                            </button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
		
		        <!-- 공지사항 테이블 -->
		        <div class="table-responsive">
		            <table class="table text-center">
		                <thead class="thead-light">
		                    <tr>
		                        <th style="width: 8%">번호</th>
		                        <th>제목</th>
		                        <th style="width: 15%">작성자</th>
		                        <th style="width: 15%">작성일</th>
		                        <th style="width: 8%">조회</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <c:forEach var="notice" items="${noticeList}" varStatus="stat">
		                        <tr ${notice.noticeType == 'IMPORTANT' ? 'class="table-warning"' : ''}>
		                            <td>
		                                <c:if test="${notice.noticeType == 'IMPORTANT'}">
		                                    <span class="badge badge-danger">중요</span>
		                                </c:if>
		                                <c:if test="${notice.noticeType != 'IMPORTANT'}">
		                                    ${notice.noticeNo}
		                                </c:if>
		                            </td>
		                            <td>
		                                <a href="/notice/detail/${notice.noticeNo}" class="text-dark ${notice.noticeType == 'IMPORTANT' ? 'font-weight-bold' : ''}">
		                                    ${notice.noticeTitle}
		                                    <c:if test="${not empty notice.attachmentCnt && notice.attachmentCnt > 0}">
		                                        <i class="fas fa-paperclip text-muted ml-1"></i>
		                                    </c:if>
		                                    <c:if test="${notice.isNew}">
		                                        <span class="badge badge-danger ml-1">New</span>
		                                    </c:if>
		                                </a>
		                            </td>
		                            <td>
		                                <div class="d-flex justify-content-center align-items-center">
		                                    <c:if test="${not empty notice.empProfile}">
		                                        <img src="${notice.empProfile}" alt="프로필" class="rounded-circle mr-2" 
		                                             style="width: 24px; height: 24px;">
		                                    </c:if>
		                                    ${notice.noticeWriter}
		                                </div>
		                            </td>
		                            <td>
		                                <fmt:formatDate value="${notice.noticeCreDate}" pattern="yyyy.MM.dd"/>
		                            </td>
		                            <td>${notice.noticeHit}</td>
		                        </tr>
		                    </c:forEach>
		                </tbody>
		            </table>
		        </div>
		
		        <!-- 페이지네이션 -->
		        <nav aria-label="Page navigation" class="mt-4">
		            <ul class="pagination justify-content-center">
		                <c:if test="${paging.startPage > paging.pageSize}">
		                    <li class="page-item">
		                        <a class="page-link" href="?page=${paging.startPage - paging.pageSize}" aria-label="Previous">
		                            <i class="fas fa-chevron-left"></i>
		                        </a>
		                    </li>
		                </c:if>
		                
		                <c:forEach var="pageNum" begin="${paging.startPage}" end="${paging.endPage}">
		                    <li class="page-item ${pageNum == paging.currentPage ? 'active' : ''}">
		                        <a class="page-link" href="?page=${pageNum}">${pageNum}</a>
		                    </li>
		                </c:forEach>
		                
		                <c:if test="${paging.endPage < paging.totalPages}">
		                    <li class="page-item">
		                        <a class="page-link" href="?page=${paging.startPage + paging.pageSize}" aria-label="Next">
		                            <i class="fas fa-chevron-right"></i>
		                        </a>
		                    </li>
		                </c:if>
		            </ul>
		        </nav>
		    </div>
		</div>
<%@ include file="../include/footer.jsp" %>


<script>
$(document).ready(function() {
    // 툴팁 초기화
    $('[data-toggle="tooltip"]').tooltip();

    // 검색 기능
    $('.input-group button').click(function() {
        var searchType = $('.input-group select').val();
        var searchText = $('.input-group input').val();
        // 검색 로직 구현
    });

    // 게시글 목록 수 변경
    $('select[class="form-control w-auto mr-2"]').change(function() {
        var limit = $(this).val();
        // 페이지당 게시글 수 변경 로직
    });
});
</script>

</html>