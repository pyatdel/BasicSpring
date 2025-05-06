<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>


<link rel="stylesheet" href="/dash/css/bootstrap.min.css">
<link rel="stylesheet" href="/dash/css/style.css">
<link href="img/favicon.ico" rel="icon">


<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap"
	rel="stylesheet">




<title>웹소켓 알림</title>

<!-- Icon Font Stylesheet -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css"
	rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<jsp:include page="./include/preScript.jsp"></jsp:include>
<style>
* {
			box-sizing: border-box;
		}

		#wrapper {
			width: 60vw;
			margin: 10px auto;
			text-align: center;
		}

		#e7eChat {
			min-height: 450px;
			border: 1px groove pink;
		}

		#e7eTitle {
			background-color: black;
			color: yellowgreen;
		}

		#e7eConn {
			margin-top: 10px;
		}

		#e7eInput {
			width: 100%;
			height: 50px;
			border: 10px groove gold;
			text-align: center;
			display: none;
		}


</style>



<!-- 메인 컨텐츠 영역 시작 --> 
<%-- <p>${contractMasterVOList}</p> --%> 
<%@ include file="./include/header.jsp"%>
<body>
<div id="wrapper">
		<h1 id="e7eTitle">E7E와 아무말 대잔치</h1>
		<div id="e7eChat">
		</div>
		<div id="e7eConn">
			아이디: <input type="text" id="chatId" autofocus value="">
			<button onclick="suminConn()">연결할꼬얌</button>
		</div>
		<div id="e7eInput" contenteditable tabindex="0" onkeydown="suminEnter(this)">
		</div>
	</div>
</body>

<script>
		// 고정 element(요소)
		const e7eChat = document.querySelector("#e7eChat");
		const e7eConn = document.querySelector("#e7eConn");
		const chatId = document.querySelector("#chatId");
		const e7eInput = document.querySelector("#e7eInput");
		// 전역 변수	
		let webSocket = null;
		let hostport = location.href.split("/")[2];
		
		// 전역 함수
		function suminEnter(cont) {
			if (event.keyCode == 13) {
				event.preventDefault(); // 요거이 있어야 <br> 2개 안 들어감.

				let myDiv = document.createElement("div");
				myDiv.style.textAlign = "right";
				myDiv.innerHTML = cont.innerHTML;
				
				// 서버로 메시지 전송
				if (webSocket && webSocket.readyState === WebSocket.OPEN) {
		            webSocket.send(cont.innerHTML);
		        } else {
		            console.error("WebSocket이 연결되지 않았습니다.");
		        }

		        cont.innerHTML = "";
			}
		}

		function suminConn() {
			webSocket = new WebSocket(`ws://\${hostport}/ws/alarm/\${empNo}`);
			
			webSocket.onmessage = (event) => {
			    console.log("체킁", event.data);

			    // 받은 메시지를 채팅창에 표시
			    const receivedDiv = document.createElement("div");
			    receivedDiv.style.textAlign = "left";
			    receivedDiv.innerHTML = event.data; // 서버로부터 받은 데이터
			    e7eChat.appendChild(receivedDiv);
			};

			// 웹소켓  이벤트 
			webSocket.onopen = () => {
				console.log("E7E 연결 되었쪙");
				webSocket.send("안농");
				// 연결 성공 시 입력창 표시
		        e7eConn.style.display = "none";
		        e7eInput.style.display = "block";
			}

			webSocket.onmessage = () => {
				console.log("체킁", event.data)
			}

			webSocket.onclose = () => {
				console.log("닫혔어요")
			}

			webSocket.onerror = () => {
				console.log("에러가 났나봐요")
			}
		}

	</script>
<%@ include file="./include/footer.jsp"%>
	
