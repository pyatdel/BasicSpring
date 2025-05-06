<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<title>W7VKY 그룹웨어</title>
<link rel="stylesheet" href="/dash/css/bootstrap.min.css">
<link rel="stylesheet" href="/dash/css/style.css">
<link rel="stylesheet" href="/css/mail.css">
<link rel="stylesheet" href="/css/styles.css">


<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Libre+Baskerville:ital,wght@0,400;0,700;1,400&family=Marhey:wght@300..700&family=Montserrat+Alternates:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Montserrat:ital,wght@0,100..900;1,100..900&family=Quicksand:wght@300..700&family=Signika+Negative:wght@300..700&family=Slabo+27px&family=Sour+Gummy:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">


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
.LOGO{
  font-family: "Quicksand", serif;
  font-optical-sizing: auto;
  font-weight: <weight>;
  font-style: normal;
}

</style>
<sec:authorize access="isAuthenticated()">
<%-- 	<p><sec:authentication property="principal.member"/></p> --%>
	<sec:authentication property="principal.member" var="userInfo" />
</sec:authorize> 
   <header>
      <a href="/main"><h1 class="text-primary LOGO">W7VKY</h1></a>
      <div class="header-icons">
         <div class="options">
         
         <div class="nav-item dropdown">
               <a href="#" class="nav-link dropdown-toggle"
                  data-bs-toggle="dropdown" onclick="window.open('http://localhost:7921/schedule','new','scrollbars=yes, resizable=no width=1200 height=850,top=40',left=200);return false">  <i class="bi bi-calendar-check"></i>
                  <span class="d-none d-lg-inline-flex">일정</span>
               </a>
            </div>
         <div class="nav-item dropdown">
               <a href="#" class="nav-link dropdown-toggle"
                  data-bs-toggle="dropdown"> <i class="bi bi-envelope"></i>
                  <span class="d-none d-lg-inline-flex">쪽지</span>
               </a>
               <div
                  class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                  <a href="/message/list/inbox" class="dropdown-item">
                     <h6>쪽지함</h6> 
                  </a>
                  <a href="/address" class="dropdown-item">
                     <h6>메신저</h6> 
                  </a>
                 
               </div>
            </div>
<!--             <a href="/mail" id="mail-menu"><i class="bi bi-envelope"></i> -->
<!--                메일</a> -->
            <!--             <a href="login" class="dropdown-item">Log Out</a> -->
            <div class="nav-item dropdown">
               <a href="#" class="nav-link dropdown-toggle"
                  data-bs-toggle="dropdown"> <i class="fa fa-bell me-lg-2"></i>
                  <span class="d-none d-lg-inline-flex">알림</span>
               </a>
               <div
                  class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                  <a href="#" class="dropdown-item">
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

            <div class="nav-item dropdown">
               <a href="#" class="nav-link dropdown-toggle"
						data-bs-toggle="dropdown"> 
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
                  <a href="/main/profile" class="dropdown-item">내 프로필</a> 
<!--                   <a href="#" class="dropdown-item">Settings</a> -->
                  <form id="logoutForm" action="/logout" method="post">
                     <button type="submit" class="dropdown-item">로그아웃</button>
                  </form>
               </div>
            </div>
         </div>
   </header>

   <!-- 사이드바 영역 -->
   <div class="main-content">
      <nav class="wgsidebar">
         <ul>
            <!-- <li class="menu-item" id="schedule-menu" onclick="window.open('http://localhost:7921/schedule','new','scrollbars=yes, resizable=no width=1200 height=850,top=40',left=200);return false">
            <i class="bi bi-calendar-check"></i> 일정</li> -->
            <li class="menu-item" id="pro-menu" onclick="location.href='/work/workDash'"><i class="bi bi-person-circle"></i> 업무</li>
            <li class="menu-item" id="contract-menu"><i
               class="bi bi-file-earmark-check"></i>계약</li>
            <li class="menu-item" id="cash-menu" onclick="location.href='/cash/cashList'"><i class="bi bi-wallet-fill"></i> 매출</li>
            <li class="menu-item" id="business-menu" onclick="location.href='/business/custManage'"><i class="bi bi-cash"></i> 영업</li>
            <li class="menu-item" id="price-menu"><i
               class="bi bi-clipboard-check"></i>전자결재</li>
            <li class="menu-item" id="edu-menu"><i
               class="bi bi-chat-left-dots"></i> 소통</li>
            <li class="menu-item" id="attendance-menu"><i
               class="bi bi-clock" ></i> 근태</li>
