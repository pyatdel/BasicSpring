<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<title>DASHMIN - Bootstrap Admin Template</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">
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
<!--     <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet"> -->

<!-- Libraries Stylesheet -->
<link href="/dash/lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link
	href="/dash/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css"
	rel="stylesheet" />
</head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<!--    <script src="/dash/lib/chart/chart.min.js"></script> -->
<style>
.blue-btn>a {
	color: white !important;
}

.white-btn>a {
	color: black !important;
}
.card-footer {
    padding: .5rem 1rem;
    background-color: rgba(0, 0, 0, 0) !important;
    border-top: 1px solid rgba(0, 0, 0, 0) !important;
}
#mail-menu{
	color: white;
}
#user_name{
	color: white;
}

#jojik{
	color:white;
}
</style>
<body>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.member" var="userInfo"/>
</sec:authorize> 
	<header class="adheader">
		<a href="/adminmain"><h1 class="adtext-primary">W7VKY</h1></a>
		<div class="header-icons">
			<div class="options">
			
			<a href="#" id ="jojik"onclick="window.open('http://localhost:7921/organization','new','scrollbars=yes, resizable=no width=1200 height=850,top=40',left=200);return false">조직도</a>
			
			<div class="nav-item dropdown">
				<a href="#" class="adnav-link dropdown-toggle" data-bs-toggle="dropdown" id="mail-menu">
					<i class="bi bi-envelope"></i>
               			<span class="d-none d-lg-inline-flex">쪽지</span>
               	</a>
               	 <div
                  class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                  <a href="/admessage/adlist/adinbox" class="dropdown-item">
                     <h6>쪽지함</h6> 
                  </a>
                  <a href="/adaddress" class="dropdown-item">
                     <h6>주소록</h6> 
                  </a>  
               </div>
            </div>
               				
				<div class="nav-item dropdown">
					<a href="/alamList" class="adnav-link dropdown-toggle" data-bs-toggle="dropdown"> 
					<i class="fa fa-bell me-lg-2"></i>
						<span class="d-none d-lg-inline-flex">알림</span>
					</a>
					<div
						class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
						<a href="/alamList" class="dropdown-item">
	                     <h6 class="fw-normal mb-0">전체 알림 보기</h6> 
	                  </a>
