<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>W7VKY 로그인</title>
    <link rel="stylesheet" href="/css/loginstyles.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Libre+Baskerville:ital,wght@0,400;0,700;1,400&family=Marhey:wght@300..700&family=Montserrat+Alternates:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Montserrat:ital,wght@0,100..900;1,100..900&family=Quicksand:wght@300..700&family=Signika+Negative:wght@300..700&family=Slabo+27px&family=Sour+Gummy:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    
</head>
<style>
.logo{
 font-family: "Quicksand", serif;
  font-optical-sizing: auto;
  font-weight: <weight>;
  font-style: normal;

}


</style>
<body>
<sec:authorize access="isAuthenticated()"><!-- 로그인 o -->

	<!-- 1. 사용자 -->
	<sec:authorize access="hasRole('ROLE_USER')">
		<p>사용자임</p>
		<script type="text/javascript">location.href="/main"</script>
	</sec:authorize>
	<!-- 2. 관리자 -->
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		<p>관리자임</p>
		<script type="text/javascript">location.href="/managerMain";</script>
	</sec:authorize>
	
</sec:authorize>
    <div class="login-container">
        <h1 class="logo">W7VKY</h1>

        <!-- 에러 메시지 표시 -->
        <c:if test="${not empty param.error}">
            <div class="error-message" style="color: red; text-align: center; margin-bottom: 10px;">
                잘못된 아이디 또는 비밀번호입니다.
            </div>
        </c:if>

        <!-- 로그아웃 메시지 표시 -->
        <c:if test="${not empty param.logout}">
            <div class="logout-message" style="color: green; text-align: center; margin-bottom: 10px;">
                로그아웃 되었습니다.
            </div>
        </c:if>

        <!-- 로그인 폼 -->
        <h>20241231005 관리자</h><br>
        <h>20241231002 일반직원</h>
        <form action="/login" method="post" id="login-form">
            <div class="input-group">
                <label for="username">아이디</label>
                <input type="text" id="username" name="username" placeholder="아이디" required>
            </div>
            <div class="input-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" placeholder="비밀번호" required>
            </div>
            <div class="checkbox-group">
                <input type="checkbox" id="remember-id">
                <label for="remember-id">아이디 저장</label>
            </div>
            <button type="submit" class="login-button">로그인</button>
        </form>
    </div>

    <!-- JavaScript: 아이디 저장 및 폼 제출 시 처리 -->
    <script>
        const rememberCheckbox = document.getElementById('remember-id');
        const usernameInput = document.getElementById('username');

        // 아이디 저장 로직
        rememberCheckbox.addEventListener('change', function() {
            if (this.checked) {
                localStorage.setItem('rememberedUsername', usernameInput.value);
            } else {
                localStorage.removeItem('rememberedUsername');
            }
        });

        // 페이지 로드 시 저장된 아이디 복원
        window.addEventListener('load', function() {
            const rememberedUsername = localStorage.getItem('rememberedUsername');
            if (rememberedUsername) {
                usernameInput.value = rememberedUsername;
                rememberCheckbox.checked = true;
            }
        });
    </script>
</body>
</html>
