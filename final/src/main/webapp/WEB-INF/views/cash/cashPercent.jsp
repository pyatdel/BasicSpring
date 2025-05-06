<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  

<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
    
<title>매출 현황</title>
<style>
.nav-link{
color:black !important;

}
.nav-link.active{

color:#3069CE !important;

}
.stats-dashboard {
    display: grid;
    grid-template-columns: 1fr 2fr;
    gap: 20px;
    padding: 20px;
    width: 90%;
    margin-left: 60px;
    margin-top: 45px;
    background: #fff;
    border-radius: 15px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
/*     height: 400px; /* 전체 높이 설정 */ 
}

.chart-section {
    padding: 20px;
    background: #f8f9fa;
    border-radius: 12px;
    height: 100%; /* 부모 높이에 맞춤 */
}

.chart-section canvas {
    width: 100% !important;
    height: calc(100% - 40px) !important; /* 제목 높이 고려 */
}

.stats-grid {
    display: flex;
    flex-direction: column;
    gap: 15px;
    height: 100%; /* 부모 높이에 맞춤 */
}

.stats-row {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 15px;
    padding: 15px;
    border-radius: 12px;
    flex: 1; /* 남은 공간 균등 분배 */
}

.stat-item {
    padding: 15px;
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    display: flex;
    flex-direction: column;
    justify-content: center; /* 수직 중앙 정렬 */
}

.stat-label {
    font-size: 14px;
    color: #666;
    margin-bottom: 8px;
}

.stat-value {
    font-size: 20px;
    font-weight: bold;
    color: #333;
    margin-bottom: 5px;
}

.stat-change {
    font-size: 13px;
}

.stat-change.positive {
    color: #278986;
}

.stat-change.negative {
    color: #e74c3c;
}

.nav-tabs.custom-tabs .nav-link.active {
    background-color: #F3F6F9 !important;
    border-color: #dee2e6 !important;
}


