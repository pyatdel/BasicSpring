<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<title>근태 관리</title>
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->

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

	
<style>
	.mainContent{
		display: flex;
		justify-content: space-between;
		align-items: flex-start;
		height: 100vh;
		box-sizing: border-box;
	}
	.attManContainer{
		justify-content: center;
		justify-items :center;
		width: 20%;
		height: 90%;
		background-color: #009CFF;
		padding: 5px;
		box-shadow: 2px 0 5px rgba(0,0,0,0.7);
		border-radius: 8px;
	}
	.scheduleContainer{
		flex: 1;
		margin-left: 20px;
		height: 90%;
		background-color: white;
		padding: 5px;
		border-radius: 8px;
		box-shadow: 0 2px 4px rgba(0,0,0,0.7);
		margin-bottom: 10px;
		justify-content: center;
		align-items: center;
	}
	.imgProfile{
		border-radius: 50%;
		height : 150px;
		width: 150px;
		margin-top : 10px;
	}
	.actions{
		display: flex;
		margin : 10px;
		justify-content:center;
	}
	
	.white-btn{
		margin :10px;
	}
	#proFileImg{
		width: 140px;
		height : 140px;
		border-radius: 20px;
		margin: 5px;
	
	}
	#currentTime{
		width: 230px;
		color: white;
	}
	
	
	/* Progress Circle 스타일 */
.progress-container {
  position: relative;
  display: inline-block;
  margin-top: 20px;
}

.progress-ring {
  transform: rotate(-90deg); /* 반시계방향으로 회전하여 원의 시작점이 위쪽으로 */
}

.progress-ring__circle {
  stroke: #e6e6e6;
}

.progress-ring__bar {
  stroke-linecap: round;
  transition: stroke-dashoffset 1s;
}

#progressText {
  font-size: 20px;
  font-weight: bold;
	color: white;
}
.attSub {
display: block !important;
height: auto !important;
}

.bluBt{
background-color: #3676EB;
color:white;
outline: none;
border:none;
width: 130px;
height:36px; 
border-radius: 5px;

}

.greenBt{
background-color: #278986 !important;
color:white;
outline: none;
border:none;
width: 130px;
height:36px; 
border-radius: 5px;
margin: 5px;
}
.whiteBt{
background-color: #ffffff !important;
color:black;
outline: none;
border:none;
width: 130px;
height:36px; 
border-radius: 5px;
margin: 5px; 	
}
</style>
</head>
<!-- 메인 컨텐츠 영역 시작 --> 
<%-- <p>${contractMasterVOList}</p> --%> 
<%@ include file="../include/header.jsp"%>
	<div class="mainContent">
		<div class="attManContainer">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<div class="proFile">
				<div class="imgProfile">
					<img id="proFileImg" src="${userInfo.empProfile}" alt="profile Image">
				</div>
				<c:if test="${userInfo != null}">
					<h5>${getUser.deptName}</h5>
					<h4>${userInfo.empName} ${userInfo.postName}</h4>
				</c:if>
			</div>	
<!-- 			<div class="status"> -->
<!-- 				<h5>결재할 문서 : 3</h5> -->
<!-- 			</div> -->
			<div class="actions">
				<form id="checkInForm" action="/att/checkIn" method="post">
				<c:if test="${userInfo != null}">
					<input type="hidden" name="empNo" value="${userInfo.empNo}">
					<button type="submit" id="checkInButton" class="whiteBt conbtn">출근하기</button>
				</c:if>
				</form>
				<form id="checkOutForm" action="/att/checkOut" method="post">
				<c:if test="${userInfo != null}">
					<input type="hidden" name="empNo" value="${userInfo.empNo}">
					<button type="submit" id= "checkOutButton" class="greenBt conbtn">퇴근하기</button>
				</c:if>
				</form>
			</div>
			<div>
				<span id="currentTime"></span>
				<input type="text" id="workTime" name = "workTime" value="" readonly style="display: none;">
			</div>
			  	 <!-- Progressbar -->
					  <div class="progress" style="height: 30px;">
					    <div id="progressBar" class="progress-bar bg-success" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
					  </div>
					  
					  <!-- 경과 시간 표시 -->
					  <div id="progressText" class="mt-2" style="font-size: 1.2rem;">근무시간: 00:00</div>
		</div>
		<div class="scheduleContainer">
			<iframe src="http://localhost:7921/attManager" frameborder="0" title="근태현황" width="100%" height="95%" scrolling="no" marginwidth="5" marginheight="5" ></iframe>
		</div>
	</div>
	<!-- 엑시오스	 -->
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<!-- 필요한 링크들 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="/dash/js/main.js"></script>
	<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
	<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
	<%@ include file="../include/footer.jsp"%>
