<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- 라이브러리 include  -->
<jsp:include page="../include/library.jsp"></jsp:include>
<!-- 라이브러리 include  -->
<sec:authentication property="principal" var="user"/>

<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- AdminLTE CSS (if still needed) -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/adminlte/dist/css/adminlte.min.css" />

<jsp:include page="../include/managerHeader.jsp"></jsp:include>

<!-- content 시작 -->
<div class="card">
    <!-- 게시물 헤더 -->
    <div class="card-header">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h3 class="card-title">[${boardVO.boardTypeVO.bodTypeName} 게시판] ${boardVO.bodTitle}</h3>
            </div>
            <div class="d-flex align-items-center">
                <button type="button" class="btn btn-danger me-2" 
                    data-bs-toggle="modal" 
                    data-bs-target="#modalReport"
                    onclick="reportPost('${boardVO.bodNo}')">
                    <i class="fas fa-exclamation-circle"></i> 게시글 신고
                </button>
                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" 
                            id="dropdownMenuButton" 
                            data-bs-toggle="dropdown" 
                            aria-expanded="false">
                        <i class="fas fa-ellipsis-v"></i>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton">
                        <li><a class="dropdown-item" href="#" id="editDropdown">수정</a></li>
                        <li><a class="dropdown-item text-danger" href="#" id="deleteDropdown">삭제</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <!-- 게시물 정보 -->
    <div class="card-header bg-light py-2">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <span class="text-muted me-2">작성자: ${boardVO.bodWriter}</span>
                <span class="text-muted">
                    작성일: <fmt:formatDate value="${boardVO.bodCreDate}" pattern="yyyy-MM-dd HH:mm"/>
                </span>
                <c:if test="${boardVO.bodCreDate != boardVO.bodCreDate}">
                    <span class="text-muted ms-2">
                        수정일: <fmt:formatDate value="${boardVO.bodModiDate}" pattern="yyyy-MM-dd HH:mm"/>
                    </span>
                </c:if>
            </div>
            <div>
                <span class="text-muted">
                    <i class="far fa-eye"></i> ${boardVO.bodHit}
                </span>
            </div>
        </div>
    </div>

    <!-- 게시물 본문 -->
    <form id="boardFrm" action="/board/updatePost" method="post">
        <input type="hidden" name="bodNo" value="${boardVO.bodNo}" />
        <div class="card-body">
            <div class="post-content mb-4">
                <textarea class="form-control" id="bodCont" name="bodCont" 
                    rows="10" readonly>${boardVO.bodCont}</textarea>
            </div>

            <!-- 첨부파일 -->
            <div class="attachments">
                <h6 class="fw-bold mb-2">
                    <i class="fas fa-paperclip"></i> 첨부파일
                </h6>
                <div class="list-group">
                    <c:forEach var="file" items="${attachments}">
                        <div class="list-group-item">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <i class="far fa-file-pdf text-danger me-2"></i>
                                    <a href="${file.filePath}" target="_blank">
                                        ${file.fileName}
                                    </a>
                                </div>
                                <span class="text-muted small">${file.fileSize}</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!-- 버튼 영역 -->
        <div class="card-footer">
            <!-- 일반모드 버튼 -->
            <div id="div1" class="d-flex justify-content-between">
                <div>
                    <a href="/board/list" class="btn btn-secondary">목록</a>
                </div>
            </div>
            <!-- 수정모드 버튼 -->
            <div id="div2" class="d-flex justify-content-end" style="display: none !important;">
                <button type="submit" class="btn btn-primary me-2">확인</button>
                <a href="/board/detail/${boardVO.bodNo}" class="btn btn-secondary">취소</a>
            </div>
        </div>
    </form>
</div>

