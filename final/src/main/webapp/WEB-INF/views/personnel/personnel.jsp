<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 
../ : views폴더(부모)
 -->
 
    <!-- <meta charset="utf-8">
    <title>DASHMIN - Bootstrap Admin Template</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
    <link rel="stylesheet" href="/dash/css/bootstrap.min.css" >
    <link rel="stylesheet" href="/dash/css/style.css" >
    <link href="img/favicon.ico" rel="icon">

    Google Web Fonts
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    

    
    
    
    Icon Font Stylesheet
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    Libraries Stylesheet
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" /> -->

	<!-- ///// sidebar 시작 ///// -->
	<jsp:include page="../include/mangerSidebar.jsp"></jsp:include> 
	<!-- ///// sidebar 끝 ///// -->

	<div class="bg-light text-center rounded p-4">
	
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">직원목록</h6>
                        <a href="">Show All</a>
                    </div>
                    <div class="table-responsive">
                        <table class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-dark">
                                    <th scope="col">사번</th>
                                    <th scope="col">이름</th>
                                    <th scope="col">부서</th>
                                    <th scope="col">직급</th>
                                    <th scope="col">연락처</th>
                                    <th scope="col">이메일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="text-dark">
                                    <th scope="col">1</th>
                                    <th scope="col">김철수</th>
                                    <th scope="col">인사부</th>
                                    <th scope="col">과장</th>
                                    <th scope="col">010-0000-0000</th>
                                    <th scope="col">test@test.com</th>
                                </tr>
                                <tr class="text-dark">
                                    <th scope="col">2</th>
                                    <th scope="col">김철수</th>
                                    <th scope="col">인사부</th>
                                    <th scope="col">과장</th>
                                    <th scope="col">010-0000-0000</th>
                                    <th scope="col">test@test.com</th>
                                </tr>
                                <tr class="text-dark">
                                    <th scope="col">3</th>
                                    <th scope="col">김철수</th>
                                    <th scope="col">인사부</th>
                                    <th scope="col">과장</th>
                                    <th scope="col">010-0000-0000</th>
                                    <th scope="col">test@test.com</th>
                                </tr>
                                <tr class="text-dark">
                                    <th scope="col">4</th>
                                    <th scope="col">김철수</th>
                                    <th scope="col">인사부</th>
                                    <th scope="col">과장</th>
                                    <th scope="col">010-0000-0000</th>
                                    <th scope="col">test@test.com</th>
                                </tr>
                                <tr class="text-dark">
                                    <th scope="col">5</th>
                                    <th scope="col">김철수</th>
                                    <th scope="col">인사부</th>
                                    <th scope="col">과장</th>
                                    <th scope="col">010-0000-0000</th>
                                    <th scope="col">test@test.com</th>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
 
 
 

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


