<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  

<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
   


<style>
    .post-type, .department-tag {
        font-size: 0.8rem;
        padding: 3px 8px;
        border-radius: 15px;
        margin-right: 8px;
    }
    
    .tag-dev { background-color: #e7f5ff; color: #1971c2; }
    .type-question { background-color: #d3f9d8; color: #2b8a3e; }
    
    .post-content {
        background: white;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0,0,0,0.05);
    }
    
    .content-body {
        font-size: 1.1rem;
        line-height: 1.8;
    }
    
    .comment-form textarea {
        border: 1px solid #dee2e6;
        resize: none;
        padding: 1rem;
    }
    
    .comment-form textarea:focus {
        outline: none;
        border-color: #4263eb;
    }
    
    .comment-item {
        border-bottom: 1px solid #f1f3f5;
        transition: background-color 0.2s;
    }
    
    .comment-item:hover {
        background-color: #f8f9fa;
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
</style>
  </head>
<!-- 여기 style css 들어가야해요  -->

<!-- 헤더 include  -->
   <jsp:include page="../include/header.jsp"></jsp:include>
<!-- 헤더 include  -->

<!-- 여기 내용 들어가야해요  -->
<div class="maxwidth">
<!-- ///// content 시작 ///// -->
<div class="container-fluid mt-4 px-5">
    <div class="mb-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#" class="text-decoration-none" onclick="location.href='/community/list'">커뮤니티</a></li>
                <li class="breadcrumb-item active" aria-current="page">게시글 보기</li>
            </ol>
        </nav>
    </div>

    <div class="post-content p-5 mb-4">
        <!-- 일반 보기 모드 -->
        <div id="div1">
            <div class="d-flex align-items-center mb-3">
                <span class="post-type type-question">${communityVO.communityStateTypeVO.comStateTypeName}</span>
                <span class="department-tag tag-dev">${communityVO.communityTypeVO.comTypeName}</span>
            </div>
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2 class="fw-bold mb-0">${communityVO.comTitle}</h2>
                <div class="dropdown">
                    <button type="button" class="btn btn-outline-secondary btn-sm" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-three-dots-vertical"></i>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="#" id="editDropdown">수정</a></li>
                        <li><a class="dropdown-item text-danger" href="#" id="deleteDropdown">삭제</a></li>
                    </ul>
                </div>
            </div>
            <div class="d-flex align-items-center text-muted">
                <span class="me-3">
<!--                 <i class="bi bi-person-circle me-1"></i> -->
				<img src="${communityVO.employeeVO.empProfile}" style="width:40px;height:40px;" />
                ${communityVO.employeeVO.empName}</span>
                <span class="me-3"><i class="bi bi-clock me-1"></i>
                    <fmt:formatDate value="${communityVO.comCreDate}" pattern="yyyy-MM-dd HH:mm"/>
                </span>
                <span class="me-3"><i class="bi bi-eye me-1"></i>${communityVO.comHit}</span>
                <span class="me-3"><i class="bi bi-chat-dots me-1"></i>${fn:length(communityReplyVOList)}</span>
                <span><i class="bi bi-hand-thumbs-up me-1"></i>0</span>
            </div>
            <hr class="my-4">
            <div class="content-body mb-5">
                ${communityVO.comCont}
            </div>
            <div class="d-flex gap-2">
                <button class="btn btn-outline-primary" onclick="likePost(${communityVO.comNo})">
                    <i class="bi bi-hand-thumbs-up me-1"></i>좋아요
                </button>
                <button class="btn btn-outline-secondary" onclick="bookmarkPost(${communityVO.comNo})">
                    <i class="bi bi-bookmark me-1"></i>북마크
                </button>
            </div>
        </div>

        <!-- 수정 모드 -->
        <div id="div2" style="display: none;">
            <form id="communityForm" method="post">
                <input type="hidden" name="comNo" value="${communityVO.comNo}" />
                <input type="hidden" name="empNo" value="${communityVO.empNo}" />
                
                <div class="form-group mb-3">
                    <label for="comTitle">제목</label>
                    <input type="text" class="form-control" name="comTitle" value="${communityVO.comTitle}" readonly>
                </div>
                
                <div class="form-group mb-3">
                    <label for="comCont">내용</label>
                    <textarea class="form-control" name="comCont" rows="10" readonly>${communityVO.comCont}</textarea>
                </div>
                
                <div class="d-flex justify-content-end gap-2">
                    <button type="submit" class="btn btn-primary">수정완료</button>
                    <button type="button" class="btn btn-secondary" onclick="location.href='/community/detail/${communityVO.comNo}'">취소</button>
                </div>
            </form>
        </div>
    </div>

    <!-- 댓글 영역 -->
	<div class="bg-white rounded-3 p-5">
	    <h5 class="fw-bold mb-4">댓글 ${fn:length(communityReplyVOList)}</h5>
	    
	    <!-- 댓글 작성 폼 -->
	    <div class="comment-form mb-5">
	        <form id="commentForm">
	            <input type="hidden" name="comNo" value="${communityVO.comNo}">
	            <input type="hidden" name="comReWriter" value="${sessionScope.empNo}">
	            <input type="hidden" name="empNo" value="${sessionScope.empNo}"> 
	            <input type="hidden" name="comLvl" value="1">
	            <textarea class="form-control mb-3" name="comReCont" rows="3" placeholder="댓글을 입력하세요"></textarea>
	            <div class="d-flex justify-content-end">
	                <button type="submit" class="btn btn-primary px-4">등록</button>
	            </div>
	        </form>
	    </div>
	
	    <!-- 댓글 목록 -->
	    <div class="comment-list">
	        <c:choose>
	            <c:when test="${not empty communityReplyVOList}">
	                <c:forEach var="reply" items="${communityReplyVOList}">
	                    <div class="comment-item py-4" style="margin-left: ${(reply.comLvl-1)*20}px">
	                        <!-- 댓글 헤더 -->
	                        <div class="d-flex justify-content-between mb-2">
	                            <div class="d-flex align-items-center">
	                                <span class="fw-bold me-2">${reply.employeeVO.empName}</span>
	                                <span class="text-muted small">
	                                    <fmt:formatDate value="${reply.comReDate}" pattern="yyyy-MM-dd HH:mm"/>
	                                </span>
	                            </div>
	                            <!-- 수정/삭제 버튼 -->
	                            <c:if test="${sessionScope.empNo == reply.comReWriter}">
	                                <div>
	                                    <span class="btn-action me-2" onclick="modifyReply(${reply.comIdx})">수정</span>
	                                    <span class="btn-action" onclick="deleteReply(${reply.comIdx})">삭제</span>
	                                </div>
	                            </c:if>
	                        </div>
	                        
	                        <!-- 댓글 내용 -->
	                        <div class="comment-content">
	                            <p class="mb-2" id="replyContent_${reply.comIdx}">${reply.comReCont}</p>
	                            
	                            <!-- 수정 폼 -->
	                            <div id="modifyForm_${reply.comIdx}" class="mt-2" style="display: none;">
	                                <textarea class="form-control mb-2" rows="2">${reply.comReCont}</textarea>
	                                <div class="d-flex gap-2">
	                                    <button class="btn btn-primary btn-sm" onclick="updateReply(${reply.comIdx})">수정완료</button>
	                                    <button class="btn btn-secondary btn-sm" onclick="cancelModify(${reply.comIdx})">취소</button>
	                                </div>
	                            </div>
	                        </div>
	                        
	                        <!-- 답글 영역 -->
	                        <div class="reply-actions mt-2">
	                            <c:if test="${reply.comLvl < 2}">
	                                <button class="btn btn-light btn-sm" onclick="showReplyForm(${reply.comIdx}, '${reply.comReWriter}')">
	                                    <i class="bi bi-arrow-return-right me-1"></i>답글
	                                </button>
	                                
	                                <!-- 답글 작성 폼 -->
	                                <div id="replyForm_${reply.comIdx}" class="mt-3" style="display: none;">
	                                    <form class="replyForm">
	                                        <input type="hidden" name="comNo" value="${communityVO.comNo}">
	                                        <input type="hidden" name="comReWriter" value="${sessionScope.empNo}">
	                                        <input type="hidden" name="empNo" value="${sessionScope.empNo}">
	                                        <input type="hidden" name="comParentIdx" value="${reply.comIdx}">
	                                        <input type="hidden" name="comParentReWriter" value="${reply.comReWriter}">
	                                        <input type="hidden" name="comLvl" value="${reply.comLvl + 1}">
	                                        <textarea class="form-control mb-2" name="comReCont" rows="2" placeholder="답글을 입력하세요"></textarea>
	                                        <div class="d-flex justify-content-end gap-2">
	                                            <button type="submit" class="btn btn-primary btn-sm">등록</button>
	                                            <button type="button" class="btn btn-secondary btn-sm" onclick="hideReplyForm(${reply.comIdx})">취소</button>
	                                        </div>
	                                    </form>
	                                </div>
	                            </c:if>
	                        </div>
	                    </div>
	                </c:forEach>
	            </c:when>
	            <c:otherwise>
	                <div class="text-center py-5">
	                    <p class="text-muted mb-0">등록된 댓글이 없습니다.</p>
	                </div>
	            </c:otherwise>
	        </c:choose>
	    </div>
<%@ include file="../include/footer.jsp" %>
	</div>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
// 답글 폼 표시/숨기기
function showReplyForm(comIdx, parentWriter) {
    $(`#replyForm_${comIdx}`).show();
}

function hideReplyForm(comIdx) {
    $(`#replyForm_${comIdx}`).hide();
}

// 댓글 수정 관련 함수
function modifyReply(comIdx) {
    $(`#replyContent_${comIdx}`).hide();
    $(`#modifyForm_${comIdx}`).show();
}

function cancelModify(comIdx) {
    $(`#replyContent_${comIdx}`).show();
    $(`#modifyForm_${comIdx}`).hide();
}

function updateReply(comIdx) {
    var content = $(`#modifyForm_${comIdx} textarea`).val();
    $.ajax({
        url: '/community/createReplyPostAjax',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            comIdx: comIdx,
            comReCont: content
        }),
        success: function(result) {
            if(result > 0) {
                $(`#replyContent_${comIdx}`).text(content).show();
                $(`#modifyForm_${comIdx}`).hide();
                location.reload();
            }
        }
    });
}

