<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>




<jsp:include page="../include/preScript.jsp"></jsp:include>


<!-- 메인 컨텐츠 영역 시작 -->
<%@ include file="../include/header.jsp"%>

<div>

	<div class="col-sm-12 col-xl-6">
		<div class="bg-light text-center rounded p-4">
			<div class="d-flex align-items-center justify-content-between mb-4">
				<h6 class="mb-0">Salse &amp; Revenue</h6>
				<a href="">Show All</a>
			</div>
			<canvas id="salse-revenue" width="656" height="328"
				style="display: block; box-sizing: border-box; height: 328px; width: 656px;"></canvas>
		</div>
	</div>
	<script src="/dash/js/main.js"></script>
	<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
	<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
	<%@ include file="../include/footer.jsp"%>

	<!-- 메인 컨텐츠 영역 끝 -->