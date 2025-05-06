<%@page import="java.util.Locale"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page import="java.util.Calendar" %>
<%
    Calendar cal = Calendar.getInstance();
    request.setAttribute("year", cal.get(Calendar.YEAR));
    request.setAttribute("month", cal.get(Calendar.MONTH)); // 0: 1월, 1: 2월, ..., 11: 12월
%>
<!-- 라이브러리 include  -->
   <jsp:include page="./include/library.jsp"></jsp:include>
<!-- 라이브러리 include  -->

<!-- 여기 style css 들어가야해요  -->
<style>

#mothlySalesChart {
   width:520px !important;
   height:270px !important;
}
 /* Quickmenu 스타일 추가 */
        .quickmenu {
            position: fixed;
            top: 450px;
            right: 10px;
            z-index: 1000;
            background-color: #f8f8f8;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 100px;
        }
        .quickmenu ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .quickmenu ul li {
            margin-bottom: 10px;
        }
        .quickmenu ul li a {
            text-decoration: none;
            color: #007bff;
        }
        .quickmenu ul li a:hover {
            text-decoration: underline;
        }
        /* 퀵메뉴 끝*/
.mainContainer{ 
height: 100vh; 
display: flex;
}
.firstBox{
height: 100vh;
display: flex;
    background-color: white !important;
width: 20%;
    flex-direction: column;
    box-shadow:none !important;
box-sizing: border-box;

}
.proFile{
height: 43vh;
background-color: #009CFF !important;
flex-basis: auto; /* 자식 요소의 기본 너비 설정 */
margin:20px;
 border-radius: 10px;
  box-shadow: 0 2px 10px rgb(0 0 0 / 70%);
   justify-content: center;
   justify-items: center;
}
.attendance{
 border-radius: 10px;
height: 47vh;
background-color: white;
flex-basis: auto; /* 자식 요소의 기본 너비 설정 */
margin:20px;
margin-top:0 !important;
 box-shadow:0 2px 10px rgb(0 0 0 / 70%);
}

.notice{
    width: 98%;
    display: flex
;
    height: 17vh;
    background-color: white;
    margin-left: 10px;
    text-align: center;
    margin: 0 auto;
    border-radius: 10px;
    margin: 15px;
     box-shadow:0 2px 10px rgb(0 0 0 / 70%);

}
.secondBox{
flex-basis: auto;
display: flex;
height: 20vh;
width: 100%;


}
.thirdBox {
  display: flex;          /* Flexbox를 사용하여 레이아웃 설정 */
  flex-wrap: wrap;        /* 자식 요소가 넘칠 경우, 자동으로 줄 바꿈 */
  gap: 20px;  
  width: 98%;            /* 각 박스 간 간격을 설정 */
margin:0 auto;
height: 76vh;
    row-gap: 10px !important;

}

.groupBox {
  width: calc(50% - 10px); /* 각 박스의 너비를 50%로 설정하고, 간격을 고려 */
  height: 100px;           /* 높이를 임의로 설정 */
  background-color:white;
  color: black;
  text-align: center;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 5px;
  height: 46%;
  margin-top:1%;
  box-shadow: 0 2px 10px rgb(0 0 0 / 70%);
  border-radius: 10px;
}
.secondContainer{
width: 80%;

}
.content-area{

background-color: #d0d4db;
}
h3{
font-weight: normal !important;
text-align: center;
padding:10px;
}

.imgProfile{
      border-radius: 50%;
      height : 150px;
      width: 150px;
      margin-top : 10px;
      justify-content: center;
      justify-items :center;
   }
   #proFileImg{
      width: 140px;
      height : 140px;
      border-radius: 20px;
      margin: 5px;
      justify-content: center;
      justify-items :center;
   
   }
   #currentTime{
      width: 230px;
      color: white;
   }
   
   .firstBox {
      justify-content: center;
      justify-items :center;
      width: 20%;
      height: 90%;
      background-color: #009CFF;
      padding: 5px;
      box-shadow: 2px 0 5px rgba(0,0,0,0.7);
      border-radius: 8px;
   }
   .actions{
      display: flex;
      margin : 10px;
      justify-content:center;
   }
   
   .white-btn{
      margin :10px;
   }
   #monthlySalesChart {
      width: 650px !important;
      height: 300px !important;
   }
   .notice {
    width: 98%;
    background-color: white;
    margin: 15px auto;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgb(0 0 0 / 70%);
    padding: 10px;
    overflow: auto;
}