<script type="text/javascript">

let startTime = null;
let workTimer = null;
let totalWorkTimeInSeconds = 9 * 3600;

let progressBar = document.getElementById('progressBar');
let progressText = document.getElementById('progressText');

function updateClock(serverTime){
	
	// 서버에서 전달된 시간을 Date 객체로 변환
	let serverDate = new Date(serverTime);
	
	setInterval(function(){
		serverDate.setSeconds(serverDate.getSeconds() +1);
		
		const year = serverDate.getFullYear();
		const month = String(serverDate.getMonth() +1).padStart(2,'0');
		const day = String(serverDate.getDate()).padStart(2,'0');
		const hours = String(serverDate.getHours()).padStart(2,'0');
		const minutes = String(serverDate.getMinutes()).padStart(2, '0');
		const seconds = String(serverDate.getSeconds()).padStart(2, '0');
		
		// 요일 규하기 (0: 일요일, 6: 토요일)
		const daysOfWeek = ['일','월','화','수','목','금','토'];
		const weekday = daysOfWeek[serverDate.getDay()];
		
		const formattedTime = `\${year}년\${month}월\${day}일 (\${weekday}) \${hours}:\${minutes}:\${seconds}`;
		document.getElementById('currentTime').textContent = formattedTime;
	},1000); // 1초마다 갱신
}
window.onload = function(){
	const serverTime = '${dTime}';
	updateClock(serverTime);
};



