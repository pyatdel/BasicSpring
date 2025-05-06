<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<style>

	.center-align{
		text-align: center;
	
	}
    .modal-content  {
    	width:max-content !important; /* max-content를 사용하여 내용에 맞게 넓이를 설정 */
   	 	margin-top: 0px !important;
	    margin-botton:0px !important;
    }

    .modal-dialog.modal-lg {
        max-width: 70%; /* 원하는 비율로 설정 (예: 화면의 90% 너비) */
        width: max-content; /* 기본 넓이 설정 */
    	justify-content: center; /* 가로 중앙 정렬 (기본적으로 설정됨) */
    }
    
    .modal-body {
        max-height: 80%; /* 최대 높이를 화면의 60%로 설정 */
        overflow-y: auto; /* 내용이 많을 경우 스크롤 표시 */
        width: max-content;
    }
	
	.modal-dialog {
	    display: flex;
	    justify-content: center; /* 가로 중앙 정렬 */
/* 	    align-items: center; /* 세로 중앙 정렬 추가 */
	    height: calc(100vh - 20px);  /* 화면 높이에 맞추기 */
	    width:max-content;
	    margin: 0 auto;
	    margin-top: 0px !important;
	    margin-bottom:0px !important;
	}


	#chd {
		background-color: #3069CE; /* 원하는 배경색 */
    	color: white; /* 원하는 글자색 */
    	text-align: center; /* 텍스트 가운데 정렬 */
	}
	
	#aRecent, #aWait, #aCancel {
		color:white;
	}
	

</style>


<!-- ///// header 시작 ///// -->
<jsp:include page="../include/header.jsp"></jsp:include>
<!-- ///// header 끝 ///// -->




<div class="bg-light text-center rounded p-4">
 <h3 class="mb-0" style="text-align: left;">고객 정보</h3>
 	<hr/>
    <div class="table-responsive">
        <!-- 내 고객 카드 -->
<%--         <p>${enterpriceVOList}</p> 왜 null이징? --%>
        <div class="card">
            <!-- 내 고객 카드 -->
<div class="card mb-3"> <!-- mb-3 클래스 추가로 간격을 조정 -->
    <div class="card-header" id="chd">
        <div class="col-md-12 d-flex justify-content-between">
            <div class="fw-bold">내 고객</div>
            <div>
                <a href="#" id="aRecent" class="btn btn-outline-* btn-sm" data-bs-toggle="modal" data-bs-target="#customerModal" data-type="recent">전체보기</a>
            </div>
        </div>
    </div>
    <div class="card-body">
        <table class="table text-start align-middle table-bordered table-hover mb-0">
            <thead>
                <tr class="text-dark center-align">
                    <th>고객사명</th>
                    <th>계약명</th>
                    <th>사업유형</th>
                    <th>상태</th>
                    <th>계약금액</th>
                    <th>등록일자</th>
                </tr>
            </thead>
            <tbody id="tbdyRecent">
                <c:forEach var="enterpriceVO" items="${enterpriceVOList}" varStatus="stat">
                    <c:if test="${stat.index < 3}">
                        <tr>
                            <td style="text-align: center;">${enterpriceVO.entName}</td>
                        	<td>${enterpriceVO.contractNm}</td>
                            <td style="text-align: center;">${enterpriceVO.entType}</td>
                            <td style="text-align: center;">${enterpriceVO.state}</td>
                            <td style="text-align: right;"><fmt:formatNumber value="${enterpriceVO.contractPrice}" pattern="#,###"/>원</td>
                            <td style="text-align: center;"><fmt:formatDate value="${enterpriceVO.inputDatetime}" pattern="yyyy-MM-dd"/></td>
                        </tr>
                    </c:if>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- 대기 중인 고객 카드 -->