<!-- 댓글 섹션 -->
<div class="card mt-4">
    <div class="card-header">
        <h5 class="card-title">
            <i class="far fa-comments"></i> 댓글
        </h5>
    
        <c:choose>
            <c:when test="${boardVO.boardTypeVO.bodTypeNo == 1}">
                <div class="alert alert-secondary mb-0">
                    공지사항에는 댓글을 작성할 수 없습니다.
                </div>
            </c:when>
            <c:otherwise>
                <!-- 기존 댓글 작성 폼 -->
                <form id="bodReplyFrm" action="/board/createReplyPost" method="post">
                    <input type="hidden" name="bodNo" value="${boardVO.bodNo}" />
                    <input type="hidden" name="empNo" value="${user.member.empNo}" />
                    <div class="input-group">
                        <input type="text" id="bodReCont" name="bodReCont" 
                            class="form-control" placeholder="댓글을 입력하세요" required />
                        <button type="submit" class="btn btn-primary">댓글 등록</button>
                    </div>
                </form>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 댓글 목록 -->
    <div class="card-body" id="replyList">
        <!-- 댓글 목록이 AJAX로 로드됨 -->
    </div>

    <!-- 댓글 페이징 -->
    <div class="card-footer clearfix" id="replyPagingArea">
        <!-- 페이징 영역이 AJAX로 로드됨 -->
    </div>
</div>

<!-- Bootstrap 5 번들 JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- 신고 모달 -->
<div class="modal fade" id="modalReport" tabindex="-1" aria-labelledby="modalReportLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalReportLabel">신고하기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="reportIdx" name="bodNo" />
                <div class="mb-3">
                    <label for="repReason" class="form-label">신고 사유</label>
                    <select class="form-select" id="repReason" name="repReason">
                        <option value="">선택하세요</option>
                        <option value="욕설/비방">욕설/비방</option>
                        <option value="광고/스팸">광고/스팸</option>
                        <option value="불법정보">불법정보</option>
                        <option value="음란성">음란성</option>
                        <option value="기타">기타</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="repCont" class="form-label">상세내용</label>
                    <textarea class="form-control" id="repCont" name="repCont" 
                        rows="3" placeholder="상세 내용을 입력해주세요"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="btnReport" class="btn btn-danger">신고하기</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>

<!-- 댓글 수정 모달 -->
<div class="modal fade" id="modalReplyUpdate" tabindex="-1" aria-labelledby="modalReplyUpdateLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalReplyUpdateLabel">댓글 수정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="modalIdx" />
                <input type="text" class="form-control" id="modalReplyContent" />
            </div>
            <div class="modal-footer">
                <button type="button" id="btnModalUpdate" class="btn btn-primary">수정</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>
 
 <style>
 .card {
     margin: 20px;
     box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2);
 }
 .comment-avatar {
     width: 40px;
     height: 40px;
     background-color: #e9ecef;
     border-radius: 50%;
     display: flex;
     align-items: center;
     justify-content: center;
     font-weight: bold;
     color: #495057;
 }
 .post-content {
     min-height: 200px;
     line-height: 1.6;
 }
 .comment {
     border-bottom: 1px solid #dee2e6;
     padding-bottom: 1rem;
 }
 .comment:last-child {
     border-bottom: none;
 }
 .btn-tool {
     padding: .25rem .5rem;
 }
 .reply-indent {
     margin-left: 40px;
 }
 </style>
 
 
 <script type="text/javascript">
// 날짜 포맷 함수 (기존 코드와 동일)
function formatDate(dateStr) {
    if (!dateStr) return "";
    
    try {
        const date = new Date(dateStr);
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        
        return `\${year}-\${month}-\${day} \${hours}:\${minutes}`;
    } catch (e) {
        console.error("날짜 변환 중 오류:", e);
        return dateStr;
    }
}

// null 값 처리 함수
function nvl(expr1, expr2) {
    if (expr1 === undefined || expr1 == null || expr1 == "") {
        expr1 = expr2;
    }
    return expr1;
}