<!--             <li class="menu-item" id="mail-menu"><i class="bi bi-envelope"></i> -->
<!--                메일</li> -->
             <li class="menu-item" onclick="location.href='/schedule/cabinetReservation'">
             	회의실 예약
            </li>
            <!--             <a href="#"><button class="blue-btn" id="compose-btn">조직도</button></a> -->
         </ul>
      </nav>

      <!-- 세부 사이드바 영역 -->
<!--       <div class="mail-sidebar" id="mail-sidebar"> -->
<!--          <div class="mail-buttons"> -->
<!--             <button class="btn btn-primary" id="won" -->
<!--                onclick="location.href='/email'">메일쓰기</button> -->
<!--             <button class="btn btn-primary" id="won">내게쓰기</button> -->
<!--          </div> -->
<!--          <button class="white-btn">안 읽음</button> -->
<!--          <button class="white-btn">중요</button> -->
<!--          <button class="white-btn">첨부</button> -->

<!--          <div class="horizontal-line"></div> -->

<!--          <button class="white-btn">전체 메일</button> -->
<!--          <button class="white-btn">받은 메일함</button> -->
<!--          <button class="white-btn">내게 쓴 메일함</button> -->
<!--          <button class="white-btn">보낸 메일함</button> -->
<!--          <div class="horizontal-line"></div> -->
<!--          <button class="white-btn">스팸 메일함</button> -->
<!--          <button class="white-btn">휴지통</button> -->
<!--       </div> -->

      <!--일정-->
<!--       <div class="schedule-sidebar" id="schedule-sidebar"> -->
<!--          <div class="schedule-buttons"> -->
           
<!--          </div> -->
<!--          <div class="horizontal-line"></div> -->
         
<!--                   <div class="submenu" id="my-list" -->
<!--                      style="display: none; padding-left: 20px;"> -->
<!--                      <a href="#">팀 일정</a><br> -->
<!--                      <a href="#">부서 회의록</a><br> -->
<!--                      <a href="#">부서 휴가 현황</a> -->
<!--                   </div> -->

