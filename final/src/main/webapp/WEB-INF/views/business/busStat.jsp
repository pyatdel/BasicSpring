<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
    
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
.hdFlex {
    display: flex;
        align-items: center;
}
}

.scheduleContainer{
		flex: 1;
		margin-left: 20px;
		height: 90%;
		background-color: white;
		padding: 5px;
		border-radius: 8px;
		box-shadow: 0 2px 4px rgba(0,0,0,0.7);
		margin-bottom: 10px;
		justify-content: center;
		align-items: center;
	}
	.businessSub {
	display: block !important;
	height: auto !important;
	}
</style>
</head>
  
  
<!-- 헤더 include  -->
   <jsp:include page="../include/header.jsp"></jsp:include>
<!-- 헤더 include  -->

<!-- ///// content 시작 ///// -->

<div class="bg-light text-center rounded p-4">
<!-- 	<div class="nav nav-tabs custom-tabs mb-4"> -->
<!-- 	    <a class="nav-link" href="/business/custManage" data-type="customer">고객 정보</a> -->
<!-- 	    <a class="nav-link" href="/business/infoList" data-type="sales">영업 관리</a> -->
<!-- 	    <a class="nav-link" href="/business/busAct" data-type="Act">영업 활동</a> -->
<!-- 	    <a class="nav-link" href="/business/busChance" data-type="Chance">영업 기회</a> -->
<!-- 	    <a class="nav-link" href="/business/busStat" data-type="stat">영업 통계</a> -->
<!-- 	</div> -->

<div class="hdFlex">
         <h3 class=" contlist" style="font-weight:normal">영업관리</h3>
         <h5 class=" contlist" style="font-weight:normal"> &nbsp;> 영업실적</h5>
      </div>
<div class="chart-container">
    <!-- 첫 번째 컨테이너: 차트 -->
<!--     <div class="chart-row"> -->
<%--         <canvas id="barChart"></canvas> --%>
<%--         <canvas id="radarChart"></canvas> --%>
<!-- </div> -->
<!--     <div class="chart-row"> -->
<%--     <canvas id="lineChart"></canvas> --%>
<%--     <canvas id="lineChart2"></canvas> --%>
<!--     </div> -->
<!--     <div class="btn-container" style="text-align: center; margin-top: 10px;"> -->
<!--         <button id="btn1" class="btn btn-outline-light">카테고리별 계약 체결률</button> -->
<!--         <button id="btn2" class="btn btn-outline-light">계약상태별 계약 체결률</button> -->
<!--         <button id="btn3" class="btn btn-outline-light">기업별 계약 체결률</button> -->
<!--     </div> -->


</div>
</div>
    
    <div class="scheduleContainer">
			<iframe src="http://localhost:7921/business/busStat" frameborder="0" title="영업 통계" width="1000px" height="750px" scrolling="no" marginwidth="5" marginheight="5" ></iframe>
		</div>
   


<script>
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
<jsp:include page="../include/footer.jsp"></jsp:include>
 </html>