// 페이징 데이터를 포함한 댓글 목록 조회
function getReList(currentPage, bodNo) {
    let data = {
        "currentPage": nvl(currentPage, "1"),
        "keyword": "", 
        "bodNo": bodNo
    };
    
    console.log("요청 데이터:", data);
    
    fetch("/board/detailAjax", {
        method: "POST",
        headers: {
            "Content-Type": "application/json;charset=utf-8"
        },
        body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(articlePage => {
        console.log("응답 데이터 전체:", articlePage);
        console.log("댓글 목록:", articlePage.content);
        
        let str = "";
        if(articlePage.content && articlePage.content.length > 0) {
            articlePage.content.forEach(reply => {
                console.log("개별 댓글:", reply);
                
                str += `
                    <div class="post clearfix" style="margin-left:${reply.bodLvl * 50}px;" data-lvl="${reply.bodLvl}">
                        <div class="user-block">
                            <div class="comment-avatar">
                                ${reply.bodReWriter ? reply.bodReWriter.charAt(0) : '?'}
                            </div>
                            <span class="username">
                                <a href="#">${reply.bodReWriter || '익명'}</a>
                            </span>
                            <span class="description">${formatDate(reply.bodReDate)}</span>
                        </div>
                        <p class="mb-0">
                            <span id="spanReplyContent${reply.bodIdx}">
                                ${reply.bodLvl > 1 ? 
                                    `<span class="text-primary">@${reply.bodParentReWriter || '익명'}</span>
                                    <span class="ml-2">${reply.bodReCont}</span>` : 
                                    reply.bodReCont
                                }
                            </span>
                            <span class="spnReplyUpdate float-right ml-2" 
                                data-bod-idx="${reply.bodIdx}" 
                                data-content="${reply.bodReCont}" 
                                data-toggle="modal" 
                                data-target="#modalReplyUpdate">
                                <i class="fas fa-edit"></i> 수정
                            </span>
                            <span class="spnReplyDelete float-right ml-2" 
                                data-bod-idx="${reply.bodIdx}">
                                <i class="fas fa-trash"></i> 삭제
                            </span>
                            <span class="spnReplyReport float-right" 
                                data-bod-idx="${reply.bodIdx}" 
                                data-toggle="modal" 
                                data-target="#modalReport">
                                <i class="fas fa-exclamation-circle"></i> 신고
                            </span>
                        </p>
                        <div class="input-group input-group-sm mt-2">
                            <input type="text" id="txt${reply.bodIdx}" 
                                class="form-control form-control-sm" 
                                placeholder="대댓글 입력">
                            <div class="input-group-append">
                                <button type="button" 
                                    data-parent-idx="${reply.bodIdx}" 
                                    class="btn btn-danger clsReplyBtn">대댓글입력</button>
                            </div>
                        </div>
                    </div>
                `;
            });
        } else {
            str = '<div class="text-center p-3">등록된 댓글이 없습니다.</div>';
        }

        // jQuery 선택자를 Vanilla JavaScript로 변경
        document.getElementById("replyList").innerHTML = str;
        if(articlePage.pagingArea) {
            document.getElementById("replyPagingArea").innerHTML = articlePage.pagingArea;
        }
    })
    .catch(error => {
        console.error("댓글 로딩 중 에러 발생:", error);
        // jQuery 선택자를 Vanilla JavaScript로 변경
        document.getElementById("replyList").innerHTML = 
            '<div class="text-center p-3 text-danger">댓글을 불러오는데 실패했습니다.</div>';
    });
}

// 신고 처리 함수 (게시글)
function reportPost(bodNo) {
    // 모달을 body로 이동하고 초기화
    var modal = document.getElementById('modalReport');
    
    // hidden input 값 설정
    document.getElementById('reportIdx').value = '0';
    
    // 부트스트랩 5 모달 show 메서드 사용
    var modalInstance = new bootstrap.Modal(modal);
    modalInstance.show();
}

// 신고 처리 함수 (댓글)
function handleReport(data) {
    console.log("handleReport->data : ", data);

    if(!document.getElementById('repReason').value) {
        alert("신고 사유를 선택해주세요.");
        return false;
    }
    
    fetch("/board/reportReplyPost", {
        method: "POST",
        headers: {
            "Content-Type": "application/json;charset=utf-8"
        },
        body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(result => {
        if(result > 0) {
            alert("신고가 접수되었습니다.");
            
            // 모달 닫기 (부트스트랩 5 방식)
            var modalElement = document.getElementById('modalReport');
            var modal = bootstrap.Modal.getInstance(modalElement);
            modal.hide();

            // 입력 필드 초기화
            document.getElementById('repReason').value = "";
            document.getElementById('repCont').value = "";
        }
    })
    .catch(error => {
        console.error('Error:', error);
    });
}

//페이지 로드 후 이벤트 설정
document.addEventListener('DOMContentLoaded', function() {
    let empNo = "${user.member.empNo}";
    let bodTypeNo = "${boardVO.boardTypeVO.bodTypeName}";
    
    // 공지사항이고 empNo가 3보다 큰 경우(일반 사용자) 수정/삭제 버튼을 숨김
    if(bodTypeNo === "공지사항" && empNo > 3) {
        document.querySelector(".btn-group").style.display = 'none';
    }
    
    if(bodTypeNo === "QnA" && empNo > 3) {
        document.querySelector(".btn-group").style.display = 'none';
    }
    
    // 초기 페이지 로드 시 첫 페이지의 댓글 목록을 가져옴
    const bodNo = "${boardVO.bodNo}";
    getReList("1", bodNo);
    
    // 페이징 영역 클릭 이벤트 처리
    document.addEventListener("click", function(event) {
        if (event.target.classList.contains('clsPagingArea')) {
            let currentPage = event.target.dataset.currentPage;
            getReList(currentPage, bodNo);
        }
    });

    // 댓글/대댓글 삭제 이벤트
    document.addEventListener("click", function(event) {
        if (event.target.closest('.spnReplyDelete')) {
            let bodIdx = event.target.closest('.spnReplyDelete').dataset.bodIdx;
            console.log("bodIdx : " + bodIdx);
            
            if (confirm("댓글을 삭제하시겠습니까?")) {
                fetch(`/board/deleteReplyPost/\${bodIdx}`, {
                    method: "POST",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify({bodIdx: bodIdx})
                })
                .then(() => {
                    // SweetAlert 대신 기본 알림
                    alert('삭제 성공!');
                    
                    // 화면에서 댓글 제거
                    event.target.closest(".post").remove();
                })
                .catch(error => {
                    console.error('삭제 중 오류:', error);
                });
            }
        }
    });

    // 댓글/대댓글 수정 모달 이벤트
    document.addEventListener("click", function(event) {
        if (event.target.closest('.spnReplyUpdate')) {
            let bodIdx = event.target.closest('.spnReplyUpdate').dataset.bodIdx;
            let bodReCont = event.target.closest('.spnReplyUpdate').dataset.content;
            
            document.getElementById('modalIdx').value = bodIdx;
            document.getElementById('modalReplyContent').value = bodReCont;
        }
    });

    // 댓글 수정 실행
    document.getElementById('btnModalUpdate').addEventListener('click', function() {
        let bodIdx = document.getElementById('modalIdx').value;
        let bodReCont = document.getElementById('modalReplyContent').value;
        
        // 댓글 수정 
        if(!bodReCont.trim()) {
            alert("댓글 내용을 입력해주세요.");
            document.getElementById('modalReplyContent').focus();
            return;
        }
        
        let data = {
            "bodIdx": bodIdx,
            "bodReCont": bodReCont
        };
        
        fetch("/board/updateReplyPostAjax", {
            method: "POST",
            headers: {
                "Content-Type": "application/json;charset=utf-8"
            },
            body: JSON.stringify(data)
        })
        .then(response => response.json())
        .then(result => {
            document.getElementById(`spanReplyContent\${bodIdx}`).innerHTML = result.bodReCont;
            
            // 부트스트랩 5 모달 닫기
            let modalElement = document.getElementById('modalReplyUpdate');
            let modal = bootstrap.Modal.getInstance(modalElement);
            modal.hide();
        })
        .catch(error => {
            console.error('수정 중 오류:', error);
        });
    });
 	   
 // 대댓글 작성 이벤트
    document.addEventListener("click", function(event) {
        if (event.target.classList.contains('clsReplyBtn')) {
            let parentIdx = event.target.dataset.parentIdx;
            let txtInput = document.getElementById(`txt\${parentIdx}`);
            let content = txtInput.value;
            let bodNo = "${boardVO.bodNo}";
            
            if (!content) {
                alert("대댓글 내용을 입력해주세요.");
                return;
            }
            
            let data = {
                bodNo: bodNo,                    
                bodReCont: content,              
                bodParentIdx: parentIdx
            };
            
            console.log("전송할 데이터:", data);
            
            fetch("/board/createReplyPostAjax", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json;charset=utf-8"
                },
                body: JSON.stringify(data)
            })
            .then(response => response.json())
            .then(result => {
                if (result > 0) {
                    alert("대댓글이 등록되었습니다.");
                    txtInput.value = '';  // 입력창 초기화
                    getReList("1", bodNo);
                }
            })
            .catch(error => {
                console.error('대댓글 작성 중 오류:', error);
            });
        }
    });
    
    // 게시글 수정 모드
    document.getElementById('editDropdown').addEventListener('click', function() {
        document.getElementById('div1').style.display = 'none';
        document.getElementById('div2').style.display = 'block';
        
        let formControls = document.querySelectorAll('.form-control');
        formControls.forEach(control => control.removeAttribute('readonly'));
        
        document.getElementById('boardFrm').action = "/board/updatePost";
        document.getElementById('bodWriter').setAttribute('readonly', true);
    });
    
    // 게시글 삭제
    document.getElementById('deleteDropdown').addEventListener('click', function() {
        document.getElementById('boardFrm').action = "/board/deletePost";
        
        let result = confirm("삭제하시겠습니까?");
        
        if (result) {
            document.getElementById('boardFrm').submit();
        } else {
            alert("삭제가 취소되었습니다.");
        }
    });
    
    // 댓글/대댓글 신고 이벤트
    document.addEventListener('click', function(event) {
        if (event.target.closest('.spnReplyReport')) {
            let bodIdx = event.target.closest('.spnReplyReport').dataset.bodIdx;
            console.log("bodIdx before:", bodIdx);
            
            document.getElementById('reportIdx').value = bodIdx;
        }
    });
    
    // 신고 버튼 클릭 이벤트
    document.getElementById('btnReport').addEventListener('click', function() {
        let bodNo = document.querySelector('input[name="bodNo"]').value;
        let bodIdx = document.getElementById('reportIdx').value;
        let repCont = document.getElementById('repCont').value;
        let repReason = document.getElementById('repReason').value;
        let repType;
        
        // repType : 1과 2
        repType = bodIdx === "0" ? "1" : "2";
        
        let data = {
            "bodNo": bodNo,
            "bodIdx": bodIdx,
            "repType": repType,
            "repCont": repCont,
            "repReason": repReason
        };
        
        console.log("전송할 data:", data);
        console.log("bodIdx type:", typeof bodIdx);
        
        handleReport(data);
    });
});
</script>
 
     
 	
 </script>
 
  <!-- ///// footer 시작 ///// -->
  <jsp:include page="../include/footer.jsp"></jsp:include>
  <!-- ///// footer 끝 ///// -->