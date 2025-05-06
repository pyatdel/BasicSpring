<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
    
    
<title>고객 정보</title>
<!-- Bootstrap CSS -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> -->
<!-- <link rel="stylesheet" href="path/to/bootstrap.min.css">C -->



<style>
table {
    border-collapse: collapse; /* 테이블 셀 간의 경계 제거 */
    width: 100%; /* 테이블 너비를 100%로 설정 */
}

th, td {
    padding: 8px; /* 셀에 패딩 추가 */
    text-align: center; /* 텍스트를 중앙 정렬 */
    border: 1px solid #ddd; /* 셀에 경계선 추가 */
}
	.center-align{
		text-align: center;
	
	}
    .modal-content  {
     	width:max-content !important; /* max-content를 사용하여 내용에 맞게 넓이를 설정 */ 
   	 	margin-top: 30px !important;
	    margin-botton:50px !important;
    }

    .modal-dialog.modal-lg {
        max-width: 70%; /* 원하는 비율로 설정 (예: 화면의 90% 너비) */
        width: max-content; /* 기본 넓이 설정 */
    	justify-content: center; /* 가로 중앙 정렬 (기본적으로 설정됨) */
    }
    
    .modal-body {
          max-height: 80%; /* 최대 높이를 화면의 60%로 설정 */ 
/*         overflow-y: auto; /* 내용이 많을 경우 스크롤 표시 */ 
        width: max-content !important;
    }
	
	.modal-dialog {
/* 	    display: flex; 
	    justify-content: center; /* 가로 중앙 정렬 */
/* 	    align-items: center; /* 세로 중앙 정렬 추가 */ */
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
	
	.mb-0{
		margin-bottom: 30px !important;
	}
	
	.nav-link.active {
	    color: black !important; /* 텍스트 색상 */
    background-color: #F3F6F9 !important; /* 배경색 */
    border-color: #dee2e6 !important; /* 테두리 색상 */
}

.hdFlex{
    display: flex;
        display: flex
;
    align-content: center;
    align-items: center;
}
.contlist{

}
.businessSub {
display: block !important;
height: auto !important;
}
</style>

<!-- 헤더 include  -->
   <jsp:include page="../include/header.jsp"></jsp:include>
<!-- 헤더 include  -->



<div class="bg-light text-center rounded p-4">


 	<h3 class="mb-0"></h3>
<!--          	<div class="nav nav-tabs custom-tabs mb-4"> -->
<!-- 			    <a class="nav-link" href="/business/custManage" data-type="customer">고객 정보</a> -->
<!-- 			    <a class="nav-link" href="/business/infoList" data-type="sales">영업 관리</a> -->
<!-- 			    <a class="nav-link" href="/business/busAct" data-type="Act">영업 활동</a> -->
<!-- 			    <a class="nav-link" href="/business/busChance" data-type="Chance">영업 기회</a> -->
<!-- 			    <a class="nav-link" href="/business/busStat" data-type="stat">영업 통계</a> -->
<!-- 			</div> -->
<div class="hdFlex">
         <h3 class=" contlist" style="font-weight:normal">영업관리</h3>
         <h5 class=" contlist" style="font-weight:normal"> &nbsp;> 고객정보</h5>
      </div>
<div id="content"> 
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
                        	<td style="text-align: left;">${enterpriceVO.contractNm}</td>
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
                            <td style="text-align: left;">${enterpriceVO.contractNm}</td>
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
	                        <td style="text-align: left;">${enterpriceVO.contractNm}</td>
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


<!-- 모달 부분 수정 -->
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
                        <thead id="modalTableHeader">
<!--                             <tr id="modalTableHeader" class='text-dark center-align'></tr> -->
                        </thead>
                        <tbody id="modalTableBody">
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <div class="d-flex justify-content-center w-100">
                    <button id="loadMoreBtn" class="btn btn-primary">더보기</button>
                </div>
            </div>
        </div>
    </div>
</div>

</div>
   <jsp:include page="../include/footer.jsp"></jsp:include>

</div>
<!-- Bootstrap 5 JS 추가 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
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
};

