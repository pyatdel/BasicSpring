<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/your-script.js"></script>
   <!-- 라이브러리 include  -->
    
    
<title>영업 활동</title>
<%
    // 현재 날짜 가져오기
    Date today = new Date();
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    String todayStr = dateFormat.format(today);
%>
<style>
.nav-tabs .nav-link{
color: black !important;
}

.nav-tabs .nav-link.active, .nav-tabs .nav-item.show .nav-link{

color:#3069CE !important;

}
#registrationModal {
    width: 90%; /* 원하는 크기 */
    max-width: 1200px; /* 최대 크기 설정 */
    height: auto; /* 내용에 맞게 높이 자동 조정 */
    display: none; 
    position: fixed; /* 화면에 고정 */
    top: 50%; /* 화면 중앙 */
    left: 50%;
    transform: translate(-50%, -50%); /* 중앙 정렬 */
    z-index: 1000; /* 다른 요소 위에 위치 */
    background-color: none; /* 배경을 반투명 검정색으로 설정 */
    border-radius: 10px; /* 모달에 둥근 모서리 추가 */
    padding: 20px; /* 모달 내부 여백 */
    
    
}


.nav-link.active {
    color: black !important; /* 텍스트 색상 */
    background-color: #F3F6F9 !important; /* 배경색 */
    border-color: #dee2e6 !important; /* 테두리 색상 */
}

.conbtn {
	background-color: 3069CE !important;
	border: none !important;
}

.form-control {
	width: 500px !important;
}
/* ========================== 기본 스타일 ========================== */
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 0;
}

#con {
/*     width: 100%; */
    max-width: 2000px;
/*     margin: 30px auto; */
/*     padding: 20px; */
    background-color: white;
    border-radius: 8px;
    border : none !important;
/*     box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1); */
}



/* ========================== 테이블 스타일 ========================== */
.table-container {
    overflow-x: auto; /* 반응형 테이블 */
}

table {
    width: 100%;
    border-collapse: collapse;
    background-color: white;
    text-align: center;
}

th, td {
    padding: 12px;
    border-bottom: 1px solid #ddd;
}

th {
    background-color: #3069CE;
    color: white;
    font-weight: bold;
}

td {
    color: #333;
}

/* 테이블 호버 효과 */
tbody tr:hover {
    background-color: #f1f7ff;
    transition: background-color 0.3s ease-in-out;
}

/* ========================== 입력 필드 & 필터 스타일 ========================== */
.form-group {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    height: 50px;
    margin-bottom: 20px;
    align-items: center;
}

.form-group input, .form-group select {
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
    height: 50px;
}


.form-group input {
height: 50px;
    flex: 1;
}

.form-group select {
    min-width: 150px;
}


/* ========================== 버튼 스타일 ========================== */
.button-container {
    text-align: right;
    margin-bottom: 10px;
}

.btn {
    display: inline-block;
    padding: 10px 16px;
    margin: 5px;
    border-radius: 20px;
    font-size: 14px;
    font-weight: bold;
    text-decoration: none;
    cursor: pointer;
    transition: all 0.3s ease-in-out;
    background-color: 3069CE !important;
}

.btn-primary {
    background-color: #007bff;
    color: white;
    border: none;
}

.btn-primary:hover {
    background-color: #0056b3;
}

.btn-secondary {
    background-color: #6c757d;
    color: white;
    border: none;
}

.btn-secondary:hover {
    background-color: #565e64;
}

#btnSearch {
	background-color:none !important;
}

/* ========================== 모달 스타일 ========================== */
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
}

.modal-content {
    background-color: white;
    margin: 10% auto;
    padding: 20px;
    width: 60%;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 18px;
    font-weight: bold;
}

.close-btn {
    cursor: pointer;
    font-size: 20px;
    color: #333;
}
/* .container { */
/* 	border: none !important; */
/* 	margin:10px !important; */
/* 	width: max-content !important; */
/* } */
.btn-transparent {
  background-color: transparent !important;
  border: none !important;
}



/* ========================== 페이지네이션 스타일 ========================== */
.page-item.active .page-link {
    z-index: 1;
    color: white;
    background-color: #3069CE !important;
    border-color: #3069CE !important;
}
.next > a{
    color: #3069CE !important;

}
.page-item > a{
    color: #3069CE ;
}