<!-- <!-- 			<a href="/schedule/scheduleTask"><button class="white-btn">업무 --> 
<!-- <!-- 					관리</button></a> <a href="/schedule/scheduleTaskPercent"><button --> 
<!-- <!-- 					class="white-btn">업무진행현황</button></a> --> 
<!-- 		</div> -->



      <!--고객-->
      <!--       <div class="prod-sidebar" id="prod-sidebar"> -->
      <!--          <div class="prod-buttons"> -->
      <!--             <button class="blue-btn" id="compose-btn">고객관리</button> -->
      <!--          </div> -->
      <!--          <div class="horizontal-line"></div> -->

      <!--          <button class="white-btn">내 고객정보</button> -->
      <!--          <button class="white-btn">SMS발송</button> -->
      <!--          <button class="white-btn">고객 문의함</button> -->
      <!--       </div> -->

      <!--영업-->
      <div class="business-sidebar" id="business-sidebar">
      <a href="/business/custManage"><button class="blue-btn" id="compose-btn"></button></a>
      
         <div class="business-buttons">
            <a href="/business/custManage"><button class="blue-btn"
                  id="compose-btn">고객 정보</button></a>
         </div>
         <div class="business-buttons">
            <a href="/business/infoList"><button class="blue-btn"
                  id="compose-btn">영업 관리</button></a>
         </div>
         <div class="business-buttons">
            <a href="/business/busStat"><button class="blue-btn"
                  id="compose-btn">영업 통계</button></a>
         </div>
      </div>

      <!--계약-->
      <div class="contract-sidebar" id="contract-sidebar">
         <div class="contract-buttons">
            <button class="blue-btn" id="compose-btn"
               onclick="location.href='/contract/create'">계약서 작성</button>
         </div>
         <div class="horizontal-line"></div>
         <button class="white-btn" onclick="location.href='/contract/list'">계약
            관리</button>
         <button class="white-btn" onclick="location.href='/taxin/list'">계산서
            관리</button>
       <!--   <button class="white-btn" onclick="location.href='/expdit/list'">입금
            / 지출 관리</button> -->
         <!-- <button class="white-btn"><a href="#">견적서 관리</a></button> -->
        <!--  <button class="white-btn" onclick="location.href='/conimpl/gant'">모니터링 / 분석</button> -->
        <!--  <button class="white-btn" onclick="location.href='/conimpl/gant'">리포트
            및 분석</button> -->
      </div>

      <!--매출-->
		<div class="cash-sidebar" id="cash-sidebar">
			<button class="white-btn" onclick="location.href='/cash/cashList'">매출 정보</button>
			<button class="white-btn" onclick="location.href='/cash/expenseReport'">문서 관리</button>
			<button class="white-btn" onclick="location.href='/cash/cashAnaly'">매출 통계 / 분석</button>
			<div class="horizontal-line"></div>
			<button class="white-btn" onclick="location.href='/cash/budgetList'">지출 관리</button>
		</div>
	
      <!--근태-->
      <div class="attendance-sidebar" id="attendance-sidebar">
         <div class="attendance-buttons">
            <a href="/att/attManager"><button class="blue-btn" id="compose-btn">근태 관리</button></a>
         </div>
         <button onclick="location.href='/att/commuteList'" class="white-btn">출퇴근 내역</button>
         <div class="horizontal-line"></div>
         
         <button onclick="location.href='/att/annualList'" class="white-btn" id="my-att">연차 및 휴가 관리</button>
<!--          <div class="submenu" id="my-attlist" -->
<!--             style="display: none; padding-left: 20px;"> -->
<!--             <a href="/att/documentattList">내 근태 현황</a><br> -->
<!--          </div> -->
         
<!--          <button onclick="location.href='/att/attAppliSituation'" class="white-btn" id="my-att2">근태 신청현황</button> -->
<!--          <button onclick="location.href='/att/workReport'" class="white-btn" id="my-att2">근무 리포트</button> -->
<!--          <div class="submenu" id="my-attlist2" -->
<!--             style="display: none; padding-left: 20px;"> -->
<!--             <a href="/att/attAppliSituation">근태 신청 현황</a><br> -->
<!--             <a href="/att/workReport">근무 리포트</a><br> -->
<!--             <a href="/att/vacationList">휴가 내역</a><br> -->
<!--          </div> -->
      </div>

      <!--소통-->
      <div class="edu-sidebar" id="edu-sidebar">
         <div class="edu-buttons" onclick="location.href='/board/'">
            <button class="blue-btn" id="compose-btn">게시판</button>
         </div>
         <button class="white-btn" onclick="location.href='/board/list?bodType=1'">공지사항</button>
         <button class="white-btn" onclick="location.href='/board/list?bodType=2'">부서게시판</button>
         <button class="white-btn" onclick="location.href='/board/list?bodType=3'">Q&A</button>
         <div class="horizontal-line"></div>
         <button class="blue-btn" id="compose-btn">커뮤니티</button>
         <button class="white-btn" onclick="location.href='/community/club/list'">만남의 광장(동호회)</button>
         <button class="white-btn" onclick="location.href='/community/list'">일반(커뮤니티)</button>
      </div>