<div class="card mb-3"> <!-- mb-3 클래스 추가로 간격을 조정 -->
    <div class="card-header" id="chd">
        <div class="col-md-12 d-flex justify-content-between">
            <div class="fw-bold">대기 중인 고객</div>
            <div>
                <a href="#" id="aWait" class="btn btn-outline-* btn-sm" data-bs-toggle="modal" data-bs-target="#customerModal" data-type="waiting">전체보기</a>
            </div>
        </div>
    </div>
    <div class="card-body">
        <table class="table text-start align-middle table-bordered table-hover mb-0">
            <thead>
                <tr class="text-dark center-align">
                    <th>고객사명</th>
                    <th>계약명</th>
                    <th>사업유형</th>
                    <th>상태</th>
                    <th>계약금액</th>
                    <th>등록일자</th>
                </tr>
            </thead>
            <tbody id="tbdyWait">
                <c:forEach var="enterpriceVO" items="${custVOList}" varStatus="stat">
                    <c:if test="${stat.index < 3}">
                        <tr>
                            <td style="text-align: center;">${enterpriceVO.entName}</td>
                            <td>${enterpriceVO.contractNm}</td>
                            <td style="text-align: center;">${enterpriceVO.entType}</td>
                            <td style="text-align: center;">${enterpriceVO.state}</td>
                            <td style="text-align: right;"><fmt:formatNumber value="${enterpriceVO.contractPrice}" pattern="#,###"/>원</td>
                            <td style="text-align: center;"><fmt:formatDate value="${enterpriceVO.inputDatetime}" pattern="yyyy-MM-dd"/></td>
                        </tr>
                    </c:if>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- 취소한 고객 카드 -->
<div class="card mb-3"> <!-- mb-3 클래스 추가로 간격을 조정 -->
    <div class="card-header" id="chd">
        <div class="col-md-12 d-flex justify-content-between">
            <div class="fw-bold">취소한 고객</div>
            <div>
                <a href="#" id="aCancel" class="btn btn-outline-* btn-sm" data-bs-toggle="modal" data-bs-target="#customerModal" data-type="canceled">전체보기</a>
            </div>
        </div>
    </div>
    <div class="card-body">
        <table class="table text-start align-middle table-bordered table-hover mb-0">
            <thead>
                <tr class="text-dark center-align">
                    <th>고객사명</th>
                    <th>계약명</th>
                    <th>사업유형</th>
                    <th>취소사유</th>
                    <th>계약금액</th>
                    <th>등록일자</th>
                </tr>
            </thead>
            <tbody id="tbdyCancel">
                <c:forEach var="enterpriceVO" items="${delCustVOList}"  varStatus="stat">
                	<c:if test="${stat.index < 3}">
	                    <tr>
	                        <td style="text-align: center;">${enterpriceVO.entName}</td>
	                        <td>${enterpriceVO.contractNm}</td>
	                        <td style="text-align: center;">${enterpriceVO.entType}</td>
	                        <td style="text-align: center;">${enterpriceVO.cancelContent}</td> 
	                        <td style="text-align: right;"><fmt:formatNumber value="${enterpriceVO.contractPrice}" pattern="#,###"/>원</td>
	                        <td style="text-align: center;"><fmt:formatDate value="${enterpriceVO.inputDatetime}" pattern="yyyy-MM-dd"/></td>
	                    </tr>
	                </c:if>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</div>


<div class="modal fade" id="customerModal" tabindex="-1" aria-labelledby="customerModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="customerModalLabel">고객 목록</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table text-start align-middle table-bordered table-hover mb-0">
                        <thead>
                            <tr id="modalTableHeader" class='text-dark center-align'>
                                
                            </tr>
                        </thead>
                        <tbody id="modalTableBody"></tbody>
                    </table>
	                    <!-- 모달 내에 "다음" 버튼 추가 -->
						<button id="loadMoreBtn" class="btn btn-primary">다음</button>
<!-- 				    <ul id="pagination" class="pagination justify-content-center"></ul> -->
                </div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