.bluBt{
background-color: #3069CE;
color:white;
outline: none;
border:none;
width: 130px;
height:36px; 
border-radius: 5px;

}

/* ========================== 반응형 스타일 ========================== */
@media (max-width: 768px) {
    .container {
        width: 100%;
        padding: 15px;
    }

    th, td {
        padding: 8px;
        font-size: 14px;
    }

    .btn {
        font-size: 12px;
        padding: 8px 12px;
    }

    .modal-content {
        width: 90%;
    }
}
.businessSub {
display: block !important;
height: auto !important;
}

</style>
  </head>
<!-- 여기 style css 들어가야해요  -->

<!-- 헤더 include  -->
   <jsp:include page="../include/header.jsp"></jsp:include>
<!-- 헤더 include  -->

<!-- ///// content 시작 ///// -->
<sec:authorize access="isAuthenticated()">
<%-- 	<sec:authentication property="principal.member"  /> --%>
	<sec:authentication property="principal.member" var="memberVO" />
</sec:authorize>

<div class="bg-light text-center rounded p-4" >
      <h3 class="mb-0"></h3>
       	<div class="nav nav-tabs custom-tabs mb-4">
<!-- 	    <a class="nav-link" href="/business/custManage" data-type="customer">고객 정보</a> -->
	    <a class="nav-link" href="/business/infoList" data-type="sales">영업 관리</a>
	    <a class="nav-link" href="/business/busAct" data-type="Act">영업 활동</a>
	    <a class="nav-link" href="/business/busChance" data-type="Chance">영업 기회</a>
<!-- 	    <a class="nav-link" href="/business/busStat" data-type="stat">영업 통계</a> -->
	</div>
</div>

<div class="container" id="con">

<!-- 영업활동 등록 폼 -->
    <!-- 테이블 -->
    <div class="d-flex justify-content-between mb-3"  id="tbl">
    	<form class="d-flex align-items-center" method="get" action="/business/busAct">
            <div class="form-group">
                    <select name="busType" id="busType">
                        <option value="이메일">이메일</option>
                        <option value="전화">전화</option>
                        <option value="SMS">SMS</option>
                        <option value="미팅">미팅</option>
                        <option value="업무">업무</option>
                        <option value="우편">우편</option>
                    </select>
                    
                    <input type="text" name="keyword"  value="${param.keyword}"
                		class="form-control float-right" placeholder="검색어 입력"/>

                <div class="input-group-append">
				  <button type="button" id="btnSearch" class="btn btn-transparent">
				    <i class="fas fa-search"></i>
				  </button>
				</div>
                </div>
            
<!--             <div class="input-group input-group-sm" style="width: auto; width: 150px;"> -->
                

<!--               </div> -->
        </form>
        <div>
<!--             <button type="button" id="openModalBtn" class="btn btn-primary">등록</button> -->
        </div>  
     </div>
        <table>
            <thead>
                <tr id="tbc">
                    <th>유형</th>
                    <th>고객명</th>
                    <th style="text-align: center;">내용</th>
                    <th>진행률 (%)</th>
                    <th>등록일자</th>
                </tr>
            </thead>
            <tbody id="tby">
            	<c:forEach var="businessAct" items="${articlePage.content}" varStatus="stat" end="9">
    <c:if test="${businessAct.busType != null}">
        <tr>
            <td> <!-- 유형 표시 -->
                <c:choose>
                    <c:when test="${businessAct.busType eq '이메일'}">
                        <i class="bi bi-envelope"></i> 이메일
                    </c:when>
                    <c:when test="${businessAct.busType eq '전화'}">
                        <i class="bi bi-telephone"></i> 전화
                    </c:when>
                    <c:when test="${businessAct.busType eq 'SMS'}">
                        <i class="bi bi-chat-dots"></i> SMS
                    </c:when>
                    <c:when test="${businessAct.busType eq '미팅'}">
                        <i class="bi bi-people"></i> 미팅
                    </c:when>
                    <c:when test="${businessAct.busType eq '업무'}">
                        <i class="bi bi-journal-text"></i> 업무
                    </c:when>
                    <c:when test="${businessAct.busType eq '우편'}">
                        <i class="bi bi-envelope-paper"></i> 우편
                    </c:when>
                    <c:otherwise>
                        <i class="bi bi-question-circle"></i> 기타
                    </c:otherwise>
                </c:choose>
            </td>
            <td class="tdModal" data-toggle="modal" data-target="#registrationModal" data-ent-name="${businessAct.entName}"
                style="cursor:pointer; color: #3069CE;">${businessAct.entName}</td>
            <td style="text-align: left;">
                <c:choose>
                    <c:when test="${businessAct.inout eq 'I'}">
                        <span style="color: #3069CE; font-weight: bold;">↓</span>
                    </c:when>
                    <c:when test="${businessAct.inout eq 'O'}">
                        <span style="color: #FF4444; font-weight: bold;">↑</span>
                    </c:when>
                </c:choose>
                ${businessAct.content}
            </td>
            <td>${businessAct.percent}%</td>
            <td>${businessAct.busDate}</td>
        </tr>
    </c:if>
