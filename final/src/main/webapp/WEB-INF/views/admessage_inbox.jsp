<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>받은 쪽지함</title>
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
	/* 모달 스타일 */
	/* 모달 스타일 */
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 50%;
    top: 10%;
    transform: translate(-50%, 0);
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: flex-start;
    animation: fadeIn 0.3s ease-in-out;
}

/* 모달 컨텐츠 */
.modal-content {
    background-color: white;
    padding: 20px;
    border-radius: 10px;
    width: 40%;
    max-width: 400px;
    min-width: 300px;
    text-align: center;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    animation: slideDown 0.3s ease-in-out;
}

/* 닫기 버튼 */
.close-btn {
    position: absolute;
    top: 10px;
    right: 15px;
    font-size: 20px;
    cursor: pointer;
    color: #555;
    transition: color 0.3s;
}

.close-btn:hover {
    color: #000;
}

/* 모달 헤더 */
.modal-header h2 {
    font-size: 20px;
    color: #333;
    margin-bottom: 15px;
    font-weight: bold;
}

/* 모달 내용 */
.modal-body {
    font-size: 16px;
    color: #555;
    line-height: 1.5;
    text-align: center;
}

/* 모달 애니메이션 */
@keyframes slideDown {
    from {
        transform: translateY(-50px);
        opacity: 0;
    }
    to {
        transform: translateY(0);
        opacity: 1;
    }
}

@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}

/* 반응형 디자인 */
@media screen and (max-width: 768px) {
    .message-container {
        width: 100%;
        padding: 10px;
    }

    .message-table th, 
    .message-table td {
        font-size: 12px;
    }

    .delete-btn, 
    .view-btn {
        padding: 6px 10px;
        font-size: 12px;
    }

    .pagination a {
        padding: 8px 10px;
        font-size: 12px;
    }

    .modal-content {
        width: 80%;
        max-width: 350px;
    }
}
}
</style>
</head>
<jsp:include page="./include/mangerSidebar.jsp"></jsp:include>
<body>
	<div class="message-container">
		<h1>받은 쪽지함</h1>
		<table class="message-table">
			<thead>
				<tr>
					<th>보낸 사람</th>
					<th>내용</th>
					<th>보낸 날짜</th>
					<th>상태</th>
					<th>작업</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="message" items="${messages}">
					<tr>
						<td>${message.senderName}</td>
						<td><c:choose>
								<c:when test="${fn:length(message.content) > 10}">
				            ${fn:substring(message.content, 0, 10)}...
				        </c:when>
								<c:otherwise>
				            ${message.content}
				        </c:otherwise>
							</c:choose></td>
						<td>${message.sendTime}</td>
						<td><c:choose>
								<c:when test="${message.readStatus == 'N'}">읽지 않음</c:when>
								<c:otherwise>읽음</c:otherwise>
							</c:choose></td>
						<td>
							<!-- 삭제 버튼 -->
							<form class="delete-form"
								action="${pageContext.request.contextPath}/admessage/delete"
								method="post" style="display: inline;">
								<input type="hidden" name="messageId"
									value="${message.messageId}">
								<button type="submit" class="delete-btn">삭제</button>
							</form> <!-- 보기 버튼 -->
							<button class="view-btn" data-message-id="${message.messageId}">보기</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<!-- 모달 창 추가 -->
		<div id="messageModal" class="modal">
			<div class="message-container">
				<span class="close-btn">&times;</span>
				<h2>쪽지 내용</h2>
				<p>
					<strong>보낸 사람:</strong> <span id="modalSender"></span>
				</p>
				<p>
					<strong>보낸 날짜:</strong> <span id="modalTime"></span>
				</p>
				<p>
					<strong>내용:</strong>
				</p>
				<p id="modalContent"></p>
			</div>
		</div>

		<!-- 페이징 처리 -->
		<div class="pagination">
			<c:if test="${!empty pagination}">
				<c:forEach var="page" items="${pagination}">
					<a href="?page=${page}">${page}</a>
				</c:forEach>
			</c:if>
		</div>
	</div>

	<script>
    // 삭제 시 알림 및 페이지 새로고침
    document.querySelectorAll(".delete-form").forEach(form => {
        form.addEventListener("submit", function (e) {
            e.preventDefault();

            if (confirm("쪽지를 삭제하시겠습니까?")) {
                const formData = new FormData(this);

                fetch(this.action, {
                    method: "POST",
                    body: formData
                })
                .then(response => {
                    if (response.ok) {
                        alert("쪽지가 삭제되었습니다.");
                        window.location.reload(); // 삭제 후 페이지 새로고침
                    } else {
                        throw new Error("삭제 실패");
                    }
                })
                .catch(error => {
                    alert("오류 발생: " + error.message);
                });
            }
        });
    });

    document.addEventListener("DOMContentLoaded", function () {
        console.log("페이지 로드 완료: 버튼 이벤트 등록 시작");

        document.querySelectorAll(".view-btn").forEach(button => {
            button.addEventListener("click", function () {
                const messageId = this.getAttribute("data-message-id");
                console.log("Clicked messageId:", messageId);

                // 메시지 ID가 없는 경우 예외 처리
                if (!messageId || messageId.trim() === "") {
                    alert("유효하지 않은 메시지 ID입니다.");
                    return;
                }

                // URL을 JavaScript에서 encodeURIComponent로 변환
                const requestUrl = "/admessage/view?messageId=" + encodeURIComponent(messageId);

                fetch(requestUrl)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error("쪽지를 가져오는 데 실패했습니다. 상태 코드: " + response.status);
                        }
                        return response.json();
                    })
                    .then(data => {
                        if (!data || Object.keys(data).length === 0) {
                            alert("해당 메시지를 찾을 수 없습니다.");
                            return;
                        }
                        document.getElementById("modalSender").textContent = data.senderName;
                        document.getElementById("modalTime").textContent = data.sendTime;
                        document.getElementById("modalContent").textContent = data.content;
                        document.getElementById("messageModal").style.display = "block";
                        
                        fetch(`/message/updateReadStatus?messageId=${messageId}`, { method: "POST" })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error("읽음 상태 업데이트 실패. 상태 코드: " + response.status);
                            }
                            return response.text();
                        })
                        .then(() => {
                            // UI에서 "읽지 않음"을 "읽음"으로 변경
                             const statusCell = button.closest("tr").querySelector(".read-status");
                            if (statusCell) {
                                statusCell.textContent = "읽음";
                            	}
                       		})
                        .catch(error => {
                            console.error("Error updating read status:", error);
                        });

                })
                .catch(error => {
                    console.error("Error fetching message:", error);
                    alert("메시지를 불러오는 중 오류가 발생했습니다.");
                });
            });
        });

        // 모달 닫기 버튼
        document.querySelector(".close-btn").addEventListener("click", function () {
            document.getElementById("messageModal").style.display = "none";
        });

        // 모달 외부 클릭 시 닫기
        window.onclick = function (event) {
            const modal = document.getElementById("messageModal");
            if (event.target === modal) {
                modal.style.display = "none";
            }
        };
    });
    
</script>

</body>
</html>
