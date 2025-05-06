<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<title>영업 통계</title>  

<style>
	canvas {
	    width: 500px !important;
	    height: 400px !important;
	    flex: 1;
	    max-width: 800px;
	}
	
	#radarChart {
    width: 100% !important; /* 부모 요소의 너비에 맞춰서 자동으로 크기 조정 */
    max-width: 500px; /* 최대 너비를 600px로 제한 */
    height: 400px !important; /* 높이는 고정 */
	}
	
	#lineChart {
		max-width: 1200px !important;
	}
	
    .chart-container {
        display: flex;
        flex-direction: column;
        gap: 50px;
        padding: 20px;
    }

    .chart-row {
        display: flex;
        justify-content: center;
        gap: 20px;
        border: 2px solid #ffffff;
        border-radius: 10px;
        padding: 15px;
        box-shadow: 0 5px 6px rgba(0, 0, 0, 0.1);
        background-color: #ffffff;
    }

    .button-container {
        text-align: center;
        margin-bottom: 20px;
        z-index: 10;
    }

    .data-btn {
        padding: 10px 20px;
        margin: 5px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.3s;
    }


    .data-btn:hover {
        background-color: #0056b3;
    }

    @media (max-width: 768px) {
        canvas {
            flex: 1 1 100%;
        }
    }
    
    h4{
    	margin-top: 40px !important;
    }
    
	.mb-0{
		margin-bottom: 30px !important;
	}
    
   	.nav-link.active {
	    color: black !important; /* 텍스트 색상 */
	    background-color: #F3F6F9 !important; /* 배경색 */
	    border-color: #dee2e6 !important; /* 테두리 색상 */
	}
	
	#btn1,#btn2, #btn3 {
		color : black;
	}
	.businessSub {
	display: block !important;
	height: auto !important;
	}
</style>
<jsp:include page="../include/preScript.jsp"></jsp:include>
<%@ include file="../include/header.jsp" %>

<!-- ///// content 시작 ///// -->

<div class="bg-light text-center rounded p-4">
	<div class="nav nav-tabs custom-tabs mb-4">
	    <a class="nav-link" href="/business/custManage" data-type="customer">고객 정보</a>
	    <a class="nav-link" href="/business/infoList" data-type="sales">영업 관리</a>
	    <a class="nav-link" href="/business/busAct" data-type="Act">영업 활동</a>
	    <a class="nav-link" href="/business/busChance" data-type="Chance">영업 기회</a>
	    <a class="nav-link" href="/business/busStat" data-type="stat">영업 통계</a>
	</div>
	<h3>이거 짜피 그래프 바꿔야하는데 리액트로 할가용?</h3>
<div class="chart-container">
    <!-- 첫 번째 컨테이너: 차트 -->
    <div class="chart-row">
        <canvas id="barChart"></canvas>
        <canvas id="radarChart"></canvas>
</div>
    <div class="chart-row">
    <canvas id="lineChart"></canvas>
    <canvas id="lineChart2"></canvas>
    
<!--     <div class="btn-container" style="text-align: center; margin-top: 10px;"> -->
<!--         <button id="btn1" class="btn btn-outline-light">카테고리별 계약 체결률</button> -->
<!--         <button id="btn2" class="btn btn-outline-light">계약상태별 계약 체결률</button> -->
<!--         <button id="btn3" class="btn btn-outline-light">기업별 계약 체결률</button> -->
<!--     </div> -->
</div>

