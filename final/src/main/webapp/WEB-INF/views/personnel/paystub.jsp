<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.5.0/dist/sweetalert2.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.5.0/dist/sweetalert2.min.css" rel="stylesheet">
<!-- 
../ : views폴더(부모)
 -->
<style>
/* 기본 스타일 초기화 */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* 배경 및 기본 글꼴 설정 */
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f5f6fa;
    color: #2f3640;
    line-height: 1.6;
}

/* 급여 명세서 컨테이너 */
.pay-slip-container {
    width: 70%;
    margin: 30px auto;
    padding: 30px;
    background-color: #ffffff;
    border-radius: 12px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    font-size: 1rem;
}

/* 헤더 스타일 */
.header {
    text-align: center;
    margin-bottom: 20px;
}

.header h1 {
    font-size: 2.5rem;
    color: #1e272e;
    font-weight: 600;
}

.company-info {
    font-size: 1rem;
    color: #8395a7;
}

/* 직원 정보 테이블 스타일 */
.employee-info table {
    width: 100%;
    margin-top: 20px;
    border-spacing: 0;
}

.employee-info td {
    padding: 12px;
    border-bottom: 1px solid #e1e2e6;
    font-size: 1rem;
}

.employee-info td:first-child {
    font-weight: 600;
    color: #2f3640;
}

.employee-info td:last-child {
    color: #57606f;
}

/* 급여 내역 테이블 스타일 */
.salary-details {
    margin-top: 30px;
}

.salary-details table {
    width: 100%;
    border-collapse: collapse;
}

.salary-details td {
    padding: 12px;
    border-bottom: 1px solid #e1e2e6;
    font-size: 1.2rem;
    text-align: left;
}

.salary-details td:first-child {
    font-weight: 600;
    color: #2f3640;
}

.salary-details td:last-child {
    font-weight: 600;
    color: #27ae60;
}

.salary-details .total {
    background-color: #f1f2f6;
    font-size: 1.4rem;
    font-weight: bold;
    color: #2d3436;
}

/* 푸터 스타일 */
.footer {
    text-align: center;
    margin-top: 40px;
    font-size: 0.9rem;
    color: #8395a7;
}

/* 반응형 디자인 */
@media (max-width: 768px) {
    .pay-slip-container {
        width: 90%;
        padding: 20px;
    }

    .header h1 {
        font-size: 2rem;
    }

    .employee-info td,
    .salary-details td {
        font-size: 1rem;
        padding: 8px;
    }
}

</style>
<body>
    <div class="pay-slip-container">
        <header class="header">
            <h1>급여 명세서</h1>
            <div class="company-info">
                <p>회사명: W7VKY</p>
                <p>주소: 대전 중구 계룡로 846 4층 401호</p>
            </div>
        </header>

        <section class="employee-info">
            <h2>직원 정보</h2>
            <table>
                <tr>
                    <td>사원 번호</td>
                    <td>${employeeSalaryVO.empId}</td>
                </tr>
                <tr>
                    <td>이름</td>
                    <td>${employeeSalaryVO.empName}</td>
                </tr>
                <tr>
                    <td>부서</td>
                    <td>${employeeSalaryVO.deptName}</td>
                </tr>
                <tr>
                    <td>급여 지급일</td>
                    <td>10 일</td>
                </tr>
            </table>
        </section>

        <section class="salary-details">
            <h2>급여 내역</h2>
            <table>
                <tr>
                    <td>기본 급여</td>
                    <td># 원</td>
                </tr>
                <tr>
                    <td>상여금</td>
                    <td>#원</td>
                </tr>
                <tr>
                    <td>세금</td>
                    <td><# 원</td>
                </tr>
                <tr>
                    <td>공제</td>
                    <td># 원</td>
                </tr>
                <tr>
                    <td><strong>총 급여</strong></td>
                    <td><strong># 원</strong></td>
                </tr>
            </table>
        </section>

        <footer class="footer">
            <p>발행일: #</p>
        </footer>
    </div>
</body>
</html>

                        
                        
                
 
       <script src="/dash/lib/easing/easing.min.js"></script>
    <script src="/dash/lib/waypoints/waypoints.min.js"></script>
    <script src="/dash/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/moment.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>
<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
    <!-- Template Javascript -->
    <script src="/dash/js/main.js"></script>
<!-- ///// footer 시작 ///// -->
 <jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  