<!--                   <hr class="dropdown-divider"> -->
<!--                   <a href="#" class="dropdown-item"> -->
<!--                      <h6 class="fw-normal mb-0">New user added</h6> <small>15 -->
<!--                         minutes ago</small> -->
<!--                   </a> -->
<!--                   <hr class="dropdown-divider"> -->
<!--                   <a href="#" class="dropdown-item"> -->
<!--                      <h6 class="fw-normal mb-0">Password changed</h6> <small>15 -->
<!--                         minutes ago</small> -->
<!--                   </a> -->
<!--                   <hr class="dropdown-divider"> -->
<!--                   <a href="#" class="dropdown-item text-center">See all -->
<!--                      notifications</a> -->
						</div>
					</div>
				</div>

				<div class="nav-item dropdown">
					<a href="#" class="nav-link dropdown-toggle"
						data-bs-toggle="dropdown" id="user_name"> 
						<img class="rounded-circle me-lg-2"
						img src="${userInfo.empProfile != null ? userInfo.empProfile : '/img/default-profile.png'}"
						alt="User Profile"
						style="width: 50px; height: 50px; border-radius: 50% !important;">
						<span class="d-none d-lg-inline-flex">
						${userInfo.empName != null ? userInfo.empName : 'Guest'}
					</span>
					
					</a>
					<div
						class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
						<a href="/adminmain/adminprofile" class="dropdown-item">My Profile</a> <a href="#"
							class="dropdown-item">Settings</a> 
							<form id="logoutForm" action="/logout" method="post">
								<button type="submit" class="dropdown-item">Log Out</button>
							</form>
					</div>
				</div>
			</div>
	</header>

	<!-- 사이드바 영역 -->
	<div class="main-content">
		<nav class="wgsidebar">
			<ul>
				<li class="menu-item" id="schedule-menu"><i
					class="bi bi-calendar-check"></i> 인사</li>
				<li class="menu-item" id="price-menu"><i
					class="bi bi-clipboard-check"></i> 결재</li>
				<li class="menu-item" id="attendanceList-menu"><i class="bi bi-clock"></i> 근태</li>
				<li class="menu-item" id="price-menu"><i
					class="bi bi-clipboard-check"></i>
					<a href="http://localhost:8020/cash/budgetList" style="color: black;">지출관리</a></li>
				<li class="menu-item" id="price-menu"><i class="bi bi-envelope"></i>
					<a
					href="http://localhost:8020/system/report" style="color: black;">신고 관리</a></li>
				<li class="menu-item" id="attendance-menu"><i
					class="bi bi-clock"></i> 게시판</li>
			</ul>
		</nav>

		<!-- 세부 사이드바 영역 -->
		
		
		<!--인사-->
		<div class="schedule-sidebar" id="schedule-sidebar">
			<button class="white-btn" id="my-schedule">직원관리</button>
			<div class="submenu" id="my-list"
				style="display: none; padding-left: 20px;">
				<a href="http://localhost:8020/personnel/list">직원 리스트</a><br> <a
					href="http://localhost:8020/employeeSalary/salaryList">직원 급여</a><br>
			</div>
			

		</div>



		<!--시스템-->
		<div class="attendance-sidebar" id="attendance-sidebar">
			<a href="http://localhost:8020/system/notice"><button
					class="white-btn">공지사항 관리</button></a> <a
				href="http://localhost:8020/system/qna"><button
					class="white-btn">문의(QnA) 관리</button></a>
		</div>

		<!--결재-->
		<div class="price-sidebar" id="price-sidebar">
			<div class="price-buttons">
				<a href="http://localhost:8020/sign/create"><button
						class="blue-btn" id="compose-btn">기안작성</button></a>
			</div>
			<div>
			<a href="http://localhost:8020/sign/signHome"><button
					class="white-btn">결재 대시보드</button></a>
			</div>		 
			<div class="horizontal-line"></div>
			<a href="http://localhost:8020/sign/signList"><button
					class="white-btn">결재 대기함</button></a> <a
				href="http://localhost:8020/sign/request"><button
					class="white-btn">결재 요청함</button></a>
			<div class="horizontal-line"></div>
			<a href="http://localhost:8020/sign/end"><button
					class="white-btn">종결함</button></a>
			<!-- 최종 결재자까지 승인 된거까지  -->
			<a href="http://localhost:8020/sign/collect"><button
					class="white-btn">반려함</button></a>
			<!-- 내가 승인한 거 확인? -->
			<div class="horizontal-line"></div>
			<a href="http://localhost:8020/sign/reading"><button
					class="white-btn">참조함</button></a> 
					<a href="http://localhost:8020/sign/department"><button
					class="white-btn">부서문서함</button></a> 
					
					
			<div class="horizontal-line"></div>
		</div>
		
		
		<!--근태-->
      <div class="attendanceList-sidebar" id="attendanceList-sidebar">
         <button onclick="location.href='/manageratt/managerAnnualList'" class="white-btn" id="my-att">연차 및 휴가 관리</button>
