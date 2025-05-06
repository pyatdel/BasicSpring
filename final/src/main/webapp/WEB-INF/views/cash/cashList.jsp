<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
    
  
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- Bootstrap JS -->

<title>매출 정보</title>


<style>
.nav-link{
color:black !important;

}
.contract-card {
    background: white;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
    padding: 12px;
    padding-bottom: 15px;
    padding-top: 1px;
    margin: 10px 0;
    width: 90%;
    margin-left: 60px;
    cursor: pointer;
    
/*     transition: 0.3s; */
}

.contract-card:hover {
    transform: scale(1.02);
}

.contract-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
/*     font-weight: bold; */
/* font-size: 10px; /* 폰트 크기 줄임 */ 
}

.contract-date {
    color: gray;
/*     font-size: 10px; /* 폰트 크기 줄임 */ 
}



.nav-tabs.custom-tabs .nav-link.active {
    color: #3069CE !important;
    background-color: #F3F6F9 !important;
    border-color: #dee2e6 !important;
}

.content-area {
    flex: 1;
    margin-top: 20px !important;
    
}
/* .content {
    margin-left: 0 !important;
    width: 90% !important;
} */
.container-fluid {
    margin: 0 auto !important;
}

.modal-header {
    background-color: white;
    color: white;
}
.card-header, .card-footer {
    background-color: rgba(0, 0, 0, 0) !important;
}

#tbc th {
    background-color: #f9f9f9; /* 원하는 배경색 */
    color: black; /* 원하는 글자색 */
    text-align: center; /* 텍스트 가운데 정렬 */
/*     width: 90%; */
}

/* 테이블 테두리 제거 */
.table-bordered {
    border: none;
}

.table-bordered th,
.table-bordered td {
    border: none;
}

	h4 {
        margin-top: 50px !important; /* 제목 아래에 간격 추가 */
    }
	canvas {
	    width: 1700px !important;
	    height: 500px !important;
	    flex: 1;
	    max-width: 800px;
	    
	}
	#monthlyChart {
		width: 1700px !important;
	    height: 600px !important;
	    flex: 1;
/* 	    max-width: 800px; */
	}
	    
       .chart-row {
	      display: flex;
	      justify-content: center;
	      gap: 20px;
          border: 2px solid #f9f9f9; /* 테두리 색상 */
	      border-radius: 10px; /* 모서리 둥글게 */
	      padding: 15px; /* 내부 여백 */
	      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	      background-color: #fffff; /* 배경색 */
	}
	
	.chart-container {
        border: 2px solid #3069CE; /* 테두리 색상 */
        border-radius: 10px; /* 모서리 둥글게 */
        padding: 15px; /* 내부 여백 */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
        background-color: #f9f9f9; /* 배경색 */
    }
    
    	.mb-0{
		margin-bottom: 30px !important;
	}
    
.main-container {
    width: 90%;  /* 80%에서 95%로 증가 */
    margin: 20px auto;
    margin-left:60px;
    padding: 8px;
    height:20vh;
}
	.stats-row {
    display: flex;
    gap: 20px;
/*     margin-bottom: 30px; */
    height:40px;
    position: relative;  /* 추가 */
/*     z-index: 1;         /* 추가 */ */
}
.stat-card {
    flex: 1;
    background: white;
    height:150px;
    padding: 10px;
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.5);
}

	.stat-title {
    font-size: 14px;
    color: #666;
    margin-bottom: 10px;
        padding-top: 20px;
        font-weight: bold;
}

.stat-value {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 5px;
}

.stat-change {
    font-size: 18px;
    color: #e51212;  /* 빨간색 (마이너스) */
    font-weight: normal !important;
}

.stat-change.positive {
    color: #278986;  /* 초록색 (플러스) */
    font-weight: normal !important;
}


#loadMore:hover {
    background-color: #0056b3;
}
.filter-item {
    position: relative;
    display: inline-block;
}

