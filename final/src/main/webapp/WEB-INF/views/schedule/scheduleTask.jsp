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
	width:70px !important;
		background-color: 3069CE !important;
		border:none !important;
}
.scb{
margin-left:auto !important;
width: 20%;
}
.cona{
color: white !important;
}
.conbtn{
background-color: 3069CE !important;
border:none !important; }
td >a{
color:3069CE !important;
}
.contlist{
font-weight:normal;}
.maxwidth{
max-width: 95%;
margin: 0 auto !important;}
.table{
margin-top:1%;}
.bg-transparent{
height: 40px !important;
}
</style>

<!-- 메인 컨텐츠 영역 시작 --> 
<%-- <p>${contractMasterVOList}</p> --%> 
<%@ include file="../include/header.jsp"%>
	<h1>업무 관리</h1>

	<script src="/dash/js/main.js"></script>
	<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
	<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
	<%@ include file="../include/footer.jsp"%>

	<!-- 메인 컨텐츠 영역 끝 -->