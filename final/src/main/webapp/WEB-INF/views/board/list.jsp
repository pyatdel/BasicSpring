<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
  
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/adminlte/dist/css/adminlte.min.css" />

<style>
/* 게시판 테이블 헤더 스타일 */
.table thead th {
    background-color: #3676EB;  /* 파란색 */
    color: white;               /* 흰색 글자 */
    border-bottom: none;        /* 기존 테두리 제거 */
    vertical-align: middle;     /* 세로 가운데 정렬 */
}

/* 제목 컬럼만 좌측 정렬이 필요한 경우 */
.table thead th:nth-child(3) {
    text-align: left;
}

/* 나머지 컬럼들은 가운데 정렬 */
.table thead th {
    text-align: center;
}

.board-tabs{
	display: flex;
    border-bottom: 1px solid #dee2e6;
    margin-bottom: 20px;
}

.board-tabs .nav-link {
    padding: 10px 20px;
    color: #495057;
    text-decoration: none;
    border-bottom: 2px solid transparent;
}

.board-tabs .nav-link.active {
    color: #007bff;
    border-bottom: 2px solid #007bff;
}

.content-wrapper {
    background: #f8f9fa;
    padding: 20px;
}

.card {
    margin-bottom: 1rem;
    border: none;
    box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2);
}

.card-header {
    padding: 1rem;
    background-color: #fff;
    border-bottom: 1px solid #3676EB;
}

.card-title {
    margin: 0;
    font-size: 1.25rem;
}

.custom-tabs {
    padding: 0.5rem 1rem;
    background-color: #fff;
    border-bottom: 1px solid #dee2e6;
}


.board-category {
    padding: 4px 8px;
    border-radius: 4px;
    display: inline-block;
    font-weight: 500;
    min-width: 80px;
    text-align: center;
    margin-right: 8px;
}

.notice {
    background-color: #f8d7da;
    color: #721c24;
}

.department {
    background-color: #d4edda;
    color: #155724;
}

.qna {
    background-color: #cce5ff;
    color: #004085;
}

.table th {
    text-align: center;
}

.table td {
    text-align: center;
}

.table td:nth-child(2) {
    text-align: left;
}

.notice-header {
    background-color: #f8f9fa;
}

.notice-item {
    background-color: #fff3cd;
}

.d-none {
    display: none !important;
}

.read-marker {
    display: inline-block;
    font-size: 0.75rem;  /* 작은 크기 */
    color: #909090;      /* 연한 회색 */
    margin-left: 5px;    /* 제목과의 간격 */
    vertical-align: top; /* 텍스트 상단 정렬 */
    font-weight: normal; /* 볼드 해제 */
}

.reply-count {
	display: inline-block;
    color: #0d6efd;  // 파란색
    margin-left: 30px;    /* 제목과의 간격 */
    vertical-align: top; /* 텍스트 상단 정렬 */
    font-weight: normal; /* 볼드 해제 */
}