</c:forEach>

            </tbody>
            
        </table>
    </div>
    <!-- 페이지네이션 -->
	<div id="divPagingContainer" style="display: flex; align-items: center; width: 100%; padding-top: 20px;">
    <!-- 페이징을 가운데 정렬 -->
    <div style="flex: 1; display: flex; justify-content: center;">
        <div id="divPagingArea" class="pagination">
            ${articlePage.pagingArea}
        </div>
    </div>
    <div style="display: flex; justify-content: flex-end; width: 150px;">
        <button type="button" id="openModalBtn" class="btn btn-primary bluBt">등록</button>
    </div>
</div>

<div class="modal" id="registrationModal" style="background-color:transparent;">
    <div class="modal-content" style="box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.5); border: 3px solid gray;">
        <div class="modal-header">
            <span style="bold">영업 활동 등록</span>
            <span class="close-btn" id="closeModalBtn">&times;</span>
        </div>
        <div class="modal-body">
            <form method="post" action="/business/busAct/create">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <div class="form-group">
                    <label>유형</label>
                    <select name="busType" id="busType">
                        <option value="이메일">이메일</option>
                        <option value="전화">전화</option>
                        <option value="SMS">SMS</option>
                        <option value="미팅">미팅</option>
                        <option value="업무">업무</option>
                        <option value="우편">우편</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>유형</label>
                    <select name="inout" id="inout" onchange="toggleReceiverSender()">
                        <option value="I">수신</option>
                        <option value="O">발신</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>수신자</label>
                    <input type="text" id="receiverInput" name="entName" required>
                    <select id="receiverSelect" name="entName" style="display:none;">
					    <option value="">선택하세요</option>
					    <c:forEach var="ent" items="${entList}" varStatus="stat">
					        <option value="${ent.entName}">${ent.entName}</option>
					    </c:forEach>
					</select>
                </div>
                <div class="form-group">
                    <label>발신자</label>
                    <input type="text" id="senderInput" name="empName" readonly>
                    <input type="hidden" id="txtEmpNo" name="empNo" readonly>
                </div>
                <div class="form-group">
                    <label>주제</label>
                    <textarea id="tareaContent" name="content" required></textarea>
                </div>
                <div class="form-group">
                    <label>진행률 (%)</label>
                    <input type="number" name="percent" min="0" max="100" required>
                </div>
                <div class="form-group">
                    <label>등록일자</label>
                    <input type="date" id="iptBusDate" name="busDate"  value="<%= todayStr %>" required>
                </div>
                <div class="button-container">
                    <button type="submit" class="btn btn-primary bluBt">등록</button>
                </div>
                <input type="hidden" id="txtInnerValue" name="innerValue" value="" />
                <input type="hidden" id="txtOutterValue" name="outterValue" value="" />
                <input type="hidden" id="txtTitle" name="title" value="" />
                <input type="hidden" id="txtStart" name="start" value="" />
                <input type="hidden" id="txtEnd" name="end" value="" />
            </form>
        </div>
    </div>
       <jsp:include page="../include/footer.jsp"></jsp:include>
    
</div>


<!-- ///// content 끝 ///// -->

<script type="text/javascript">
//전역변수. 선택된 영업 대상 회사명
let entName;

