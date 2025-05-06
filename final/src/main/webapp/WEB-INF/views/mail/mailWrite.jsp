<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>메일 작성</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/dash/css/bootstrap.min.css">
    <link rel="stylesheet" href="/dash/css/style.css">
    <link rel="stylesheet" href="/css/mail.css">
</head>
<body>
    <!-- Header -->
    <header>
        <a href="/main">
            <h1 class="text-primary">NOSLEEP</h1>
        </a>
        <div class="header-icons">
            <div class="options">
                <a href="/mail" id="mail-menu">
                    <i class="bi bi-envelope"></i> 메일
                </a>
                <div class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                        <img class="rounded-circle me-lg-2"
                             src="${userInfo.empProfile != null ? userInfo.empProfile : '/img/default-profile.png'}"
                             alt="User Profile" style="width: 50px; height: 50px;">
                        <span class="d-none d-lg-inline-flex">
                            ${userInfo.empName != null ? userInfo.empName : 'Guest'}
                        </span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                        <a href="#" class="dropdown-item">My Profile</a>
                        <a href="#" class="dropdown-item">Settings</a>
                        <form action="/logout" method="post">
                            <button type="submit" class="dropdown-item">Log Out</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <div class="container mt-5">
        <h2>메일 작성</h2>
        <form action="/mail/send" method="post">
            <!-- 수신인 -->
            <div class="mb-3">
                <label for="empMail" class="form-label">받는 사람</label>
                <input type="email" class="form-control" id="empMail" name="empMail" placeholder="수신인의 이메일을 입력하세요" required>
            </div>
            <!-- 제목 -->
            <div class="mb-3">
                <label for="mailName" class="form-label">제목</label>
                <input type="text" class="form-control" id="mailName" name="mailName" placeholder="메일 제목을 입력하세요" required>
            </div>
            <!-- 내용 -->
            <div class="mb-3">
                <label for="mailContent" class="form-label">내용</label>
                <textarea class="form-control" id="mailContent" name="mailContent" rows="10" placeholder="메일 내용을 입력하세요" required></textarea>
            </div>
            <!-- 파일 첨부 -->
            <div class="mb-3">
                <label for="mailAttachment" class="form-label">파일 첨부</label>
                <input type="file" class="form-control" id="mailAttachment" name="mailAttachment">
            </div>
            <!-- 버튼 -->
            <div class="text-end">
                <button type="submit" class="btn btn-primary">보내기</button>
                <button type="reset" class="btn btn-secondary">취소</button>
            </div>
        </form>
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
