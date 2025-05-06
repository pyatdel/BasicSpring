<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  

<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>

<style>
    body {
        font-family: Arial, sans-serif;
        padding: 20px;
    }
    .container {
        max-width: 800px;
        margin: auto;
        padding: 20px;
        border-radius: 10px;
        background-color: white;
    	border: none;
    }
    h2 {
        text-align: center;
        margin-bottom: 20px;
    }
    .tabs {
        display: flex;
        border-bottom: 2px solid #000;
    }
    .tabs li {
        list-style: none;
        padding: 10px 20px;
        cursor: pointer;
        border: 1px solid #ccc;
        border-bottom: none;
        background: #f1f1f1;
    }
    .tabs li.active {
        background: white;
        font-weight: bold;
        border-top: 2px solid #000;
    }
    .tab-content {
        display: none;
        padding: 20px;
        border: 1px solid #000;
    }
    .tab-content.active {
        display: block;
    }
    input, select, textarea {
        width: 100%;
        padding: 8px;
        margin: 10px 0;
        border-radius: 5px;
        border: 1px solid #ccc;
    }
    button {
        background-color: #ffcc00;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        width: 100%;
    }
    button:hover {
        background-color: #ff9900;
    }
    .btn-container {
        text-align: center;
        margin-top: 20px;
    }
    .btn {
        padding: 10px 15px;
        background-color: #007bff;
        color: white;
        border: none;
        cursor: pointer;
    }
    .btn:hover {
        background-color: #0056b3;
    }
    
    label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
}

input, textarea, text {
    width: 100%;
    padding: 8px;
    margin-bottom: 15px; /* 입력 필드 간격 조정 */
    border: 1px solid #ccc;
    border-radius: 4px;
}

button {
    margin-top: 10px;
    padding: 10px 15px;
    background-color: #007bff;
    color: white;
    border: none;
    cursor: pointer;
}
 .cashSub{
display: block !important;
height: auto !important;
}  
</style>

<%@ include file="../include/header.jsp" %>

<div class="container">

    <!-- 탭 버튼 -->
    <ul class="tabs">
        <li class="tab-link active" data-tab="expenseReport">지출결의서</li>
        <li class="tab-link" data-tab="taxInvoice">세금계산서</li>
        <li class="tab-link" data-tab="approvalDoc">품의서</li>
        <li class="tab-link" data-tab="contract">계약서</li>
    </ul>

    <!-- 탭 컨텐츠 -->
    <div id="expenseReport" class="tab-content active">
<!--         <h5>지출결의서</h5> -->
        <hr/>
        <form id="expenseForm">
            <label for="item">지출 항목</label>
            <input type="text" id="item" name="item" placeholder="지출 항목을 입력하세요" required>

            <label for="amount">금액 (원)</label>
            <input type="number" id="amount" name="amount" placeholder="금액을 입력하세요" required>

            <label for="description">지출 내역 설명</label>
            <textarea id="description" name="description" rows="4" placeholder="지출 내역을 상세히 작성하세요" required></textarea>

            <label for="receipt">영수증 첨부</label>
            <input type="file" id="receipt" name="receipt" accept="image/*,application/pdf" required>

            <button type="submit">결제하기</button>
        </form>
    </div>

    <div id="taxInvoice" class="tab-content">
<!--         <h3>세금계산서</h3> -->
<hr/>
        <form id="taxForm">
            <label for="company">회사명</label>
            <input type="text" id="company" name="company" placeholder="회사명을 입력하세요" required>

            <label for="taxAmount">세금액 (원)</label>
            <input type="number" id="taxAmount" name="taxAmount" placeholder="세금액을 입력하세요" required>

            <label for="taxDesc">세금 내역 설명</label>
            <textarea id="taxDesc" name="taxDesc" rows="4" placeholder="세금 내역을 상세히 작성하세요" required></textarea>

            <button type="submit">발행하기</button>
        </form>
    </div>

    <div id="approvalDoc" class="tab-content">