.notice table {
    width: 90%;
    border-collapse: collapse;
}

.notice table th,
.notice table td {
    padding: 8px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

.notice .badge {
    padding: 0.4em 0.8em;
    border-radius: 4px;
}

.notice table tr:hover {
    background-color: #f5f5f5;
}

.sign {
    width: 100%;
    background-color: white;
    margin: 15px auto;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgb(0 0 0 / 70%);
    padding: 10px;
    height: 100%;
    overflow: auto;
}

.sign table {
    width: 90%;
    border-collapse: collapse;
}

.sign table th,
.sign table td {
    padding: 7px;
    text-align: center;
    border-bottom: 1px solid #ddd;
}

.sign .badge {
    padding: 0.4em 0.8em;
    border-radius: 4px;
}

.sign table tr:hover {
    background-color: #f5f5f5;
}


.groupBox2{
width: calc(50% - 10px); /* 각 박스의 너비를 50%로 설정하고, 간격을 고려 */
  height: 100px;           /* 높이를 임의로 설정 */
  background-color:white;
  color: black;
  text-align: center;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 5px;
  height: 46%;
  margin-top:1%;
  box-shadow: 0 2px 10px rgb(0 0 0 / 70%);
  border-radius: 10px;
}


.calendar-container {
    width: 500px;
    height: 300px;
}

.cal_month {
    text-align: center;
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 15px;
}

.cal_month a {
    text-decoration: none;
    font-size: 22px;
    color: #333;
}

.tt-calendar {
    width: 100%;
    border-collapse: collapse;
}

.tt-calendar th, 
.tt-calendar td {
    width: 14.28%;
    height: 40px;
    text-align: center;
    font-size: 16px;
    border: 1px solid #ddd;
}

.tt-calendar thead th {
    background-color: #3676EB;
    color: white;
    font-weight: bold;
}

.tt-calendar tbody td {
    background-color: white;
}

.tt-calendar tbody td:hover {
    background-color: #009CFF;
    cursor: pointer;
}

.cal_day_sunday {
    color: red;
    font-weight: bold;
}

.today {
    background-color: #ffeb3b !important;
    font-weight: bold;
}

.bluBt{
background-color: #3676EB;
color:white;
outline: none;
border:none;
width: 130px;
height:36px; 
border-radius: 5px;
margin: 5px;

}

.greenBt{
background-color: #278986 !important;
color:white;
outline: none;
border:none;
width: 130px;
height:36px; 
border-radius: 5px;
margin: 5px;
}
</style>


<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<!-- 여기 style css 들어가야해요  -->

<!-- 헤더 include  -->
   <jsp:include page="./include/header.jsp"></jsp:include>
<!-- 헤더 include  -->

<!-- 여기 내용 들어가야해요  -->

<sec:authorize access="isAuthenticated()">
<%--    <p><sec:authentication property="principal.member"/></p> --%>
   <sec:authentication property="principal.member" var="userInfo" />
</sec:authorize>
 <div class="quickmenu">
        <ul>
            <li><a href="/message/list/inbox">쪽지함</a></li>
            <li><a href="/address">메신저</a></li>
        </ul>
    </div>
   <div class="mainContainer">
         <div class="firstBox">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <div class="proFile">
            <h3>프로필</h3>
                  <img id="proFileImg" src="${userInfo.empProfile}" alt="profile Image">
               <c:if test="${userInfo != null}">
                  <h5>${getUser.deptName}</h5>
                  <h4>${userInfo.empName} ${userInfo.postName}</h4>
               </c:if>
            </div>
           <div class="attendance">
               <div class="actions">
               <form id="checkInForm" action="/att/MaincheckIn" method="post">
               <c:if test="${userInfo != null}">
                  <input type="hidden" name="empNo" value="${userInfo.empNo}">
                  <button type="submit" id="checkInButton" class="greenBt conbtn">출근하기</button>
               </c:if>
               </form>
               <form id="checkOutForm" action="/att/MaincheckOut" method="post">
               <c:if test="${userInfo != null}">
                  <input type="hidden" name="empNo" value="${userInfo.empNo}">
                  <button type="submit" id= "checkOutButton" class="bluBt conbtn">퇴근하기</button>
               </c:if>
               </form>
               </div>
               <div>
                  <div class="dateFlex">
                      <div class="tododate">
                       <span id="current-date">
                              <%
                           // 서버에서 현재 날짜 출력
                           Date currentDate = new Date();
                           SimpleDateFormat formatter = new SimpleDateFormat("EEEE dd MMMM yyyy", Locale.KOREA);
                           String formattedDate = formatter.format(currentDate);
                           out.println(formattedDate);
                           %>
                       </span>
                   </div>
                   <div class="todotime">
                       <span id="current-time">
                           <%
                           // 서버에서 현재 시간 출력
                           SimpleDateFormat formatter2 = new SimpleDateFormat("HH:mm:ss", Locale.ENGLISH);
                           String formattedDate2 = formatter2.format(currentDate);
                           out.println(formattedDate2);
                           %>
                       </span>
                   </div>
         </div>
               <input type="text" id="workTime" name = "workTime" value="" readonly style="display: none;">
               
               <div class="progress" style="height: 30px;">
                   <div id="progressBar" class="progress-bar bg-success" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                 </div>
            </div>
           <!-- 경과 시간 표시 -->
           <div id="progressText" class="mt-2" style="font-size: 1.2rem;">근무시간: 00:00</div>
            </div>
         </div>
      <div class="secondContainer">
      <div class="secondBox">
         <div class="notice">
                <h3>공지사항</h3> 
                <table>
                    <thead>
                        <tr>
                            <th width="10%">구분</th>
                            <th width="30%">제목</th>
                            <th width="15%">작성자</th>
                            <th width="15%">작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="boardVO" items="${noticeList}" varStatus="status">
                            <c:if test="${status.index < 3}">
                                <tr>
                                    <td>
                                        <c:choose>
                                            <c:when test="${boardVO.noticeType == 1}">
                                                <span class="badge bg-danger text-white">긴급</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-primary text-white">공지</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="/board/detail/${boardVO.bodNo}" class="text-reset">
                                            ${boardVO.bodTitle}
                                        </a>
                                    </td>
                                    <td>${boardVO.bodWriter}</td>
                                    <td><fmt:formatDate value="${boardVO.bodCreDate}" pattern="yyyy-MM-dd"/></td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
      
      </div>
      
      
      <div class="thirdBox">
         <div class="groupBox">
                  <div class="sign">
                   <h5><a href="/sign/signList">요청함</a></h5>
                      <table>
                          <thead>
                              <tr>
                                  <th width="10%">번호</th>
                                  <th width="25%">제목</th>
                                  <th width="10%">기안자</th>
                                  <th width="10%">부서</th>
                                  <th width="25%">기안일</th>
                              </tr>
                          </thead>
                          <tbody>
                              <c:forEach var="signVO" items="${signVOList}" varStatus="stat">
                                  <tr>
                                      <td style="color=black;">${signVO.rnum}</td>
                                      <td><a href="/sign/detail?appGroupCode=${signVO.appGroupCode}">${signVO.docTitle}</a></td>
                                      <td>${signVO.originalEmpName}</td>
                                      <td>${signVO.originalDeptName}</td>
                                      <td>${signVO.writeDate}</td>
                                  </tr>
                              </c:forEach>
                          </tbody>
                      </table>
                </div>
             </div> 
             
             
         <div class="groupBox">
            <h3>내 업무 / 진행중 프로젝트 </h3>
         </div>
         <div class="groupBox2">
				<!-- 달력 -->
		<div class="box_aside">
			    <div class="calendar-container">
			        <div class="cal_month">
			            <a href="#" id="prevMonth">&#9665;</a>
			            <span id="currentMonth">\${year}년 \${month+ 1}월</span>
			            <a href="#" id="nextMonth">&#9655;</a>
			        </div>
			        <table class="tt-calendar">
			            <thead>
			                <tr>
			                    <th class="tit_week">일</th>
			                    <th class="tit_week">월</th>
			                    <th class="tit_week">화</th>
			                    <th class="tit_week">수</th>
			                    <th class="tit_week">목</th>
			                    <th class="tit_week">금</th>
			                    <th class="tit_week">토</th>
			                </tr>
			            </thead>
			            <tbody id="calendar-body">
			                <!-- JavaScript가 날짜를 채울 예정 -->
			            </tbody>
			        </table>
			    </div>
			</div>
         </div>
         
         
         <div class="groupBox">
<!--              <h3>내 매출 (그래프)</h3> -->
<!--              <div class="stats-dashboard"> -->
                 <!-- 레이더 차트 섹션 -->
                 <canvas id="monthlySalesChart"></canvas>
         
             </div>
         </div>      
      
     
      </div>
      </div>
      
   </div>

<!--    <script src="/dsah/js/Quick.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="/dash/lib/easing/easing.min.js"></script>
<!-- <script src="/dash/lib/waypoints/waypoints.min.js"></script> -->
<!-- <script src="/dash/lib/owlcarousel/owl.carousel.min.js"></script> -->
<script src="/dash/lib/tempusdominus/js/moment.min.js"></script>
<!-- <script src="/dash/lib/tempusdominus/js/moment-timezone.min.js"></script> -->
<!-- <script -->
<!--    src="/dash/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script> -->
<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
<!-- Template Javascript -->

<script src="/dash/js/main.js"></script>
   <!-- JavaScript Libraries -->
    <script>
    
    document.addEventListener("DOMContentLoaded", function() {
        let currentYear = ${year};
        let currentMonth = ${month}; // 0부터 시작하는 월 (1월=0, 2월=1)

        function generateCalendar(year, month) {
            const calendarBody = document.getElementById("calendar-body");
            const monthText = document.getElementById("currentMonth");

            // 월 표시 (YYYY년 MM월 형식)
            monthText.textContent = `\${year}년 \${month + 1}월`;

            calendarBody.innerHTML = ""; // 기존 내용 초기화

            const firstDay = new Date(year, month, 1).getDay(); // 첫 요일
            const lastDate = new Date(year, month + 1, 0).getDate(); // 마지막 날짜

            let row = document.createElement("tr");
            let cellCount = 0;

            // 첫 주 빈 칸 채우기
            for (let i = 0; i < firstDay; i++) {
                let emptyCell = document.createElement("td");
                row.appendChild(emptyCell);
                cellCount++;
            }

            // 날짜 채우기
            for (let date = 1; date <= lastDate; date++) {
                let cell = document.createElement("td");
                cell.textContent = date;
                cell.classList.add("col_day");

                // 오늘 날짜 강조
                let today = new Date();
                if (year === today.getFullYear() && month === today.getMonth() && date === today.getDate()) {
                    cell.style.fontWeight = "bold";
                    cell.style.backgroundColor = "#009CFF"; // 노란색 배경
                }

                // 일요일 색상 추가
                if (cellCount % 7 === 0) {
                    cell.classList.add("cal_day_sunday");
                }

                row.appendChild(cell);
                cellCount++;

                // 한 줄(일주일)이 끝나면 새로운 행 추가
                if (cellCount % 7 === 0) {
                    calendarBody.appendChild(row);
                    row = document.createElement("tr");
                }
            }

            // 마지막 주 빈 칸 채우기
            while (cellCount % 7 !== 0) {
                let emptyCell = document.createElement("td");
                row.appendChild(emptyCell);
                cellCount++;
            }

            // 마지막 행 추가
            calendarBody.appendChild(row);
        }

        // 이전/다음 달 이동 기능
        document.getElementById("prevMonth").addEventListener("click", function(e) {
            e.preventDefault();
            currentMonth--;
            if (currentMonth < 0) {
                currentMonth = 11;
                currentYear--;
            }
            generateCalendar(currentYear, currentMonth);
        });

        document.getElementById("nextMonth").addEventListener("click", function(e) {
            e.preventDefault();
            currentMonth++;
            if (currentMonth > 11) {
                currentMonth = 0;
                currentYear++;
            }
            generateCalendar(currentYear, currentMonth);
        });

        // 현재 월의 달력 표시
        generateCalendar(currentYear, currentMonth);
    });
    
    
    $(document).ready(function() {
       
      // 더미 데이터 예시 (막대 그래프 + 선 그래프 혼합)
       const ctx = document.getElementById('monthlySalesChart').getContext('2d');

       const monthlySalesChart = new Chart(ctx, {
           type: 'bar', // 기본 차트는 막대 그래프
           data: {
               labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], // 월별
               datasets: [
                   {
                       label: '매출',
                       data: [220010, 252000, 130400, 170020, 160500, 190500, 221000, 250010, 271000, 249000, 300200, 220400], // 매출 데이터
                       backgroundColor: 'rgba(54, 162, 235, 0.2)', // 막대 그래프 색상
                       borderColor: 'rgba(54, 162, 235, 1)', // 막대 그래프 경계 색상
                       borderWidth: 1,
                       yAxisID: 'y', // 기본 Y축 사용
                       type: 'bar', // 막대 그래프
                   },
                   {
                       label: '예상 매출',
                       data: [200030, 240002, 120100, 162000, 150010, 180100, 210900, 240500, 260020, 281000, 292000, 310010], // 예상 매출 데이터
                       backgroundColor: 'rgba(255, 99, 132, 0.2)', // 선 그래프 색상
                       borderColor: 'rgba(255, 99, 132, 1)', // 선 그래프 경계 색상
                       borderWidth: 2,
                       fill: false, // 선 그래프는 채우지 않음
                       tension: 0.1, // 선의 굴곡 정도
                       yAxisID: 'y', // 기본 Y축 사용
                       type: 'line', // 선 그래프
                   }
               ]
           },
           options: {
               responsive: true,
               plugins: {
                   legend: {
                       position: 'top',
                   },
                   tooltip: {
                       mode: 'index',
                       intersect: false,
                   }
               },
               scales: {
                   y: {
                       beginAtZero: true,
                       ticks: {
                           stepSize: 5000,
                       }
                   }
               }
           }
       });

          
    });
    
    
    $(document).ready(function(){
        var currentPosition = parseInt($(".quickmenu").css("top"));
        $(window).scroll(function() {
            var position = $(window).scrollTop(); 
            $(".quickmenu").stop().animate({"top":position+currentPosition+"px"},1000);
        });
    });
    
    let startTime = null;
    let workTimer = null;
    let totalWorkTimeInSeconds = 9 * 3600;

    let progressBar = document.getElementById('progressBar');
    let progressText = document.getElementById('progressText');

    function updateClock(serverTime){
       
       // 서버에서 전달된 시간을 Date 객체로 변환
       let serverDate = new Date(serverTime);
       
       setInterval(function(){
          serverDate.setSeconds(serverDate.getSeconds() +1);
          
          const year = serverDate.getFullYear();
          const month = String(serverDate.getMonth() +1).padStart(2,'0');
          const day = String(serverDate.getDate()).padStart(2,'0');
          const hours = String(serverDate.getHours()).padStart(2,'0');
          const minutes = String(serverDate.getMinutes()).padStart(2, '0');
          const seconds = String(serverDate.getSeconds()).padStart(2, '0');
          
          // 요일 규하기 (0: 일요일, 6: 토요일)
          const daysOfWeek = ['일','월','화','수','목','금','토'];
          const weekday = daysOfWeek[serverDate.getDay()];
          
          const formattedTime = `\${year}년\${month}월\${day}일 (\${weekday}) \${hours}:\${minutes}:\${seconds}`;
          document.getElementById('currentTime').textContent = formattedTime;
       },1000); // 1초마다 갱신
    }
    window.onload = function(){
       const serverTime = '${dTime}';
       updateClock(serverTime);
    };



    $(document).ready(function(){
       const empNoInput = $("input[name='empNo']");
       const checkInButton = $("#checkInButton");
       
       
       function checkEmployeeStatus(empNo){
          return $.ajax({
             url:`/att/checkStatus?empNo=\${empNo}`,
             type: "GET",
          });
       }
       
       function processCheckIn(empNo){
          let formData = new FormData();
          formData.append("empNo",empNo);
          
          return $.ajax({
             url: '/att/checkIn',
             processData : false,
             contentType: false,
             data : formData,
             type: 'POST',
          });
       }
       
       // 출근 상태 확인 및 초기화
       function initializeCheckIn(){
          let empNo = empNoInput.val();
          
          if(!empNo){
             alert('사원 번호를 입력해주세요.');
             return;
          }
          checkEmployeeStatus(empNo)
             .done(function(response){
             console.log("response",response);
             if(response.isCheckedIn > 0){
                checkInButton.prop("disabled",true); // 버튼 비활성화
                checkInButton.text("이미 출근 처리 됨");
             }
          })
          .fail(function(error){
             console.log("출근 상태 확인 실패:",error);
          });
       }

       // 출근 처리 이벤트
       $("#checkInForm").submit(function (event){
          event.preventDefault();

          let empNo = empNoInput.val();

          if(!empNo){
             alert("사원 번호를 입력해주세요.");
             return;
          }
          processCheckIn(empNo)
          .done(function (result){
             console.log("result:", result);

             if(result.message === "출근 완료!"){
                const serverTime = result.serverTime; // 서버에서 전달된 출근 시간
                startTime = new Date(serverTime); // 서버 시간으로 초기화
                updateWorkTime(); //근무 시간 갱신 시작
                var Toast = Swal.mixin({
                         toast: true,
                         position: 'top-end',
                         showConfirmButton: false,
                         timer: 3000
                      });
                      
                         Toast.fire({
                         icon:'success',
                         title:'등록성공!'
                      });
                      
                   }
                   else{
                      var Toast = Swal.mixin({
                         toast: true,
                         position: 'top-end',
                         showConfirmButton: false,
                         timer: 3000
                      });
                      
                         Toast.fire({
                         icon:'warning',
                         title:'등록실패'
                      });
             }

          })
          .fail(function (error){
             console.log("출근 처리 시패:", error);
          });
          initializeCheckIn();
       })
    })
       
       // 퇴근 처리 이벤트
          $("#checkOutForm").submit(function (event){
             event.preventDefault();
             
             let empNo = $("input[name='empNo']").val();
             let formData = new FormData();
             
             formData.append("empNo",empNo);

             if(!empNo){
                alert('사원 번호를 확인 할수 없습니다.');
                return;
             }
             $.ajax({
                url: '/att/checkOut',
                processData : false, // 파일객체를 string으르 만들 수 없어서 false
                contentType : false,
                data : formData,
                type:'PUT',
                success : function(result){
                   // 5. 결과 확인(1 또는 0)
                   // 0 또는 1
                   console.log("result :", result);
                   // success, error, warning, info, question
                   if(result.message == '퇴근 완료!'){//등록성공
                      clearInterval(workTimer); // 타이머 종료
                      var Toast = Swal.mixin({
                         toast: true,
                         position: 'top-end',
                         showConfirmButton: false,
                         timer: 3000
                      });
                      
                         Toast.fire({
                         icon:'success',
                         title:'퇴근 등록!'
                      });
                      
                   }
                   else{
                      var Toast = Swal.mixin({
                         toast: true,
                         position: 'top-end',
                         showConfirmButton: false,
                         timer: 3000
                      });
                      
                         Toast.fire({
                         icon:'warning',
                         title:'등록실패'
                      });
                      
                   }
                }
                
             });
          });
       
       
       // 근무 시간 갱신
       function updateWorkTime(){
          if(!startTime) return;
          

          workTimer = setInterval(function () {
             const now = new Date();
               const elapsedTime = Math.floor((now - startTime) / 1000); // 초 단위 경과 시간
               const hours = Math.floor(elapsedTime / 3600);
               const minutes = Math.floor((elapsedTime % 3600) / 60);
               const seconds = elapsedTime % 60;

               // 경과 시간 표시
               const workTime = `\${hours}H \${minutes}M \${seconds}S`;
               progressText.textContent = `근무시간: \${workTime}`; // 화면 표시

               // 진행률 업데이트
               let percentage = (elapsedTime / totalWorkTimeInSeconds) * 100;
               progressBar.style.width = `\${Math.min(percentage, 100)}%`; // 진행률 제한 100%

               // 근무 시간 종료 시 타이머 종료
               if (elapsedTime >= totalWorkTimeInSeconds) {
                   clearInterval(workTimer);
               }
           }, 1000); // 1초마다 갱신
       }
       
       function restoreCheckInTime(){
          
          let empNo = $("input[name='empNo']").val();
          $.ajax({
             url: `/att/getCheckInTime?empNo=\${empNo}`,
             type: "GET",
             success: function(response){
                console.log(response);
                if(response.status === "success"){
                   const checkInTime = new Date(response.checkInTime);
                   startTime = checkInTime; // 출근 시간 복구
                   updateWorkTime(); // 타이머 재시작
                }else{
                   console.warn(response.message);
                }
             },
             error: function (error){
                console.error("출근 시간 복구 중 오류:",error);
             }
          });
       }
       
       $(document).ready(function(){
          const empNo = $("input[name= 'empNo']").val();
          if(empNo){
             restoreCheckInTime(empNo);
          }
       });

    </script>
<!-- 여기 내용 들어가야해요  -->
        
<!-- 푸터 include  -->
   
   <jsp:include page="./include/footer.jsp"></jsp:include>
<!-- 푸터 include  -->



 </html>