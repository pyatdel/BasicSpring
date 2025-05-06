<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 라이브러리 include  -->
   <jsp:include page="./include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
    
    
<title>주소록</title>
<style>
/* CSS 코드 */
.message-container {
	width: 90%;
	margin: 0 auto;
	margin-top: 20px;
	background: #f9f9f9;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	padding: 20px;
	font-family: 'Arial', sans-serif;
}

.message-container h1 {
	font-size: 24px;
	color: #333;
	text-align: center;
	margin-bottom: 20px;
	text-transform: uppercase;
	letter-spacing: 1px;
}

.message-table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

.message-table th, .message-table td {
	padding: 12px 15px;
	text-align: left;
	font-size: 14px;
}

.message-table th {
	background-color: #007bff;
	color: white;
	text-transform: uppercase;
	font-weight: bold;
}

.message-table tr:nth-child(even) {
	background-color: #f2f2f2;
}

.message-table tr:hover {
	background-color: #e9ecef;
}

.message-table td {
	border-bottom: 1px solid #ddd;
}

.delete-btn, .view-btn {
	display: inline-block;
	padding: 8px 12px;
	font-size: 14px;
	color: #fff;
	background-color: #007bff;
	border: none;
	border-radius: 5px;
	text-decoration: none;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.delete-btn:hover {
	background-color: #dc3545;
}

.view-btn:hover {
	background-color: #17a2b8;
}

.pagination {
	display: flex;
	justify-content: center;
	margin-top: 20px;
}

.pagination a {
	color: #007bff;
	padding: 10px 15px;
	margin: 0 5px;
	border: 1px solid #ddd;
	text-decoration: none;
	border-radius: 5px;
	transition: background-color 0.3s, color 0.3s;
}

.pagination a:hover {
	background-color: #007bff;
	color: white;
}

@media screen and (max-width: 768px) {
	.message-container {
		width: 100%;
		padding: 10px;
	}
	.message-table th, .message-table td {
		font-size: 12px;
	}
	.delete-btn, .view-btn {
		padding: 6px 10px;
		font-size: 12px;
	}
	.pagination a {
		padding: 8px 10px;
		font-size: 12px;
	}

.pagination {
	display: flex;
	justify-content: center;
	align-items: center;
	list-style: none;
	padding: 0;
	margin-top: 20px;
}

.pagination li {
	margin: 0 5px;
}

.pagination a, .pagination span {
	display: block;
	padding: 10px 15px;
	text-decoration: none;
	border: 1px solid #ddd;
	border-radius: 5px;
	color: #007bff;
	font-size: 14px;
	transition: all 0.3s;
}

.pagination a:hover {
	background-color: #f0f0f0;
	border-color: #007bff;
}

.pagination .current {
	background-color: #007bff;
	color: #fff;
	border-color: #007bff;
	pointer-events: none;
}

.pagination .disabled {
	color: #ccc;
	border-color: #ddd;
	pointer-events: none;
}

.modal {
	display: none;
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	display: flex;
	justify-content: center;
	align-items: center;
}

.modal-content {
	background-color: white;
	padding: 20px;
	border-radius: 10px;
	width: 40%;
	max-width: 400px;
	min-width: 300px;
	text-align: center;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.modal-content h2 {
	margin-bottom: 10px;
}

.modal-content button {
	padding: 10px 15px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.modal-content button:hover {
	background-color: #0056b3;
}

.close-btn {
	position: absolute;
	top: 10px;
	right: 15px;
	font-size: 20px;
	cursor: pointer;
}
</style>
</head>
	<jsp:include page="./include/header.jsp"></jsp:include>
	<div class="message-container">
	<div class="nav nav-tabs custom-tabs mb-4">
			    <a class="nav-link" href="/address" data-type="sales">주소록</a>
			    <a class="nav-link" href="/message/list/inbox" data-type="customer">쪽지함</a>
			</div>
		<h1>주소록</h1>
		
		<form class="search-bar" action="/address/search" method="get">
			<input type="text" name="keyword" placeholder="이름 또는 ID 검색" required>
			<button type="submit">검색</button>
		</form>

		<table class="message-table">
			<thead>
				<tr>
					<th>이름</th>
					<th>직원 ID</th>
					<th>프로필</th>
					<th>작업</th>
				</tr>
			</thead>
			<tbody>
				<!-- 서버에서 전달된 주소록 데이터를 반복문으로 출력 -->
				<c:forEach var="address" items="${addresses}">
					<tr>
						<td>${address.empName}</td>
						<td>${address.empId}</td>
						<td><img src="${address.empProfile}" alt="프로필 이미지" width="50"
							height="50"></td>
						<td>
							<button class="send-button" data-empid="${address.empId}">쪽지
								보내기</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div>
			<ul class="pagination">
				<c:if test="${currentPage > 1}">
					<li><a
						href="${pageContext.request.contextPath}/address?page=${currentPage - 1}&keyword=${keyword}">이전</a></li>
				</c:if>
				<c:forEach begin="1" end="${totalPages}" var="page">
					<c:choose>
						<c:when test="${page == currentPage}">
							<li><span class="current">${page}</span></li>
						</c:when>
						<c:otherwise>
							<li><a
								href="${pageContext.request.contextPath}/address?page=${page}&keyword=${keyword}">${page}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${currentPage < totalPages}">
					<li><a
						href="${pageContext.request.contextPath}/address?page=${currentPage + 1}&keyword=${keyword}">다음</a></li>
				</c:if>
			</ul>
		</div>
	</div>
	<div id="messageModal" class="modal">
		<div class="modal-content">
			<span class="close-btn">&times;</span>
			<h2>쪽지 보내기</h2>
			<form id="sendMessageForm"
				action="${pageContext.request.contextPath}/message/send"
				method="post">
				<div>
					<label for="receiver">수신자:</label> <input type="text" id="receiver"
						name="receiverEmpId" readonly>
				</div>
				<div>
					<label for="content">내용:</label>
					<textarea id="content" name="content" rows="5" cols="30" required></textarea>
				</div>
				<div>
					<button type="submit">보내기</button>
				</div>
			</form>
		</div>
		  <jsp:include page="./include/footer.jsp"></jsp:include>
		
	</div>

	<script>
        // 모달 요소 가져오기
        const modal = document.getElementById("messageModal");
        const closeModal = document.querySelector(".close-btn");
        const receiverInput = document.getElementById("receiver");

        // "쪽지 보내기" 버튼 클릭 시 모달 열기
        document.querySelectorAll(".send-button").forEach(button => {
            button.addEventListener("click", function () {
                const empId = this.getAttribute("data-empid");
                receiverInput.value = empId;
                modal.style.display = "flex";
            });
        });

        // 모달 닫기 버튼 클릭 시 닫기
        closeModal.addEventListener("click", () => {
            modal.style.display = "none";
        });

        // 모달 외부 클릭 시 닫기
        window.addEventListener("click", (event) => {
            if (event.target === modal) {
                modal.style.display = "none";
            }
        });

        // 쪽지 전송 이벤트 핸들러
        document.getElementById("sendMessageForm").addEventListener("submit", function (e) {
            e.preventDefault(); // 기본 폼 제출 방지

            const formData = new FormData(this);

            fetch("${pageContext.request.contextPath}/message/send", {
                method: "POST",
                body: formData
            })
            .then(response => response.text()) // 응답을 텍스트로 변환
            .then(data => {
                alert("쪽지가 성공적으로 전송되었습니다."); // 성공 알림
                modal.style.display = "none"; // 모달 닫기
            })
            .catch(error => {
                alert("오류 발생: " + error.message);
            });
        });
    </script>
</html>