/* 반응형 처리 */
@media (max-width: 768px) {
    .table th:nth-child(4),
    .table td:nth-child(4),
    .table th:nth-child(5),
    .table td:nth-child(5) {
        display: none;
    }
    
    .board-category {
        min-width: 60px;
        padding: 2px 4px;
    }
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
  width: 10px;
  padding-top: 10px;
  padding-bottom: 5px;
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

<div class="content-wrapper" style="min-height: 100vh; background: #f8f9fa; padding: 20px;">
    <!-- 상단 헤더 -->
    <div class="content-header" style="margin-bottom: 20px;">
        <div class="d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center">
                <h1 class="m-0" style="font-size: 24px; font-weight: bold;">게시판</h1>
                <div class="view-type-buttons ml-4">
                    <button type="button" class="btn btn-outline-primary active" onclick="changeView('classic')">클래식형</button>
                    <button type="button" class="btn btn-outline-primary ml-2" onclick="changeView('feed')">피드형</button>
                </div>
            </div>
            <div>
                <a href="/board/form" class="bluBt">
                    <i class="fas fa-plus"></i> 게시글 작성
                </a>
            </div>
        </div>
    </div>

    <!-- 검색창 -->
    <div class="search-write-section d-flex justify-content-between align-items-center mb-4">
        <div class="search-bar flex-grow-1 mr-3">
            <div class="input-group">
                <input type="text" name="keyword" value="${param.keyword}" class="form-control" placeholder="검색어를 입력하세요">
                <div class="input-group-append">
                    <button type="button" id="btnSearch" class="btn btn-outline-secondary">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 탭 메뉴 -->
    <div class="board-tabs">
			    <a class="nav-link" href="#" data-type="">전체게시판</a>
			    <a class="nav-link" href="#" data-type="1">공지사항</a>
			    <a class="nav-link" href="#" data-type="2">부서게시판</a>
			    <a class="nav-link" href="#" data-type="3">QnA게시판</a>
			</div>
			
	<!-- <div class="community-tabs">
        <div class="tab active" data-tab="my-communities">내 동호회</div>
        <div class="tab" data-tab="all-communities">전체 동호회</div>
    </div> -->

    
    <!-- 게시글 목록 -->
    <div class="board-content" id="classicView">
        <div class="card">
            <div class="card-body table-responsive p-0">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th style="width: 8%">글번호</th>
                            <th style="width: 13%">종류</th>
                            <th style="width: 35%">제목</th>
                            <th style="width: 15%">작성자</th>
                            <th style="width: 17%">작성일시</th>
                            <th style="width: 10%">조회수</th>
                        </tr>
                    </thead>
                    <tbody id="tby">
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- 피드형 목록 -->
    <div class="board-content" id="feedView" style="display: none;">
    </div>
	
    <!-- 페이징 -->
    <div class="card-footer" id="divPagingArea"></div>
    
    
   <jsp:include page="../include/footer.jsp"></jsp:include>
</div>



<script type="text/javascript">
// null 체크 함수
function nvl(expr1, expr2) {
   if (expr1 === undefined || expr1 == null || expr1 == "") {
       expr1 = expr2;
   }
   return expr1;
}

//날짜 포맷팅 함수 
function formatDate(dateStr) {
    if (!dateStr) return "";
    try {
        const date = new Date(dateStr);
        
        // 날짜가 유효한지 확인
        if (isNaN(date.getTime())) {
            console.error("유효하지 않은 날짜:", dateStr);
            return "";
        }
        
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        
        // 템플릿 리터럴 대신 문자열 연결 사용
        return year + "-" + month + "-" + day;
    } catch (e) {
        console.error("날짜 변환 중 오류:", e);
        return dateStr;
    }
}


// URL에서 bodType 파라미터를 가져오는 함수
function getUrlParameter(name) {
   const urlParams = new URLSearchParams(window.location.search);
   return urlParams.get(name);
}

// 전역 변수
let bodType = getUrlParameter('bodType') || "";
let currentView = 'classic';

function getList(currentPage, keyword, bodType) {
   let data = {
       "currentPage": nvl(currentPage,"1"),
       "keyword": nvl(keyword,""),
       "bodType": bodType || ""
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
    	    
    	    // 날짜 형식 확인을 위한 로그
    	    console.log("첫번째 게시물의 날짜:", articlePage.content[0].bodCreDate);
    	    console.log("날짜 포맷팅 테스트:", formatDate(articlePage.content[0].bodCreDate));
    	    
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
           
           // 현재 뷰 타입에 따라 다른 렌더링 함수 호출
           if (currentView === 'classic') {
               renderClassicView(urgentNotices, normalNotices, normalPosts);
           } else {
               renderFeedView(urgentNotices, normalNotices, normalPosts);
           }
           
           $("#divPagingArea").html(articlePage.pagingArea);
       }
   });
   
}

