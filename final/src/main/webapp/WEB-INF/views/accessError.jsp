<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<!-- ///// content 시작 ///// -->

<div class="col-md-12">
	<!-- 404 Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row vh-100 bg-light rounded align-items-center justify-content-center mx-0">
                    <div class="col-md-6 text-center p-4">
                        <i class="bi bi-exclamation-triangle display-1 text-primary"></i>
                        <h1 class="display-1 fw-bold">권한없음</h1>
                        <h1 class="mb-4">NO SLEEP!!</h1>
                        <p class="mb-4">권한이 없어요</p>
                        <a class="btn btn-primary rounded-pill py-3 px-5" href="/main">누르면 홈으로 간당</a>
                    </div>
                </div>
            </div>
            <!-- 404 End -->
</div>

<!-- ///// content 끝 ///// -->

<%@ include file="./include/footer.jsp" %>   
