<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>관리자 페이지</title>
</head>
<body>
    <h1>관리자 페이지</h1>
    <sec:authorize access="hasRole('ROLE_ADMIN')">
        <p>환영합니다, 관리자님!</p>
    </sec:authorize>
    <sec:authorize access="!hasRole('ROLE_ADMIN')">
        <p>접근 권한이 없습니다.</p>
    </sec:authorize>
</body>
</html>