$(document).ready(function(){
	const empNoInput = $("input[name='empNo']");
	const checkInButton = $("#checkInButton");
	
	
	function checkEmployeeStatus(empNo){
		return $.ajax({
			url:`/att/checkStatus?empNo=\${empNo}`,
			type: "GET",
		});
	}
	
	function processCheckIn(empNo){
		let formData = new FormData();
		formData.append("empNo",empNo);
		
		return $.ajax({
			url: '/att/checkIn',
			processData : false,
			contentType: false,
			data : formData,
			type: 'POST',
		});
	}
	
	// 출근 상태 확인 및 초기화
	function initializeCheckIn(){
		let empNo = empNoInput.val();
		
		if(!empNo){
			alert('사원 번호를 입력해주세요.');
			return;
		}
		checkEmployeeStatus(empNo)
			.done(function(response){
			console.log("response",response);
			if(response.isCheckedIn > 0){
				checkInButton.prop("disabled",true); // 버튼 비활성화
				checkInButton.text("이미 출근 처리 됨");
			}
		})
		.fail(function(error){
			console.log("출근 상태 확인 실패:",error);
		});
	}

	// 출근 처리 이벤트
	$("#checkInForm").submit(function (event){
		event.preventDefault();

		let empNo = empNoInput.val();

		if(!empNo){
			alert("사원 번호를 입력해주세요.");
			return;
		}
		processCheckIn(empNo)
		.done(function (result){
			console.log("result:", result);

			if(result.message === "출근 완료!"){
				const serverTime = result.serverTime; // 서버에서 전달된 출근 시간
				startTime = new Date(serverTime); // 서버 시간으로 초기화
				updateWorkTime(); //근무 시간 갱신 시작
				var Toast = Swal.mixin({
							toast: true,
							position: 'top-end',
							showConfirmButton: false,
							timer: 3000
						});
						
							Toast.fire({
							icon:'success',
							title:'등록성공!'
						});
						
					}
					else{
						var Toast = Swal.mixin({
							toast: true,
							position: 'top-end',
							showConfirmButton: false,
							timer: 3000
						});
						
							Toast.fire({
							icon:'warning',
							title:'등록실패'
						});
			}

		})
		.fail(function (error){
			console.log("출근 처리 시패:", error);
		});
		initializeCheckIn();
	})
})


	
	// $(document).ready(function(){
	// 	$("#checkInForm").submit(function (event){
	// 		event.preventDefault();
			
	// 		let empNo = $("input[name='empNo']").val();
			
	// 		// 출근 상태 확인
	// 		if(empNo){
	// 			$.ajax({
	// 			url : `/att/checkStatus?empNo=\${empNo}`,
	// 			type : "GET",
	// 			success : function(response){
	// 				console.log("response",response); // 응답데이터 확인
	// 				if(response.isCheckedIn > 0){
	// 					$("#checkInButton").prop("disabled",true) // 버튼 비활성화
	// 					$("#checkInButton").text("이미 출근 처리 됨");
	// 					}
	// 				},
	// 				error: function (error){
	// 					console.log("출근 상태 확인 실패:",error);
	// 				},
	// 			});
	// 		}
			
	// 		let formData = new FormData();
			
	// 		formData.append("empNo",empNo);

	// 		if(!empNo){
	// 			alert('사원 번호를 확인 할수 없습니다.');
	// 			return;
	// 		}
	// 		$.ajax({
	// 			url: '/att/checkIn',
	// 			processData : false, // 파일객체를 string으르 만들 수 없어서 false
	// 			contentType : false,
	// 			data : formData,
	// 			type:'POST',
	// 			success : function(result){
	// 				// 5. 결과 확인(1 또는 0)
	// 				// 0 또는 1
	// 				console.log("result :", result);
	// 				// success, error, warning, info, question
	// 				if(result.message == '출근 완료!'){//등록성공
	// 					const serverTime = result.serverTime; // 서버에서 전달된 출근시간
	// 					startTime = new Date(serverTime); //  서버 시간으로 초기화
	// 					updateWorkTime(); // 근무 시간 갱신 시작
	// 					var Toast = Swal.mixin({
	// 						toast: true,
	// 						position: 'top-end',
	// 						showConfirmButton: false,
	// 						timer: 3000
	// 					});
						
	// 						Toast.fire({
	// 						icon:'success',
	// 						title:'등록성공!'
	// 					});
						
	// 				}
	// 				else{
	// 					var Toast = Swal.mixin({
	// 						toast: true,
	// 						position: 'top-end',
	// 						showConfirmButton: false,
	// 						timer: 3000
	// 					});
						
	// 						Toast.fire({
	// 						icon:'warning',
	// 						title:'등록실패'
	// 					});
						
	// 				}
	// 			}
				
	// 		});
	// 	});
	// });
	
	
	// 퇴근 처리 이벤트
		$("#checkOutForm").submit(function (event){
			event.preventDefault();
			
			let empNo = $("input[name='empNo']").val();
			let formData = new FormData();
			
			formData.append("empNo",empNo);

			if(!empNo){
				alert('사원 번호를 확인 할수 없습니다.');
				return;
			}
			$.ajax({
				url: '/att/checkOut',
				processData : false, // 파일객체를 string으르 만들 수 없어서 false
				contentType : false,
				data : formData,
				type:'PUT',
				success : function(result){
					// 5. 결과 확인(1 또는 0)
					// 0 또는 1
					console.log("result :", result);
					// success, error, warning, info, question
					if(result.message == '퇴근 완료!'){//등록성공
						clearInterval(workTimer); // 타이머 종료
						var Toast = Swal.mixin({
							toast: true,
							position: 'top-end',
							showConfirmButton: false,
							timer: 3000
						});
						
							Toast.fire({
							icon:'success',
							title:'퇴근 등록!'
						});
						
					}
					else{
						var Toast = Swal.mixin({
							toast: true,
							position: 'top-end',
							showConfirmButton: false,
							timer: 3000
						});
						
							Toast.fire({
							icon:'warning',
							title:'등록실패'
						});
						
					}
				}
				
			});
		});
	
	
	// 근무 시간 갱신
	function updateWorkTime(){
		if(!startTime) return;
		

		workTimer = setInterval(function () {
			const now = new Date();
	        const elapsedTime = Math.floor((now - startTime) / 1000); // 초 단위 경과 시간
	        const hours = Math.floor(elapsedTime / 3600);
	        const minutes = Math.floor((elapsedTime % 3600) / 60);
	        const seconds = elapsedTime % 60;

	        // 경과 시간 표시
	        const workTime = `\${hours}H \${minutes}M \${seconds}S`;
	        progressText.textContent = `근무시간: \${workTime}`; // 화면 표시

	        // 진행률 업데이트
	        let percentage = (elapsedTime / totalWorkTimeInSeconds) * 100;
	        progressBar.style.width = `\${Math.min(percentage, 100)}%`; // 진행률 제한 100%

	        // 근무 시간 종료 시 타이머 종료
	        if (elapsedTime >= totalWorkTimeInSeconds) {
	            clearInterval(workTimer);
	        }
	    }, 1000); // 1초마다 갱신
	}
	
	function restoreCheckInTime(){
		
		let empNo = $("input[name='empNo']").val();
		$.ajax({
			url: `/att/getCheckInTime?empNo=\${empNo}`,
			type: "GET",
			success: function(response){
				console.log(response);
				if(response.status === "success"){
					const checkInTime = new Date(response.checkInTime);
					startTime = checkInTime; // 출근 시간 복구
					updateWorkTime(); // 타이머 재시작
				}else{
					console.warn(response.message);
				}
			},
			error: function (error){
				console.error("출근 시간 복구 중 오류:",error);
			}
		});
	}
	
	$(document).ready(function(){
		const empNo = $("input[name= 'empNo']").val();
		if(empNo){
			restoreCheckInTime(empNo);
		}
	});

	


</script>
	<!-- 메인 컨텐츠 영역 끝 -->
	</html>