<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 

<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
    
<script src="https://cdn.jsdelivr.net/npm/progressbar.js@1.1.0/dist/progressbar.min.js"></script> 
<title>영업 기회</title>
<style>
/* 전체 컨테이너 스타일 */
.container {
    padding: 20px;
    background-color: #fff;
    border-radius: 5px;
    margin-top: 20px;
}

/* 검색/필터 영역 스타일 */
.search-section {
    background: #fff;
    padding: 20px;
    border-radius: 5px;
    margin-bottom: 20px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.search-section .row {
    align-items: right; 
}

.date-range {
    display: flex;
    align-items: center;
    gap: 10px;
}

.date-range input {
    flex: 1;
}

/* 버튼 영역 스타일 */
.button-section {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
    padding: 10px 0;
}

/* 영업기회 리스트 스타일 */
.opportunity-list {
    background: #fff;
}

.opportunity-item {
    padding: 20px;
    border-bottom: 1px solid #eee;
    transition: background-color 0.3s;
}

.opportunity-item:hover {
    background-color: #f8f9fa;
}

/* 진행 단계 스타일 */
.progress-steps {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
    gap: 5px;
}

.step-item {
    flex: 1;
    height: 100%;
    position: relative;
    display: flex;
    align-items: center;
}

.step-item:not(:last-child)::after {
    content: '';
    position: absolute;
    right: 0;
    width: 15px;
    height: 2px;
    background: #ddd;
}

.step-content {
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #fff;
    font-size: 0.9em;
}

/* 단계별 색상 */
.step-발굴 { background-color: #FFA07A; } /* 발굴 */
.step-제안 { background-color: #FF7F7F; } /* 제안 */
.step-협상 { background-color: #DA70D6; } /* 협상 */
.step-계약 { background-color: #9370DB; } /* 계약 */

/* 비활성 상태 */
.step-inactive {
    background-color: #f0f0f0;
    color: #999;
}

/* 성공률 프로그레스바 */
.success-rate {
    display: flex;
    align-items: center;
    margin-top: 10px;
}

.progress {
    flex-grow: 1;
    height: 15px;
    background-color: #f5f5f5;
    border-radius: 10px;
    overflow: hidden;
    margin-right: 10px;
}

/* 성공률에 따른 프로그레스바 색상 */
.progress-bar-0-25 {
    background: linear-gradient(to right, #FF6B6B, #FF7F7F);
}

.progress-bar-26-50 {
    background: linear-gradient(to right, #FFA07A, #FF8C69);
}

.progress-bar-51-75 {
    background: linear-gradient(to right, #DA70D6, #BA55D3);
}

.progress-bar-76-100 {
    background: linear-gradient(to right, #9370DB, #8A2BE2);
}

.progress-bar {
    transition: width 0.5s ease-in-out;
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
}

.progress-text {
    color: white;
    font-size: 12px;
    font-weight: bold;
    text-shadow: 1px 1px 1px rgba(0,0,0,0.2);
}

.rate-text {
    min-width: 45px;
    text-align: right;
    color: #666;
}

/* 제목과 날짜 스타일 */
.opportunity-item h5 {
    margin: 0;
    color: #333;
    font-size: 16px;
    font-weight: 600;
}

.opportunity-item p {
    margin: 5px 0 0;
    color: #666;
    font-size: 14px;
}

/* 폼 요소 스타일 */
.form-select, .form-control {
    border: 1px solid #ddd;
    border-radius: 4px;
    height: 38px;
}

.btn {
    padding: 8px 16px;
    border-radius: 4px;
}

.btn-success {
    background-color: #4CAF50;
    border: none;
}

.btn-secondary {
    background-color: #6c757d;
    border: none;
}

/* 반응형 조정 */
@media (max-width: 768px) {
    .search-section .row > div {
        margin-bottom: 10px;
    }
    
    .date-range {
        flex-direction: column;
    }
    
    .progress-steps {
        flex-wrap: wrap;
    }
}

.nav-link.active {
    color: black !important; /* 텍스트 색상 */
    background-color: #F3F6F9 !important; /* 배경색 */
    border-color: #dee2e6 !important; /* 테두리 색상 */
}
.businessSub {
display: block !important;
height: auto !important;
}

    .bluBt{
background-color: #3069CE;
color:white;
outline: none;
border:none;
width: 130px;
height:36px; 
border-radius: 5px;

}
.page-item.active .page-link {
    z-index: 1;
    color: white;
    background-color: #3069CE !important;
    border-color: #3069CE !important;
}
.next > a{
    color: #3069CE !important;

}
.page-item > a{
    color: #3069CE ;
}
.nav-tabs .nav-link{
color: black !important;
}

.nav-tabs .nav-link.active, .nav-tabs .nav-item.show .nav-link{

color:#3069CE !important;

}
.bluBt{
background-color: #3069CE;
color:white;
outline: none;
border:none;
width: 130px;
height:36px; 
border-radius: 5px;

}
</style>

 </head>
<!-- 여기 style css 들어가야해요  -->

<!-- 헤더 include  -->
   <jsp:include page="../include/header.jsp"></jsp:include>
<!-- 헤더 include  -->





<!-- ///// content 시작 ///// -->
<div class="bg-light text-center rounded p-4"  style="background-color:white;">
      <h3 class="mb-0"  ></h3>
       	<div class="nav nav-tabs custom-tabs mb-4">
<!-- 	    <a class="nav-link" href="/business/custManage" data-type="customer">고객 정보</a> -->
	    <a class="nav-link" href="/business/infoList" data-type="sales">영업 관리</a>
	    <a class="nav-link" href="/business/busAct" data-type="Act">영업 활동</a>
	    <a class="nav-link" href="/business/busChance" data-type="Chance">영업 기회</a>
<!-- 	    <a class="nav-link" href="/business/busStat" data-type="stat">영업 통계</a> -->
	</div>
</div>
<div class="container">
    <!-- 1. 검색/필터 영역 -->
    <div class="search-section">
        <div class="row">
            <div class="col-md-3">
                <select class="form-select" id="searchType">
                    <option value="">영업상태</option>
                    <c:forEach var="stateList" items="${stateList}" varStatus="stat">
				        <option value="${stateList.state}">${stateList.state}</option>
				    </c:forEach>
                </select>
            </div>
            
            <!-- 영업 상태 검색 버튼 -->
			    <div class="col-md-2">
			        <button class="btn btn-primary bluBt" onclick="filterByState()">검색</button>
			    </div>
<!--             <div class="col-md-3"> -->
<!--                 <select class="form-select" id="status"> -->
<!--                     <option value="">전체</option> -->
<!--                 </select> -->
<!--             </div> -->
            <div class="col-md-4">
                <div class="date-range">
                    <input type="date" class="form-control" id="startDate">
                    <span>~</span>
                    <input type="date" class="form-control" id="endDate">
                </div>
            </div>
            <div class="col-md-2">
                <button class="btn btn-primary bluBt" onclick="filterOpportunities()">검색</button>
            </div>
        </div>
    </div>
 
 
<!-- 3. 영업기회 리스트 -->
<!-- 기존 opportunity-list div를 다음과 같이 수정 -->
<div class="opportunity-list">
    <c:forEach var="opp" items="${busChanceVOList}" varStatus="stat">
    <c:if test="${stat.index < 7}">
	        <div class="opportunity-item" data-state-stage="${opp.stateStage}" style="cursor:pointer" onclick='window.location.href="http://localhost:8020/contract/detail?currentPage=&keyword=&contractNo=${opp.contractNo}"'>
	            <div class="row">
	                <div class="col-md-8">
	                    <div class="opportunity-title">
	                        <h5>${opp.contractNm}</h5>
	                        <h6> </h6>
	                        ${opp.entName}
	                    </div>
	                    <div class="opportunity-date">
	                        <fmt:formatDate value="${opp.fromDate}"/> ~ <fmt:formatDate value="${opp.toDate}"/>
	                    </div>
	                </div>
	                <div class="col-md-4">
	                    <!-- 진행 단계 -->
	                    <c:set var="stateStage" value="${opp.stateStage}" />
							<div class="progress-steps">
							    <div class="step-item">
							        <!-- 진행률이 0~25%일 때 '발굴' 색상 처리 -->
							        <div class="step-content ${opp.successRate >= 0 ? 'step-발굴' : 'step-inactive'}">발굴</div>
							    </div>
							    <div class="step-item">
							        <!-- 진행률이 25~50%일 때 '제안' 색상 처리 -->
							        <div class="step-content ${opp.successRate > 25 ? 'step-제안' : 'step-inactive'}">제안</div>
							    </div>
							    <div class="step-item">
							        <!-- 진행률이 50~75%일 때 '협상' 색상 처리 -->
							        <div class="step-content ${opp.successRate > 50 ? 'step-협상' : 'step-inactive'}">협상</div>
							    </div>
							    <div class="step-item">
							        <!-- 진행률이 75~100%일 때 '계약' 색상 처리 -->
							        <div class="step-content ${opp.successRate > 75 ? 'step-계약' : 'step-inactive'}">계약</div>
							    </div>
							</div>


	                    <!-- 성공률 -->
		                    <div class="success-rate">
							    <div class="progress">
							        <div class="progress-bar" 
							             role="progressbar" 
							             style="width: ${opp.successRate}%; background-color: ${opp.successRate >= 80 ? 'lightblue' : (opp.successRate >= 50 ? 'yellow' : 'red')};"
							             data-percentage="${opp.successRate}">
							            <span class="progress-text">${opp.successRate}</span>

							        </div>
							    </div>
							</div>

	                </div>
	            </div>
	        </div>
		</c:if>
	</c:forEach>
</div>

<div id="divPagingContainer" style="display: flex; align-items: center; width: 100%; padding-top: 20px;">
    <!-- 페이징을 가운데 정렬 -->
    <div style="flex: 1; display: flex; justify-content: center;">
        <div id="divPagingArea" class="pagination">
            ${articlePage.pagingArea}
        </div>
    </div>
</div>
</div>
<!-- ///// content 끝 ///// -->
 <jsp:include page="../include/footer.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
$(document).ready(function() {


    // ProgressBar.js를 사용한 성공확률 표시
    $('.Progress-bar').each(function() {
        let container = this;
		let percentage = $(this).data('percentage') / 100;
        
        // 성공률에 따른 색상 설정
        let barColor;
        if (percentage <= 0.25) {
            barColor = '#FF6B6B';
        } else if (percentage <= 0.50) {
            barColor = '#FFA07A';
        } else if (percentage <= 0.75) {
            barColor = '#DA70D6';
        } else {
            barColor = '#9370DB';
        }
        
        
        let bar = new ProgressBar.Line(container, {
            strokeWidth: 4,
            easing: 'easeInOut',
            duration: 1400,
            color: barColor,
            trailColor: '#f5f5f5',
            trailWidth: 4,
            svgStyle: {width: '100%', height: '100%'},
            text: {
                style: {
                    color: '#999',
                    position: 'absolute',
                    right: '0',
                    top: '30px',
                    padding: 0,
                    margin: 0,
                    transform: null
                },
                autoStyleContainer: false
            },
            step: (state, bar) => {
                bar.setText(Math.round(bar.value() * 100) + ' %');
            }
        });

//         let percentage = $(this).data('percentage') / 100;
        bar.animate(percentage);
    });
});

$(document).on("click", ".pagination-link", function(event) {
    event.preventDefault();
    let page = $(this).data("page");
    window.location.href = `/business/busChance?page=${page}`;
});



function filterOpportunities() {
    let startDate = document.getElementById("startDate").value;
    let endDate = document.getElementById("endDate").value;
    let items = document.querySelectorAll(".opportunity-item");

    items.forEach(item => {
        let fromDate = new Date(item.getAttribute("data-from-date"));
        let toDate = new Date(item.getAttribute("data-to-date"));
        let start = new Date(startDate);
        let end = new Date(endDate);

        if (startDate && endDate) {
            item.style.display = (fromDate >= start && toDate <= end) ? "" : "none";
        } else {
            item.style.display = "";
        }
    });
}

//영업 상태 필터링
document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("searchType").addEventListener("change", filterByState);
});

function filterByState() {
    let stateStage = document.getElementById("searchType").value;
    let items = document.querySelectorAll(".opportunity-item");

    items.forEach(item => {
        let state = item.getAttribute("data-state-stage");
        console.log(`State Stage: ${state}, Selected: ${stateStage}`);
        
        let stateCondition = (!stateStage || state == stateStage);
        item.style.display = stateCondition ? "" : "none"; 
    });
}

//현재 URL 가져오기
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