<!--          <button onclick="location.href='/manageratt/managerWorkReport'" class="white-btn" id="my-att2">근무 리포트</button> -->
      </div>
		
		
		
		
		<!--세부 사이드바 영역 종료-->
		<!-- 메인 컨텐츠 영역 -->
		<div class="content-area">

			<script>
			
			document.addEventListener("DOMContentLoaded",function() {
	     		let webSocket;
	     		
	     	 	// 세션에서 empNo 가져오기
	     		const empNo = '${EMP_NO}';
	     		const empName = '${EMP_NAME}';
	           if(!empNo){
	              console.log("로그인 정보가 없습니다. 웹소켓 연결을 건너뜁니다.");
	              return;
	           }
	           
	           // 로그아웃 시 초기화를 보장하기 위해 sessionStorage 강제 초기화
	           sessionStorage.removeItem("websocketConnected");
	           
	        	// 첫 연결 확인을 위한 상태 저장 (sessionStorage 사용)
	           const isFirstConnection = sessionStorage.getItem("websocketConnected");
	        
	        
	        		if(isFirstConnection) {
	        			console.log("이미 웹소켓이 연결되어 있습니다. 연결을 건너뜁니다.");
	        			 return;
	        		}

	     		function connectWebSocket(){
	     				// 웹소켓 연결
	     				const socketUrl = `ws://localhost:8020/ws/alarm/\${empNo}`;
	                 
	                 // 웹소켓이 이미 연결된 경우
	                 if(webSocket && webSocket.readyState === WebSocket.OPEN){
	                    console.log("이미 웹소켓이 연결되어 있습니다.");
	                    return;
	                 }

	                 webSocket = new WebSocket(socketUrl);

	     				// 웹소켄 이벤트 핸들러
	     				webSocket.onopen = () => {
	     					console.log(`WebSocket 연결 성공: empNo = \${empNo}`);
	     					
	     					// 웹소켓 연결 시 메시지를 전송하기 전에 조건 확인
	     					if(!sessionStorage.getItem("websocketFirstMessageSent")){
	     						const messageData = {
	         							message : `\${empName}님이 접속했습니다.`
	         						};
	         						webSocket.send(JSON.stringify(messageData));
	     						// 첫 연결 완료 상태를 sessionStorage 에 저장
	     						sessionStorage.setItem("websocketFirstMessageSent","true");
	     					}
	     					
	     					sessionStorage.setItem("websocketConnected","true");
	     				};

	     				webSocket.onmessage = (event) =>{
	     					// 알림 메시지
	     					const data = JSON.parse(event.data);
	     				    showNotification(data.message, data.url);
	     				};

	     				webSocket.onclose = (event) =>{
	     					console.error("WebSocket 연결이 종료 되었습니다 : ",event.reason);
	     					sessionStorage.removeItem("websocketConnected"); // 연결 종료 시 상태 초기화
	     					sessionStorage.removeItem("websocketFirstMessageSent");
	     				};

	     	            webSocket.onerror = (error) => {
	     	            console.error("WebSocket 오류 발생:", error);
	     	            };
	     	            
	     				// 로그아웃 버튼 클릭 이벤트 처리
	     				const logoutForm = document.getElementById("logoutForm");
	     				logoutForm.addEventListener("submit",function (event){
		     				console.log("로그아웃 버튼 클릭됨");
		   					// 폼 제출 동작 막기
		   					event.preventDefault();
	     					console.log("webSocket 상태 : ",webSocket.readyState);
	     					
	     					// 폼 제출 전 웹소켓 연결 종료
	     					if(webSocket && webSocket.readyState === WebSocket.OPEN){
	     						webSocket.close(); // 웹소켓 닫기
	     						console.log("WebSocket 연결이 로그아웃으로 인해 종료되었습니다.");
	     						sessionStorage.removeItem("websocketConnected"); // 상태 초기화
	     						sessionStorage.removeItem("websocketFirstMessageSent");
	     					}else {
	     						console.log("WebSocket이 이미 종료된 상태입니다.");
	     					}
	   						logoutForm.submit();
	     				});
	              }  
	     		
	     				// 알림 표시 함수
	     		function showNotification(message,url) {
	     				const notification = document.createElement("div");
	     				notification.textContent = `📢 알림: \${message}`;
	     				notification.style.cssText = `
	     					position: fixed;
	     					top: 100px;
	     					right: 20px;
	     					background-color: #ffeb3b;
	     					padding: 10px 20px;
	     					border: 1px solid #fbc02d;
	     					border-radius: 5px;
	     					box-shadow: 0px 2px 10px rgba(0,0,0,0.7);
	     					z-index: 1000;
	     					transform: translateX(100%); /* 오른쪽 밖으로 이동 */
	     					opacity: 0;
	     					transition : opacity 0.5s;
	     				`;
	     				
	     				// 클릭하면 해당 URL로 이동
					    if(url){
					    	notification.addEventListener("click", () => {
					        window.location.href = url;
					    });
					    }
	     				
	     				document.body.appendChild(notification);
	     				
	     				// 애니메이션 : 서서히 나타내기
	     				setTimeout(()=>{
	     					notification.style.opacity = "1";
	     					notification.style.transform = "translateX(0)";
	     				},10);
	     				
	     				// 3초 후 알람 제거 (서서히 사라지기)
	     				setTimeout(() => {
	     					notification.style.opacity = "0";
	     					notification.style.transform = "translateX(60%)";
	     				setTimeout(() => notification.remove(),300);
	     				}, 3000);
	     			}
	     			
	   				// 새로고침 시 기존 웹소켓 연결 끊김을 처리하기 위해 다시 연결
	   				connectWebSocket();
	     	});
			
   // 모든 사이드바를 닫는 함수
   function closeAllSidebars() {
       const sidebars = document.querySelectorAll('.mail-sidebar, .schedule-sidebar, .attendance-sidebar, .price-sidebar, .attendanceList-sidebar');
       sidebars.forEach(sidebar => sidebar.classList.remove('visible'));
   }

