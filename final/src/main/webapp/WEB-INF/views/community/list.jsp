<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
    <!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    
   

<!-- 추가 스타일 -->
<style>
    .post-type, .department-tag {
        font-size: 0.8rem;
        padding: 3px 8px;
        border-radius: 15px;
        margin-right: 8px;
    }
    
    .tag-dev { background-color: #e7f5ff; color: #1971c2; }
    .tag-marketing { background-color: #fff3bf; color: #e67700; }
    .tag-design { background-color: #f3f0ff; color: #7048e8; }
    .tag-sales { background-color: #ebfbee; color: #2b8a3e; }
    .tag-hr { background-color: #fff0f6; color: #c2255c; }

    /* 게시글 종류별 태그 스타일 */
    .type-normal { background-color: #e9ecef; color: #495057; }
    .type-question { background-color: #d3f9d8; color: #2b8a3e; }
    .type-info { background-color: #e3fafc; color: #0c8599; }
    .type-secret { background-color: #fff3bf; color: #e67700; }
    
    .board-card {
        background: white;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0,0,0,0.05);
        transition: transform 0.2s ease;
        overflow: hidden;
        min-height: 220px;
        cursor: pointer;
    }
    
    .card-body {
        padding: 1.5rem;
    }
    
    .card-title {
        font-size: 1.25rem;
        line-height: 1.5;
        margin-bottom: 1rem;
    }
    
    .card-text {
        font-size: 1.1rem;
        line-height: 1.8;
        margin-bottom: 1.5rem;
        color: #495057;
    }
    
    .board-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }
    
    .filter-section {
        background: white;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0,0,0,0.05);
        padding: 1.5rem;
        margin-bottom: 2rem;
    }
    
    .search-form {
        background: white;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0,0,0,0.05);
        padding: 1.5rem;
    }
    
    .btn-action {
        color: #868e96;
        font-size: 0.9rem;
        cursor: pointer;
        transition: color 0.2s;
    }
    
    .btn-action:hover {
        color: #4263eb;
    }
    
    .stats-info {
        color: #868e96;
        font-size: 0.9rem;
    }
    
    .bluBt {
  background-color: #3676EB;
  color: white;
  outline: none;
  border: none;
  width: 100px;
  padding-top: 12px;
  padding-bottom: 10px;
  border-radius: 5px;
  padding-left: 15px;
  padding-right: 10px;
}

.page-item.active .page-link {
    z-index: 1;
    color: white;
    background-color: #3676EB !important;
    border-color: #3676EB !important;
}
.next > a{
    color: #3676EB !important;

}
.page-item > a{
    color: #3676EB ;
}

</style>
  </head>

<!-- 헤더 include  -->
   <jsp:include page="../include/header.jsp"></jsp:include>
<!-- 헤더 include  -->

<!-- ///// content 시작 ///// -->
<div class="container-fluid mt-4 px-5">
    <!-- 게시판 헤더 -->
    <div class="row align-items-center mb-4">
        <div class="col">
            <h2 class="fw-bold">사내 커뮤니티</h2>
            <p class="text-muted mb-0">모든 부서가 자유롭게 소통하는 공간입니다</p>
        </div>
        <div class="col-auto">
            <button type="button" class="bluBt" onclick="location.href='/community/form'">
                <i class="plus"></i>새 글 작성
            </button>
        </div>
    </div>

    <!-- 검색 및 정렬 옵션 -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="search-form">
                <div class="row">
                    <div class="col-md-4">
                        <select class="form-select" name="comType" onchange="location.href='/community/list?comType='+this.value+'&keyword=${param.keyword}'">
                            <option value="">전체</option>
                            <c:forEach var="type" items="${communityVOList}">
                                <option value="${type.communityTypeVO.comTypeNo}" ${param.comType == type.communityTypeVO.comTypeNo ? 'selected' : ''}>${type.communityTypeVO.comTypeName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-8">
                        <form action="/community/list" method="get" class="input-group">
                            <input type="text" name="keyword" class="form-control" placeholder="검색어를 입력하세요" value="${param.keyword}">
                            <button class="btn btn-primary" type="submit">
                                <i class="bi bi-search me-1"></i>검색
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 게시글 목록 -->
    <div class="row g-4">
        <c:forEach var="post" items="${articlePage.content}">
            <div class="col-md-6">
                <div class="board-card h-100" onclick="location.href='/community/detail/${post.comNo}'">
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-3">
                            <div class="d-flex align-items-center flex-grow-1">
                                <span class="post-type ${post.communityStateTypeVO.comStateTypeNo == 1 ? 'type-normal' : 
                                                       post.communityStateTypeVO.comStateTypeNo == 2 ? 'type-question' :
                                                       post.communityStateTypeVO.comStateTypeNo == 3 ? 'type-info' :
                                                       'type-secret'}">
                                    ${post.communityStateTypeVO.comStateTypeName}
                                </span>
                                <span class="department-tag tag-dev">
                                    ${post.communityTypeVO.comTypeName}
                                </span>
                            </div>
                            <small class="text-muted">
                                <i class="bi bi-clock me-1"></i>
                                <fmt:formatDate value="${post.comCreDate}" pattern="yyyy-MM-dd"/>
                            </small>
                        </div>
                        <h5 class="card-title mb-2">${post.comTitle}</h5>
                        <p class="card-text">${fn:substring(post.comCont, 0, 100)}${fn:length(post.comCont) > 100 ? '...' : ''}</p>
                        <div class="d-flex align-items-center">
                            <div class="d-flex align-items-center">
<!--                                 <i class="bi bi-person-circle me-1"></i> -->
								<img src="${post.employeeVO.empProfile}" style="width:40px;height:40px;" />
                                &nbsp;<span class="fw-medium">${post.employeeVO.empName}</span>
                            </div>
                            <div class="ms-auto d-flex gap-3 stats-info">
                                <span><i class="bi bi-eye me-1"></i>${post.comHit}</span>
                                <span><i class="bi bi-chat-dots me-1"></i>0</span>
                                <span><i class="bi bi-hand-thumbs-up me-1"></i>0</span>
                                <span><i class="bi bi-bookmark me-1"></i>0</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- 페이징 -->
    <div class="row mt-5">
        <div class="col">
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <c:if test="${articlePage.startPage > 5}">
                        <li class="page-item">
                            <a class="page-link" href="/community/list?currentPage=${articlePage.startPage - 5}&keyword=${param.keyword}&comType=${param.comType}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    
                    <c:forEach var="pNo" begin="${articlePage.startPage}" end="${articlePage.endPage}">
                        <li class="page-item ${pNo == articlePage.currentPage ? 'active' : ''}">
                            <a class="page-link" href="/community/list?currentPage=${pNo}&keyword=${param.keyword}&comType=${param.comType}">${pNo}</a>
                        </li>
                    </c:forEach>
                    
                    <c:if test="${articlePage.endPage < articlePage.totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="/community/list?currentPage=${articlePage.startPage + 5}&keyword=${param.keyword}&comType=${param.comType}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>
    </div>   

</div>
 <jsp:include page="../include/footer.jsp"></jsp:include>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>


<!-- ///// content 끝 ///// -->
