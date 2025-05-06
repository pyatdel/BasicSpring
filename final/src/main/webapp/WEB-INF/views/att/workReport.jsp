<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	<title>근무 리포트</title>
 	<meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="robots" content="noindex" />
	
<link rel="stylesheet" href="/dash/css/bootstrap.min.css">
<link rel="stylesheet" href="/dash/css/style.css">
<link href="img/favicon.ico" rel="icon">


<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap"
	rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css"
	rel="stylesheet" />

<jsp:include page="../include/preScript.jsp"></jsp:include>
<style>
.tbc {
	background-color: 3069CE;
	color: white;
	width: 90%;
	border-radius: 10% !important;
}

.dashboard {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
  padding: 20px;
  max-width: 1000px;
  background-color: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.7);
}

.info-card {
  background-color: #ffffff;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 20px;
  text-align: center;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.7);
  transition: transform 0.3s, box-shadow 0.3s;
}

.info-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.7);
}

.info-card h2 {
  font-size: 18px;
  color: #333;
  margin-bottom: 10px;
}

.info-card p {
  font-size: 24px;
  font-weight: bold;
  color: #555;
}


.ag-charts-canvas-container{
	
	margin :10px;
	margin-left : 10px;
	padding : 10px;
	
}
.attSub {
display: block !important;
height: auto !important;
}



}
</style>
<!-- 메인 컨텐츠 영역 시작 --> 
<%-- <p>${contractMasterVOList}</p> --%> 
<%@ include file="../include/header.jsp"%>
	<div class="dashboard">
		<div class="info-card">
			<h2>평균 출근시간</h2>
			<p>09:15</p>
		</div>
		<div class="info-card">
			<h2>평균 퇴근시간</h2>
			<p>18:30</p>
		</div>
		<div class="info-card">
		    <h2>일평균 근무 시간</h2>
		    <p>8시간 15분</p>
	  	</div>
	  	<div class="info-card">
		    <h2>누적 초과근무 시간</h2>
		    <p>60시간</p>
	  	</div>
	</div>
	
	<div style="width:600px;height:400px;border:2px solid black">
        <!-- 차트 그릴 위치 지정 canvas webGL(그래픽엔진) 사용 -->
        <canvas id="myChart"></canvas>
    </div>
	
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="/dash/js/main.js"></script>
<script type="text/javascript">
const ctx = document.querySelector('#myChart');

//만들위치, 설정값객체
new Chart(ctx, {
    type: 'bar',  // bar, line, pie, doughnut, radar 등등...
    data: {
        labels: ['구두', '스니커즈', '캔버스화', '워커', '운동화', '크록스', '샌들'],
        datasets: [
            {
                label: '작년 매출',
                data: [10, 19, 13, 15, 12, 13, 9],
                borderWidth: 1,
            },
            {
                label: '올해 매출',
                data: [9, 14, 10, 19, 22, 11, 16],
                borderWidth: 1
            }
        ]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});


</script>
    
	<%@ include file="../include/footer.jsp"%>

	<!-- 메인 컨텐츠 영역 끝 -->