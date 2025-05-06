<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
    
<title>매출 통계</title>
<style>
.main-wrapper {
    padding: 10px;
/*     padding-left: 10px; */
    width: 90%;
    margin-top: 30px;
    margin-left: 60px;
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
.filter-section {
    display: flex;
    gap: 15px;
    margin-bottom: 30px;
    padding: 30px;
    padding-left: 170px;
    text-align: center;
    font-weight: bold;
    background: white;
    border-radius: 10px;
    box-shadow: 0 2px 4px rgb(0 0 0 / 51%);
}

.filter-item {
    flex: 1;
}

.filter-item select, .filter-item input {
    width: 100%;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 5px;
}

.stats-cards {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
}

.stat-card {
    background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 2px 4px   rgb(0 0 0 / 51%);
    font-size: medium;
/*     font-weight: bold; */
}

.stat-title {
    color: #666;
    font-size: 14px;
    margin-bottom: 10px;
}

.stat-value {
    font-size: 20px;
    font-weight: bold;
    color: #333;
}

.chart-grid {
    display: grid;
    grid-template-columns: 1fr;
    gap: 20px;
    margin-bottom: 20px;
}

.chart-row {
    display: grid;
    grid-template-columns: 2fr 1fr;
    gap: 20px;
}

.chart-container {
    background: white;
    padding: 70px;
    border-radius: 10px;
    box-shadow: 0 2px 4px  rgb(0 0 0 / 51%);
}

.chart-container.full-width {
    grid-column: 1 / -1;
}

canvas {
    width: 100% !important;
    height: auto !important;
}

.nav-tabs.custom-tabs .nav-link.active {
    color: black !important;
    background-color: #F3F6F9 !important;
    border-color: #dee2e6 !important;
}

#mChart {
heigth:500px !important;
}

.hdFlex {
       display: flex
;
    align-items: center;
    /* align-items: center; */
    margin: 0 auto;
    width: 90%;

/*      align-items: center;  */
/*     justify-content: flex-start; /* 왼쪽 정렬 */ */
/* 	gap: 5px; /* 띄어쓰기 유지 */ */
}

.contlist {
    white-space: pre !important; 
}
.cashSub{
display: block !important;
height: auto !important;
}
</style>
</head>
<!-- 여기 style css 들어가야해요  -->

<!-- 헤더 include  -->
   <jsp:include page="../include/header.jsp"></jsp:include>
<!-- 헤더 include  -->

<div class="bg-light text-center rounded p-4">
<!--  	<h3 class="mb-0"></h3> -->
 	<div class="hdFlex">
         <h3 class=" contlist" style="font-weight:normal">매출관리</h3>
         <h5 class=" contlist" style="font-weight:normal"> &nbsp;> 매출통계</h5>
      </div>
<!--          	<div class="nav nav-tabs custom-tabs mb-4"> -->
<!-- 			    <a class="nav-link" href="/cash/cashList" data-type="cashList">매출 정보</a> -->
<!-- 			    <a class="nav-link" href="/cash/cashPercent" data-type="cashPercent">매출 현황</a> -->
<!-- 			    <a class="nav-link" href="/cash/cashAnaly" data-type="cashAnaly">매출 통계</a> -->
<!-- 			    <a class="nav-link" href="/cash/cashCreate" data-type="cashCreate">지출 신청</a> -->
<!-- 			</div> -->

