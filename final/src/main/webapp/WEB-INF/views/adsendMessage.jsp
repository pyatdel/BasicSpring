<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>쪽지 보내기</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        form {
            max-width: 400px;
            margin: 0 auto;
        }
        div {
            margin-bottom: 15px;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<jsp:include page="./include/mangerSidebar.jsp"></jsp:include>
    
    <body>
    
    <form id="adsendMessageForm" action="${pageContext.request.contextPath}/admessage/adsend" method="post">
        <div>
            <label for="receiver">수신자:</label>
            <input type="text" id="receiver" name="receiverEmpId" value="${param.receiverId}" readonly>
        </div>
        <div>
            <label for="content">내용:</label>
            <textarea id="content" name="content" rows="5" cols="30" required></textarea>
        </div>
        <div>
            <button type="submit">보내기</button>
        </div>
    </form>

    <script>
        document.getElementById("adsendMessageForm").addEventListener("submit", function (e) {
            e.preventDefault(); // 기본 폼 제출 방지

            const formData = new FormData(this);

            fetch("${pageContext.request.contextPath}/admessage/adsend", {
                method: "POST",
                body: formData
            })
            .then(response => response.text()) // 응답을 텍스트로 변환
            .then(data => {
                alert("쪽지가 성공적으로 전송되었습니다."); // 성공 알림
                window.location.href = "${pageContext.request.contextPath}/adaddress"; // 받은 쪽지함으로 이동
            })
            .catch(error => {
                alert("오류 발생: " + error.message);
            });
        });
    </script>
</html>