var isLoading = false;
function updateModalTable(dataType, page = 1) {
    const modalTableBody = $('#modalTableBody');
    const modalTableHeader = $('#modalTableHeader');
    modalTableBody.empty(); // 기존 데이터 제거

    // URL 및 설정값 동적으로 설정
    const urlMap = {
        recent: '/business/getTotal',
        waiting: '/business/getWaiting',
        canceled: '/business/getCanceled',
    };
    
    const url = urlMap[dataType] || '';
    if (!url) return;

    if (isLoading) return; // 중복 요청 방지
    isLoading = true;
    

    // Ajax 요청으로 데이터를 가져옴
    $.ajax({
        url: `\${url}?page=${page}&size=10`,
        method: 'GET',
        success: function (response) {
            const { data, totalCount } = response; // 총 데이터와 전체 카운트
            data.forEach(item => {
            	
            	 // 숫자를 천단위로 포맷하고 '원'을 붙이는 함수
                function formatCurrency(value) {
                  if (!value || isNaN(value)) return "0원"; // 값이 없거나 숫자가 아니면 기본값
                  return new Intl.NumberFormat("ko-KR").format(value) + "원";
                }
                    // 서버에서 전달된 날짜 값 가져오기
                   var inputDatetime = new Date('${item.inputDatetime}');
                    
                    // 날짜 포맷팅 함수
                    function formatDate(date) {
                        let year = date.getFullYear();
                        let month = date.getMonth() + 1; // getMonth()는 0부터 시작하므로 1을 더해줍니다.
                        let day = date.getDate();

                        // 월과 일이 10보다 작으면 앞에 0을 추가하여 두 자리로 맞추기
                        if (month < 10) {
                            month = '0' + month;
                        }
                        if (day < 10) {
                            day = '0' + day;
                        }

                        return year + '-' + month + '-' + day;
                    }

                    // 포맷된 날짜 출력
//                     document.write(formatDate(inputDatetime));

            	
            	var data = formatCurrency(item.contractPrice);
//                 modalTableBody.append(`
//                     <tr>
//                         <td style="text-align: center;">${item.entName || '-'}</td>
//                         <td>${item.contractNm || '-'}</td>
//                         <td style="text-align: center;">${item.entType || '-'}</td>
//                         <td style="text-align: center;">${item.state || item.cancelContent || '-'}</td>
//                         <td style="text-align: right;">\${data || '-'}</td>
//                         <td style="text-align: center;"></td>
//                     </tr>
//                 `);
            });

            // 페이징 처리
            updatePagination(totalCount, page, response.size, dataType);
        },
        error: function (error) {
            console.error('데이터 로드 실패:', error);
            alert('데이터를 로드하는 데 실패했습니다. 잠시 후 다시 시도하세요.');
        }
    });
}


function updatePagination(totalCount, currentPage, size, dataType) {
    const totalPages = Math.ceil(totalCount / size);
    const pagination = $('#pagination');
    pagination.empty();

    for (let i = 1; i <= totalPages; i++) {
        const pageItem = $(`<li class="page-item ${i == currentPage ? 'active' : ''}">
            <a class="page-link" href="#">${i}</a>
        </li>`);

        pageItem.on('click', function (e) {
            e.preventDefault();
            updateModalTable(dataType, i, size);
        });

        pagination.append(pageItem);
    }
}


$(document).on('click', '#aRecent, #aWait, #aCancel', function (e) {
    e.preventDefault();
    const type = $(this).data('type');
    updateModalTable(type); // 모달에 데이터를 업데이트
});

//"다음" 버튼 클릭 시 페이지 증가 및 데이터 로드
$('#loadMoreBtn').on('click', function() {
    currentPage++; // 페이지 번호 증가
    updateModalTable('recent', currentPage); // 'recent' 데이터를 로드
});

// 모달이 열릴 때 처음 데이터를 로드
$('#dataModal').on('show.bs.modal', function() {
    updateModalTable('recent', 1); // 모달이 열릴 때 첫 번째 페이지 데이터 로드
});

//모달 닫을 때 데이터 초기화
$('#customerModal').on('hidden.bs.modal', function () {
//     $('#modalTableBody').empty();
});
</script>

<!-- ///// footer 시작 ///// -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->