#block {
height:400px;


}
/* 반응형 처리 */
@media (max-width: 768px) {
    .stats-dashboard {
        grid-template-columns: 1fr;
        height: auto;
    }
    
    .chart-section, .stats-grid {
        height: 400px;
    }
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
 	<h3 class="mb-0"></h3>
         	<div class="nav nav-tabs custom-tabs mb-4">
			    <a class="nav-link" href="/cash/cashList" data-type="cashList">매출 정보</a>
			    <a class="nav-link" href="/cash/cashPercent" data-type="cashPercent">매출 현황</a>
<!-- 			    <a class="nav-link" href="/cash/cashAnaly" data-type="cashAnaly">매출 통계</a> -->
<!-- 			    <a class="nav-link" href="/cash/cashCreate" data-type="cashCreate">지출 신청</a> -->
			</div>


<!-- ///// content 시작 ///// -->
<div class="stats-dashboard">
    <!-- 레이더 차트 섹션 -->
    <div class="chart-section">
<!--         <h5>매출 현황</h5> -->
        <canvas id="radarChart"></canvas>
    </div>

    <!-- 통계 그리드 섹션 -->
<div class="stats-grid">
    <!-- 상단 행 -->
    <div class="stats-row orange-bg">
    <c:forEach var="monthAvg" items="${monthAvg}" varStatus="stat">
        <div class="stat-item">
            <div class="stat-label">월 평균 매출액</div>
            <div class="stat-value">
			        <fmt:formatNumber value="${monthAvg.totalExpense}" pattern="#,###"/>원
            </div>
            <div class="stat-change positive">+5.7% ▲</div>
        </div>
        </c:forEach>
        
        <c:forEach  var="totalSale" items="${totalSale}" varStatus="stat">
        <div class="stat-item" >
            <div class="stat-label">누적 매출액</div>
            <div class="stat-value">
                <fmt:formatNumber value="${totalSale.contractPrice}" pattern="#,###"/>원
            </div>
            <div class="stat-change positive">+2.69% ▲</div>
        </div>
         </c:forEach>
         
         
       <c:forEach var="goalSale" items="${goalSale}" varStatus="stat">
		    <div class="stat-item">
		        <div class="stat-label">월 목표 매출액</div>
		        <div class="stat-value">
		        968,515,522원
<%-- 		            <fmt:formatNumber value="${goalSale.achievementRate}" pattern="#,###.##"/>% --%>
		        </div>
		        <div class="stat-change negative">-0.71% ▼ </div>	
		        </div>	   
		</c:forEach>
    </div>
    <!-- 하단 행 -->
    <div class="stats-row green-bg">
    <c:forEach  var="confirmedSale" items="${confirmedSale}" varStatus="stat">
        <div class="stat-item">
            <div class="stat-label">계약 체결</div>
            <div class="stat-value">
               <fmt:formatNumber value="${confirmedSale.confirmedContracts}" type="number"/>
            /
            <fmt:formatNumber value="${confirmedSale.totalContracts}" type="number"/>건
            </div>
            <div class="stat-change negative">-1.28% ▼</div>
        </div>
        </c:forEach>
        
        <c:forEach  var="confirmedSalePer" items="${confirmedSalePer}" varStatus="stat">
        <div class="stat-item">
            <div class="stat-label">계약 체결률</div>
            <div class="stat-value">
                <fmt:formatNumber value="${confirmedSalePer.confirmationRate}" pattern="#,###"/>%
            </div>
            <div class="stat-change positive">+0.12% ▲</div>
        </div>
        </c:forEach>
        
        <c:forEach  var="entSale" items="${entSale}" varStatus="stat">
        <div class="stat-item">
            <div class="stat-label">객단가</div>
            <div class="stat-value">
                <fmt:formatNumber value="${entSale.contractPrice}" type="number"/>원
            </div>
            <div class="stat-change positive">+0.08% ▲</div>
        </div>
        </c:forEach>
    </div>
</div>
</div>


<div id="block">


</div>
  <jsp:include page="../include/footer.jsp"></jsp:include>

<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
//정규화 함수 (Min-Max Scaling)
function normalize(value, min, max) {
    return ((value - min) / (max - min)) * 100;
}

// 재무지표 데이터 예시
const financialData = {
    totalSales: 1500000000,      // 총 매출 (15억)
    netProfit: 300000000,        // 순이익 (3억)
    averageOrderValue: 150000,    // 객단가 (15만원)
    repurchaseRate: 35,          // 재구매율 (35%)
    salesGrowth: 25,             // 매출 성장률 (25%)
    categoryShare: 40            // 카테고리별 매출 비중 (40%)
};

// 각 지표별 최소/최대 기준값 설정
const metrics = {
    totalSales: { min: 0, max: 2000000000 },    // 최대 20억 기준
    netProfit: { min: 0, max: 500000000 },      // 최대 5억 기준
    averageOrderValue: { min: 0, max: 200000 }, // 최대 20만원 기준
    repurchaseRate: { min: 0, max: 100 },       // 최대 100% 기준
    salesGrowth: { min: -20, max: 50 },         // -20% ~ 50% 기준
    categoryShare: { min: 0, max: 100 }         // 최대 100% 기준
};

// 데이터 정규화 적용
const normalizedData = [
    normalize(financialData.totalSales, metrics.totalSales.min, metrics.totalSales.max),
    normalize(financialData.netProfit, metrics.netProfit.min, metrics.netProfit.max),
    normalize(financialData.averageOrderValue, metrics.averageOrderValue.min, metrics.averageOrderValue.max),
    normalize(financialData.repurchaseRate, metrics.repurchaseRate.min, metrics.repurchaseRate.max),
    normalize(financialData.salesGrowth, metrics.salesGrowth.min, metrics.salesGrowth.max),
    normalize(financialData.categoryShare, metrics.categoryShare.min, metrics.categoryShare.max)
];

// 레이더 차트 업데이트
const radarChart = new Chart(document.getElementById('radarChart'), {
    type: 'radar',
    data: {
        labels: ['총 매출', '순이익', '객단가', '재구매율', '매출 성장률', '카테고리별 매출 비중'],
        datasets: [{
            label: ' ',
            data: normalizedData,
            fill: true,
            backgroundColor: 'rgba(54, 162, 235, 0.2)',
            borderColor: 'rgb(54, 162, 235)',
            pointBackgroundColor: 'rgb(54, 162, 235)',
            pointBorderColor: '#fff',
            pointHoverBackgroundColor: '#fff',
            pointHoverBorderColor: 'rgb(54, 162, 235)'
        }]
    },
    options: {
        elements: {
            line: {
                borderWidth: 3
            }
        },
        scales: {
            r: {
                angleLines: {
                    display: true
                },
                suggestedMin: 0,
                suggestedMax: 100,
                ticks: {
                    callback: function(value) {
                        return value + '%';
                    }
                }
            }
        },
        plugins: {
            tooltip: {
                callbacks: {
                    label: function(context) {
                        const originalValue = financialData[Object.keys(financialData)[context.dataIndex]];
                        const normalizedValue = context.raw.toFixed(1);
                        return `정규화 값: ${normalizedValue}% (실제 값: ${originalValue.toLocaleString()})`;
                    }
                }
            }
        }
    }
});

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

</script>
<!-- ///// content 끝 ///// -->


 </html>	