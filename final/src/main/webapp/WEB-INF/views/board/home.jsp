<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 라이브러리 include   -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/adminlte/dist/css/adminlte.min.css" />
 
<style>
.card {
    margin-bottom: 1.5rem;
    box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2);
}

.card-header {
    background-color: #3069CE !important;
    color: white !important;
    text-align: center !important;
}

.card-title {
    float: left;
    font-size: 1.1rem;
    font-weight: 400;
    margin: 0;
    color: white ;
}

.page-header {
    margin: 20px 0 20px;
    padding-bottom: 9px;
    border-bottom: 1px solid #eee;
}

.badge {
    padding: 0.4em 0.8em;
}

.table td, .table th {
    padding: .75rem;
    vertical-align: middle;
}

.btn-tool {
   color: white !important;
}
.boardSub {
display: block !important;
height: auto !important;
}

.bluBt {
  background-color: #3676EB;
  color: white;
  outline: none;
  border: none;
  width: 600px;
  padding-top: 15px;
  padding-bottom: 10px;
  border-radius: 5px;
  padding-left: 15px;
  padding-right: 10px;
}
</style>
 
 
   </head>
<!-- 여기 style css 들어가야해요  -->

<!-- 헤더 include  -->
   <jsp:include page="../include/header.jsp"></jsp:include>
<!-- 헤더 include  -->
    
    
<div class="container-fluid">
    <!-- 페이지 헤더 -->
    <div class="row">
        <div class="col-md-12">
            <div class="page-header clearfix">
                <h1 class="pull-left">게시판</h1>
                <div class="text-end">
				    <a href="/board/form" class="bluBt">
				        <i class="fas fa-edit"></i> 글쓰기
				    </a>
				</div>
            </div>
        </div>
    </div>

    <!-- 공지사항 섹션 -->
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-bullhorn"></i> 공지사항
                    </h3>
                    <div class="card-tools">
                        <a href="/board/list?bodType=1" class="btn btn-tool">
                            <i class="fas fa-plus"></i> 더보기
                        </a>
                    </div>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th width="10%">구분</th>
                                    <th>제목</th>
                                    <th width="15%">작성자</th>
                                    <th width="15%">작성일</th>
                                    <th width="10%">조회수</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="boardVO" items="${noticeList}">
								    <tr>
								        <td>
								            <c:choose>
								                <c:when test="${boardVO.noticeType == 1}">
								                    <span class="badge bg-danger text-white">긴급</span>
								                </c:when>
								                <c:otherwise>
								                    <span class="badge bg-primary text-white">공지</span>
								                </c:otherwise>
								            </c:choose>
								        </td>
								        <td>
								            <a href="/board/detail/${boardVO.bodNo}" class="text-reset">
								                ${boardVO.bodTitle}
								            </a>
								        </td>
								        <td>${boardVO.bodWriter}</td>
								        <td><fmt:formatDate value="${boardVO.bodCreDate}" pattern="yyyy-MM-dd"/></td>
								        <td>${boardVO.bodHit}</td>
								    </tr>
								</c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 전체 게시물 -->
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-stream"></i> 전체 게시판
                    </h3>
                    <div class="card-tools">
                        <a href="/board/list" class="btn btn-tool">
                            <i class="fas fa-plus"></i> 더보기
                        </a>
                    </div>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th width="10%">게시판</th>
                                    <th>제목</th>
                                    <th width="15%">작성자</th>
                                    <th width="15%">작성일</th>
                                    <th width="10%">조회수</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="boardVO" items="${allPosts}">
								    <tr>
								        <td>
								            <c:choose>
								                <c:when test="${boardVO.boardTypeVO.bodTypeName eq '공지사항'}">
								                    <span class="badge bg-primary text-white">공지</span>
								                </c:when>
								                <c:when test="${boardVO.boardTypeVO.bodTypeName eq '전체게시판'}">
								                    <span class="badge bg-warning text-dark">QnA</span>
								                </c:when>
								                <c:when test="${boardVO.boardTypeVO.bodTypeName eq '부서게시판'}">
								                    <span class="badge bg-success text-white">부서</span>
								                </c:when>
								                <c:when test="${boardVO.boardTypeVO.bodTypeName eq 'QnA게시판'}">
								                    <span class="badge bg-warning text-dark">QnA</span>
								                </c:when>
								            </c:choose>
								        </td>
								        <td>
								            <a href="/board/detail/${boardVO.bodNo}" class="text-reset">
								                ${boardVO.bodTitle}
								            </a>
								        </td>
								        <td>${boardVO.bodWriter}</td>
								        <td><fmt:formatDate value="${boardVO.bodCreDate}" pattern="yyyy-MM-dd"/></td>
								        <td>${boardVO.bodHit}</td>
								    </tr>
								</c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 최근 게시물 -->
    <div class="row">
        <!-- 부서 게시판 최근 글 -->
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-list"></i> 부서 게시판
                    </h3>
                    <div class="card-tools">
                        <a href="/board/list?bodType=2" class="btn btn-tool">
                            <i class="fas fa-plus"></i> 더보기
                        </a>
                    </div>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>제목</th>
                                    <th width="20%">작성자</th>
                                    <th width="20%">작성일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="boardVO" items="${deptList}">
								    <tr>
								        <td>
								            <a href="/board/detail/${boardVO.bodNo}" class="text-reset">
								                ${boardVO.bodTitle}
								            </a>
								        </td>
								        <td>${boardVO.bodWriter}</td>
								        <td><fmt:formatDate value="${boardVO.bodCreDate}" pattern="yyyy-MM-dd"/></td>
								    </tr>
								</c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- QnA 게시판 최근 글 -->
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-question-circle"></i> QnA 게시판
                    </h3>
                    <div class="card-tools">
                        <a href="/board/list?bodType=3" class="btn btn-tool">
                            <i class="fas fa-plus"></i> 더보기
                        </a>
                    </div>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>제목</th>
                                    <th width="20%">작성자</th>
                                    <th width="20%">작성일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="boardVO" items="${qnaList}">
								    <tr>
								        <td>
								            <a href="/board/detail/${boardVO.bodNo}" class="text-reset">
								                ${boardVO.bodTitle}
								            </a>
								        </td>
								        <td>${boardVO.bodWriter}</td>
								        <td><fmt:formatDate value="${boardVO.bodCreDate}" pattern="yyyy-MM-dd"/></td>
								    </tr>
								</c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
   <jsp:include page="../include/footer.jsp"></jsp:include>
</div>


