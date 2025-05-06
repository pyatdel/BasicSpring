<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  


    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }
        .cashSub{
		display: block !important;
		height: auto !important;
		}
    </style>
<%@ include file="../include/header.jsp" %>

<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<%@ include file="../include/sidebar.jsp" %>


<!-- ///// content 시작 ///// -->

<h2>지출 신청 내역</h2>
    <table id="expenseTable">
        <thead>
            <tr>
                <th>번호</th>
                <th>항목</th>
                <th>금액</th>
                <th>날짜</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>사무용품</td>
                <td>50,000원</td>
                <td>2025-01-20</td>
            </tr>
            <tr>
                <td>2</td>
                <td>회의비</td>
                <td>100,000원</td>
                <td>2025-01-18</td>
            </tr>
        </tbody>
    </table>

    <button onclick="downloadPDF()">PDF 저장</button>

    <script>
        function downloadPDF() {
            const element = document.getElementById('expenseTable');
            html2pdf().from(element).save("지출신청내역.pdf");
        }
    </script>
<!-- ///// content 끝 ///// -->

<%@ include file="../include/footer.jsp" %>   
	