function renderClassicView(urgentNotices, normalNotices, normalPosts) {
   let str = "";
   
   // 1. 긴급 공지사항 섹션
   if (urgentNotices.length > 0) {
    str += '<tr class="notice-header bg-light">' +
        '<td colspan="6">' +  // 5에서 6으로 수정 (컬럼 추가)
        '<div class="d-flex align-items-center">' +
        '<span class="toggle-notice me-2" data-section="urgent" style="cursor:pointer;">▾</span>' +
        '<strong>긴급 공지사항 (' + urgentNotices.length + ')</strong>' +
        '</div>' +
        '</td>' +
        '</tr>';

    urgentNotices.forEach((boardVO, idx) => {
        str += '<tr class="notice-item urgent-notice' + (idx > 0 ? ' d-none' : '') + '">' +
            '<td>' + boardVO.bodNo + '</td>' +
            '<td style="text-align: center;">' +  // 종류 컬럼 추가 및 가운데 정렬
            '<span class="board-category notice">' +
            '긴급공지' +
            '</span>' +
            '</td>' +
            '<td style="text-align: left;">' +    // 제목 컬럼 분리 및 좌측 정렬
            '<a href="/board/detail/' + boardVO.bodNo + '" ' +
            'class="fw-bold text-danger">' + boardVO.bodTitle +
            (boardVO.bodRead == 1 ? '<span class="read-marker">r</span>' : '') +
            (boardVO.replyCount > 0 ? ' <span class="reply-count">[' + boardVO.replyCount + ']</span>' : '') +
            '</a>' +
            '</td>' +
            '<td>' + nvl(boardVO.bodWriter, "") + '</td>' +
            '<td>' + formatDate(boardVO.bodCreDate) + '</td>' +
            '<td>' + nvl(boardVO.bodHit, "") + '</td>' +
            '</tr>';
    });
}
   
	   // 2. 일반 공지사항 섹션
	   if (normalNotices.length > 0) {
	       str += '<tr class="notice-header bg-light">' +
	           '<td colspan="6">' +  // 5에서 6으로 수정 (컬럼 추가)
	           '<div class="d-flex align-items-center">' +
	           '<span class="toggle-notice me-2" data-section="normal" style="cursor:pointer;">▾</span>' +
	           '<strong>공지사항 (' + normalNotices.length + ')</strong>' +
	           '</div>' +
	           '</td>' +
	           '</tr>';

	       normalNotices.forEach((boardVO, idx) => {
	           str += '<tr class="notice-item normal-notice' + (idx > 0 ? ' d-none' : '') + '">' +
	               '<td>' + boardVO.bodNo + '</td>' +
	               '<td style="text-align: center;">' +  // 종류 컬럼 추가 및 가운데 정렬
	               '<span class="board-category notice">' +
	               boardVO.boardTypeVO.bodTypeName +
	               '</span>' +
	               '</td>' +
	               '<td style="text-align: left;">' +    // 제목 컬럼 분리 및 좌측 정렬
	               '<a href="/board/detail/' + boardVO.bodNo + '" ' +
	               'class="fw-bold">' + boardVO.bodTitle +
	               (boardVO.bodRead == 1 ? '<span class="read-marker">r</span>' : '') +
	               (boardVO.replyCount > 0 ? ' <span class="reply-count">[' + boardVO.replyCount + ']</span>' : '') +
	               '</a>' +
	               '</td>' +
	               '<td>' + nvl(boardVO.bodWriter, "") + '</td>' +
	               '<td>' + formatDate(boardVO.bodCreDate) + '</td>' +
	               '<td>' + nvl(boardVO.bodHit, "") + '</td>' +
	               '</tr>';
	       });
   }

	// 3. 일반 게시물 목록
   normalPosts.forEach(boardVO => {
    str += '<tr>' +
        '<td>' + boardVO.bodNo + '</td>' +
        '<td style="text-align: center;">' +  // 종류 컬럼 가운데 정렬
        '<span class="board-category ' + 
        (boardVO.boardTypeVO.bodTypeName === '부서' ? 'department' : 'qna') + '">' +
        boardVO.boardTypeVO.bodTypeName +
        '</span>' + 
        '</td>' +
        '<td style="text-align: left;">' +    // 제목 컬럼 좌측 정렬
        '<a href="/board/detail/' + boardVO.bodNo + '">' +
        boardVO.bodTitle +
        (boardVO.bodRead === 1 ? '<span class="read-marker">r</span>' : '') +
        (boardVO.bodReCnt > 0 ? ' <span class="reply-count">[' + boardVO.bodReCnt + ']</span>' : '') +
        '</a>' +
        '</td>' +
        '<td>' + nvl(boardVO.bodWriter, "") + '</td>' +
        '<td>' + formatDate(boardVO.bodCreDate) + '</td>' +
        '<td>' + nvl(boardVO.bodHit, "") + '</td>' +
        '</tr>';
});
   
   $("#tby").html(str);
}