<div class="main-wrapper">
    <!-- 필터 섹션 -->
    <div class="filter-section">
	        <div class="filter-item">
	            <label>기업 선택</label>
	            <select id="companySelect" class="form-select">
	                <option value="">선택하세요</option>
	                <c:forEach var="ent" items="${entList}" varStatus="stat">
				        <option value="${ent.entName}">${ent.entName}</option>
				    </c:forEach>
	            </select>
	        </div>
	        <div class="filter-item">
	            <label>시작일</label>
	            <input type="date" id="startDate" class="form-control">
	        </div>
	        <div class="filter-item">
	            <label>종료일</label>
	            <input type="date" id="endDate" class="form-control">
	        </div>
	        <div class="filter-item" style="display: flex; align-items: flex-end;">
	            <button class="bluBt" onclick="applyFilters()">적용</button>
	        </div>
    </div>

    <!-- 통계 카드 -->
    
	    <div class="stats-cards">
		    <c:forEach var="totalSale" items="${totalSale}" varStatus="stat">
	        <div class="stat-card">
	            <div class="stat-title">누적 매출액</div>
	            <div class="stat-value">
	            <fmt:formatNumber value="${totalSale.contractPrice}" pattern="#,###"/>원
	        </div>
	        </div>
	        </c:forEach>
	        <c:forEach var="monthAvg" items="${monthAvg}" varStatus="stat">
	        <div class="stat-card">
	            <div class="stat-title">월 평균 매출액</div>
<!-- 	            <div>4.32%</div> -->
	            <div class="stat-value"><fmt:formatNumber value="${monthAvg.totalExpense}" pattern="#,###"/>원</div>
	        </div>
	        </c:forEach>
	        <c:forEach var="goalSale" items="${goalSale}" varStatus="stat">
	        <div class="stat-card">
			        <div class="stat-title">목표 달성률</div>
			        <div class="stat-value">
			        		4.32%
<%-- 			            <fmt:formatNumber value="${goalSale.achievementRate}" pattern="#,###"/>% --%>
			        </div>
			    </div>
			</c:forEach>
	        <c:forEach var="confirmedSale" items="${confirmedSale}" varStatus="stat">
	        <div class="stat-card">
	            <div class="stat-title">계약 체결 수</div>
	            <div class="stat-value"> <fmt:formatNumber value="${confirmedSale.confirmedContracts}" type="number"/>건</div>
	        </div>
	        </c:forEach>
	        <c:forEach var="entSale" items="${entSale}" varStatus="stat">
	        <div class="stat-card">
	            <div class="stat-title">객단가</div>
	            <div class="stat-value"><fmt:formatNumber value="${entSale.contractPrice}" pattern="#,###"/>원</div>
	        </div>
		    </c:forEach>
	    </div>

    <!-- 차트 그리드 -->
    <div class="chart-grid">
        <!-- 메인 차트 -->
        <div class="chart-container" id="mChart">
            <canvas id="mainChart" ></canvas>
        </div>
        <!-- 하단 차트들 -->
        <div class="chart-row">
            <div class="chart-container" id="eChart">
                <canvas id="monthlyChart"></canvas>
            </div>
            <div class="chart-container" id="pChart">
                <canvas id="pieChart"></canvas>
            </div>
        </div>
    </div>
      <jsp:include page="../include/footer.jsp"></jsp:include>
    
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
//차트를 전역변수로 선언
let mainChart, monthlyChart, pieChart;

//데이터 문자열을 숫자로 변환하는 함수
function convertToNumbers(arr) {
    return arr.map(value => Number(value.replace(/[^0-9.-]+/g,'')));
}

//월별 매출 통계 그래프
var monthLabel = [
    <c:forEach items="${monthSaleStat}" var="data" varStatus="loop">
        "${data.month}"<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
];
// 월별 라벨 생성 (2024년 1월 ~ 2026년 12월)
const monthLabels = [];
for (let year = 2024; year <= 2025; year++) {
    for (let month = 1; month <= 12; month++) {
        monthLabels.push(`${year}-${month.toString().padStart(2, '0')}`);
    }
}

//더미 데이터 생성
const numericSalesData = [];
for (let i = 0; i <= monthLabels.length; i++) {
    numericSalesData.push(Math.floor(Math.random() * (10000000 - 1000000 + 1)) + 1000000);
}	
// //월별 매출 통계 그래프
var salesData = [
    <c:forEach items="${monthSaleStat}" var="data" varStatus="loop">
        "${data.totalExpense != null ? data.totalExpense : 0}"<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
];		
		
