<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
.hdmnul{
display: flex;
list-style: none;
}
.hdmnul> li{
margin:10px;
}


</style>
<body>
<div class="headerCon">
   <header>
   <div class="hdflex">
      <a href="/main"><h1 class="text-primary">NOSLEEP</h1></a>
      <!-- <ul class="hdmnul">
      	<li class="">ㄹㄹ</li>
      	<li class="">ㄹㄹ</li>
      	<li class="">ㄹㄹ</li>
      	<li class="">ㄹㅇㄹ</li>
      </ul> -->
       </div>
      <div class="header-icons">
         <div class="options">
            <a href="/mail" id="mail-menu"><i class="bi bi-envelope"></i>
               메일</a>
            <!--             <a href="login" class="dropdown-item">Log Out</a> -->
            <div class="nav-item dropdown">
               <a href="#" class="nav-link dropdown-toggle"
                  data-bs-toggle="dropdown"> <i class="fa fa-bell me-lg-2"></i>
                  <span class="d-none d-lg-inline-flex">Notificatin</span>
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
                  <a href="main/profile" class="dropdown-item">My Profile</a> <a href="#"
                     class="dropdown-item">Settings</a>
                  <form action="/logout" method="post">
                     <button type="submit" class="dropdown-item">Log Out</button>
                  </form>
               </div>
            </div>
         </div>
        
   </header>
   <div class="header-md">
   
   </div>