document.addEventListener("DOMContentLoaded", function () {
    const modal = document.getElementById("registrationModal");
    const openModalBtn = document.getElementById("openModalBtn");
    const closeModalBtn = document.getElementById("closeModalBtn");
    
    //수신자 업체 선택 처리
    $("#receiverSelect").on("change",function(){
    	 let entName = $(this).val();
    	 
    	 console.log("entName : ", entName);
    	 
    	 $("#receiverInput").val(entName);
    	 $("#txtOutterValue").val(entName);
    });
    
    // 모달 열기
    openModalBtn.onclick = function() {
    	//초기화
    	$("#senderInput").val("");
    	
        modal.style.display = "block";
        document.body.style.overflow = 'hidden'; // 배경 스크롤 방지
    }

    // 모달 닫기
    closeModalBtn.onclick = function() {
        closeModal();
    }

    // 모달 외부 클릭시 닫기
    window.onclick = function(event) {
        if (event.target == modal) {
            closeModal();
        }
    }

    // ESC 키로 모달 닫기
    document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape') {
            closeModal();
        }
    });

    //고객명 클릭 시 모달 띄우기*****
    $(".tdModal").on("click",function(){
    	//초기화
    	$("#senderInput").val("");
    	$("#inout option:eq(0)").prop("selected",true);
    	$("#receiverInput").val("${memberVO.empName}");
    	
    	//전역변수 사용
    	entName = $(this).data("entName");
    	console.log("entName : " + entName);
    	
    	modal.style.display = "block";
        document.body.style.overflow = 'hidden'; // 배경 스크롤 방지
        
        $("#senderInput").val(entName);
    });
    
    function closeModal() {
        modal.style.display = "none";
        document.body.style.overflow = 'auto'; // 배경 스크롤 복원
    }
    
    $("#senderInput").on("focusout",function(){
		$("#txtInnerValue").val($("#senderInput").val());
	});
    
    $("#tareaContent").on("focusout",function(){
		$("#txtTitle").val($("#tareaContent").val());
	});
    
    $("#iptBusDate").on("focusout",function(){
		$("#txtStart").val($("#iptBusDate").val());
		$("#txtEnd").val($("#iptBusDate").val());
	});

    // 초기 상태 설정
    document.getElementById("inout").addEventListener('change', toggleReceiverSender);
    toggleReceiverSender();
    
});

//수신자/발신자 토글 함수 개선
function toggleReceiverSender() {
    const inout = document.getElementById("inout").value;
    const receiverInput = document.getElementById("receiverInput");
    const receiverSelect = document.getElementById("receiverSelect");

    console.log("inout : ", inout);
    
    if (inout === "I") {//수신
        receiverInput.style.display = "block";
        receiverSelect.style.display = "none";
        receiverSelect.value = "";
        receiverInput.required = true;
        receiverSelect.required = false;
        
        $("#receiverInput").val("${memberVO.empName}");
        $("#senderInput").val(entName);
        $("#txtEmpNo").val("${memberVO.empNo}");
        $("#senderInput").attr("readonly",false);
        $("#txtInnerValue").val($("#senderInput").val());
        $("#txtOutterValue").val("${memberVO.empNo}");
    } else {//발신
        receiverInput.style.display = "block";
        receiverSelect.style.display = "block";
//         receiverInput.value = "";
        receiverSelect.required = true;
        receiverInput.required = false;
        
        $("#receiverInput").val(entName);
        $("#senderInput").val("${memberVO.empName}");
        $("#txtEmpNo").val("${memberVO.empNo}");
        $("#senderInput").attr("readonly",true);
        $("#txtInnerValue").val("${memberVO.empNo}");
        $("#txtOutterValue").val($("#receiverInput").val());
    }
}
//현재 URL 가져오기
const currentPath = window.location.pathname;

// 모든 탭 요소 가져오기
const navLinks = document.querySelectorAll('.nav-link');

// 현재 경로와 href가 일치하는 탭에 active 클래스 추가
navLinks.forEach(link => {
    if (link.getAttribute('href') === currentPath) {
        link.classList.add('active'); // Bootstrap의 기본 스타일을 활용
    }
});

</script>
</html>	