</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- Chart.js CDN -->
<script>
	var currentYear = new Date().getFullYear(); // 현재 연도	

	// 월별 계약 체결 수에 대한 데이터
    var yearData = {
        // 예시: 각 년도에 해당하는 월별 계약 체결 수 데이터 (이 부분은 JSP에서 데이터를 동적으로 생성해야 합니다)
        2023: [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120], // 2023년 월별 계약 체결 수
        2024: [15, 25, 35, 45, 55, 65, 75, 85, 95, 105, 115, 125], // 2024년 월별 계약 체결 수
        // 더 많은 년도를 추가할 수 있습니다.
    };

    var radarLabels = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
    if (yearData[currentYear] && yearData[currentYear].length === 12) {
        radarLabels = yearData[currentYear]; // 월별 데이터를 동적으로 가져옴
    }
	
    // JSP에서 전달된 데이터로 Chart.js 설정
    //월별 계약 체결 수
    var radarLabels = [
        <c:forEach items="${custInfoVOList}" var="data" varStatus="loop">
            "${data.month}"<c:if test="${!loop.last}">,</c:if>
        </c:forEach>
    ];
    
    var monthLabels = [
        <c:forEach items="${custInfoVOList}" var="data" varStatus="loop">
            "${data.count}"<c:if test="${!loop.last}">,</c:if>
        </c:forEach>
    ];

    
    
    //전체 계약 체결률
    //총 계약 체결 수
    var totalContracts = [
        <c:forEach items="${contractState}" var="data" varStatus="loop">
            ${data.totalContracts}<c:if test="${!loop.last}">,</c:if>
        </c:forEach>
    ]|| new Array(12).fill(0); // 값이 없으면 0으로 채움
    
    //체결된 계약 수
    var confirmedContracts = [
        <c:forEach items="${contractState}" var="data" varStatus="loop">
            ${data.confirmedContracts}<c:if test="${!loop.last}">,</c:if>
        </c:forEach>
    ]|| new Array(12).fill(0); // 값이 없으면 0으로 채움

    
    //카테고리별 계약 체결률
    //카테고리별 전체 계약 수
    var totalTypes = [
        <c:forEach items="${getContractByCategory}" var="data" varStatus="loop">
            ${data.totalTypes}<c:if test="${!loop.last}">,</c:if>
        </c:forEach>
    ];
    
    //카테고리별 계약 체결 수
    var confirmedTypes = [
        <c:forEach items="${getContractByCategory}" var="data" varStatus="loop">
            ${data.confirmedTypes}<c:if test="${!loop.last}">,</c:if>
        </c:forEach>
    ];

    
    //기업별 계약 체결률
    //기업별 전체 계약 수
    var totalEnters = [
        <c:forEach items="${getContractByEnterprise}" var="data" varStatus="loop">
            ${data.totalEnters}<c:if test="${!loop.last}">,</c:if>
        </c:forEach>
    ];
    
    //기업별 계약 체결 수
    var confirmedEnters = [
        <c:forEach items="${getContractByEnterprise}" var="data" varStatus="loop">
            ${data.confirmedEnters}<c:if test="${!loop.last}">,</c:if>
        </c:forEach>
    ];
	
    const labels = ['January', 'February', 'March', 'April', 'May'];
    const sampleData = [10, 20, 30, 40, 50];
	
    var ctx1 = document.getElementById('barChart').getContext('2d');
    var barChart = new Chart(ctx1, {
        type: 'bar', 
        data: {
            labels: radarLabels, 
            datasets: [{
                label: 'Monthly Sales',
                data: monthLabels, 
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            indexAxis: 'x',
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                title: {
                    display: true,
                    text: `2024년 계약 체결 수` ,
                    font: {
                        size: 15,
                        weight: 'bold'
                    },
                    padding: {
                        top: 10,
                        bottom: 30
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: false,
                    max: 20
                    
                },
            	x : {
            		 max: 12,
//             		 type: 'time',  // 시간을 x축으로 설정
//             		 time: {
//             	          unit: 'month',
//                           }
            	}
            }
        }
    });

    var ctx2 = document.getElementById('radarChart').getContext('2d');
    var radarChart = new Chart(ctx2, {
        type: 'radar',
        data: {
            labels: radarLabels,
            datasets: [
                {
                    label: '전체 계약',
                    data: totalTypes, 
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                },
                {
                    label: '체결된 계약',
                    data: confirmedTypes, 
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 1
                }
            ]
        },
        options: {
            responsive: true,
            plugins: {
                title: {
                    display: true,
                    text: '계약 체결률',
                    font: {
                        size: 15,
                        weight: 'bold'
                    },
                    padding: {
                        top: 10,
                        bottom: 30
                    }
                }
            },
            scales: {
                r: {
                    beginAtZero: true
                }
            }
        }
    });

    const lineCtx = document.getElementById('lineChart').getContext('2d');
    var lineChart = new Chart(lineCtx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [
                {
                    label: '카테고리별 전체 계약 체결수',
                    data: totalContracts,
                    borderColor: 'rgb(27, 180, 53)',
                    borderWidth: 2,
                    fill: false
                },
                {
                    label: '카테고리별 계약 체결수',
                    data: confirmedContracts,
                    borderColor: 'rgb(129, 51, 255)',  // 색깔을 다르게 할 수 있습니다
                    borderWidth: 2,
                    fill: false
                }
            ]
        },
        options: {
            responsive: false,
            maintainAspectRatio: false,
        },
        plugins: {
            title: {
                display: true,
                text: 'Line Chart Example'
            }
        },
        scales: {
            y: { beginAtZero: true }
        }
    });
    
    
    const lineCtx2 = document.getElementById('lineChart2').getContext('2d');
    var lineChart2 = new Chart(lineCtx2, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [
                {
                    label: '기업별 전체 계약 체결수',
                    data: totalEnters,
                    borderColor: 'rgb(255, 41, 202)',
                    borderWidth: 2,
                    fill: false
                },
                {
                    label: '기업별 계약 체결수',
                    data: confirmedEnters,
                    borderColor: 'rgb(43, 142, 255)',  // 색깔을 다르게 할 수 있습니다
                    borderWidth: 2,
                    fill: false
                }
            ]
        },
        options: {
            responsive: false,
            maintainAspectRatio: false,
        },
        plugins: {
            title: {
                display: true,
                text: 'Line Chart Example'
            }
        },
        scales: {
            y: { beginAtZero: true }
        }
    });

//     // 버튼 클릭 이벤트 추가
//     document.getElementById('btn1').addEventListener('click', function () {
//         updateLineChart(totalTypes,  '카테고리별 계약 체결률');
//     });

//     document.getElementById('btn2').addEventListener('click', function () {
//         updateLineChart(totalContracts, '계약상태별 계약 체결률');
//     });

//     document.getElementById('btn3').addEventListener('click', function () {
//         updateLineChart(totalEnters,  '기업별 계약 체결률');
//     });
    
    
    
    



    function updateLineChart(newData,  newLabel) {
        lineChart.data.datasets[0].data = newData;
        lineChart.data.datasets[0].label = newLabel;
        lineChart.update();
    }
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

<%@ include file="../include/footer.jsp" %>

