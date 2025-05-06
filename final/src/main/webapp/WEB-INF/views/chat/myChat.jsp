<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>초간단 채팅</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
<style>
   #id_chatwin {
    width: 300px;
    height: 300px;
    background-color: black;
    border: 1px solid pink;
    color: yellow;
    overflow-y: auto;
    padding: 10px;
    display: block; /* 확실하게 표시되도록 */
}

.chat-message {
    margin: 5px 0;
    word-wrap: break-word;
    color: yellow;  /* 일반 메시지는 노란색 */
    display: block; /* 블록 레벨 요소로 설정 */
}

.system-message {
    color: #00ff00;  /* 시스템 메시지는 초록색 */
    font-style: italic;
}
</style>
</head>
<body>
   <h1>대화창</h1>
   <div>
       <div id="id_chatwin"></div>
       <input type="text" id="id_message" placeholder="메시지를 입력하세요"/>
       <input type="button" id="id_send" value="전송">
       <input type="button" id="id_exit" value="나가기">
   </div>

<script>
const c_alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
const f_ranID = () => {
    let ranID = "";
    for(let i=1; i< (Math.ceil(Math.random()*5)+4); i++){
        ranID += c_alpha[Math.floor(Math.random()*c_alpha.length)];
    }
    return ranID;
}

let webSocket;
let myId = f_ranID();
const c_chatWin = document.querySelector("#id_chatwin");
const c_message = document.querySelector("#id_message");        
const c_send = document.querySelector("#id_send");
const c_exit = document.querySelector("#id_exit");

c_send.addEventListener("click", () => {
    send();
});

c_exit.addEventListener("click", function () {
    disconnect();
});

connect();

function connect() {
    webSocket = new SockJS("/chat");
    
    webSocket.onopen = function() {
        console.log("WebSocket 연결됨");
        fOpen();
    };
    
    webSocket.onmessage = fMessage;
    
    webSocket.onerror = function(error) {
        console.error("WebSocket Error:", error);
        alert("연결에 문제가 발생했습니다. 재연결을 시도합니다.");
        setTimeout(connect, 5000);
    };
    
    webSocket.onclose = function() {
        console.log("WebSocket 연결 종료");
    };
}

function fOpen() {
    let chatMessage = {
        sender: myId,
        message: "입장했습니다.",
        type: "ENTER"
    };
    webSocket.send(JSON.stringify(chatMessage));
}

function send() {
    if(!c_message.value.trim()) {
        return; // 빈 메시지 전송 방지
    }
    
    if (webSocket && webSocket.readyState === WebSocket.OPEN) {
        let chatMessage = {
            sender: myId,
            message: c_message.value,
            type: "CHAT"
        };
        webSocket.send(JSON.stringify(chatMessage));
        c_message.value = "";
    } else {
        console.log("WebSocket is not open. Current state:", webSocket ? webSocket.readyState : "no websocket");
        connect();
    }
}

function fMessage(e) {
    try {
        const msg = JSON.parse(e.data);
        console.log("Received message:", msg);
        
        const msgElement = document.createElement('div');
        msgElement.className = 'chat-message';
        
        // 문자열 연결 방식으로 변경
        let displayText = '';
        
        if (msg.type === "ENTER") {
            msgElement.classList.add('system-message');
            displayText = msg.sender + "님이 입장했습니다.";
        } else if (msg.type === "LEAVE") {
            msgElement.classList.add('system-message');
            displayText = msg.sender + "님이 퇴장했습니다.";
        } else if (msg.type === "CHAT") {
            displayText = msg.sender + ": " + msg.message;
        }
        
        console.log("Final display text:", displayText);
        
        msgElement.textContent = displayText;
        c_chatWin.appendChild(msgElement);
        c_chatWin.scrollTop = c_chatWin.scrollHeight;
    } catch (error) {
        console.error("Error in fMessage:", error);
    }
}

function disconnect() {
    if(webSocket && webSocket.readyState === WebSocket.OPEN) {
        let chatMessage = {
            sender: myId,
            message: "퇴장했습니다.",
            type: "LEAVE"
        };
        webSocket.send(JSON.stringify(chatMessage));
        webSocket.close();
    }
}

// Enter 키 이벤트 추가
c_message.addEventListener("keypress", (event) => {
    if(event.keyCode === 13) {
        send();
    }
});
</script>
</body>
</html>