.fa-calendar-alt {
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);
    color: #888;
    pointer-events: none;
}
@media (max-width: 768px) {
    .custom-select {
        width: 100%;
        max-width: 200px;
    }
}
.custom-select {
    transition: transform 0.2s ease;
}

.custom-select:hover {
    transform: scale(1.05);
}
.cashSub{
display: block !important;
height: auto !important;
}
h1, .h1, h2, .h2, h3, .h3, h4, .h4, h5, .h5, h6, .h6 {

font-weight: normal;
}
</style>
</head>

<!-- 헤더 include  -->
   <jsp:include page="../include/header.jsp"></jsp:include>
<!-- 헤더 include  -->

<!-- Main content -->

<!--  <h3>매출 정보</h3> -->
 
 <div class="bg-light text-center rounded p-4">
 	<h3 class="mb-0"></h3>
         	<div class="nav nav-tabs custom-tabs mb-4">
			    <a class="nav-link active" href="/cash/cashList" data-type="cashList">매출 정보</a>
			    <a class="nav-link" href="/cash/cashPercent" data-type="cashPercent">매출 현황</a>
<!-- 			    <a class="nav-link" href="/cash/cashAnaly" data-type="cashAnaly">매출 통계</a> -->
<!-- 			    <a class="nav-link" href="/cash/cashCreate" data-type="cashCreate">지출 신청</a> -->
			</div>
<div class="main-container">
   <div class="stats-row">
<%--         	<c:forEach var="totalSale" items="${totalSale}" varStatus="stat"> --%>
		        <div class="stat-card">
		            <div class="stat-title">총 매출</div>
<%-- 		            <div class="stat-value"><fmt:formatNumber value="${totalSale.contractPrice}" pattern="#,###"/>원</div> --%>
		            <div class="stat-value">21,254,654,22원</div>
		            <div class="stat-change positive" style="font-weight:bold">전년도 대비 +63.3%</div>
		        </div>
<%--         	</c:forEach> --%>
        <div class="stat-card">
            <div class="stat-title">목표 매출</div>
            <div class="stat-value">24,568,515,522원</div>
            <div class="stat-change" style="font-weight:bold">목표 매출 달성률 -5.71%</div>
        </div>
        <div class="stat-card">
            <div class="stat-title">고객사</div>
            <div class="stat-value">21</div>
            <div class="stat-change positive" style="font-weight:bold">전년도 대비 +100%</div>
        </div>
	</div>
</div>			

<!-- 탭 버튼 -->
<ul class="nav nav-tabs">
    <li class="nav-item">
        <a class="nav-link active" data-bs-toggle="tab" href="#total">전체</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" data-bs-toggle="tab" href="#monthly">월별</a>
    </li>
<!--     <li class="nav-item"> -->
<!--         <a class="nav-link" data-bs-toggle="tab" href="#quarterly">분기별</a> -->
<!--     </li> -->
    <li class="nav-item">
        <a class="nav-link" data-bs-toggle="tab" href="#enterprise">기업별</a>
    </li>
</ul>

<!-- 탭 콘텐츠 -->
<div class="tab-content mt-3">
    <!-- 전체 -->
    <div id="total" class="tab-pane fade show active">
    <c:forEach var="saleVO" items="${saleVOList}" varStatus="stat">
     <a href="/contract/detail?currentPage=${param.currentPage}&keyword=${param.keyword}&contractNo=${saleVO.contractNo}"> 
        <div class="contract-card" ${stat.index >= 5 ? 'style="display: none;"' : ''}>