</div>
<!-- <li class="is-depth3">
        <a href="/kr/ecount/product/production_bill-of-material-software" title="생산/제조">생산/제조</a>
        <ul class="depth3">
          <li><a href="/kr/ecount/product/production_overview" title="이카운트 생산관리 특징">이카운트 생산관리 특징</a></li>
          <li><a href="/kr/ecount/product/production_bill-of-material-software" title="BOM(소요량)">BOM(소요량)</a></li>
          <li><a href="/kr/ecount/product/production_master-production-schedule" title="기준생산계획(MPS)">기준생산계획(MPS)</a></li>
          <li><a href="/kr/ecount/product/production_process-management" title="공정흐름관리">공정흐름관리</a></li>
          
          <li><a href="/kr/ecount/product/production_cost-management" title="원가관리">원가관리</a></li>
          <li><a href="/kr/ecount/product/production_workorder-software" title="작업지시서">작업지시서</a></li>
          <li><a href="/kr/ecount/product/production_quality-control-management" title="품질관리(QC)">품질관리(QC)</a></li>
          
        </ul>
      </li> -->
   <!-- 사이드바 영역 -->
   <div class="main-content">
      <nav class="wgsidebar">
         <ul>
            <li class="menu-item" id="schedule-menu">
            <i class="bi bi-calendar-check"></i> 일정
            <ul class="depth3">
	          <li><a href="#" class="sdmenu">회의실 예약</a>
	          		<a href="#">내 일정 관리</a>
	          </li>
        </ul>
            
            <li class="menu-item" id="attendance-menu"><i
               class="bi bi-clock"></i> 근태
              <ul class="depth3">
	          <li><a href="#"  class="sdmenu" >근태 관리</a>
	          		<a href="#">출퇴근 내역</a>
	          </li>
	          <li><a href="#" >연차 및 휴가 관리</a>
	          <a href="#">근태 신청현황</a></li>
	          
	          <li><a href="#">근무 리포트</a>
	          </li>
        </ul>
               </li>
           <li class="menu-item" id="pro-menu"><i class="bi bi-person-circle"></i> 업무
            <ul class="depth3">
	          <li><a href="#" >업무 관리</a>
	          		<a href="#">업무진행현황</a>
	          </li>
        </ul>
           </li>
            <li class="menu-item" id="price-menu"><i
               class="bi bi-clipboard-check"></i> 결재
                <ul class="depth3">
	          <li>
	          <a href="#" class="sdmenu" >기안서 작성</a>
	          		<a href="#">결재 대기</a>
	          </li>
	          <li>
	          <a href="#" >결재요청</a>
	          <a href="#">기안함</a>
	          </li>
	          <li>
	          <a href="#" >종결</a>
	          <a href="#">회수</a>
	          </li>
	          <li>
	          <a href="#" >임시저장</a>
	          <a href="#">결재함</a>
	          </li>
	          <li>
	          <a href="#" >미결</a>
	          <a href="#">열람/공람</a>
	          </li>
	          <li>
	          <a href="#" >부서문서함</a>
	          <a href="#">문서관리</a>
	          </li>
	          <li>
	          <a href="#" >미결</a>
	          <a href="#">승인</a></li>
	          </li>
	          <li>
	          
        </ul>
               </li>
            <li class="menu-item" id="contract-menu"><i
               class="bi bi-file-earmark-check"></i>계약
                <ul class="depth3">
                  <li>
                  <a href="#" class="sdmenu">계약등록</a>
	          		<a href="#">계약 관리</a>
	          </li>
	          <li>
	          			<a href="#">계약 모니터링 / 분석</a>
	          <a href="#" >계산서 관리</a>
	          </li>
	          
        </ul>
               </li>
            <li class="menu-item" id="cash-menu"><i
               class="bi bi-wallet-fill"></i> 매출
                <ul class="depth3">
	          <li><a href="#" >매출 정보</a>
	          		<a href="#">입금 / 지출 관리</a>
	          </li>
	          <li><a href="#" >매출 통계 / 분석</a>
	          </li>
        </ul>
               </li>
            <li class="menu-item" id="business-menu"><i class="bi bi-cash"></i>
               영업
                 <ul class="depth3">
	          <li><a href="#" >고객 정보</a>
	          		<a href="#">영업 관리</a>
	          </li>
	          <li><a href="#" >영업 통계</a>
	          </li>
        </ul>
               </li>
            <li class="menu-item" id="mail-menu"><i class="bi bi-envelope"></i>
               메일</li>
            <li class="menu-item" id="edu-menu"><i
               class="bi bi-chat-left-dots"></i> 소통
                 <ul class="depth3">
	          <li><a href="#" class="sdmenu">게시판</a>
	          		<a href="#" class="sdmenu">커뮤니티</a>
	          </li>
	          <li><a href="#" >공지사항</a>
	          		<a href="#">만남의 광장</a>
	          </li>
	          <li>
	          <a href="#" >부서 게시판</a>
	          <a href="#" >일반</a>
	          </li>
	          <li>
	          <a href="#" >Q & A</a>
	          </li>
        </ul>
               </li>
                      <!--   <a href="#"><button class="blue-btn" id="compose-btn">조직도</button></a> -->
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
<<!-- div class="sidecontainer">
      일정
      <div class="schedule-sidebar" id="schedule-sidebar">
         <div class="schedule-buttons">
            <a href="/schedule/cabinetReservation">
               <button class="white-btn">회의실 예약</button>
            </a>
         </div>
         <div class="horizontal-line"></div>
         <button
            onclick="window.open('http://localhost:7921/schedule','_blank')"
            class="white-btn" id="my-schedule">내일정관리</button>
                  <div class="submenu" id="my-list"
                     style="display: none; padding-left: 20px;">
                     <a href="#">팀 일정</a><br>
                     <a href="#">부서 회의록</a><br>
                     <a href="#">부서 휴가 현황</a>
                  </div>

         <a href="/schedule/scheduleTask"><button class="white-btn">업무
               관리</button></a> <a href="/schedule/scheduleTaskPercent"><button
               class="white-btn">업무진행현황</button></a>
      </div>



      고객
            <div class="prod-sidebar" id="prod-sidebar">
               <div class="prod-buttons">
                  <button class="blue-btn" id="compose-btn">고객관리</button>
               </div>
               <div class="horizontal-line"></div>

               <button class="white-btn">내 고객정보</button>
               <button class="white-btn">SMS발송</button>
               <button class="white-btn">고객 문의함</button>
            </div>

      영업
      <div class="business-sidebar sidefixed" id="business-sidebar">
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

      계약
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
         <button class="white-btn" onclick="location.href='/expdit/list'">입금
            / 지출 관리</button>
         <button class="white-btn"><a href="#">견적서 관리</a></button>
         <button class="white-btn" onclick="location.href='/conimpl/gant'">계약
            이행 모니터링</button>
         <button class="white-btn" onclick="location.href='/conimpl/gant'">리포트
            및 분석</button>
      </div>

      매출
		<div class="cash-sidebar" id="cash-sidebar">
			<button class="white-btn" onclick="location.href='/cash/cashList'">매출 정보</button>
			<button class="white-btn" onclick="location.href='/cash/budgetList'">입금 / 지출 관리</button>
			<button class="white-btn" onclick="location.href='/cash/cashAnaly'">매출 통계 / 분석</button>
		</div>

      근태
      <div class="attendance-sidebar" id="attendance-sidebar">
         <div class="attendance-buttons">
            <a href="/att/attManager"><button class="blue-btn" id="compose-btn">근태 관리</button></a>
         </div>
         <button onclick="location.href='/att/commuteList'" class="white-btn">출퇴근 내역</button>
         <div class="horizontal-line"></div>
         
         <button onclick="location.href='/att/documentattList'" class="white-btn" id="my-att">연차 및 휴가 관리</button>
         <div class="submenu" id="my-attlist"
            style="display: none; padding-left: 20px;">
            <a href="/att/documentattList">내 근태 현황</a><br>
         </div>
         
         <button onclick="location.href='/att/attAppliSituation'" class="white-btn" id="my-att2">근태 신청현황</button>
         <button onclick="location.href='/att/workReport'" class="white-btn" id="my-att2">근무 리포트</button>
         <div class="submenu" id="my-attlist2"
            style="display: none; padding-left: 20px;">
            <a href="/att/attAppliSituation">근태 신청 현황</a><br>
            <a href="/att/workReport">근무 리포트</a><br>
            <a href="/att/vacationList">휴가 내역</a><br>
         </div>
      </div>

      소통
      <div class="edu-sidebar" id="edu-sidebar">
         <div class="edu-buttons" onclick="location.href='/board/'">
            <button class="blue-btn" id="compose-btn">게시판</button>
         </div>
         <button class="white-btn" onclick="location.href='/board/list?bodType=1'">공지사항</button>
         <button class="white-btn" onclick="location.href='/board/list?bodType=2'">부서게시판</button>
         <button class="white-btn" onclick="location.href='/board/list?bodType=3'">Q&A</button>
         <div class="horizontal-line"></div>
         <button class="blue-btn" id="compose-btn">커뮤니티</button>
         <button class="white-btn" onclick="location.href='/community/club/'">만남의 광장</button>
         <button class="white-btn" onclick="location.href='/community/list'">일반</button>
      </div>

      <!--프로필 
 	 <div class="pro-sidebar" id="pro-sidebar"> 
         <div class="pro-buttons">
            <button class="blue-btn" id="compose-btn">프로필관리</button>
         </div>
         <button class="white-btn" onclick="location.href='/board/list?bodType=1'">공지사항</button>
         <button class="white-btn" onclick="location.href='/board/list?bodType=2'">부서게시판</button>
      </div> 

      결재
      <div class="price-sidebar" id="price-sidebar">
         <div class="price-buttons">
            <button class="blue-btn" id="compose-btn">기안작성</button>
            <button class="white-btn">받은메일</button>
         </div>
         <div class="horizontal-line"></div>
         <button class="white-btn">결재 대기</button>
         <button class="white-btn">결재 요청</button>
         <div class="horizontal-line"></div>
         <button class="white-btn">기안함</button>
         <button class="white-btn">종결</button>
         <button class="white-btn">회수</button>
         <div class="horizontal-line"></div>
         <button class="white-btn">임시저장</button>
         <button class="white-btn">결재함</button>
         <button class="white-btn">미결</button>
         <div class="horizontal-line"></div>
         <button class="white-btn">열람/공람</button>
         <button class="white-btn">부서문서함</button>
         <button class="white-btn">문서관리</button>
         <button class="white-btn">미결</button>
         <button class="white-btn">승인</button>
         <div class="horizontal-line"></div>
      </div>
      </div> -->
      <!--세부 사이드바 영역 종료-->
      <!-- 메인 컨텐츠 영역 -->
      <div class="content-area">

         <script>
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
   document.getElementById('schedule-menu').addEventListener('click', function() {
       closeAllSidebars();
       document.getElementById('schedule-sidebar').classList.toggle('visible');
   });


   // 고객 사이드바 토글
//    document.getElementById('prod-menu').addEventListener('click', function() {
//        closeAllSidebars();
//        document.getElementById('prod-sidebar').classList.toggle('visible');
//    });

   // 영업 사이드바 토글
   document.getElementById('business-menu').addEventListener('click', function() {
       closeAllSidebars();
       document.getElementById('business-sidebar').classList.toggle('visible');
   });

   // 계약 사이드바 토글
   document.getElementById('contract-menu').addEventListener('click', function() {
       closeAllSidebars();
       document.getElementById('contract-sidebar').classList.toggle('visible');
   });

   // 매출 사이드바 토글
   document.getElementById('cash-menu').addEventListener('click', function() {
       closeAllSidebars();
       document.getElementById('cash-sidebar').classList.toggle('visible');
   });

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