<!--       <!--프로필--> 
<!--    <div class="pro-sidebar" id="pro-sidebar"> 
         <div class="pro-buttons">
            <button class="blue-btn" id="compose-btn">프로필관리</button>
         </div>
          <div class="edu-buttons" onclick="location.href='/todo/list'">
            <button class="blue-btn" id="compose-btn">할일 만들기</button>
         </div>
         <button class="white-btn"  onclick="window.open('http://localhost:7921/gantt','new','scrollbars=yes, resizable=no width=1900 height=1000,top=40',left=200);return false">업무 진행현황</button>
		 <button class="white-btn" onclick="location.href='/work/workDash'">업무 대시보드</button>
         <button class="white-btn" onclick="location.href='/todo/list'">나의 할일 리스트</button>
         <button class="white-btn" onclick="location.href='/file/list'">업무 파일 보관함</button>
      </div>  -->

      <!--결재-->
      <div class="price-sidebar" id="price-sidebar">
         <div class="price-buttons">
				<a href="http://localhost:8020/memberSign/create"><button
						class="blue-btn" id="compose-btn">기안작성</button></a>
			</div>
         <div class="horizontal-line"></div>
			<a href="http://localhost:8020/memberSign/signList"><button
					class="white-btn">결재 대기함</button></a> <a
				href="http://localhost:8020/memberSign/request"><button
					class="white-btn">결재 요청함</button></a>
			<div class="horizontal-line"></div>
			<a href="http://localhost:8020/memberSign/end"><button
					class="white-btn">종결함</button></a>
			<!-- 최종 결재자까지 승인 된거까지  -->
			<a href="http://localhost:8020/memberSign/collect"><button
					class="white-btn">반려함</button></a>
			<div class="horizontal-line"></div>
			<!-- 내가 승인한 거 확인? -->
			<a href="http://localhost:8020/memberSign/reading"><button
					class="white-btn">참조함</button></a> <a
				href="http://localhost:8020/memberSign/department"><button
					class="white-btn">부서문서함</button></a>
      </div>
      <!--세부 사이드바 영역 종료-->
      <!-- 메인 컨텐츠 영역 -->
      <div class="content-area">

         <script>
         
     	let webSocket;
         document.addEventListener("DOMContentLoaded",function() {
     		
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
       const sidebars = document.querySelectorAll('.mail-sidebar, .schedule-sidebar, .reservation-sidebar, .prod-sidebar, .business-sidebar, .contract-sidebar, .cash-sidebar, .attendance-sidebar, .edu-sidebar, .pro-sidebar, .price-sidebar');
       sidebars.forEach(sidebar => sidebar.classList.remove('visible'));
   }

   // 메일 사이드바 토글
//    document.getElementById('mail-menu').addEventListener('click', function() {
//        closeAllSidebars();
//        document.getElementById('mail-sidebar').classList.toggle('visible');
//    });

   // 일정 사이드바 토글
//    document.getElementById('schedule-menu').addEventListener('click', function() {
//        closeAllSidebars();
//        document.getElementById('schedule-sidebar').classList.toggle('visible');
//    });


   // 고객 사이드바 토글
//    document.getElementById('prod-menu').addEventListener('click', function() {
//        closeAllSidebars();
//        document.getElementById('prod-sidebar').classList.toggle('visible');
//    });

//    영업 사이드바 토글
//    document.getElementById('business-menu').addEventListener('click', function() {
//        closeAllSidebars();
//        document.getElementById('business-sidebar').classList.toggle('visible');
//    });
	
   // 계약 사이드바 토글
   document.getElementById('contract-menu').addEventListener('click', function() {
       closeAllSidebars();
       document.getElementById('contract-sidebar').classList.toggle('visible');
   });

//    // 매출 사이드바 토글
//    document.getElementById('cash-menu').addEventListener('click', function() {
//        closeAllSidebars();
//        document.getElementById('cash-sidebar').classList.toggle('visible');
//    });

   // 근태 사이드바 토글
   document.getElementById('attendance-menu').addEventListener('click', function() {
       closeAllSidebars();
       document.getElementById('attendance-sidebar').classList.toggle('visible');
   });

   // 소통 사이드바 토글
   document.getElementById('edu-menu').addEventListener('click', function() {
       closeAllSidebars();
       document.getElementById('edu-sidebar').classList.toggle('visible');
   });
	
//    // 프로필 사이드바 토글
   document.getElementById('pro-menu').addEventListener('click', function() {
        closeAllSidebars();
        document.getElementById('pro-sidebar').classList.toggle('visible');
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