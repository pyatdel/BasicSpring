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
.tbc {
	background-color: 3069CE;
	color: white;
	width: 90%;
	border-radius: 10% !important;
}

.page-item.active .page-link {
	background-color: 3069CE !important;
	border-color: 3069CE !important;
}

#example2_paginate ul {
	justify-content: center !important;
}

#tbhd {
	display: flex;
}

#scbar {
	height: 40px !important;
}

#scbar2 {
	font-size: 13px !important;
	height: 40px !important;
	width: 70px !important;
	background-color: 3069CE !important;
	border: none !important;
}

.scb {
	margin-left: auto !important;
	width: 20%;
}

.cona {
	color: white !important;
}

.conbtn {
	background-color: 3069CE !important;
	border: none !important;
}

td>a {
	color: 3069CE !important;
}

.contlist {
	font-weight: normal;
}

.maxwidth {
	max-width: 95%;
	margin: 0 auto !important;
}

.table {
	margin-top: 1%;
	border-color: #FCFCFC !important;
}

.bg-transparent {
	height: 40px !important;
}

.taxindate {
	display: flex;
	margin-left: 3%;
}

.taxincontain {
	background-color: #FCFCFC;
	border-radius: 10px;
	border: 1px solid #c4c4c4;
}

.datebtn {
	text-align: center;
	margin-bottom: 1%;
}

.databtn>button {
	margin: 0 !important;
	background-color:;
}

.taxlist {
	border: 1px solid #c4c4c4 !important;
}

.taxlist {
	text-align: center;
}
.widflex{

width: 70%;
margin: 0 auto;
}
</style>

<!-- 메인 컨텐츠 영역 시작 -->
<%-- <p>${contractMasterVOList}</p> --%>
<%@ include file="../../include/header.jsp"%>
<div class="expditcontainer">
	<div class="bg-light rounded h-100 p-4 widflex">
		<div>
		<h3 class="mb-4">지출내역</h3>
		<div class="taxincontain">

			<div class="taxindate">
				<table class="table cmcrtb table-bordered">
					<tbody class="contb">
						<!-- <input type="hidden" class="updtcon" name="entNo"> -->

						<tr>
							<td>계약코드</td>
							<td><input type="number" name="contractNo" class="updtcon"
								placeholder="ex : 20240101+001" value="${param.expNo}"></td>
						</tr>
						<tr>
							<td>기간</td>
							<td><input type="date" name="tiTransdate"
								class="updtcon cdate"> ㅡ <input class="cdate"
								name="tiIssuedate" type="date"></td>
						</tr>


					</tbody>
				</table>
				<table class="table cmcrtb table-bordered">
					<tbody class="contb">
						<!-- <input type="hidden" class="updtcon" name="entNo"> -->

						<tr>
							<td>거래처 상호</td>
							<td><input type="text" name="entName" class="updtcon"
								placeholder="ex : 20240101+001"></td>
						</tr>
						<tr>
							<td>사업자 등록번호</td>
							<td><input type="text" name="busNo" class="updtcon"
								placeholder="사업자등록번호"></td>
						</tr>



					</tbody>
				</table>

			</div>
			<div class="datebtn">
				<button type="button" id="edit" class="btn btn-primary conbtn">조회하기</button>
			</div>
		</div>
		<div class="bg-light rounded h-100">
			<table class="table table-striped">
				<thead>
					<tr>
						<th scope="col">No.</th>
						<th scope="col">지출번호</th>
						<th scope="col">지출일시</th>
						<th scope="col">카테고리번호</th>
						<th scope="col">구매품목</th>
						<th scope="col">구매수량</th>
						<th scope="col">구매사유</th>
						<th scope="col">예산번호</th>
						<th scope="col">지출금액</th>
					</tr>
				</thead>
				<tbody id="tby">
					<c:forEach var="expenditureVO" items="${articlePage.content}"
						varStatus="stat">
						<tr>
							<td>${expenditureVO.rnum}</td>
							<td><a
								href="/expdit/detail?currentPage=${param.currentPage}&keyword=${param.keyword}&expNo=${expenditureVO.expNo}">${expenditureVO.expNo}</a></td>
							<td>${expenditureVO.expDate}</td>
							<td>${expenditureVO.cateNo}</td>
							<td>${expenditureVO.expObj}</td>
							<td>${expenditureVO.expQty}</td>
							<td>${expenditureVO.expReason}</td>
							<td>${expenditureVO.budgetNo}</td>
							<td>${expenditureVO.expPrice}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<center>
				<div class="row justify-content-center" id="divPagingArea">
					${articlePage.pagingArea}</div>
			</center>
			<div style="width:1000px;">
				<canvas id="myChart"></canvas>
			</div>
	</div>
	</div>
		</div>

</div>

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
</script>
<script src="/dash/js/main.js"></script>
<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<%@ include file="../../include/footer.jsp"%>

<!-- 메인 컨텐츠 영역 끝 -->