//기업별 매출 통계 그래프 - 기업 이름 
var enterSaleLabels = [
    <c:forEach items="${enterSaleStat}" var="data" varStatus="loop">
        "${data.entName}"<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
];
		
//기업별 매출 통계 그래프
var enterSaleStat = [
    <c:forEach items="${enterSaleStat}" var="data" varStatus="loop">
        "${data.totalPrice}"<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
];

//차트 초기화 함수
function initializeCharts() {
    // 데이터 문자열을 숫자로 변환
    const numericSalesData = salesData.map(value => 
        typeof value === 'string' ? Number(value.replace(/[^0-9.-]+/g,'')) : value
    );
    const numericEnterSaleStat = enterSaleStat.map(value => 
        typeof value === 'string' ? Number(value.replace(/[^0-9.-]+/g,'')) : value
    );

 // mainChart 초기화
mainChart = new Chart(document.getElementById('mainChart'), {
    type: 'line',
    data: {
        labels: monthLabel,
        datasets: [{
            label: '월별 매출액',
            data: salesData,
            fill: true,
            borderColor: 'rgb(75, 192, 192)',
            tension: 0.3,
            backgroundColor: 'rgba(75, 192, 192, 0.2)'
        }]
    },
    options: {
        responsive: true,
        plugins: {
            title: {
                display: true,
                font: { size: 16, weight: 'bold' }
            }
        },
        scales: {
            y: {
                beginAtZero: true,
                ticks: {
                    callback: function(value) {
                        return value.toLocaleString() + '원';
                    }
                }
            }
        }
    }
});

    // monthlyChart 초기화
    monthlyChart = new Chart(document.getElementById('monthlyChart'), {
        type: 'bar',
        data: {
            labels: enterSaleLabels,
            datasets: [{
                label: '기업별 매출액',
                data: numericEnterSaleStat,
                backgroundColor: 'rgba(54, 162, 235, 0.5)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                title: {
                    display: true,
//                     text: '매출 상위 5개 기업',
                    font: {
                        size: 16,
                        weight: 'bold'
                    }
                },
                legend: {
                    position: 'top'
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return value.toLocaleString() + '원';
                        }
                    }
                }
            }
        }
    });

    // pieChart 초기화
    pieChart = new Chart(document.getElementById('pieChart'), {
        type: 'doughnut',
        data: {
            labels: ['계약체결', '진행중', '보류'],
            datasets: [{
                data: [30, 15, 10],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.5)',
                    'rgba(54, 162, 235, 0.5)',
                    'rgba(255, 206, 86, 0.5)'
                ]
            }]
        },
        options: {
            responsive: true,
            plugins: {
                title: {
                    display: true,
                    text: '거래 상태 비율'
                }
            }
        }
    });
}

$(document).ready(function() {
    // 차트 초기화 호출
    initializeCharts();

    //필터 적용을 위한 JavaScript 코드
    // 날짜 기본값 설정 (현재 달의 1일부터 오늘까지)
    const today = new Date();
    const firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
    
    document.getElementById('startDate').value = firstDay.toISOString().split('T')[0];
    document.getElementById('endDate').value = today.toISOString().split('T')[0];

    //현재 URL 가져오기
    const currentPath = window.location.pathname;
    
    // 모든 탭 요소 가져오기
    const navLinks = document.querySelectorAll('.nav-link');
    
    // 현재 경로와 href가 일치하는 탭에 active 클래스 추가
    navLinks.forEach(link => {
        if (link.getAttribute('href') === currentPath) {
            link.classList.add('active');
        }
    });
});

// 날짜 유효성 검사
function validateDates() {
    const startDate = new Date(document.getElementById('startDate').value);
    const endDate = new Date(document.getElementById('endDate').value);
    
    if (startDate > endDate) {
        alert('시작일은 종료일보다 이후일 수 없습니다.');
        return false;
    }
    return true;
}

