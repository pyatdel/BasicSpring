<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<title>받은 메일함</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<link rel="stylesheet" href="/dash/css/bootstrap.min.css">
<link rel="stylesheet" href="/dash/css/style.css">
<link rel="stylesheet" href="/css/mail.css">
<link rel="stylesheet" href="/css/styles.css">
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
<link href="/dash/lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link
	href="/dash/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css"
	rel="stylesheet" />
</head>
<body>
	<header>
		<a href="/main"><h1 class="text-primary">NOSLEEP</h1></a>
		<div class="header-icons">
			<div class="options">
				<a href="/mail" id="mail-menu"><i class="bi bi-envelope"></i> 메일</a>
				<div class="nav-item dropdown">
					<a href="#" class="nav-link dropdown-toggle"
						data-bs-toggle="dropdown"> <i class="fa fa-bell me-lg-2"></i>
						<span class="d-none d-lg-inline-flex">Notification</span>
					</a>
					<div
						class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
						<a href="#" class="dropdown-item">
							<h6 class="fw-normal mb-0">Profile updated</h6> <small>15
								minutes ago</small>
						</a>
						<hr class="dropdown-divider">
						<a href="#" class="dropdown-item">
							<h6 class="fw-normal mb-0">New user added</h6> <small>15
								minutes ago</small>
						</a>
						<hr class="dropdown-divider">
						<a href="#" class="dropdown-item">
							<h6 class="fw-normal mb-0">Password changed</h6> <small>15
								minutes ago</small>
						</a>
						<hr class="dropdown-divider">
						<a href="#" class="dropdown-item text-center">See all
							notifications</a>
					</div>
				</div>
				<div class="nav-item dropdown">
					<a href="#" class="nav-link dropdown-toggle"
						data-bs-toggle="dropdown"> <img class="rounded-circle me-lg-2"
						src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
						<span class="d-none d-lg-inline-flex">John Doe</span>
					</a>
					<div
						class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
						<a href="#" class="dropdown-item">My Profile</a> <a href="#"
							class="dropdown-item">Settings</a>
						<form action="/logout" method="post">
							<button type="submit" class="dropdown-item">Log Out</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</header>
	<br>
	<div class="container-fluid">
		<div class="row">
			<!-- 1번 영역: 네이버 스타일 사이드바 -->
			<nav class="wgsidebar">
				<ul class="nav flex-column">
					<div class="mail-buttons">
						<!-- 메일쓰기 버튼 -->
						<button class="btn btn-primary" id="won"
							onclick="location.href='/mail/mailWrite'">메일쓰기</button>
						<!-- 내게쓰기 버튼 -->
						<button class="btn btn-primary" id="won"
							onclick="location.href='/mail/selfMail'">내게쓰기</button>
					</div>
					<!-- 안 읽음 -->
					<button class="white-btn" onclick="location.href='/mail/noCheck'">안읽음</button>
					<!-- 중요 -->
					<button class="white-btn" onclick="location.href='/mail/important'">중요</button>
					<!-- 첨부 -->
					<button class="white-btn" onclick="location.href='/mail/plus'">첨부</button>

					<div class="horizontal-line"></div>

					<!-- 전체 메일 -->
					<button class="white-btn" onclick="location.href='/mail/allMail'">전체
						메일</button>
					<!-- 받은 메일함 -->
					<button class="white-btn" onclick="location.href='/mail/myMail'">받은
						메일함</button>
					<!-- 내게 쓴 메일함 -->
					<button class="white-btn" onclick="location.href='/mail/myWrite'">내게
						쓴 메일함</button>
					<!-- 보낸 메일함 -->
					<button class="white-btn" onclick="location.href='/mail/sendMail'">보낸
						메일함</button>

					<div class="horizontal-line"></div>

					<!-- 스팸 메일함 -->
					<button class="white-btn" onclick="location.href='/mail/spam'">스팸
						메일함</button>
					<!-- 휴지통 -->
					<button class="white-btn" onclick="location.href='/mail/trash'">휴지통</button>
				</ul>
			</nav>


			<!-- 2번 영역: 받은 메일함 -->
			<main class="col-md-10">
				<h2>안읽은 메일</h2>
				<table class="table table-hover mt-3">
					<thead>
						<tr>
							<th>보낸사람</th>
							<th>제목</th>
							<th>날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="email" items="${emailList}">
							<tr>
								<td>${email.sender}</td>
								<td>${email.subject}</td>
								<td><fmt:formatDate value="${email.date}"
										pattern="MM.dd HH:mm" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</main>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