<!--             <div class="contract-header"> -->
<%--                 <h5>📌 ${saleVO.entName}</h5> --%>
<%--                 <span class="contract-date"><fmt:formatDate value="${saleVO.fromDate}" pattern="yyyy-MM-dd"/></span> --%>
<!--             </div> -->
            <div class="contract-body">
                <h4>${saleVO.contractNm}</h4>
                <h6>${saleVO.entName}</h6>
                <h5><fmt:formatNumber value="${saleVO.contractPrice}" pattern="#,###"/>원</h5>
                <span class="contract-date"><fmt:formatDate value="${saleVO.fromDate}" pattern="yyyy-MM-dd"/></span>
            </div>
        </div>
        </a>
    </c:forEach>
    <!-- 더보기 버튼 -->
	<div class="text-center mt-3">
	    <button  class="loadMore btn btn-light" ${fn:length(saleVOList) <= 5 ? 'style="display: none;"' : ''}>
	        더보기
	    </button>
	</div>
</div>


<!-- 월별 매출 -->
    <div id="monthly" class="tab-pane fade">
<!--     <h3>📅 월별 매출</h3> -->

    <!-- 년도 선택 및 그래프 표시 영역 -->
    <div class="mb-4 d-flex justify-content-start ps-5" id="filterSection">
    <div class="filter-item">
        <label for="yearSelect" class="form-label d-block">연도 선택</label>
        <div class="input-group">
            <select id="yearSelect" class="form-control text-center" style="max-width: 180px;">
                <option value="2024">2024</option>
                <option value="2025">2025</option>
            </select>
<!--             <span class="input-group-text"><i class="fas fa-calendar-alt"></i></span> -->
        </div>
    </div>
</div>

    <!-- 그래프 표시 영역 -->
    <div style="width: 100%; margin: auto; display: flex; justify-content: center;">
        <canvas id="monthlySalesChart"></canvas>
    </div>
</div>


    <div id="enterprise" class="tab-pane fade">
    <!-- 기업별 매출 -->
    <div class="mb-4">
	    <c:forEach var="enterSaleStat" items="${enterSaleStat}" varStatus="stat">
		    <div style="width: 100%; margin: auto; display: flex; justify-content: center;">
		        <canvas id="monthlyChart"></canvas>
		    </div>
	    </c:forEach>
    </div>
    </div>
    
    
    
<!-- 부트스트랩 JS 추가 -->


            

</div>
<jsp:include page="../include/footer.jsp"></jsp:include>
</div>
<script type="text/javascript">
// 기업별 매출 통계 그래프 - 기업 이름
var enterSaleLabels = [
    <c:forEach items="${enterSaleStat}" var="data" varStatus="loop">
        "${data.entName}"<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
];

// 기업별 매출 통계 그래프 - 매출액
var enterSaleStat = [
    <c:forEach items="${enterSaleStat}" var="data" varStatus="loop">
        "${data.totalPrice}"<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
];

// 문자열 배열을 숫자 배열로 변환
const numericEnterSaleStat = enterSaleStat.map(Number);
let monthlySalesChart;

// 월별 매출 데이터 로드
function loadData() {
    const selectedYear = document.getElementById('yearSelect').value;
    const dummyData = [
        {
            "year": "2024",
            "data": [
                { "expenseMonth": "202401", "totalExpense": 120052000 },
                { "expenseMonth": "202402", "totalExpense": 1500000 },
                { "expenseMonth": "202403", "totalExpense": 130054600 },
                { "expenseMonth": "202404", "totalExpense": 140000000 },
                { "expenseMonth": "202405", "totalExpense": 160005500 },
                { "expenseMonth": "202406", "totalExpense": 170005500 },
                { "expenseMonth": "202407", "totalExpense": 180005200 },
                { "expenseMonth": "202408", "totalExpense": 1000000000 },
                { "expenseMonth": "202409", "totalExpense": 200052000 },
                { "expenseMonth": "202410", "totalExpense": 210002500 },
                { "expenseMonth": "202411", "totalExpense": 2400000000 },
                { "expenseMonth": "202412", "totalExpense": 6300000000 }
            ]
        },
        {
            "year": "2025",
            "data": [
                { "expenseMonth": "202501", "totalExpense": 178357685732 },
                { "expenseMonth": "202502", "totalExpense": 255000000033 },
                { "expenseMonth": "202503", "totalExpense": 3600000000 },
                { "expenseMonth": "202504", "totalExpense": 160000000 },
                { "expenseMonth": "202505", "totalExpense": 3550000000 },
                { "expenseMonth": "202506", "totalExpense": 1800000000 },
                { "expenseMonth": "202507", "totalExpense": 1000000000 },
                { "expenseMonth": "202508", "totalExpense": 340000000 },
                { "expenseMonth": "202509", "totalExpense": 210000000 },
                { "expenseMonth": "202510", "totalExpense": 220000000 },
                { "expenseMonth": "202511", "totalExpense": 230000000 },
                { "expenseMonth": "202512", "totalExpense": 1900000000 }
            ]
        },
    ];

    const selectedData = dummyData.find(item => item.year === selectedYear);
    if (selectedData) {
        updateChart(selectedData.data);
    } else {
        console.error("선택된 년도의 데이터가 없습니다.");
    }
}

