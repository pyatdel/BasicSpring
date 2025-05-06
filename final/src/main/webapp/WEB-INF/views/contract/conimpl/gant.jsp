<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>


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

<jsp:include page="../../include/preScript.jsp"></jsp:include>
<style>

.widflex{

width: 90%;
margin: 0 auto;
}
.contsucc{
display: flex;
}
.contsucc > div{
width:300px;
height: 200px;
background-color: #F6F6F6;
margin:10px;
border-radius: 10px;
}
.contsucc > div>div{
text-align: center;
align-content: center;
vertical-align: middle;  
}
.firstcont{
display: flex;
justify-content: space-between;
align-items: center;

}
.gantcont{
margin-top:4%;

}
</style>

<!-- 메인 컨텐츠 영역 시작 -->
<%-- <p>${contractMasterVOList}</p> --%>
<%@ include file="../../include/header.jsp"%>
<div class="expditcontainer">
	<div class="bg-light rounded h-100 p-4 widflex">
		<h3 class="mb-4">계약이행모니터링</h3>
		<div class="firstcont">
			<div class="contsucc">
				<div>
					<div>진행중 프로젝트</div>
					<div>22건</div>
				</div>
				<div></div>
			</div>
			<div style="width:700px;">
				<canvas id="myChart"></canvas>
			</div>
		</div>
		<div class="gantcont">
			<div id="chart_div"></div>
		</div>
	</div>
</div>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
	const ctx = document.querySelector('#myChart');

	// chart.js가 잘 만들어진 이유, 왼쪽에 변수로 받으면, 설정 내용을 받아올 수 있음 
	const chChart = new Chart(ctx, {
		type : 'bar', // bar,line,pie,doughnut,radar 일반적..., 항상 생각..!
		data : {
			labels : [ '1월', '2월', '3월', '4월', '5월', '6월','7월','8월','9월','10월','11월','12월' ],
			datasets : [ {
				label : '전년도 매출 ',
				data : [ 12, 19, 3, 5, 2, 3 ,10,20,10,10,10,30],
				borderWidth : 1,
				backgroundColor : '#3069CE'
			}
			// {
			//     label: '올해 매출',
			//     data: [22, 29, 33, 51, 12, 13],
			//     borderWidth: 1
			// }

			]
		},
		options : {
			indexAxis : 'x',
			scales : {
				x : {
					beginAtZero : true
				}
			}
		}
	});
	   google.charts.load('current', {'packages':['gantt']});
	    google.charts.setOnLoadCallback(drawChart);

	    function daysToMilliseconds(days) {
	      return days * 24 * 60 * 60 * 1000;
	    }

	    function drawChart() {

	      var data = new google.visualization.DataTable();
	      data.addColumn('string', 'Task ID');
	      data.addColumn('string', 'Task Name');
	      data.addColumn('date', 'Start Date');
	      data.addColumn('date', 'End Date');
	      data.addColumn('number', 'Duration');
	      data.addColumn('number', 'Percent Complete');
	      data.addColumn('string', 'Dependencies');

	      data.addRows([
	        ['Research', 'Find sources',
	         new Date(2015, 0, 1), new Date(2015, 0, 5), null,  100,  null],
	        ['Write', 'Write paper',
	         null, new Date(2015, 0, 9), daysToMilliseconds(3), 25, 'Research,Outline'],
	        ['Cite', 'Create bibliography',
	         null, new Date(2015, 0, 7), daysToMilliseconds(1), 20, 'Research'],
	        ['Complete', 'Hand in paper',
	         null, new Date(2015, 0, 10), daysToMilliseconds(1), 0, 'Cite,Write'],
	        ['Outline', 'Outline paper',
	         null, new Date(2015, 0, 6), daysToMilliseconds(1), 100, 'Research']
	      ]);

	      var options = {
	        height: 275
	      };

	      var chart = new google.visualization.Gantt(document.getElementById('chart_div'));

	      chart.draw(data, options);
	    }
</script>

<script src="/dash/js/main.js"></script>
<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<%@ include file="../../include/footer.jsp"%>

<!-- 메인 컨텐츠 영역 끝 -->