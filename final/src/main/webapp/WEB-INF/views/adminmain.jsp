<%@page import="java.util.Locale"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
   
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
width: 20%;
    flex-direction: column;
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
   
   .firstBox{
height: 100vh;
display: flex;
    background-color: white !important;
width: 20%;
    flex-direction: column;
    box-shadow:none !important;
box-sizing: border-box;

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
    padding: 18px;
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
</style>





<!-- 여기 style css 들어가야해요  -->

<!-- 헤더 include  -->
    <jsp:include page="./include/managerHeader.jsp"></jsp:include>

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
                  <button type="submit" id="checkInButton" class="white-btn">출근하기</button>
               </c:if>
               </form>
               <form id="checkOutForm" action="/att/MaincheckOut" method="post">
               <c:if test="${userInfo != null}">
                  <input type="hidden" name="empNo" value="${userInfo.empNo}">
                  <button type="submit" id= "checkOutButton" class="white-btn">퇴근하기</button>
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
         <div class="groupBox">
            <h3>쪽지함 </h3>
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
      <!-- 푸터 include  -->
   
       <jsp:include page="./include/managerFooter.jsp"></jsp:include>

<!-- 푸터 include  -->
      
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
   <!-- JavaScript Libraries -->
    <script>
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
    </script>
<!-- 여기 내용 들어가야해요  -->
        



 </html>