// 차트 업데이트
function updateChart(data) {
    const labels = data.map(item => item.expenseMonth);
    const salesData = data.map(item => item.totalExpense);

    const ctx = document.getElementById('monthlySalesChart').getContext('2d');

    if (monthlySalesChart) {
        monthlySalesChart.destroy();
    }

    monthlySalesChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: '월별 매출액',
                data: salesData,
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 2,
                fill: false
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return value.toLocaleString() + '원';
                        }
                    }
                }
            },
            plugins: {
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let label = context.dataset.label || '';
                            if (label) {
                                label += ': ';
                            }
                            label += context.raw.toLocaleString() + '원';
                            return label;
                        }
                    }
                }
            }
        }
    });
}

$(document).ready(function() {
    // 기업별 매출 차트 초기화
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

    // 페이지 로드 시 기본 데이터 불러오기
    loadData();

    // 년도 선택 버튼에 이벤트 리스너 추가
    document.getElementById("yearSelect").addEventListener("change", function() {
    	loadData();
});

    // 모달 및 검색 관련 코드
    const entNo = "${entNo}"; // JSP에서 전달된 값
    const contractName = "${contractName}"; // JSP에서 전달된 값

    const contractLink = document.getElementById("contractLink");
    contractLink.href = `/business/detail?entNo=${entNo}`;
    contractLink.textContent = contractName;

    $('#contractDetailModal').modal('show');

    $('#contractDetailModal').on('hidden.bs.modal', function () {
        $(this).find('td').text('');
        $('#contractLink').attr('href', '').text('');
    });

    // 검색 버튼 클릭 이벤트
    $("#btnSearch").on("click", function() {
        search();
    });

    // 검색어 입력 필드에서 엔터 키 이벤트
    $("input[name='keyword']").on("keypress", function(e) {
        if (e.keyCode === 13) {
            e.preventDefault();
            search();
        }
    });

    // 검색 함수
    function search() {
        const keyword = $("input[name='keyword']").val();
        location.href = "/cash/cashList?keyword=" + encodeURIComponent(keyword);
    }

    

    // 더보기 버튼 로직
    $(".tab-pane").each(function() {
        const tabPane = $(this);
        const cards = tabPane.find(".contract-card");
        const loadMoreBtn = tabPane.find(".loadMore");

        cards.slice(5).hide();

        if (cards.length <= 5) {
            loadMoreBtn.hide();
        }

        loadMoreBtn.on("click", function() {
            const hiddenCards = tabPane.find(".contract-card:hidden");
            hiddenCards.slice(0, 3).slideDown({
                duration: 500,
                easing: 'swing',
                complete: function() {
                    if (tabPane.find(".contract-card:hidden").length === 0) {
                        loadMoreBtn.fadeOut();
                    }
                }
            });
        });
    });
    
 // 현재 URL 가져오기
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
</script>

 </html>