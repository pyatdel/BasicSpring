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

<jsp:include page="../include/preScript.jsp"></jsp:include>
<style>
.tbc {
	background-color: #009CFF;
	color: white;
	width: 90%;
	border-radius: 10% !important;
}

.commuteList{
	background-color : #ffffff;
	box-shadow: 0 2px 4px rgba(0,0,0,0.7);
}
.attSub {
display: block !important;
height: auto !important;
}
</style>

<!-- 메인 컨텐츠 영역 시작 --> 
<%-- <p>${contractMasterVOList}</p> --%> 
<%@ include file="../include/header.jsp"%>
	
<div class="commuteList rounded h-100 p-4 maxwidth">
		<div id="tbhd">
			<h3 class=" contlist">근태 신청현황</h3>
		</div>

		<div class="table-responsive ">
			<table class="table" id="tbb">
				<thead class="thc">
					<tr class="tbc">
						<th scope="col">순번</th>
						<th scope="col">일자</th>
						<th scope="col">출근시간</th>
						<th scope="col">퇴근시간</th>
						<th scope="col">근무시간</th>
						<th scope="col">상태</th>
					</tr>
				</thead>
				<tbody id="tby">
						<tr>
							<th scope="row"></th>
							<td></td>
							<td><a  href=""></a></td>
							<td></td>
						
							<td></td>
							<td></td>
						</tr>
				</tbody>
			</table>
		</div>
	</div>
	<script src="/dash/js/main.js"></script>
	<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
	<%@ include file="../include/footer.jsp"%>

	<!-- 메인 컨텐츠 영역 끝 -->