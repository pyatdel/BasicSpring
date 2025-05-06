<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="./include/header.jsp" %>

<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<!-- 메인 컨텐츠 영역 시작 -->
<div class="content-area">
    <div class="grid-container">
        <div class="grid-item">
            <h2>일정표</h2>
            <div class="placeholder"></div>
        </div>
        <div class="grid-item">
            <h2>근태 <button class="blue-btn small-btn">출근하기</button></h2>
            <div class="placeholder"></div>
        </div>
        <div class="grid-item">
            <h2>공지사항</h2>
            <div class="placeholder"></div>
        </div>
        <div class="grid-item">
            <h2>매출 그래프</h2>
            <div class="placeholder"></div>
        </div>
    </div>
</div>
<!-- 메인 컨텐츠 영역 끝 -->
   
<%@ include file="./include/footer.jsp" %>