<!--     <h3>품의서</h3> -->
    <hr/>
    <form id="approvalForm">
        <label for="approvalTitle">품의 제목</label>
        <input type="text" id="approvalTitle" name="approvalTitle" placeholder="품의 제목을 입력하세요" required>

        <label for="approvalType">품의 유형</label>
        <select id="approvalType" name="approvalType">
            <option value="예산 승인">예산 승인</option>
            <option value="프로젝트 승인">프로젝트 승인</option>
            <option value="신규 도입">신규 도입</option>
            <option value="기타">기타</option>
        </select>

        <label for="requestDept">요청 부서</label>
        <input type="text" id="requestDept" name="requestDept" placeholder="부서를 입력하세요" required>

        <label for="requester">요청자</label>
        <input type="text" id="requester" name="requester" placeholder="요청자 성명을 입력하세요" required>

        <label for="approvalDesc">품의 내용</label>
        <textarea id="approvalDesc" name="approvalDesc" rows="4" placeholder="품의 내용을 상세히 작성하세요" required></textarea>

        <label for="approvalAmount">예산 금액 (원)</label>
        <input type="number" id="approvalAmount" name="approvalAmount" placeholder="예산이 필요하면 입력하세요">

        <label for="approvalFile">관련 문서 첨부</label>
        <input type="file" id="approvalFile" name="approvalFile" accept=".pdf, .docx, .xlsx, .jpg, .png">

        <button type="submit">제출하기</button>
    </form>
</div>

<div id="contract" class="tab-content">
<!--     <h3>계약서</h3> -->
<hr/>
    <form id="contractForm">
        <label for="contractTitle">계약 제목</label>
        <input type="text" id="contractTitle" name="contractTitle" placeholder="계약 제목을 입력하세요" required>

        <label for="contractParty">계약 당사자</label>
        <input type="text" id="contractParty" name="contractParty" placeholder="계약 당사자를 입력하세요" required>

        <label for="contractDuration">계약 기간</label>
        <input type="text" id="contractDuration" name="contractDuration" placeholder="예: 2025-01-01 ~ 2025-12-31" required>

        <label for="contractAmount">계약 금액 (원)</label>
        <input type="number" id="contractAmount" name="contractAmount" placeholder="계약 금액을 입력하세요" required>

        <label for="contractTerms">계약 조건</label>
        <textarea id="contractTerms" name="contractTerms" rows="4" placeholder="지불 조건, 해지 조건 등을 입력하세요" required></textarea>

        <label for="contractPurpose">계약 목적</label>
        <textarea id="contractPurpose" name="contractPurpose" rows="4" placeholder="계약이 체결되는 목적을 입력하세요" required></textarea>

        <label for="contractFile">관련 문서 첨부</label>
        <input type="file" id="contractFile" name="contractFile" accept=".pdf, .docx, .xlsx">

        <h4>서명란</h4>
        <label for="signDate">서명 일자</label>
        <input type="date" id="signDate" name="signDate" required>

        <label for="signer">계약 당사자 서명</label>
        <input type="text" id="signer" name="signer" placeholder="서명자 성명을 입력하세요" required>

        <button type="submit">계약 체결</button>
    </form>
</div>

<div class="btn-container">
    <button class="btn" onclick="downloadPDF()">PDF 저장</button>
</div>

</div>

<script>
    // 탭 전환 기능
    document.querySelectorAll('.tab-link').forEach(tab => {
        tab.addEventListener('click', function() {
            document.querySelectorAll('.tab-link').forEach(el => el.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(el => el.classList.remove('active'));

            this.classList.add('active');
            document.getElementById(this.dataset.tab).classList.add('active');
        });
    });

    // PDF 다운로드
    function downloadPDF() {
        const activeTab = document.querySelector('.tab-content.active');
        if (activeTab) {
            html2pdf().from(activeTab).save(activeTab.querySelector('h3').innerText + ".pdf");
        }
    }
</script>

<%@ include file="../include/footer.jsp" %>