// 댓글 삭제
function deleteReply(comIdx) {
    if(confirm('댓글을 삭제하시겠습니까?')) {
        $.ajax({
            url: '/community/deleteReplyPost',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                comIdx: comIdx
            }),
            success: function(result) {
                if(result > 0) {
                    location.reload();
                }
            }
        });
    }
}

$(document).ready(function() {
    // 수정 드롭다운 클릭 시
    $("#editDropdown").on("click", function(e) {
        e.preventDefault();
        $("#div1").hide();
        $("#div2").show();
        
        // readonly 속성 제거
        $("input[name='comTitle']").prop('readonly', false);
        $("textarea[name='comCont']").prop('readonly', false);
    });

    // 수정 폼 제출 시
    $("#communityForm").on("submit", function(e) {
        e.preventDefault();
        
        var formData = $(this).serialize();
        
        $.ajax({
            url: '/community/updatePost',
            type: 'POST',
            data: formData,
            success: function(response) {
                // 수정 후 상세 페이지로 리다이렉트
                location.href = '/community/detail/' + $("input[name='comNo']").val();
            },
            error: function(xhr, status, error) {
                alert('수정 중 오류가 발생했습니다.');
            }
        });
    });

    // 삭제 드롭다운 클릭 시
    $("#deleteDropdown").on("click", function(e) {
        e.preventDefault();
        
        if(confirm('정말로 이 게시물을 삭제하시겠습니까?')) {
            $.ajax({
                url: '/community/deletePost',
                type: 'POST',
                data: { comNo: $("input[name='comNo']").val() },
                success: function(response) {
                    // 삭제 후 목록 페이지로 리다이렉트
                    location.href = '/community/list';
                },
                error: function(xhr, status, error) {
                    alert('삭제 중 오류가 발생했습니다.');
                }
            });
        }
    });

    // 댓글 작성 폼 제출
    $("#commentForm").on("submit", function(e) {
        e.preventDefault();
        var formData = $(this).serializeArray();
        var jsonData = {};
        
        $(formData).each(function(index, obj){
            jsonData[obj.name] = obj.value;
        });
        
        $.ajax({
            url: '/community/createReplyPostAjax',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(jsonData),
            success: function(result) {
                if(result > 0) {
                    location.reload();
                }
            }
        });
    });

    // 답글 폼 제출
    $(".replyForm").on("submit", function(e) {
        e.preventDefault();
        var formData = $(this).serializeArray();
        var jsonData = {};
        
        $(formData).each(function(index, obj){
            jsonData[obj.name] = obj.value;
        });
        
        $.ajax({
            url: '/community/createReplyPostAjax',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(jsonData),
            success: function(result) {
                if(result > 0) {
                    location.reload();
                }
            }
        });
    });
});
</script>
