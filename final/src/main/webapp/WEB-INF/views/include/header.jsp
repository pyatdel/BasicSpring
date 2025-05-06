<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<body>

<sec:authorize access="isAuthenticated()">
<%-- 	<p><sec:authentication property="principal.member"/></p> --%>
	<sec:authentication property="principal.member" var="userInfo" />
</sec:authorize>  
    <!-- 헤더 -->
     <div>
    <div class="header">
       <div class="leftHeader">
           <a href="/main"><div class="logo">W7VKY</div></a>
           <nav>
               <a href="#" id="adminModeBtn" style="display: none;">|</a> 
               <a href="#" id="employeeModeBtn" onclick="changeColor(event, 'employeeModeBtn')" style="display: none;">직원</a>
            </nav>
        </div>
        <div class="header-right">
            <a href="/file/storage"><i class="bi bi-cloud-arrow-down" id="hdicon"></i>파일함</a>
            <a href="#" onclick="window.open('http://localhost:7921/organization','new','scrollbars=yes, resizable=no width=1200 height=850,top=40',left=200);return false"><i class="bi bi-diagram-3" id="hdicon"></i>조직도</a>
            <a href="#" onclick="window.open('http://localhost:7921/schedule','new','scrollbars=yes, resizable=no width=1200 height=850,top=40',left=200);return false"><i class="bi bi-calendar-check" id="hdicon"></i>일정</a>
            <a href="#" class="dropdown-toggle" onclick="toggleDropdown('notificationDropdown')"><i class="bi bi-bell " id="hdicon"></i>알림</a>
            <div id="notificationDropdown" class="dropdown-content">
            </div>

            <a href="#" class="dropdown-toggle" onclick="toggleDropdown('messageDropdown')"><i class="bi bi-envelope-plus" id="hdicon"></i>쪽지</a>
            <div id="messageDropdown" class="dropdown-content">
                <a href="/message/list/inbox">쪽지함</a>
                <a href="/address">주소록</a>
            </div>

            <a href="#" class="dropdown-toggle"  id="pro" onclick="toggleDropdown('profileDropdown')"><img class="rounded-circle "
						img src="${userInfo.empProfile != null ? userInfo.empProfile : '/img/default-profile.png'}"
						alt="User Profile"
						style="width: 50px; height: 50px; border-radius: 50% !important;">
						<span class="d-none d-lg-inline-flex">
						<%-- ${userInfo.empName != null ? userInfo.empName : 'Guest'} --%></a>
            <div id="profileDropdown" class="dropdown-content">
                <a href="/main/profile">내 프로필</a>
                <form id="logoutForm" action="/logout" method="post">
                     <button type="submit" class="dropdown-item logOut">로그아웃</button>
                  </form>
                
               
            </div>
        </div>
    </div>
    <!-- 사이드바 -->
    <div id="mySidebar" class="sidebar">
        <!-- #### 직원 메뉴 #### -->
        <div id="empSidebar">   
        <div class="sideMenu">
            
            <a href="#" class="submenu-toggle workMenu"> 
                <span class="menu-icon "  onclick="location.href='/work/workDash'"><i class="bi bi-person-workspace workMenu"></i></span>
                <span class="menu-text ">업무 관리</span>
            </a>
            <div class="sub-menu workSubMenu">
                <a href="#"onclick="window.open('http://localhost:7921/gantt','new','scrollbars=yes, resizable=no width=1700 height=900,top=40',left=200 );return false">프로젝트 진행상황</a>
                <a href="/work/projWorkspace" class="workList">업무리스트</a>
                <a href="/file/storage" class="fileStorage">파일함</a>
                <a href="/todo/list" class="workMemo">업무메모함</a>
            </div>
        </div>
       <div class="sideMenu">
        <a href="#" class="submenu-toggle contractSide"> 
            <span class="menu-icon" onclick="location.href='/contract/list'"><i
                class="bi bi-file-earmark-check"></i></span>
            <span class="menu-text">계약 관리</span>
        </a>
       
        <div class="sub-menu contractSub">
            <a href="/contract/list" class="contListSub">계약서 목록</a>
            <a href="/contract/create" class="contCreSub">계약서 작성</a>
            <a href="/taxin/list" class="taxinSub">세금계산서 관리</a>
        </div>
       </div>
      <div class="sideMenu">
		    <a href="#" class="submenu-toggle"> 
		        <span class="menu-icon" onclick="location.href='/cash/cashList'">
		            <i class="bi bi-graph-down"></i>
		        </span>
		        <span class="menu-text">매출 관리</span>
		    </a>
		    <div class="sub-menu">
		        <a href="/cash/cashList">매출 관리</a>
		        <a href="/cash/cashAnaly">매출 통계</a>
		    </div>
		</div>														
        <div class="sideMenu">
        <a href="#" class="submenu-toggle"> 
            <span class="menu-icon" onclick="location.href='/business/custManage'"><i class="bi bi-luggage-fill"></i></span>
            <span class="menu-text">영업 관리</span>
        </a>
        <div class="sub-menu">
         <a href="/business/custManage">고객 정보</a>
            <a href="/business/infoList">영업 활동</a>
            <a href="/business/busStat">영업 실적</a>
        </div>
        </div>
        <div class="sideMenu">

            <a href="#" class="submenu-toggle"> 
                <span class="menu-icon" onclick="location.href='/memberSign/signHome'"><i
                    class="bi bi-clipboard-check"></i></span>
                    <span class="menu-text">전자결재</span>
                </a>
                <div class="sub-menu">
                    <a href="/memberSign/create">기안서 작성</a>
                    <a href="/memberSign/signList">결재 대기/요청함</a>
                    <a href="/memberSign/end">결재 종결/반려함</a>
                    <a href="/memberSign/reading">결재 참조함</a>
                    <a href="/memberSign/department">부서문서함</a>
                </div>
            </div>
            <div class="sideMenu">
                <a href="#" class="submenu-toggle"> 
                    <span class="menu-icon" onclick="location.href='/board/'"><i class="bi bi-people"></i></span>
                    <span class="menu-text" >게시판</span>
                </a>
                <div class="sub-menu">
                    <a href="/board/">일반 게시판</a>
                    <a href="/community/list" >자유 게시판</a>
                </div>
            </div>
            <div class="sideMenu">

                <a href="/community/club/list" class="submenu-toggle"> 
                    <span class="menu-icon"><i class="bi bi-chat-left-quote"></i></span>
                        <span class="menu-text">동호회</span>
                    </a>
                </div>
            <div class="sideMenu">

                <a href="#" class="submenu-toggle"> 
                    <span class="menu-icon" onclick="location.href='/att/attManager'"><i
                        class="bi bi-clock" ></i> </span>
                        <span class="menu-text" onclick="">근태 관리</span>
                    </a>
                    <div class="sub-menu">
                        <a href="/att/attManager">근태 관리</a>
                        <a href="/att/commuteList">출퇴근 내역</a>
                        <a href="/att/annualList">연차 및 휴가 관리</a>
                    </div>
                </div>
<!--                 <div class="sideMenu"> -->

<!--                     <a href="/schedule/cabinetReservation" class="submenu-toggle">  -->
<!--                         <span class="menu-icon"><i class="bi bi-bank"></i></span> -->
<!--                         <span class="menu-text">회의실 예약</span> -->
<!--                     </a> -->
<!--                     <div class="sub-menu"> -->
<!--                     </div> -->
<!--                 </div> -->
            </div>     
        <!-- #### 관리자 메뉴 #### -->
            
        </div>
    </div>

    <!-- 바깥 배경(overlay) -->
    <div id="myOverlay" class="overlay" onclick=""></div>

    <!-- 메뉴 버튼 -->
    <button class="menu-btn" onclick=""><i class="bi bi-grid-fill"></i></button>

    <!-- 메인 콘텐츠 -->
       <!-- 메인 콘텐츠 -->
    <div class="content">
        
        <!-- 다른 페이지 내용들 들어갈거임  -->
   
   
   <script type="text/javascript">
   
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
    
    
   
   </script>     