//type :  recent / type :  waiting / type :  canceled
    function updateModalTable(dataType) {
        const modalTableBody = $('#modalTableBody');
        const modalTableHeader = $('#modalTableHeader');
        modalTableBody.empty(); // 기존 데이터 제거
        modalTableHeader.empty(); // 기존 데이터 제거

        let url = '';
        let modalTitle = '';
        let tableHeader = '';
        let tableRow = '';
		
        // 각 데이터 타입에 맞는 URL 설정 및 테이블 헤더 구성을 변경
        if (dataType === 'recent') {
        	console.log("dataType : ",dataType);
        	
        	
            modalTitle = '내 고객 목록';
            url = '/business/getTotal';  // 내 고객 전체 조회

            tableHeader = `
            	<thead>
                <tr class="text-dark">
                    <th>고객사명</th>
                    <th>계약명</th>
                    <th>사업유형</th>
                    <th>상태</th>
                    <th>등록일자</th>
                 </tr>
                 </thead>`;
                 
            tableRow = (item) => `
//                 <tr>
            		<td>`+item.entName+`</td>
                    <td>`+item.contractNm+`</td>
                    <td>`+item.entType+`</td>
                    <td>`+item.state+`</td>
                    <td>`+formatDate(new Date(item.inputDatetime))+`</td>
                `;
	
                
        } else if (dataType === 'waiting') {
            modalTitle = '대기 중인 고객 목록';
            url = '/business/getWaiting';  // 대기 중인 고객 조회
			
            tableHeader = `
            	<thead>
                <tr class="text-dark">
                    <th>고객사명</th>
                    <th>계약명</th>
                    <th>사업유형</th>
                    <th>상태</th>
                    <th>등록일자</th>
                </tr>
                </thead>`;

            tableRow = (item) => `
                <tr>
                    <td>`+item.entName+`</td>
            		<td>`+item.contractNm+`</td>
                    <td>`+item.entType+`</td>
                    <td>`+item.state+`</td>
                    <td>`+formatDate(new Date(item.inputDatetime))+`</td>
                </tr>`;
                
        } else if (dataType === 'canceled') {
            modalTitle = '취소한 고객 목록';
            url = '/business/getCanceled';  // 취소한 고객 조회

            tableHeader = `
            	<thead>
                <tr class="text-dark">
                    <th>고객사명</th>
                    <th>계약명</th>
                    <th>사업유형</th>
                    <th>취소사유</th>
                    <th>등록일자</th>
                </tr>
                </thead>`;

            tableRow = (item) => `
                <tr>
                    <td>`+item.entName+`</td>
           			<td>`+item.contractNm+`</td>
                    <td>`+item.entType+`</td>
                    <td>`+item.cancelContent+`</td>
                    <td>`+formatDate(new Date(item.inputDatetime))+`</td>
                </tr>`;
        }
		
        // Ajax를 사용하여 서버로부터 데이터 받아오기
        ///business/getTotal
        $.ajax({
            url: url,
            type: 'GET',
            success: function(response) {
                // 서버에서 데이터를 받아온 후 모달에 데이터 추가
                const dataList = response;  // 서버에서 받아온 데이터
                $('#customerModalLabel').text(modalTitle);
                modalTableHeader.html(tableHeader); // 각 타입에 맞는 테이블 헤더 적용

                // 받아온 데이터로 테이블 업데이트
                dataList.forEach(item => {
                    const row = tableRow(item); // 각 타입에 맞는 테이블 row 추가
                    //console.log("item: ", item)
                    modalTableBody.append(row);
                });
            },
            error: function(error) {
                //console.error("Error fetching customer data: ", error);
            }
        });
    }

    // 버튼 클릭 시 해당 타입의 데이터를 모달에 로드
    $(document).on('click', '#aRecent, #aWait, #aCancel', function(e) {
        e.preventDefault();
        const type = $(this).data('type');
        //type :  recent / type :  waiting / type :  canceled
        console.log("type : ", type);
        
        updateModalTable(type); // 모달에 데이터를 업데이트
    });
// 현재 URL 가져오기
const currentPath = window.location.pathname;

// 모든 탭 요소 가져오기
const navLinks = document.querySelectorAll('.nav-link');

// 현재 경로와 href가 일치하는 탭에 active 클래스 추가
navLinks.forEach(link => {
    if (link.getAttribute('href') === currentPath) {
        link.classList.add('active'); // Bootstrap의 기본 스타일을 활용
    }
});

</script>
</html>