// 필터 적용 함수
function applyFilters() {
    if (!validateDates()) return;
    
    const company = document.getElementById('companySelect').value;
    const startDate = document.getElementById('startDate').value;
    const endDate = document.getElementById('endDate').value;
    
 	// 값들이 제대로 가져와지는지 확인
    console.log('Selected company:', company);
    console.log('Start date:', startDate);
    console.log('End date:', endDate);
    
    // CSRF 토큰 추가 (Spring Security 사용 시 필요)
    const token = $("meta[name='_csrf']").attr("content");
    const header = $("meta[name='_csrf_header']").attr("content");
    
    // AJAX 요청
    $.ajax({
        url: '/cash/filterData',
        method: 'POST',
        data: {
            entName: company,
            startDate: startDate,
            endDate: endDate
        },
        beforeSend: function() {
            showLoading();
            console.log("sending request..");
        },
        success: function(response) {
        	console.log("response received: ", response);
            updateStatsCards(response);
            updateCharts(response);
        },
        error: function(xhr, status, error) {
            console.error('데이터 조회 실패:', error);
            alert('데이터 조회 중 오류가 발생했습니다.');
        },
        complete: function() {
            hideLoading();
            console.log("요청 완료");
        }
    });
}

// 로딩 표시 함수
function showLoading() {
    const overlay = document.createElement('div');
    overlay.className = 'loading-overlay';
    overlay.innerHTML = `
        <div class="spinner-border text-primary" role="status">
            <span class="visually-hidden">Loading...</span>
        </div>
    `;
    document.body.appendChild(overlay);
}

function hideLoading() {
    const overlay = document.querySelector('.loading-overlay');
    if (overlay) {
        overlay.remove();
    }
}

// 데이터 포맷팅 함수
function formatCurrency(value) {
    return new Intl.NumberFormat('ko-KR').format(value) + '원';
}

function formatPercent(value) {
    return value.toFixed(2) + '%';
}

//통계 카드 업데이트
function updateStatsCards(data) {
    if (data.totalSale) {
        document.querySelector('.stat-card:nth-child(1) .stat-value').textContent = 
            formatCurrency(data.totalSale.contractPrice);
    }
    if (data.monthAvg) {
        document.querySelector('.stat-card:nth-child(2) .stat-value').textContent = 
            formatCurrency(data.monthAvg.totalExpense);
    }
    if (data.goalSale) {
        document.querySelector('.stat-card:nth-child(3) .stat-value').textContent = 
            formatCurrency(data.goalSale.actualSales);
    }
    if (data.confirmedSale) {
        document.querySelector('.stat-card:nth-child(4) .stat-value').textContent = 
            formatCurrency(data.confirmedSale.totalContracts);
    }
    if (data.entSale) {
        document.querySelector('.stat-card:nth-child(5) .stat-value').textContent = 
            formatCurrency(data.entSale.contractPrice);
    }
}

// 차트 업데이트
function updateCharts(data) {
    // 메인 차트 업데이트
    if (data.monthLabels && data.salesData) {
        mainChart.data.labels = data.monthLabels;
        mainChart.data.datasets[0].data = data.salesData;
        mainChart.update();
    }

    // 기업별 매출 차트 업데이트
    if (data.enterSaleLabels && data.enterSaleStat) {
        monthlyChart.data.labels = data.enterSaleLabels;
        monthlyChart.data.datasets[0].data = data.enterSaleStat;
        monthlyChart.update();
    }

    // 파이 차트 업데이트
    if (data.paymentData) {
        pieChart.data.datasets[0].data = data.paymentData;
        pieChart.update();
    }
}

	//현재 URL 가져오기
	const currentPath = window.location.pathname;
	
	// 모든 탭 요소 가져오기
	const navLinks = document.querySelectorAll('.nav-link');
	console.log(navLinks);
	
	// 현재 경로와 href가 일치하는 탭에 active 클래스 추가
	navLinks.forEach(link => {
	    if (link.getAttribute('href') === currentPath) {
	        link.classList.add('active'); // Bootstrap의 기본 스타일을 활용
	    }
	});
// });
</script>

 </html>