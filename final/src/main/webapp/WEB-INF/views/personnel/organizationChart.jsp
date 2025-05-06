<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


	<!-- ///// sidebar 시작 ///// -->
	<jsp:include page="../include/mangerSidebar.jsp"></jsp:include> 
	<!-- ///// sidebar 끝 ///// -->

<head>
  <meta charset="utf-8">
  <link rel="stylesheet" href="dist/themes/default/style.min.css" />
</head>

<body>

<iframe src="http://localhost:7921/organization" frameborder="0" title="근태현황" width="100%" height="95%" scrolling="no" marginwidth="5" marginheight="5" ></iframe>
</body>


       <script src="/dash/lib/easing/easing.min.js"></script>
    <script src="/dash/lib/waypoints/waypoints.min.js"></script>
    <script src="/dash/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/moment.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>
<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
    <!-- Template Javascript -->
    <script src="/dash/js/main.js"></script>
<!-- ///// footer 시작 ///// -->
 <jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->