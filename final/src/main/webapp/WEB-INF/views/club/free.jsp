<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- Bootstrap 4 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<%@ include file="../include/header_p.jsp" %>

<div class="community-board-wrapper">
    <div class="container-fluid">
        <!-- 상단 정보 카드 -->
        <div class="card mb-4">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h2 class="mb-1">
                            <i class="fas fa-comments text-primary"></i> 자유게시판
                        </h2>
                        <p class="text-muted mb-0">연못에</p>
                    </div>
                    <div>
                        <button class="btn btn-primary" onclick="location.href='write.jsp'">
                            <i class="fas fa-pen"></i> 글쓰기
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 게시글 목록 -->
        <div class="card">
            <div class="card-body">
                <!-- 검색 및 필터 -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <div class="d-flex">
                            <select class="form-control w-auto mr-2">
                                <option value="10">10개씩 보기</option>
                                <option value="20">20개씩 보기</option>
                                <option value="30">30개씩 보기</option>
                            </select>
                            <select class="form-control w-auto">
                                <option value="latest">최신순</option>
                                <option value="views">조회순</option>
                                <option value="likes">추천순</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group">
                            <select class="form-control w-auto">
                                <option value="all">전체</option>
                                <option value="title">제목</option>
                                <option value="content">내용</option>
                                <option value="writer">작성자</option>
                            </select>
                            <input type="text" class="form-control" placeholder="검색어를 입력하세요">
                            <div class="input-group-append">
                                <button class="btn btn-outline-secondary" type="button">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 게시글 테이블 -->
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
            <c:forEach var="clubCom" items="${clubComVOList}" varStatus="stat">
				<tr>
				    <td>${clubCom.clubComNo}</td>
				    <td>
				        <!-- 제목 컬럼 추가 -->
				        <a href="/community/club/${clubNo}/detail/${clubCom.clubComNo}" class="text-dark">
				            ${clubCom.clubComTitle}
				        </a>
				    </td>
				    <td>
				        <div class="d-flex justify-content-center align-items-center">
				            <c:if test="${not empty clubCom.employeeVO.empProfile}">
				                <img src="${clubCom.employeeVO.empProfile}" class="rounded-circle mr-2"
				                    style="width: 24px; height: 24px;">
				            </c:if>
				            ${clubCom.clubComWriter}
				        </div>
				    </td>
				    <td>
				        <fmt:formatDate value="${clubCom.clubComCreDate}" pattern="yyyy.MM.dd"/>
				    </td>
				    <td>${clubCom.clubComHit}</td>
				</tr>
				</c:forEach>
            
            <c:if test="${empty clubComVOList}">
                <tr>
                    <td colspan="6" class="text-center p-4">
                        <p class="mb-0">등록된 게시글이 없습니다.</p>
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

<!-- 페이지네이션 -->
<nav aria-label="Page navigation" class="mt-4">
    <ul class="pagination justify-content-center">
        <c:if test="${articlePage.startPage > 5}">
            <li class="page-item">
                <a class="page-link" href="?currentPage=${articlePage.startPage - 5}">
                    <i class="fas fa-chevron-left"></i>
                </a>
            </li>
        </c:if>
        
        <c:forEach var="pNo" begin="${articlePage.startPage}" end="${articlePage.endPage}">
            <li class="page-item ${articlePage.currentPage eq pNo ? 'active' : ''}">
                <a class="page-link" href="?currentPage=${pNo}">${pNo}</a>
            </li>
        </c:forEach>
        
        <c:if test="${articlePage.endPage < articlePage.totalPages}">
            <li class="page-item">
                <a class="page-link" href="?currentPage=${articlePage.startPage + 5}">
                    <i class="fas fa-chevron-right"></i>
                </a>
            </li>
        </c:if>
    </ul>
</nav>

<style>
/* 기존 스타일 유지하면서 추가 */
.table-primary {
    background-color: #e8f4ff;
}

.table-primary:hover {
    background-color: #d4e9ff !important;
}

.badge-primary {
    background-color: #007bff;
}

.text-primary {
    color: #007bff !important;
}

/* 게시글 호버 효과 */
.table tbody tr:hover {
    background-color: #f8f9fa;
}

/* 댓글 수 스타일 */
.text-primary {
    font-size: 0.9em;
}

/* 테이블 전체 가운데 정렬 */
.table {
    text-align: center;
}

.table thead th {
    text-align: center;
}

.table td {
    text-align: center;
}

/* 제목만 왼쪽 정렬 유지 */
.table td:nth-child(2) {
    text-align: left;
}

/* 뱃지 스타일 */
.badge {
    font-weight: normal;
    padding: 0.4em 0.8em;
}

.badge-danger {
    font-size: 80%;
}

/* 반응형 조정 */
@media (max-width: 768px) {
    .community-board-wrapper {
        padding: 20px;
    }
    
    .table {
        font-size: 14px;
    }
    
    .badge {
        font-size: 75%;
    }
}
</style>

<script>
$(document).ready(function() {
    // 정렬 변경 이벤트
    $('select').change(function() {
        // 정렬 로직 구현
    });

    // 검색 기능
    $('.input-group button').click(function() {
        var searchType = $('.input-group select').val();
        var searchText = $('.input-group input').val();
        // 검색 로직 구현
    });

    // 툴팁 초기화
    $('[data-toggle="tooltip"]').tooltip();
});
</script>

<%@ include file="../include/footer.jsp" %>