function renderFeedView(urgentNotices, normalNotices, normalPosts) {
   let str = "";
   const allPosts = [...urgentNotices, ...normalNotices, ...normalPosts];
   
   allPosts.forEach(boardVO => {
       str += '<div class="card mb-3">' +
           '<div class="card-body">' +
           '<div class="d-flex">' +
           '<div class="user-avatar mr-3">' +
           '<div style="width: 48px; height: 48px; background-color: #e9ecef; border-radius: 50%; display: flex; align-items: center; justify-content: center;">' +
           boardVO.bodWriter.substring(0, 1) +
           '</div>' +
           '</div>' +
           '<div style="flex: 1;">' +
           '<div class="d-flex justify-content-between">' +
           '<div>' +
           '<h6 class="mb-0">' + boardVO.bodWriter + '</h6>' +
           '<small class="text-muted">' + formatDate(boardVO.bodCreDate) + '</small>' +
           '</div>' +
           '</div>' +
           '<span class="board-category ' + 
           (boardVO.boardTypeVO.bodTypeName === '공지사항' ? 'notice' : 
            boardVO.boardTypeVO.bodTypeName === '부서' ? 'department' : 'qna') + '">' +
           boardVO.boardTypeVO.bodTypeName +
           '</span>' +
           '<a href="/board/detail/' + boardVO.bodNo + '" class="text-dark text-decoration-none">' +
           '<h5 class="mt-2">' + boardVO.bodTitle + '</h5>' +
           '</a>' +
           '<div class="mt-3">' +
           '<span class="text-muted mr-3">' +
           '<i class="far fa-eye"></i> ' + boardVO.bodHit +
           '</span>' +
           '</div>' +
           '</div>' +
           '</div>' +
           '</div>' +
           '</div>';
   });
   
   $("#feedView").html(str);
}

function changeView(type) {
   if (currentView === type) return;
   
   currentView = type;
   const classicView = document.getElementById('classicView');
   const feedView = document.getElementById('feedView');
   
   if (type === 'classic') {
       classicView.style.display = 'block';
       feedView.style.display = 'none';
   } else {
       classicView.style.display = 'none';
       feedView.style.display = 'block';
   }
   
   // 현재 페이지의 데이터로 새로운 뷰 렌더링
   getList("1", $("input[name='keyword']").val(), bodType);
   
   // 버튼 활성화 상태 변경
   document.querySelectorAll('.view-type-buttons button').forEach(btn => {
       btn.classList.remove('active');
       if (btn.textContent.toLowerCase().includes(type)) {
           btn.classList.add('active');
       }
   });
}

// 문서 로딩 완료 후 실행되는 코드
$(function(){
   // 초기 목록 로드
   getList("1", "", bodType);
   
   // 탭 활성화 (현재 선택된 bodType에 따라)
   $(`.board-tabs .nav-link[data-type="${bodType}"]`).addClass('active');
   
   // 탭 클릭 이벤트
   $(".board-tabs .nav-link").on("click", function(e) {
       e.preventDefault();
       $(this).addClass('active').siblings().removeClass('active');
       bodType = $(this).data('type');
       // URL 업데이트
       const newUrl = new URL(window.location);
       newUrl.searchParams.set('bodType', bodType);
       window.history.pushState({}, '', newUrl);
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
   
   // 공지사항 토글 이벤트
   $(document).on("click", ".toggle-notice", function() {
       const $this = $(this);
       const section = $this.data("section");
       const $noticeItems = section === "urgent" 
           ? $(".urgent-notice:not(:first-child)")
           : $(".normal-notice:not(:first-child)");
       
       if ($this.text() === "▾") {
           $noticeItems.removeClass("d-none");
           $this.text("▴");
       } else {
           $noticeItems.addClass("d-none");
           $this.text("▾");
       }
   });
});

</script>

</html>