//    // 메일 사이드바 토글
//    document.getElementById('mail-menu').addEventListener('click', function() {
//        closeAllSidebars();
//        document.getElementById('mail-sidebar').classList.toggle('visible');
//    });
   
	// 근태 사이드바 토글
   document.getElementById('attendanceList-menu').addEventListener('click', function() {
       closeAllSidebars();
       document.getElementById('attendanceList-sidebar').classList.toggle('visible');
   });

   // 인사 사이드바 토글
   document.getElementById('schedule-menu').addEventListener('click', function() {
       closeAllSidebars();
       document.getElementById('schedule-sidebar').classList.toggle('visible');
   });


   // 시스템 사이드바 토글
   document.getElementById('attendance-menu').addEventListener('click', function() {
       closeAllSidebars();
       document.getElementById('attendance-sidebar').classList.toggle('visible');
   });

   // 결재 사이드바 토글
   document.getElementById('price-menu').addEventListener('click', function() {
       closeAllSidebars();
       document.getElementById('price-sidebar').classList.toggle('visible');
   });

   document.getElementById('my-schedule').addEventListener('click', function () {
       const submenu = document.getElementById('my-list');
       const isVisible = submenu.style.display === 'block';
       
       // 모든 서브메뉴 닫기
       document.querySelectorAll('.submenu').forEach(menu => menu.style.display = 'none');
       
       // 현재 서브메뉴 토글
       submenu.style.display = isVisible ? 'none' : 'block';
   });
   document.getElementById('my-att').addEventListener('click', function () {
       const submenu = document.getElementById('my-attlist');
       const isVisible = submenu.style.display === 'block';
       
       // 모든 서브메뉴 닫기
       document.querySelectorAll('.submenu').forEach(menu => menu.style.display = 'none');
       
       // 현재 서브메뉴 토글
       submenu.style.display = isVisible ? 'none' : 'block';
   });
   document.getElementById('my-att2').addEventListener('click', function () {
       const submenu = document.getElementById('my-attlist2');
       const isVisible = submenu.style.display === 'block';
       
       // 모든 서브메뉴 닫기
       document.querySelectorAll('.submenu').forEach(menu => menu.style.display = 'none');
       
       // 현재 서브메뉴 토글
       submenu.style.display = isVisible ? 'none' : 'block';
   });
   
   </script>